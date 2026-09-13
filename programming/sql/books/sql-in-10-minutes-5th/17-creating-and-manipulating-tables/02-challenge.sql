/*
 *create time: 2026-09-13
 */

/* 1. */
ALTER TABLE Vendors
ADD vend_web CHAR(100);

/* 2. */
UPDATE Vendors
SET vend_web = 'website.com'
WHERE vend_id = 'DLL01';
