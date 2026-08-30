/*
 * create time: 2026-08-21 10:49
 */

/* 1. */
SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%';

/*
+---------------------+-----------------------------------------------------------------------+
| prod_name           | prod_desc                                                             |
+---------------------+-----------------------------------------------------------------------+
| Fish bean bag toy   | Fish bean bag toy, complete with bean bag worms with which to feed it |
| Bird bean bag toy   | Bird bean bag toy, eggs are not included                              |
| Rabbit bean bag toy | Rabbit bean bag toy, comes with bean bag carrots                      |
+---------------------+-----------------------------------------------------------------------+
3 rows in set (0.00 sec)
*/

/* 2. */
SELECT prod_name, prod_desc
FROM Products
WHERE NOT prod_desc LIKE '%toy%'
ORDER BY prod_name;

/*
+--------------------+--------------------------------------------------+
| prod_name          | prod_desc                                        |
+--------------------+--------------------------------------------------+
| 12 inch teddy bear | 12 inch teddy bear, comes with cap and jacket    |
| 18 inch teddy bear | 18 inch teddy bear, comes with cap and jacket    |
| 8 inch teddy bear  | 8 inch teddy bear, comes with cap and jacket     |
| King doll          | 12 inch king doll with royal garments and crown  |
| Queen doll         | 12 inch queen doll with royal garments and crown |
| Raggedy Ann        | 18 inch Raggedy Ann doll                         |
+--------------------+--------------------------------------------------+
6 rows in set (0.00 sec)
*/

/* 3. */
SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%' AND prod_desc LIKE '%carrots%';

/*
+---------------------+--------------------------------------------------+
| prod_name           | prod_desc                                        |
+---------------------+--------------------------------------------------+
| Rabbit bean bag toy | Rabbit bean bag toy, comes with bean bag carrots |
+---------------------+--------------------------------------------------+
1 row in set (0.00 sec)
*/

/* 4. */
SELECT prod_name, prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%carrots%';

/*
+---------------------+--------------------------------------------------+
| prod_name           | prod_desc                                        |
+---------------------+--------------------------------------------------+
| Rabbit bean bag toy | Rabbit bean bag toy, comes with bean bag carrots |
+---------------------+--------------------------------------------------+
1 row in set (0.00 sec)
*/
