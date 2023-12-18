USE gabinet_dentystyczny

/* select do pokazania efektu */

/* 1 UPDATE */
SELECT PESEL FROM Pacjenci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Miejscowosc='Gdañsk'
)

UPDATE Osoby
	SET Miejscowosc='Gdansk'
	WHERE Miejscowosc='Gdañsk'

SELECT PESEL FROM Pacjenci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Miejscowosc='Gdansk'
)

/* 1 DELETE */

SELECT PESEL FROM Pacjenci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Miejscowosc='Rumia'
)

DELETE Osoby WHERE Miejscowosc='Rumia'

SELECT PESEL FROM Pacjenci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Miejscowosc='Rumia'
) OR PESEL=NULL

/* 2 UPDATE */
SELECT * FROM Pacjenci WHERE PESEL='08021255678';

UPDATE Osoby
	SET PESEL='00000000000'
	WHERE PESEL='08021255678'

SELECT * FROM Pacjenci WHERE PESEL='08021255678';
SELECT * FROM Pacjenci WHERE PESEL='00000000000';

/* 2 DELETE */

DELETE Osoby WHERE PESEL='00000000000'
SELECT * FROM Pacjenci WHERE PESEL='00000000000';

/* 3 UPDATE */
SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Nr_telefonu='334455238'
)

UPDATE Osoby
	SET Nr_telefonu='111111111'
	WHERE Nr_telefonu='334455238'

SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Nr_telefonu='111111111'
)


/* 3 DELETE */
SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Nr_telefonu='111111111'
)

DELETE Wizyty WHERE PESEL_dentysty IN (SELECT PESEL FROM Osoby WHERE Nr_telefonu='889900243')
DELETE Osoby WHERE PESEL IN (SELECT PESEL FROM Osoby WHERE Nr_telefonu='889900243')

SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL FROM Osoby WHERE
		Nr_telefonu='889900243'
) OR PESEL=NULL

/* 4 UPDATE */
SELECT * FROM Dentysci WHERE PESEL='56090944567';

UPDATE Osoby
	SET PESEL='00000000002'
	WHERE PESEL='56090944567'

SELECT * FROM Dentysci WHERE PESEL='56090944567';
SELECT * FROM Dentysci WHERE PESEL='00000000002';

/* 4 DELETE */

DELETE Osoby WHERE PESEL='00000000002'
SELECT * FROM Pacjenci WHERE PESEL='00000000002';

/* 5 UPDATE */
SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL_dentysty FROM Wyplaty WHERE
		Data_zakonczenia_umowy < '2014-01-01'
)

UPDATE Dentysci
	SET Data_zakonczenia_umowy='2015-01-01'
	WHERE Data_zakonczenia_umowy < '2014-01-01'

SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL_dentysty FROM Wyplaty WHERE
		Data_zakonczenia_umowy = '2015-01-01'
)

/* 5 DELETE */

SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL_dentysty FROM Wyplaty WHERE
		Data_zakonczenia_umowy = '2015-01-01'
)

DELETE Wizyty WHERE PESEL_dentysty IN (SELECT PESEL FROM Dentysci WHERE Data_zakonczenia_umowy = '2015-01-01')
DELETE Dentysci WHERE PESEL IN (SELECT PESEL FROM Dentysci WHERE Data_zakonczenia_umowy = '2015-01-01')

SELECT PESEL FROM Dentysci WHERE PESEL IN (
	SELECT PESEL_dentysty FROM Wyplaty WHERE
		Data_zakonczenia_umowy = '2015-01-01'
) OR PESEL=NULL

/* 6 UPDATE */
SELECT * FROM Sale WHERE Nr_oddzialu IN (
	SELECT Nr_oddzialu FROM Oddzialy WHERE
		Nr_oddzialu=2
)

UPDATE Oddzialy
	SET Nr_oddzialu=30
	WHERE Nr_oddzialu=2

SELECT * FROM Sale WHERE Nr_oddzialu IN (
	SELECT Nr_oddzialu FROM Oddzialy WHERE
		Nr_oddzialu=30
)

/* 6 DELETE */

SELECT * FROM Sale WHERE Nr_oddzialu IN (
	SELECT Nr_oddzialu FROM Oddzialy WHERE
		Nr_oddzialu=30
)

DELETE Oddzialy WHERE Nr_oddzialu=30

SELECT * FROM Sale WHERE Nr_oddzialu IN (
	SELECT Nr_oddzialu FROM Oddzialy WHERE
		Nr_oddzialu=2
) OR Nr_oddzialu=NULL

/* 7 UPDATE */
SELECT * FROM Wizyty WHERE PESEL_pacjenta='11010166789';

UPDATE Osoby
	SET PESEL='00000000005'
	WHERE PESEL='11010166789'

SELECT * FROM Wizyty WHERE PESEL_pacjenta='11010166789';
SELECT * FROM Wizyty WHERE PESEL_pacjenta='00000000005';

/* 7 DELETE */

DELETE Pacjenci WHERE PESEL='00000000005'
SELECT * FROM Wizyty WHERE PESEL_pacjenta='00000000005';

/* 8 UPDATE */
SELECT * FROM Wizyty WHERE Nr_sali=1;

UPDATE Sale
	SET Nr_sali=50
	WHERE Nr_sali=1

SELECT * FROM Wizyty WHERE Nr_sali=1;
SELECT * FROM Wizyty WHERE Nr_sali=50;

/* 8 DELETE */

DELETE Sale WHERE Nr_sali=50;
SELECT * FROM Wizyty WHERE Nr_sali=50;

/* 9 UPDATE */
SELECT * FROM Oferowanie_uslugi WHERE (PESEL_pacjenta='93070711234' AND Data='2023-10-10');

UPDATE Osoby
	SET PESEL='10000000000'
	WHERE PESEL='93070711234';

UPDATE Wizyty 
	SET Data='2029-10-10'
	WHERE PESEL_pacjenta='10000000000' AND Data='2023-10-10';

SELECT * FROM Oferowanie_uslugi WHERE (PESEL_pacjenta='93070711234' AND Data='2023-10-10');
SELECT * FROM Oferowanie_uslugi WHERE (PESEL_pacjenta='10000000000' AND Data='2029-10-10');

/* 9 DELETE */

DELETE Osoby WHERE PESEL='10000000000';
SELECT * FROM Oferowanie_uslugi WHERE PESEL_pacjenta='10000000000';

/* 10 UPDATE */
SELECT * FROM Oferowanie_uslugi WHERE Nazwa='implant dentystyczny';

UPDATE Uslugi
	SET Nazwa='implanttttt dentystyczny'
	WHERE Nazwa='implant dentystyczny';

SELECT * FROM Oferowanie_uslugi WHERE Nazwa='implant dentystyczny';
SELECT * FROM Oferowanie_uslugi WHERE Nazwa='implanttttt dentystyczny';

/* 10 DELETE */

DELETE Uslugi WHERE Nazwa='implanttttt dentystyczny';
SELECT * FROM Oferowanie_uslugi WHERE Nazwa='implanttttt dentystyczny';