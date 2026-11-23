from datetime import datetime
import re
import pandas as pd


def validate_csv_data_quality(file_path):
    # Load dataset
    df = pd.read_csv(file_path)

    # DataFrame to collect detected errors
    errors = []

    def record_error(row_idx, column, dimension, description, value):
        errors.append(
            {
                "Row": row_idx + 2,  # +2 accounts for 0-indexing and header row
                "Column": column,
                "Dimension": dimension,
                "Description": description,
                "Value": value,
            }
        )

    # Allowed / standard values for validation
    VALID_PROGRAMS = ["BSCS", "BSIT", "BSIS", "BSECE"]
    VALID_STATUSES = ["Active", "Inactive", "Dropped", "On Leave"]
    VALID_GENDERS = ["Male", "Female", "Non-Binary"]
    EMAIL_REGEX = r"^[\w\.-]+@[\w\.-]+\.\w+$"

    # --- 1. UNIQUENESS ---
    # Check for duplicate Student_IDs
    duplicate_ids = df[df.duplicated(subset=["Student_ID"], keep=False)]
    for idx, row in duplicate_ids.iterrows():
        record_error(
            idx,
            "Student_ID",
            "Uniqueness",
            "Duplicate Student_ID found",
            row["Student_ID"],
        )

    # Check for complete row duplicates
    duplicate_rows = df[df.duplicated(keep=False)]
    for idx, row in duplicate_rows.iterrows():
        record_error(
            idx,
            "ALL",
            "Uniqueness",
            "Entire record is duplicated",
            row["Student_ID"],
        )

    # Loop through each row for field-level checks
    for idx, row in df.iterrows():

        # --- 2. COMPLETENESS ---
        # Required fields: Student_ID, Student_Name, Program, Email
        required_fields = ["Student_ID", "Student_Name", "Program", "Email"]
        for col in required_fields:
            if pd.isna(row[col]) or str(row[col]).strip() == "":
                record_error(
                    idx,
                    col,
                    "Completeness",
                    f"Required field '{col}' is blank",
                    row[col],
                )

        # --- 3. VALIDITY ---
        # Age range check (e.g., 15 to 100)
        if not pd.isna(row["Age"]):
            try:
                age = float(row["Age"])
                if age < 15 or age > 100 or not age.is_integer():
                    record_error(
                        idx,
                        "Age",
                        "Validity",
                        "Age is out of realistic range (15-100) or not an integer",
                        row["Age"],
                    )
            except ValueError:
                record_error(
                    idx, "Age", "Validity", "Age is not a numeric value", row["Age"]
                )

        # Email format check
        if not pd.isna(row["Email"]) and str(row["Email"]).strip() != "":
            if not re.match(EMAIL_REGEX, str(row["Email"]).strip()):
                record_error(
                    idx,
                    "Email",
                    "Validity",
                    "Invalid email address format",
                    row["Email"],
                )

        # Student_ID format check (e.g., expected format S-XXXXXX or numeric)
        if not pd.isna(row["Student_ID"]):
            if not str(row["Student_ID"]).isalnum():
                record_error(
                    idx,
                    "Student_ID",
                    "Validity",
                    "Student_ID contains invalid special characters",
                    row["Student_ID"],
                )

        # --- 4. CONSISTENCY ---
        # Gender format consistency (e.g., 'M' instead of 'Male')
        if not pd.isna(row["Gender"]):
            gender_val = str(row["Gender"]).strip()
            if gender_val in ["M", "F"]:
                record_error(
                    idx,
                    "Gender",
                    "Consistency",
                    "Inconsistent format (use full name e.g., 'Male' instead of abbreviation)",
                    row["Gender"],
                )

        # Campus format consistency (e.g., checking trailing spaces or hyphenation differences)
        if not pd.isna(row["Campus"]):
            campus_val = str(row["Campus"])
            if campus_val != campus_val.strip():
                record_error(
                    idx,
                    "Campus",
                    "Consistency",
                    "Value has leading or trailing whitespaces",
                    row["Campus"],
                )

        # --- 5. TIMELINESS ---
        # Check if Last_Updated is in the future or improperly formatted
        if not pd.isna(row["Last_Updated"]):
            try:
                updated_date = pd.to_datetime(row["Last_Updated"])
                if updated_date > datetime.now():
                    record_error(
                        idx,
                        "Last_Updated",
                        "Timeliness",
                        "Last_Updated date is set in the future",
                        row["Last_Updated"],
                    )
            except Exception:
                record_error(
                    idx,
                    "Last_Updated",
                    "Validity",
                    "Unable to parse timestamp format",
                    row["Last_Updated"],
                )

        # --- 6. INTEGRITY ---
        # Check against reference domain constraints (Foreign Key/Domain constraints)
        if (
            not pd.isna(row["Status"])
            and str(row["Status"]).title() not in VALID_STATUSES
        ):
            record_error(
                idx,
                "Status",
                "Integrity",
                f"Status '{row['Status']}' does not exist in master list {VALID_STATUSES}",
                row["Status"],
            )

        if not pd.isna(row["Program"]) and str(row["Program"]) not in VALID_PROGRAMS:
            record_error(
                idx,
                "Program",
                "Integrity",
                f"Program '{row['Program']}' does not match allowed program codes",
                row["Program"],
            )

        # --- 7. ACCURACY ---
        # Logic check: e.g., Student_Name domain checks (contains numbers/symbols)
        if not pd.isna(row["Student_Name"]):
            name = str(row["Student_Name"])
            if any(char.isdigit() for char in name):
                record_error(
                    idx,
                    "Student_Name",
                    "Accuracy",
                    "Name contains numbers, indicating recorded value does not match real-world value",
                    name,
                )

    # Convert errors list to DataFrame
    error_df = pd.DataFrame(errors)
    return error_df


# --- Example Usage ---
error_report = validate_csv_data_quality('data.csv')
print(error_report.to_string(index=False))
error_report.to_csv('data_quality_report.csv', index=False)
