/*
 * create time: 2026-08-22 13:12
 */

/* 1. */
SELECT vend_id, 
   vend_name AS vname, 
   vend_address AS vaddress, 
   vend_city AS vcity
FROM Vendors
ORDER BY vend_name;

/*
+---------+-----------------+-----------------+------------+
| vend_id | vname           | vaddress        | vcity      |
+---------+-----------------+-----------------+------------+
| BRE02   | Bear Emporium   | 500 Park Street | Anytown    |
| BRS01   | Bears R Us      | 123 Main Street | Bear Town  |
| DLL01   | Doll House Inc. | 555 High Street | Dollsville |
| FNG01   | Fun and Games   | 42 Galaxy Road  | London     |
| FRB01   | Furball Inc.    | 1000 5th Avenue | New York   |
| JTS01   | Jouets et ours  | 1 Rue Amusement | Paris      |
+---------+-----------------+-----------------+------------+
6 rows in set (0.00 sec)
*/

SELECT vend_id, 
   vend_name AS vname, 
   vend_address AS vaddress, 
   vend_city AS vcity
FROM Vendors
ORDER BY vname;

/*
+---------+-----------------+-----------------+------------+
| vend_id | vname           | vaddress        | vcity      |
+---------+-----------------+-----------------+------------+
| BRE02   | Bear Emporium   | 500 Park Street | Anytown    |
| BRS01   | Bears R Us      | 123 Main Street | Bear Town  |
| DLL01   | Doll House Inc. | 555 High Street | Dollsville |
| FNG01   | Fun and Games   | 42 Galaxy Road  | London     |
| FRB01   | Furball Inc.    | 1000 5th Avenue | New York   |
| JTS01   | Jouets et ours  | 1 Rue Amusement | Paris      |
+---------+-----------------+-----------------+------------+
6 rows in set (0.00 sec)
*/

/* 2. */
SELECT prod_id,
   prod_price,
   prod_price*0.9 AS sale_price
FROM Products;

/*
+---------+------------+------------+
| prod_id | prod_price | sale_price |
+---------+------------+------------+
| BNBG01  |       3.49 |      3.141 |
| BNBG02  |       3.49 |      3.141 |
| BNBG03  |       3.49 |      3.141 |
| BR01    |       5.99 |      5.391 |
| BR02    |       8.99 |      8.091 |
| BR03    |      11.99 |     10.791 |
| RGAN01  |       4.99 |      4.491 |
| RYL01   |       9.49 |      8.541 |
| RYL02   |       9.49 |      8.541 |
+---------+------------+------------+
9 rows in set (0.00 sec)
*/
