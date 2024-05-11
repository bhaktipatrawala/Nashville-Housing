-- Cleaning data Using SQL Queries

-- Cleaning data Using SQL Queries

use [Portfolio Project]

select *
from [Portfolio Project].dbo.NashvilleHousing

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Standardization of Data Format
select SaleDate, CONVERT(Date, SaleDate) as SDate
from [Portfolio Project].dbo.NashvilleHousing


Update NashvilleHousing
set SaleDate =  CONVERT(Date, SaleDate)     -- dosent work well


-- Below Works
ALTER TABLE NashvilleHousing
ADD SaleDateConverted date;

Update NashvilleHousing
set SaleDateConverted =  CONVERT(Date, SaleDate)



select SaleDateConverted, CONVERT(Date, SaleDate) as SDate         
from [Portfolio Project].dbo.NashvilleHousing                   -- Checking if it worked

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Property Address data

select PropertyAddress
from [Portfolio Project].dbo.NashvilleHousing
where PropertyAddress is null

select *
from [Portfolio Project].dbo.NashvilleHousing
where PropertyAddress is null


-- We want the Null property address to be changed to the address which has occured in another instance having the same parcelID

select nh1.ParcelID, nh1.PropertyAddress, nh2.ParcelID,nh2.PropertyAddress, ISNULL(nh1.PropertyAddress, nh2.PropertyAddress)
from [Portfolio Project].dbo.NashvilleHousing nh1 JOIN [Portfolio Project].dbo.NashvilleHousing nh2
 on nh1.ParcelID = nh2.ParcelID and nh1.[UniqueID ]<> nh2.[UniqueID ]
 where nh1.PropertyAddress is null

 -- Update Query
 update nh1
 set PropertyAddress = ISNULL(nh1.PropertyAddress, nh2.PropertyAddress)
 from [Portfolio Project].dbo.NashvilleHousing nh1 JOIN [Portfolio Project].dbo.NashvilleHousing nh2
 on nh1.ParcelID = nh2.ParcelID and nh1.[UniqueID ]<> nh2.[UniqueID ]
 where nh1.PropertyAddress is null

 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Breaking PropertyAddress into individual columns (Address, City, State)
 select PropertyAddress
from [Portfolio Project].dbo.NashvilleHousing

--
select 
SUBSTRING(PropertyAddress,1,Charindex(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,Charindex(',', PropertyAddress)+1,len(PropertyAddress)) as City
from [Portfolio Project].dbo.NashvilleHousing 

-- Add to the table

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255);

Update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress,1,Charindex(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(100);

Update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress,Charindex(',', PropertyAddress)+1,len(PropertyAddress))

-- Checking 
select *
from [Portfolio Project].dbo.NashvilleHousing
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Splitting the OwnerAddress into Individual Components (without using Substrings)

select OwnerAddress
from [Portfolio Project].dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) as state,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) as city,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) as address
from [Portfolio Project].dbo.NashvilleHousing


 -- Add to the table
 
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(100);

Update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(100);

Update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

-- Checking

select *
from [Portfolio Project].dbo.NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Change Y to Yes and N to No in "Sold as Vacant" field

select distinct(SoldAsVacant),COUNT(SoldAsVacant)
from [Portfolio Project].dbo.NashvilleHousing
group by SoldAsVacant
order by 2

-- Write a Case Statement
select SoldAsVacant,
case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end

from [Portfolio Project].dbo.NashvilleHousing

-- Update the table
update sold
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Standardization of Data Format
select SaleDate, CONVERT(Date, SaleDate) as SDate
from [Portfolio Project].dbo.NashvilleHousing


Update NashvilleHousing
set SaleDate =  CONVERT(Date, SaleDate)     -- dosent work well


-- Below Works
ALTER TABLE NashvilleHousing
ADD SaleDateConverted date;

Update NashvilleHousing
set SaleDateConverted =  CONVERT(Date, SaleDate)



