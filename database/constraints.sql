-- change property status to leased 
create or replace trigger changePropertyStatus for insert on leaseAgreement
compound trigger
    
  m_rentalID leaseAgreement.propertyID%type;

  before each row is
  begin
    m_rentalID := :new.propertyID;
  end before each row;

  after statement is 
  begin
    update rentalProperty set status = 'leased' where rentalID = m_rentalID;
  end after statement;
end;
/
show errors;

-- a supervisor cannot supervise more than three rental properties at a time
create or replace trigger rentalConstraint for insert or update on rentalProperty
  compound trigger
    /* Declaration Section*/
    maxPrereq constant integer := 3;
    numRental integer := 1;
    target varchar(5);

  --ROW level
  before each row is
  begin
    target := :new.supervisorID;
  end before each row;

  --Statement level
  after statement is
   begin
     select count(*) into numRental from rentalProperty where supervisorID = target group by supervisorID;
     if numRental  > maxPrereq THEN
      RAISE_APPLICATION_ERROR(-20000,'Only 3 properties for each supervisor');
     end if;
   end after statement;
end;
/
show errors;

-- The rent for a 6 month lease is 10% more than the regular rent for that property
-- add 10% of rent to previous lease
create or replace trigger updateRent before insert on leaseAgreement
for each row
declare
  m_origRentAmount leaseAgreement.rentAmount%type;
begin
  select rent into m_origRentAmount from rentalProperty where rentalID = :new.propertyID;
  if (:new.rentAmount != m_origRentAmount * 1.1 and months_between(:new.endDate, :new.startDate) = 6) 
  then
    --RAISE_APPLICATION_ERROR(-20000, 'For a property with a 6 month lease, the rent should be greater than or equal to 10%')
    :new.rentAmount := m_origRentAmount * 1.1;
  end if;
 
end;
/
show errors;

create or replace trigger updateNextLeaseRent for insert on leaseAgreement
  compound trigger
    /* Declaration Section*/
    
    m_rentalID rentalProperty.rentalID%type;
    m_newRent leaseAgreement.rentAmount%type;

    
  --ROW level
  before each row is
  begin
    m_rentalID := :new.propertyID;
    m_newRent := :new.rentAmount;
  end before each row;

  --Statement level
  after statement is
   begin
     update rentalProperty set rent = 1.1 * m_newRent where rentalID = m_rentalID;
   end after statement;
end;
/
show errors;

create or replace trigger addFee for insert on rentalProperty
compound trigger
   m_rentalID rentalProperty.rentalID%type;

  before each row is
  begin
    m_rentalID := :new.rentalID;
  end before each row;

  after statement is
  begin
    update propertyOwner set fee = fee + 400 where ownerID in (select ownerID from rentalProperty where rentalID = m_rentalID);
  end after statement;
end;
/
show errors;
