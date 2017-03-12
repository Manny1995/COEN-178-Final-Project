create table manager (
  employeeID varchar(5) primary key,
  firstName varchar(20),
  lastName varchar(20),
  phone varchar(10),
  startDate date
);

create table branch (
  branchNumber int primary key,
  branchName varchar(20) unique,
  phone varchar(10),
  streetNumber varchar(10),
  streetName varchar(20),
  city varchar(20),
  zip varchar(5),
  managerID varchar(5) unique,
  foreign key (managerID) references manager(employeeID)
);


create table supervisor (
  employeeID varchar(5) primary key,
  firstName varchar(20),
  lastName varchar(20),
  phone varchar(10),
  startDate date,
  managerID varchar(5),
  foreign key (managerID) references manager(employeeID)
);

create table staff (
  employeeID varchar(5) primary key,
  firstName varchar(20),
  lastName varchar(20),
  phone varchar(10),
  startDate date,
  branchNumber int
);


create table propertyOwner (
  ownerID varchar(5) primary key,
  firstName varchar(20),
  lastName varchar(20),
  phone varchar(10),
  fee number(10,2),
  streetNumber varchar(10),
  streetName varchar(20),
  city varchar(20),
  zip varchar(5)
);


create table rentalProperty (
  rentalID varchar(5) primary key,
  ownerID varchar(5),
  foreign key (ownerID) references propertyOwner(ownerID),
  supervisorID varchar(5),
  foreign key (supervisorID) references supervisor(employeeID),
  streetNumber varchar(10),
  streetName varchar(20),
  city varchar(20),
  zip varchar(5),
  rooms int,
  rent number(6,2),
  status varchar(10) check (status in ('available', 'leased')),
  startDate date 
);


create table leaseAgreement (
  leaseID int primary key,
  propertyID varchar(5),
  firstName varchar(20),
  lastName varchar(20),
  homePhone varchar(10),
  workPhone varchar(10),
  contactFirstName varchar(20),
  contactLastName varchar(20),
  contactPhone varchar(10),
  startDate date,
  endDate date,
  depositAmount number(10,2),
  rentAmount number(6,2),
  foreign key (propertyID) references rentalProperty(rentalID),
  check(months_between(endDate, startDate) >= 6 and months_between(EndDate, startDate) <=12)
);

--lease_sequence.nextValue
create sequence lease_sequence
start with 1
increment by 1
minvalue 1
maxvalue 100000000;
