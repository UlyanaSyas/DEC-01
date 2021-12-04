/*
1. ??????? ??? ?????? ???? ???????, 5 ??.:
*/

-- 1

select
*
from
[HumanResources].[Employee];

-- 2

select
*
from
[Person].[Person];

-- 3
select
*
from
[Person].[EmailAddress];

-- 4

select
*
from
[Production].[Document];

-- 5

select
*
from
[Purchasing].[Vendor];

/*
2. ??????? ?? ????? ?????? ???? ????? ?? ??????, 5??.:
*/

-- 1

select
BusinessEntityID,
PersonType,
NameStyle
from
[Person].[Person];

-- 2

select
BusinessEntityID,
EmailAddressID,
EmailAddress
from
[Person].[EmailAddress];

-- 3

select
BusinessEntityID,
NationalIDNumber,
LoginID
from
[HumanResources].[Employee];

-- 4

select
DocumentNode,
DocumentLevel,
Title
from
[Production].[Document];

-- 5

select
BusinessEntityID,
AccountNumber,
Name
from
[Purchasing].[Vendor];

/* 3. ??????? ? ???????? ???????????? ??????? ? ???????, ????????? ?????????, 5 ??.:
*/

-- 1

select
Name,
GroupName
from
[HumanResources].[Department];

-- 2

select
LoginID,
JobTitle
from
[HumanResources].[Employee];

-- 3

select
Name,
CountryRegionCode
from
[Person].[CountryRegion];

-- 4

select
BusinessEntityID,
CreditCardID
from
[Sales].[PersonCreditCard];

-- 5

select
BusinessEntityID,
FirstName,
LastName
from
[Person].[Person];