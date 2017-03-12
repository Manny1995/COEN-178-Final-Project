insert into manager values('m1', 'Butters', 'Stotch', '4088874946', date '2016-11-06');
insert into manager values('m2', 'Scott', 'Tenorman', '4088361512', date '2016-10-06');
insert into manager values('m3', 'Filmore', 'Anderson', '4089040932', date '2016-09-03');


insert into branch values (1, 'Sodasopa Branch', '4088874946', '10480', 'CtPa', 'Santa Clara', '95014', 'm1');
insert into branch values (2, 'CtPa Branch', '4088874946', '10480', 'Sodasopa.', 'Cupertino', '95014', 'm2');
insert into branch values (3, 'Other Branch', '4088874946', '10480', 'Whole Foods Lane', 'South Park', '95014', 'm3');
prompt add second manager for same branch - constraint: one branch can only have one manager
insert into branch values (3, 'Other Branch', '4088874946', '10480', 'Whole Foods Lane', 'South Park', '95014', 'm4');
prompt add second branch for same manager - constraint: one manager manages one branch
insert into branch values (4, 'Other Branch', '4088874946', '10480', 'Whole Foods Lane', 'South Park', '95014', 'm3');


insert into supervisor values ('s1', 'PC', 'Principal', '4089123234', date '2017-04-09', 'm1');
insert into supervisor values ('s2', 'Stan', 'Marsh', '6500129834', date '2016-05-09', 'm1');
insert into supervisor values ('s3', 'Eric', 'Cartman', '1239540924', date '2016-03-08', 'm1');


insert into staff values ('st1', 'PC', 'Principal', '4089123234', date '2017-04-09', 1);
insert into staff values ('st2', 'Stan', 'Marsh', '6500129834', date '2016-05-09', 2);
insert into staff values ('st3', 'Eric', 'Cartman', '1239540924', date '2016-03-08', 1);


insert into supervisor values ('s4', 'Wendy', 'Testaburger', '4089123234', date '2017-04-09', 'm2');
insert into supervisor values ('s5', 'Token', 'Black', '6500129834', date '2016-04-03', 'm2');

insert into supervisor values ('s6', 'Scott', 'Malkinson', '1239540924', date '2016-09-08', 'm3');


insert into propertyOwner values ('o1', 'Kyle', 'Brofloski', '4088874946', 100, '10480', 'Alviso Street.', 'Santa Clara', '95014');
insert into propertyOwner values ('o2', 'Towelie', 'Towel', '4088874946', 100, '10480', 'Monta Vista Dr.', 'Cupertino', '95014');
insert into propertyOwner values ('o3', 'Kenny', 'McKormick', '4088874946', 100, '10480', 'Infinite Loop', 'Cupertino', '95014');


insert into rentalProperty values ('r1', 'o1', 's1', '21', 'Jump St', 'Santa Clara', '95014', 4, 100, 'available', date '2016-11-11');
insert into rentalProperty values ('r2', 'o2', 's1', '22', 'Jump St', 'Santa Clara', '95014', 4, 430, 'available', date '2016-10-11');
insert into rentalProperty values ('r3', 'o3', 's2', '9842', 'Washington St', 'Cupertino', '95014', 4, 420, 'leased', date '2016-09-11');
insert into rentalProperty values ('r5', 'o3', 's1', '9844', 'Washington Ave', 'San Jose', '95243', 2, 250, 'available', date '2016-05-11');
prompt constraint: a supervisor cannot manage more than three properties
insert into rentalProperty values ('r4', 'o1', 's1', '9844', 'Washington Ave', 'San Jose', '95243', 2, 250, 'available', date '2016-05-11');


insert into rentalProperty values ('r4', 'o2', 's2', '233', 'Alviso St', 'Cupertino', '95014', 2, 100, 'available', date '2017-11-11');
insert into rentalProperty values ('r6', 'o3', 's6', '14893', 'Lafayette', 'Cupertino', '95014', 9, 420, 'leased', date '2018-11-19');

prompt constraint: a lease agreement should be for a minimum of six months and a maximum of one year
insert into leaseAgreement values (lease_sequence.nextVal, 'r1', 'Craig', 'Tucker', '4086963456', '1234567890', 'Tweek', 'Tweaker', '4327890987', date '2016-1-1', date '2016-6-1', 100, 100);
insert into leaseAgreement values (lease_sequence.nextVal, 'r2', 'Craig', 'Tucker', '4086963456', '1234567890', 'Tweek', 'Tweaker', '4327890987', date '2016-1-1', date '2018-7-1', 430, 430);

prompt constraint: If a lease agreement = 6 month, increase the rent by 1.1
insert into leaseAgreement values (lease_sequence.nextVal, 'r3', 'Craig', 'Tucker', '4086963456', '1234567890', 'Tweek', 'Tweaker', '4327890987', date '2016-1-1', date '2016-7-1', 462, 462);

prompt constraint: when a lease agreement is created, the status should be changed to leased
select rentalID, status from rentalProperty where rentalID = 'r1';
insert into leaseAgreement values (lease_sequence.nextVal, 'r1', 'Craig', 'Tucker', '4086963456', '1234567890', 'Tweek', 'Tweaker', '4327890987', date '2016-1-1', date '2016-7-1', 100, 110);
select rentalID, status from rentalProperty where rentalID = 'r1';

Prompt When a rental property is removed from the list of rentals, it should also be removed from its supervisor’s list.
select * from rentalProperty where status = 'available';
select firstName ||  ' ' || lastName as fullName, streetNumber || ' ' || streetName || ' ' || city || ' ' || zip as address from supervisor inner join rentalProperty on supervisor.employeeID = rentalProperty.supervisorID where status = 'available';
update rentalProperty set status = 'leased' where rentalID = 'r4';
select * from rentalProperty where status = 'available';
select firstName ||  ' ' || lastName as fullName, streetNumber || ' ' || streetName || ' ' || city || ' ' || zip as address from supervisor inner join rentalProperty on supervisor.employeeID = rentalProperty.supervisorID where status = 'available';


Prompt With every new lease, a 10% increase in rent should be added to the rent from the previous lease.
select rentalID, rent from rentalProperty where rentalID = 'r5';
insert into leaseAgreement values (lease_sequence.nextVal, 'r5', 'Craig', 'Tucker', '4086963456', '1234567890', 'Tweek', 'Tweaker', '4327890987', date '2016-1-1', date '2016-8-1', 250, 250);
select rentalID, rent from rentalProperty where rentalID = 'r5';



--insert into leaseAgreement values (lease_sequence.nextVal, 'r3', 'Randy', 'Marsh', '4086963456', '1234567890', 'Token', 'Black', '4327890987', date '2015-10-10', date '2016-6-6', 1000, 400);

-- delete from rentalProperty;
-- delete from propertyOwner;
-- delete from employee;
-- delete from branch;
--select firstName, street from supervisor inner join rentalProperty on supervisor.employeeID = rentalProperty.supervisorID;

--select street from rentalProperty where supervisorID in (select employeeID from supervisor where managerID in (select employeeID from manager natural join branch where branchNumber = 1 and firstName = 'Butters' and lastName = 'Stotch')) and status = 'available';

--select street from rentalProperty where ownerID in (select ownerID from propertyOwner where firstName = 'Kyle' and lastName = 'Brofloski') and supervisorID in (select employeeID from supervisor where branchNumber = 1);

--select avg(rent), city from rentalProperty group by city having city = 'Santa Clara';
