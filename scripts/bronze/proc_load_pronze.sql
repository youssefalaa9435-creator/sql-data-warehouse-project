/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
/*-----------------------------------------*/
DECLARE @Start_time DATETIME ,@End_time DATETIME,@BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME;
/*-----------------------------------------*/

BEGIN TRY

SET @BATCH_START_TIME = GETDATE();

/*-----------------------------------------*/
PRINT '<<===========================>>';
PRINT '<-Loading Bronze Layer->';
PRINT '<<===========================>>';
PRINT '<<--------------------------->>';
PRINT '<----Loading CRM Tables---->';
PRINT '<<--------------------------->>';
print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
/*-----------------------------------------*/

SET @Start_time = GETDATE();
PRINT 'Truncating Table : bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;
PRINT '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
PRINT 'Inserting Data Into : bronze.crm_cust_info';
PRINT '------------------------------>>';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\pc\OneDrive\Desktop\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @End_time = GETDATE();
PRINT'<< LOAD DURATION = '+ CAST(DATEDIFF(SECOND,@Start_time,@End_time)AS NVARCHAR)+' SECOND >>';
PRINT '<<------------------------------------->>';

/*-----------------------------------------*/
/*-----------------------------------------*/

PRINT 'Truncating Table : bronze.crm_prd_info';
SET @Start_time = GETDATE();
TRUNCATE TABLE bronze.crm_prd_info;
PRINT '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
PRINT 'Inserting Data Into : bronze.crm_prd_info';
PRINT '------------------------------>>';

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\pc\OneDrive\Desktop\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @End_time = GETDATE();
PRINT'<< LOAD DURATION = '+ CAST(DATEDIFF(SECOND,@Start_time,@End_time)AS NVARCHAR)+' SECOND >>';
PRINT '<<------------------------------------->>'

/*-----------------------------------------*/
/*-----------------------------------------*/

PRINT 'Truncating Table : bronze.crm_sales_details';
SET @Start_time = GETDATE();
TRUNCATE TABLE bronze.crm_sales_details;
PRINT '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
PRINT 'Inserting Data Into : bronze.crm_sales_details';
PRINT '------------------------------>>';
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\pc\OneDrive\Desktop\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @End_time = GETDATE();
PRINT'<< LOAD DURATION = '+ CAST(DATEDIFF(SECOND,@Start_time,@End_time)AS NVARCHAR)+' SECOND >>';
PRINT '<<------------------------------------->>'

/*-----------------------------------------*/
/*-----------------------------------------*/

PRINT '<<--------------------------->>';
PRINT '<----Loading ERB Tables---->';
PRINT '<<--------------------------->>';

/*-----------------------------------------*/
/*-----------------------------------------*/

PRINT 'Truncating Table : bronze.erb_loc_a101';
SET @Start_time = GETDATE();
TRUNCATE TABLE bronze.erb_loc_a101;
PRINT '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
PRINT 'Inserting Data Into : bronze.erb_loc_a101';
PRINT '------------------------------>>';
BULK INSERT bronze.erb_loc_a101
FROM 'C:\Users\pc\OneDrive\Desktop\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @End_time = GETDATE();
PRINT'<< LOAD DURATION = '+ CAST(DATEDIFF(SECOND,@Start_time,@End_time)AS NVARCHAR)+' SECOND >>';
PRINT '<<------------------------------------->>'

/*-----------------------------------------*/
/*-----------------------------------------*/

PRINT 'Truncating Table : bronze.erb_cust_az12';
SET @Start_time = GETDATE();
TRUNCATE TABLE bronze.erb_cust_az12;
PRINT '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
PRINT 'Inserting Data Into : bronze.erb_cust_az12';
PRINT '------------------------------>>';
BULK INSERT bronze.erb_cust_az12
from 'C:\Users\pc\OneDrive\Desktop\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @End_time = GETDATE();
PRINT'<< LOAD DURATION = '+ CAST(DATEDIFF(SECOND,@Start_time,@End_time)AS NVARCHAR)+' SECOND >>';
PRINT '<<------------------------------------->>'

/*-----------------------------------------*/
/*-----------------------------------------*/

PRINT 'Truncating Table : bronze.erb_px_cat_g1v2';
SET @Start_time = GETDATE();
TRUNCATE TABLE bronze.erb_px_cat_g1v2;
PRINT '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>';
PRINT 'Inserting Data Into : bronze.erb_px_cat_g1v2';
PRINT '------------------------------>>';
BULK INSERT bronze.erb_px_cat_g1v2
from 'C:\Users\pc\OneDrive\Desktop\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @End_time = GETDATE();
PRINT'<< LOAD DURATION = '+ CAST(DATEDIFF(SECOND,@Start_time,@End_time)AS NVARCHAR)+' SECOND >>';
PRINT '<<------------------------------------->>';
SET @BATCH_END_TIME=GETDATE();
PRINT'<=======================================>';
PRINT'LOADING IS BRONZE LAYER IS COMBLETED';
PRINT'<=======================================>';
PRINT'<<-- TOTAL LOAD DURATION = '+CAST(DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME)AS NVARCHAR)+ ' SECOND -->>';
PRINT'<<=====================================>>';
/*-----------------------------------------*/
/*-----------------------------------------*/

END TRY
BEGIN CATCH
PRINT '<<============================================>>';
PRINT '<--ERORR OCCURED DURING LOADING BRONZE LAYER--> ';
PRINT '<--ERORR MESSAGE '+  ERROR_MESSAGE()+'-->';
PRINT '<--ERORR NUMBER ' +CAST ( ERROR_NUMBER() AS NVARCHAR)+'-->';
PRINT '<--ERORR STATE '  +CAST ( ERROR_STATE() AS NVARCHAR)+'-->';
PRINT '<<============================================>>';
END CATCH
END

