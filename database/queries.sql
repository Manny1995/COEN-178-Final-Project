-- Generate a list of rental properties available for a specific branch (where the name of the branch is entered as input), along with the manager’s name.

create or replace function query_1(b_name IN  branch.branchName%type)
--create or replace function query_1(b_name IN  branch.branchName%type, m_firstName IN manager.firstName%type, m_lastName IN manager.lastName%type)
/* make the type of the orderno_param the same type as the orderno column in ORDER_5 table.*/
return sys_refcursor is /* Should return a string */
  returnCursor sys_refcursor;
  m_managerID manager.employeeID%type;

BEGIN
    open returnCursor for select r.streetNumber || ' ' || r.streetName || ' ' || r.city || ' ' || r.zip as address, m.firstName ||  ' ' || m.lastName as fullName from rentalProperty r inner join
      supervisor s on s.employeeID = r.supervisorID inner join
	manager m on m.employeeID = s.managerID where m.employeeID =
	  (select managerID from branch where branchName = b_name) and r.status = 'available';
 --     open returnCursor for select street from rentalProperty where supervisorID inner join supervisor on rentalProperty.supervisorID = supervisor.supervisorID

    return returnCursor;
END;
/
Show Errors


--select street, manager.firstName from rentalProperty, supervisor, manager;

create or replace function query_2
return sys_refcursor is
  returnCursor sys_refcursor;

begin
  open returnCursor for select firstName ||  ' ' || lastName as fullName, streetNumber || ' ' || streetName || ' ' || city || ' ' || zip as address from supervisor inner join rentalProperty on supervisor.employeeID = rentalProperty.supervisorID;
  return returnCursor;
end;
/
show errors

create or replace function query_3(b_name in branch.branchName%type, o_firstName in propertyOwner.firstName%type, o_lastName in propertyOwner.lastName%type)
return sys_refcursor is
  returnCursor sys_refcursor;
  tempCursor sys_refcursor;
  m_ID manager.employeeID%type;
begin
--  open tempCursor for select managerID into m_ID from branch where branchName = b_name;

  open returnCursor for select streetNumber || ' ' || streetName || ' ' || city || ' ' || zip as address from rentalProperty where ownerID =
    (select ownerID from propertyOwner where firstName = o_firstName and lastName = o_lastName) and supervisorID in
      (select employeeID from supervisor where managerID = (select managerID from branch where branchName = b_name));

  return returnCursor;
end;
/
show errors

create or replace function query_4(m_city in rentalProperty.city%type, m_rooms in rentalProperty.rooms%type, m_lowest in rentalProperty.rent%type, m_highest in rentalProperty.rent%type)
return sys_refcursor is
returnCursor sys_refcursor;
begin
open returnCursor for select streetNumber || ' ' || streetName || ' ' || city || ' ' || zip as address, rooms, rent from rentalProperty where city = m_city and rooms = m_rooms and rent between m_lowest and m_highest;
return returnCursor;
end;
/
show errors


-- branch name needed?
create or replace function query_5
return sys_refcursor is
  returnCursor sys_refcursor;
begin
--  open returnCursor for select count(*), b.branchNumber from rentalProperty r inner join supervisor s on s.employeeID = r.supervisorID natural join branch b group by branchNumber;
  open returnCursor for select count(*), b.branchNumber from rentalProperty r inner join supervisor s on s.employeeID = r.supervisorID inner join branch b on b.managerID = s.managerID group by branchNumber;

  return returnCursor;
end;
/
show errors

create or replace procedure query_6(
m_propertyID in leaseAgreement.propertyID%type,
m_firstName in leaseAgreement.firstName%type,
m_lastName in leaseAgreement.lastName%type,
m_homePhone in leaseAgreement.homePhone%type,
m_workPhone in leaseAgreement.workPhone%type,
m_contactFirstName in leaseAgreement.contactFirstName%type,
m_contactLastName in leaseAgreement.contactLastName%type,
m_contactPhone in leaseAgreement.contactPhone%type,
m_startDate in varchar2,
m_endDate in varchar2,
m_rent in leaseAgreement.depositAmount%type)
as
 isAdded varchar(10);
 m_rentalID rentalProperty.rentalID%type;
 tempCursor sys_refcursor;

  m_start date;
  m_end date;
  m_rentAmount leaseAgreement.rentAmount%type;

begin


  m_start := to_date(m_startDate, 'YYYY.MM.DD.');
  m_end := to_date(m_endDate, 'YYYY.MM.DD.');

  select rent into m_rentAmount from rentalProperty where rentalID = m_propertyID;

  insert into leaseAgreement values (
    lease_sequence.nextVal,
    m_propertyID,
    m_firstName,
    m_lastName,
    m_homePhone,
    m_workPhone,
    m_contactFirstName,
    m_contactLastName,
    m_contactPhone,
    m_start,
    m_end,
    m_rentAmount,
    m_rentAmount
  );
end;
/
show errors


--ask whether we need to display the property address!
create or replace function query_7(m_firstName in leaseAgreement.firstName%type, m_lastName in leaseAgreement.lastName%type)
return sys_refcursor is
  returnCursor sys_refcursor;
begin
	open returnCursor for select leaseID, firstName ||  ' ' || lastName as fullName, homePhone, workPhone, contactFirstName || ' ' || contactLastName as contactName, contactPhone, startDate, endDate, depositAmount, rentAmount from leaseAgreement where firstName = m_firstName and lastName = m_lastName;
	return returnCursor;
end;
/
show errors


create or replace function query_8
return sys_refcursor is
  returnCursor sys_refcursor;
begin
--  open returnCursor for select A.firstName ||  ' ' || A.lastName as fullName from leaseAgreement A, leaseAgreement B where A.firstName = B.firstName and A.lastName = B.lastName and A.leaseID < B.leaseID and A.leaseID <> B.leaseID;
  open returnCursor for select firstName || ' ' || lastName as fullName from leaseAgreement group by firstName, lastName having count(*) > 1;
  return returnCursor;
end;
/
show errors


create or replace function query_9(c_name in rentalProperty.city%type)
return sys_refcursor is
returnCursor sys_refcursor;
begin
  open returnCursor for select avg(rent), city from rentalProperty group by city having city = c_name;
  return returnCursor;
end;
/
show errors


create or replace function query_10
return sys_refcursor is
returnCursor sys_refcursor;
begin
  open returnCursor for select streetNumber || ' ' || streetName || ' ' || city || ' ' || zip as address, firstName || ' ' || lastName as fullName, endDate from leaseAgreement inner join rentalProperty on leaseAgreement.propertyID = rentalProperty.rentalID
    where months_between(endDate, sysdate) <= 2 and status = 'leased';
  return returnCursor;
end;
/
show errors


  Prompt Queries

 select query_1('Sodasopa Branch') from dual;
 select query_2 from dual;
 select query_3('Sodasopa Branch', 'Butters', 'Stotch') from dual;
 select query_4('Santa Clara', 4, 0, 500) from dual;
 select query_5 from dual;
 execute query_6('r6', 'Manny', 'Amirtharaj', '1231231234', '1231231234', 'Tyrone', 'Jackson', '1231231234', date '2016-01-03', date '2016-09-03', 30.50);
 select query_7('Manny', 'Amirtharaj') from dual;
 select query_8 from dual;
 select query_9('Santa Clara') from dual;
 select query_10 from dual;
