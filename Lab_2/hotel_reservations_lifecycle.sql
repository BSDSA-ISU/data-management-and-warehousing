-- =====================================================================
-- Laboratory Activity No. 2 - The Data Lifecycle
-- Organization : Hotel
-- Dataset      : Hotel Reservations
-- Purpose      : Demonstrate, in SQL, the same lifecycle stages described
--                in the Activity Sheet (Plan/Capture/Store/Process/Use/
--                Share/Archive/Purge) for the hotel's reservation data.
-- DBMS         : Written in standard SQL (MySQL / MariaDB syntax).
-- =====================================================================

-- ---------------------------------------------------------------------
-- 0. DATABASE SETUP  (PLAN stage: defining the structures we need)
-- ---------------------------------------------------------------------
DROP DATABASE IF EXISTS hotel_reservations_db;
CREATE DATABASE hotel_reservations_db;
USE hotel_reservations_db;

-- ---------------------------------------------------------------------
-- 1. STORE stage: core "live" tables that hold active reservation data
-- ---------------------------------------------------------------------

-- Guests: personal / confidential information (protected under Data
-- Privacy Act & PCI DSS - access should be role-restricted in practice)
CREATE TABLE guests (
    guest_id        INT AUTO_INCREMENT PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    phone_number    VARCHAR(20),
    id_number       VARCHAR(50),          -- government ID / passport no.
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Rooms available in the hotel
CREATE TABLE rooms (
    room_id         INT AUTO_INCREMENT PRIMARY KEY,
    room_number     VARCHAR(10) NOT NULL UNIQUE,
    room_type       VARCHAR(30) NOT NULL,     -- e.g., Standard, Deluxe, Suite
    rate_per_night  DECIMAL(10,2) NOT NULL
);

-- Reservations: the main dataset for this activity (CAPTURE -> PROCESS -> USE)
CREATE TABLE reservations (
    reservation_id  INT AUTO_INCREMENT PRIMARY KEY,
    guest_id        INT NOT NULL,
    room_id         INT NOT NULL,
    check_in_date   DATE NOT NULL,
    check_out_date  DATE NOT NULL,
    booking_source  VARCHAR(30) NOT NULL,     -- Website, OTA, Walk-in, Phone
    status          VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
                       -- Confirmed, Checked-in, Checked-out, Cancelled, No-show
    amount_due      DECIMAL(10,2) NOT NULL,
    payment_status  VARCHAR(20) NOT NULL DEFAULT 'Pending',  -- Pending, Paid, Refunded
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_res_guest FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    CONSTRAINT fk_res_room  FOREIGN KEY (room_id)  REFERENCES rooms(room_id)
);

-- Audit log: supports governance, risk control, and accountability
-- (who did what, and when, at every lifecycle stage)
CREATE TABLE reservation_audit_log (
    log_id          INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id  INT NOT NULL,
    action          VARCHAR(20) NOT NULL,   -- INSERT, UPDATE, ARCHIVE, PURGE
    performed_by    VARCHAR(50) NOT NULL,   -- role/user, e.g. 'front_desk_staff'
    action_date     DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes           VARCHAR(255)
);

-- ---------------------------------------------------------------------
-- 2. CAPTURE / COLLECT stage: sample data entering the system
-- ---------------------------------------------------------------------
INSERT INTO guests (first_name, last_name, email, phone_number, id_number) VALUES
('Maria', 'Santos', 'maria.santos@email.com', '09171234567', 'PH-ID-00123'),
('John',  'Reyes',  'john.reyes@email.com',   '09209876543', 'PH-ID-00456'),
('Aiko',  'Tanaka', 'aiko.tanaka@email.com',  '09171112222', 'PP-JP-77812');

INSERT INTO rooms (room_number, room_type, rate_per_night) VALUES
('101', 'Standard', 2500.00),
('205', 'Deluxe',   4200.00),
('310', 'Suite',    7800.00);

INSERT INTO reservations
    (guest_id, room_id, check_in_date, check_out_date, booking_source, status, amount_due, payment_status)
VALUES
    (1, 1, '2026-08-20', '2026-08-22', 'Website', 'Confirmed', 5000.00, 'Pending'),
    (2, 2, '2026-08-21', '2026-08-23', 'OTA',     'Confirmed', 8400.00, 'Paid'),
    (3, 3, '2026-08-25', '2026-08-27', 'Walk-in', 'Confirmed', 15600.00, 'Pending');

INSERT INTO reservation_audit_log (reservation_id, action, performed_by, notes)
VALUES
    (1, 'INSERT', 'front_desk_staff', 'Reservation captured via website'),
    (2, 'INSERT', 'reservations_team', 'Reservation captured via OTA'),
    (3, 'INSERT', 'front_desk_staff', 'Reservation captured via walk-in');

-- ---------------------------------------------------------------------
-- 3. PROCESS / MAINTAIN stage: updates as the booking progresses
-- ---------------------------------------------------------------------

-- Guest checks in
UPDATE reservations
SET status = 'Checked-in'
WHERE reservation_id = 1;

-- Payment is completed
UPDATE reservations
SET payment_status = 'Paid'
WHERE reservation_id = 1;

-- Guest checks out
UPDATE reservations
SET status = 'Checked-out'
WHERE reservation_id = 2;

INSERT INTO reservation_audit_log (reservation_id, action, performed_by, notes) VALUES
    (1, 'UPDATE', 'front_desk_staff', 'Guest checked in, payment marked as Paid'),
    (2, 'UPDATE', 'front_desk_staff', 'Guest checked out');

-- ---------------------------------------------------------------------
-- 4. USE / ANALYZE stage: queries that turn reservations into insight
-- ---------------------------------------------------------------------

-- Current occupancy: rooms with an active, checked-in reservation
SELECT r.room_number, r.room_type, res.check_in_date, res.check_out_date
FROM reservations res
JOIN rooms r ON r.room_id = res.room_id
WHERE res.status = 'Checked-in';

-- Revenue collected per room type
SELECT r.room_type, SUM(res.amount_due) AS total_revenue
FROM reservations res
JOIN rooms r ON r.room_id = res.room_id
WHERE res.payment_status = 'Paid'
GROUP BY r.room_type;

-- Booking source breakdown (for demand/marketing analysis)
SELECT booking_source, COUNT(*) AS total_bookings
FROM reservations
GROUP BY booking_source;

-- ---------------------------------------------------------------------
-- 5. PUBLISH / SHARE stage: a controlled view for external/finance use
--    (exposes only what finance or an OTA partner needs - not full PII)
-- ---------------------------------------------------------------------
CREATE VIEW vw_billing_share AS
SELECT
    res.reservation_id,
    CONCAT(g.first_name, ' ', LEFT(g.last_name, 1), '.') AS guest_display_name,
    res.check_in_date,
    res.check_out_date,
    res.amount_due,
    res.payment_status
FROM reservations res
JOIN guests g ON g.guest_id = res.guest_id;

-- ---------------------------------------------------------------------
-- 6. ARCHIVE stage: move reservations older than the active period
--    (policy: active for 2 years, then archived - see Part D)
-- ---------------------------------------------------------------------
CREATE TABLE reservations_archive LIKE reservations;
ALTER TABLE reservations_archive
    ADD COLUMN archived_at DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Move reservations whose stay ended more than 2 years ago into the archive
INSERT INTO reservations_archive
    (reservation_id, guest_id, room_id, check_in_date, check_out_date,
     booking_source, status, amount_due, payment_status, created_at, updated_at)
SELECT reservation_id, guest_id, room_id, check_in_date, check_out_date,
       booking_source, status, amount_due, payment_status, created_at, updated_at
FROM reservations
WHERE check_out_date < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

DELETE FROM reservations
WHERE check_out_date < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

INSERT INTO reservation_audit_log (reservation_id, action, performed_by, notes)
SELECT reservation_id, 'ARCHIVE', 'system_admin', 'Moved to archive after 2-year active period'
FROM reservations_archive;

-- ---------------------------------------------------------------------
-- 7. PURGE / DESTROY stage: permanently delete records past the full
--    retention period (policy: purge after 7 years total - see Part D)
-- ---------------------------------------------------------------------

-- Log the purge before deleting, to keep an accountability trail
INSERT INTO reservation_audit_log (reservation_id, action, performed_by, notes)
SELECT reservation_id, 'PURGE', 'data_governance_officer',
       'Permanently deleted after 7-year retention period expired'
FROM reservations_archive
WHERE check_out_date < DATE_SUB(CURDATE(), INTERVAL 7 YEAR);

DELETE FROM reservations_archive
WHERE check_out_date < DATE_SUB(CURDATE(), INTERVAL 7 YEAR);

-- ---------------------------------------------------------------------
-- 8. Quick checks
-- ---------------------------------------------------------------------
SELECT * FROM reservations;
SELECT * FROM reservations_archive;
SELECT * FROM reservation_audit_log ORDER BY action_date;
