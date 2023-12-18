/*CREATE DATABASE gabinet_dentystyczny;*/
USE gabinet_dentystyczny;

CREATE TABLE Osoby(
	PESEL CHAR(11) CHECK (LEN(PESEL) = 11 AND ISNUMERIC(PESEL) = 1) PRIMARY KEY,
	Imie VARCHAR(50) CHECK (Imie NOT LIKE '%[^a-zA-Z ]%' and Imie LIKE '[A-Z]%') NOT NULL,
	Nazwisko VARCHAR(50) CHECK (Nazwisko NOT LIKE '%[^a-zA-Z-]%' and Nazwisko LIKE '[A-Z]%') NOT NULL,
	Miejscowosc VARCHAR(30) CHECK (Miejscowosc NOT LIKE '%[^a-zA-Z]%' and Miejscowosc LIKE '[A-Z]%') NOT NULL,
	Data_urodzenia DATE NOT NULL,
	Nr_telefonu CHAR(9) CHECK (LEN(Nr_telefonu) = 9 AND ISNUMERIC(Nr_telefonu) = 1) NOT NULL
);

CREATE TABLE Pacjenci(
	PESEL CHAR(11) PRIMARY KEY REFERENCES Osoby(PESEL) ON DELETE CASCADE ON UPDATE CASCADE,
	PESEL_rodzica CHAR(11) REFERENCES Pacjenci
);

CREATE TABLE Dentysci(
	PESEL CHAR(11) CHECK (LEN(PESEL) = 11 AND ISNUMERIC(PESEL) = 1) PRIMARY KEY REFERENCES Osoby(PESEL),
	Data_zawarcia_umowy DATE NOT NULL,
	Data_zakonczenia_umowy DATE,
	CONSTRAINT ogr_dentysci FOREIGN KEY (PESEL) REFERENCES Osoby 
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Wyplaty(
	PESEL_dentysty CHAR(11) REFERENCES Dentysci(PESEL),
	Data DATE,
	Kwota INT CHECK (Kwota > 0) NOT NULL,
	Premia INT CHECK (Premia > 0),
	PRIMARY KEY(PESEL_dentysty, Data),
	CONSTRAINT ogr_wyplaty FOREIGN KEY (PESEL_dentysty) REFERENCES Dentysci 
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Oddzialy(
	Nr_oddzialu INT CHECK (Nr_oddzialu > 0) PRIMARY KEY,
	Ulica VARCHAR(30) CHECK (Ulica NOT LIKE '%[^a-zA-Z ]%' and Ulica LIKE '[A-Z]%') NOT NULL,
	Numer_budynku INT CHECK (Numer_budynku > 0) NOT NULL,
	UNIQUE(Ulica, Numer_budynku)
);

CREATE TABLE Sale(
	Nr_sali INT CHECK (Nr_sali > 0),
	Nr_oddzialu INT REFERENCES Oddzialy,
	PRIMARY KEY(Nr_sali, Nr_oddzialu),
	CONSTRAINT ogr_sale FOREIGN KEY (Nr_oddzialu) REFERENCES Oddzialy(Nr_oddzialu)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Uslugi(
	Nazwa VARCHAR(50) CHECK (Nazwa NOT LIKE '%[^a-z ]%') PRIMARY KEY,
	Cena INT CHECK (Cena > 0) NOT NULL,
	Czas INT CHECK (Czas > 0) NOT NULL
);

CREATE TABLE Wizyty(
	PESEL_pacjenta CHAR(11) REFERENCES Pacjenci(PESEL),
	Data DATE,
	Godzina TIME,
	Ocena_wizyty INT CHECK (Ocena_wizyty BETWEEN 1 AND 5),
	Opinia CHAR(256),
	Odbyla_sie BIT NOT NULL,
	PESEL_dentysty CHAR(11) REFERENCES Dentysci(PESEL) NOT NULL,
	Nr_sali INT NOT NULL,
	Nr_oddzialu INT NOT NULL,
	PRIMARY KEY(PESEL_pacjenta, Data, Godzina),
	FOREIGN KEY(Nr_sali, Nr_oddzialu) REFERENCES Sale(Nr_sali, Nr_oddzialu),
	CONSTRAINT ogr_wizyty1 FOREIGN KEY (PESEL_pacjenta) REFERENCES Pacjenci 
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT ogr_wizyty2 FOREIGN KEY (Nr_sali, Nr_oddzialu) REFERENCES Sale
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Oferowanie_uslugi(
	Nazwa VARCHAR(50) REFERENCES Uslugi(Nazwa),
	PESEL_pacjenta CHAR(11),
	Data DATE,
	Godzina TIME,
	FOREIGN KEY(PESEL_pacjenta, Data, Godzina) REFERENCES Wizyty(PESEL_pacjenta, Data, Godzina),
	PRIMARY KEY(Nazwa, PESEL_pacjenta, Data, Godzina),
	CONSTRAINT ogr_oferowanie_uslugi FOREIGN KEY (PESEL_pacjenta, Data, Godzina) REFERENCES Wizyty 
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT ogr_oferowanie_uslugi2 FOREIGN KEY (Nazwa) REFERENCES Uslugi
		ON UPDATE CASCADE ON DELETE CASCADE
);