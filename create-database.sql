-- author: Rohan Shah

CREATE TABLE Flight (
FLNO INT NOT NULL,
Meal VARCHAR(25),
Smoking VARCHAR(1),
PRIMARY KEY (FLNO)) ENGINE = InnoDB;

CREATE TABLE FlightInstance (
FLNO INT NOT NULL, 
FDate DATE NOT NULL,
PRIMARY KEY (FLNO, FDate),
FOREIGN KEY (FLNO) REFERENCES Flight (FLNO) ON UPDATE CASCADE) ENGINE = InnoDB;

CREATE TABLE Passenger (
ID INT NOT NULL,
Name VARCHAR(25),
Phone BIGINT(10),
PRIMARY KEY (ID)) ENGINE = InnoDB;

CREATE TABLE Pilot (
ID INT NOT NULL,
Name VARCHAR(25),
DateHired DATE,
PRIMARY KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE PlaneType (
Maker VARCHAR(25) NOT NULL,
Model VARCHAR(25) NOT NULL,
FlyingSpeed INT,
GroundSpeed INT,
PRIMARY KEY (Maker, Model)) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Airport (
Code VARCHAR(3) NOT NULL,
City VARCHAR(25),
State VARCHAR(3),
PRIMARY KEY (Code)) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Plane (
ID INT NOT NULL,
Maker VARCHAR(15),
Model VARCHAR(15),
LastMaint DATE,
LastMaintA VARCHAR(5),
PRIMARY KEY (ID),
FOREIGN KEY (Maker, Model) REFERENCES PlaneType (Maker, Model) ON UPDATE CASCADE,
FOREIGN KEY (LastMaintA) REFERENCES Airport (Code) ON UPDATE CASCADE) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE FlightLeg (
FLNO INT NOT NULL,
Seq INT NOT NULL,
FromA VARCHAR(5),
ToA VARCHAR(5),
DeptTime DATETIME,
ArrTime DATETIME,
Plane INT,
PRIMARY KEY (FLNO, Seq),
FOREIGN KEY (FLNO) REFERENCES Flight (FLNO) ON UPDATE CASCADE,
FOREIGN KEY (FromA) REFERENCES Airport (Code) ON UPDATE CASCADE,
FOREIGN KEY (ToA) REFERENCES Airport (Code) ON UPDATE CASCADE,
FOREIGN KEY (Plane) REFERENCES Plane (ID) ON UPDATE CASCADE) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Reservation (
PassID INT NOT NULL,
FLNO INT NOT NULL,
FDate DATE NOT NULL,
FromA VARCHAR(5),
ToA VARCHAR(5),
SeatClass VARCHAR(2),
DateBooked DATE,
DateCancelled DATE,
PRIMARY KEY (PassID, FLNO, FDate),
FOREIGN KEY (PassID) REFERENCES Passenger (ID) ON UPDATE CASCADE,
FOREIGN KEY (FLNO, FDate) REFERENCES FlightInstance (FLNO, FDate) ON UPDATE CASCADE,
FOREIGN KEY (FromA) REFERENCES Airport (Code) ON UPDATE CASCADE,
FOREIGN KEY (ToA) REFERENCES Airport (Code) ON UPDATE CASCADE) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE FlightLegInstance (
Seq INT NOT NULL,
FLNO INT NOT NULL,
FDate DATE NOT NULL,
ActDept DATETIME,
ActArr DATETIME,
Pilot INT,
PRIMARY KEY (Seq, FLNO, FDate),
FOREIGN KEY (FLNO, Seq) REFERENCES FlightLeg (FLNO, Seq) ON UPDATE CASCADE,
FOREIGN KEY (FLNO, FDate) REFERENCES FlightInstance (FLNO, FDate) ON UPDATE CASCADE,
FOREIGN KEY (Pilot) REFERENCES Pilot (ID) ON UPDATE CASCADE) ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE PlaneSeats (
Maker VARCHAR(15) NOT NULL,
Model VARCHAR(15) NOT NULL,
SeatType VARCHAR(3) NOT NULL,
NoOfSeats INT,
PRIMARY KEY (Maker, Model, SeatType),
FOREIGN KEY (Maker, Model) REFERENCES PlaneType (Maker, Model) ON UPDATE CASCADE) ENGINE = InnoDB DEFAULT CHARSET=latin1;