select SaleDateConverted, CONVERT(Date, SaleDate) as SDate         
from [Portfolio Project].dbo.NashvilleHousing                   -- Checking if it worked

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Property Address data

select PropertyAddress
from [Portfolio Project].dbo.NashvilleHousing
where PropertyAddress is null

select *
from [Portfolio Project].dbo.NashvilleHousing
where PropertyAddress is null


-- We want the Null property address to be changed to the address which has occured in another instance having the same parcelID

select nh1.ParcelID, nh1.PropertyAddress, nh2.ParcelID,nh2.PropertyAddress, ISNULL(nh1.PropertyAddress, nh2.PropertyAddress)
from [Portfolio Project].dbo.NashvilleHousing nh1 JOIN [Portfolio Project].dbo.NashvilleHousing nh2
 on nh1.ParcelID = nh2.ParcelID and nh1.[UniqueID ]<> nh2.[UniqueID ]
 where nh1.PropertyAddress is null

 -- Update Query
 update nh1
 set PropertyAddress = ISNULL(nh1.PropertyAddress, nh2.PropertyAddress)
 from [Portfolio Project].dbo.NashvilleHousing nh1 JOIN [Portfolio Project].dbo.NashvilleHousing nh2
 on nh1.ParcelID = nh2.ParcelID and nh1.[UniqueID ]<> nh2.[UniqueID ]
 where nh1.PropertyAddress is null

 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Breaking PropertyAddress into individual columns (Address, City, State)
 select PropertyAddress
from [Portfolio Project].dbo.NashvilleHousing

--
select 
SUBSTRING(PropertyAddress,1,Charindex(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,Charindex(',', PropertyAddress)+1,len(PropertyAddress)) as City
from [Portfolio Project].dbo.NashvilleHousing 

-- Add to the table

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255);

Update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress,1,Charindex(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(100);

Update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress,Charindex(',', PropertyAddress)+1,len(PropertyAddress))

-- Checking 
select *
from [Portfolio Project].dbo.NashvilleHousing
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Splitting the OwnerAddress into Individual Components (without using Substrings)

select OwnerAddress
from [Portfolio Project].dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) as state,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) as city,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) as address
from [Portfolio Project].dbo.NashvilleHousing


 -- Add to the table
 
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(100);

Update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(100);

Update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

-- Checking

select *
from [Portfolio Project].dbo.NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Change Y to Yes and N to No in "Sold as Vacant" field

select distinct(SoldAsVacant),COUNT(SoldAsVacant)
from [Portfolio Project].dbo.NashvilleHousing
group by SoldAsVacant
order by 2

-- Write a Case Statement
select SoldAsVacant,
case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end
from [Portfolio Project].dbo.NashvilleHousing

-- Update the table
update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

select *
from [Portfolio Project].dbo.NashvilleHousing;

-- Write CTE
with RowNumCTE as (
select *, 
		  ROW_NUMBER() over (
		  partition by  ParcelID,
						PropertyAddress,
						SalePrice,
						SaleDate,
						LegalReference
						Order by
							UniqueID
							) row_num
From [Portfolio Project].dbo.NashvilleHousing
	)
select * 
from RowNumCTE
where row_num > 1
order by PropertyAddress;

-- Delete Duplicates

with RowNumCTE as (
select *, 
		  ROW_NUMBER() over (
		  partition by  ParcelID,
						PropertyAddress,
						SalePrice,
						SaleDate,
						LegalReference
						Order by
							UniqueID
							) row_num
From [Portfolio Project].dbo.NashvilleHousing
	)
Delete 
from RowNumCTE
where row_num > 1
--order by PropertyAddress

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Delete Unused Column

select *
from [Portfolio Project].dbo.NashvilleHousing

Alter table [Portfolio Project].dbo.NashvilleHousing
drop column OwnerAddress,PropertyAddress

Alter table [Portfolio Project].dbo.NashvilleHousing
drop column SaleDate