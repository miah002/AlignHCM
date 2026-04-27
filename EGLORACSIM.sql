/**********************************************************************************

EGLORACSIM: Oracle GL Export

FormatCode:     EGLORACSIM
Project:        Oracle GL Export
Client ID:      SIM1010
Date/time:      2022-09-19 12:52:39.213
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N35
Server:         N3SUP5DB02
Database:       ULTIPRO_SMPF
Web Filename:   SIM1010_V6JM6_EEHISTORY_EGLORACSIM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EGLORACSIM_SavePath') IS NOT NULL DROP TABLE dbo.U_EGLORACSIM_SavePath


-----------
-- Create U_dsi_RipoutParms if it doesn't exist
-----------

IF OBJECT_ID('U_dsi_RipoutParms') IS NULL BEGIN

   CREATE TABLE dbo.U_dsi_RipoutParms (
   rpoFormatCode  VARCHAR(10)   NOT NULL,
   rpoParmType    VARCHAR(64)   NOT NULL,
   rpoParmValue01 VARCHAR(1024) NULL,
   rpoParmValue02 VARCHAR(1024) NULL,
   rpoParmValue03 VARCHAR(1024) NULL,
   rpoParmValue04 VARCHAR(1024) NULL,
   rpoParmValue05 VARCHAR(1024) NULL
)
END


-----------
-- Clear U_dsi_RipoutParms
-----------

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EGLORACSIM'


-----------
-- Add paths to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02)
SELECT

FormatCode,
'Path',
CfgName,
CfgValue

FROM dbo.U_Dsi_Configuration
WHERE FormatCode = 'EGLORACSIM'
AND CfgName LIKE '%path%'


-----------
-- Add AscExp expSystemIDs to U_dsi_RipoutParms
-----------

INSERT INTO dbo.U_dsi_RipoutParms (rpoFormatCode, rpoParmType, rpoParmValue01, rpoParmValue02) 
SELECT

ExpFormatCode,
'expSystemID',
ExpExportCode,
ExpSystemID

FROM dbo.AscExp
WHERE ExpFormatCode = 'EGLORACSIM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EGLORACSIM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EGLORACSIM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EGLORACSIM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EGLORACSIM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EGLORACSIM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EGLORACSIM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EGLORACSIM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EGLORACSIM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EGLORACSIM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EGLORACSIM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEGLORACSIM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEGLORACSIM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EGLORACSIM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGLORACSIM];
GO
IF OBJECT_ID('U_EGLORACSIM_GlBase') IS NOT NULL DROP TABLE [dbo].[U_EGLORACSIM_GlBase];
GO
IF OBJECT_ID('U_EGLORACSIM_File') IS NOT NULL DROP TABLE [dbo].[U_EGLORACSIM_File];
GO
IF OBJECT_ID('U_EGLORACSIM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EGLORACSIM_EEList];
GO
IF OBJECT_ID('U_EGLORACSIM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGLORACSIM_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EGLORACSIM','Oracle GL Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EGLORACSIMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGLORACSIMZ0','500','H','01','1',NULL,'Company',NULL,NULL,'"Company"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGLORACSIMZ0','500','H','01','2',NULL,'Segment',NULL,NULL,'"Segment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGLORACSIMZ0','500','H','01','3',NULL,'Chg Location',NULL,NULL,'"Chg Location"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGLORACSIMZ0','500','H','01','4',NULL,'Cost Center',NULL,NULL,'"Cost Center"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGLORACSIMZ0','500','H','01','5',NULL,'Base Account',NULL,NULL,'"Base Account"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGLORACSIMZ0','500','H','01','6',NULL,'Debit',NULL,NULL,'"Debit"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGLORACSIMZ0','500','H','01','7',NULL,'Credit',NULL,NULL,'"Credit"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGLORACSIMZ0','500','H','01','8',NULL,'Description',NULL,NULL,'"Description"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGLORACSIMZ0','500','H','01','9',NULL,'Job',NULL,NULL,'"Job"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGLORACSIMZ0','500','D','10','1',NULL,'Company',NULL,NULL,'"drvCompany"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGLORACSIMZ0','500','D','10','2',NULL,'Segment',NULL,NULL,'"drvSegment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGLORACSIMZ0','500','D','10','3',NULL,'Chg Location',NULL,NULL,'"drvChgLocation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGLORACSIMZ0','500','D','10','4',NULL,'Cost Center',NULL,NULL,'"drvCostCenter"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGLORACSIMZ0','500','D','10','5',NULL,'Base Account',NULL,NULL,'"drvBaseAccount"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGLORACSIMZ0','500','D','10','6',NULL,'Debit',NULL,NULL,'"drvDebit"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGLORACSIMZ0','500','D','10','7',NULL,'Credit',NULL,NULL,'"drvCredit"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGLORACSIMZ0','500','D','10','8',NULL,'Description',NULL,NULL,'"drvDescription"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGLORACSIMZ0','500','D','10','9',NULL,'Job',NULL,NULL,'"drvJob"','(''UA''=''Q,'')');

-----------
-- Build web filename
-----------

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME, 3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME, 2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME, 3) ELSE LEFT(@@SERVERNAME, 2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME, 2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME, 3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FileName varchar(1000) = 'EGLORACSIM_20220919.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','VVETB',NULL,NULL,NULL,'Oracle GL JDE CAN','202205059','EMPEXPORT','EJDECANGL',NULL,'EGLORACSIM',NULL,NULL,NULL,'202205059','Feb 10 2022  8:56AM','Feb 10 2022  8:56AM','202205051',NULL,'','','202205051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',UYQT9,UYF3T,UYGA3,UYFUB',NULL,NULL,NULL,'Oracle GL JDE USA','202204079','EMPEXPORT','EJDEUSAGL',NULL,'EGLORACSIM',NULL,NULL,NULL,'202204079','Feb 10 2022  8:56AM','Feb 10 2022  8:56AM','202204071',NULL,'','','202204071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','UYQT9,UYF3T,UYGA3,UYFUB',NULL,NULL,NULL,'Oracle GL Export','202205059','EMPEXPORT','EORACLEGL',NULL,'EGLORACSIM',NULL,NULL,NULL,'202205059','Feb 10 2022  8:56AM','Feb 10 2022  8:56AM','202205051',NULL,'eecPaygroup','HRLYUS,SALNUS,SALUS','202205051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','InitialSort','C','drvCompany');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','SubSort','C','drvBaseAccount');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGLORACSIM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGLORACSIM','D10','dbo.U_EGLORACSIM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EGLORACSIM_drvTbl
-----------

IF OBJECT_ID('U_EGLORACSIM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGLORACSIM_drvTbl] (
    [drvCompany] varchar(255) NULL,
    [drvSegment] varchar(255) NULL,
    [drvChgLocation] varchar(255) NULL,
    [drvCostCenter] varchar(255) NULL,
    [drvBaseAccount] varchar(255) NULL,
    [drvDebit] varchar(255) NULL,
    [drvCredit] varchar(255) NULL,
    [drvDescription] varchar(255) NULL,
    [drvJob] varchar(255) NULL
);

-----------
-- Create table U_EGLORACSIM_EEList
-----------

IF OBJECT_ID('U_EGLORACSIM_EEList') IS NULL
CREATE TABLE [dbo].[U_EGLORACSIM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EGLORACSIM_File
-----------

IF OBJECT_ID('U_EGLORACSIM_File') IS NULL
CREATE TABLE [dbo].[U_EGLORACSIM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EGLORACSIM_GlBase
-----------

IF OBJECT_ID('U_EGLORACSIM_GlBase') IS NULL
CREATE TABLE [dbo].[U_EGLORACSIM_GlBase] (
    [MapGLAcctNumber] varchar(50) NULL,
    [MapCompany] varchar(255) NULL,
    [MapSegment] varchar(255) NULL,
    [MapChgLocation] varchar(255) NULL,
    [MapCostCenter] varchar(255) NULL,
    [MapBaseAccount] varchar(255) NULL,
    [MapJob] varchar(255) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGLORACSIM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Simmons Prepared Foods, Inc.

Created By: Jose Sotolongo
Business Analyst: Gail Yates
Create Date: 02/10/2022
Service Request Number: SR-2022-00348605

Purpose: Oracle GL Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EGLORACSIM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EGLORACSIM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EGLORACSIM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EGLORACSIM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EGLORACSIM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGLORACSIM', 'EORACLEGL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGLORACSIM', 'EJDEUSAGL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGLORACSIM', 'EJDECANGL';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EGLORACSIM', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EGLORACSIM';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    ---------------------------------
    -- Generate Map for accounts. Doing this as a outside table for performance reasons.
    ---------------------------------
    IF OBJECT_ID('U_EGLORACSIM_GlBase','U') IS NOT NULL
        DROP TABLE dbo.U_EGLORACSIM_GlBase;

    SELECT DISTINCT 
        MapGLAcctNumber        = vGLAcctNumber
        ,MapCompany            = CAST(NULL AS VARCHAR(255))
        ,MapSegment            = CAST(NULL AS VARCHAR(255))
        ,MapChgLocation        = CAST(NULL AS VARCHAR(255))
        ,MapCostCenter        = CAST(NULL AS VARCHAR(255))
        ,MapBaseAccount        = CAST(NULL AS VARCHAR(255))
        ,MapJob                = CAST(NULL AS VARCHAR(255))
    INTO dbo.U_EGLORACSIM_GlBase
    FROM dbo.vw_Dsi_Tmpalloc WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON vCOID = CmpCOID
    WHERE (
               (@ExportCode = 'EORACLEGL')
            OR (@ExportCode = 'EJDEUSAGL' AND CmpAddressCountry = 'USA')
            OR (@ExportCode = 'EJDECANGL' AND CmpAddressCountry = 'CAN')
          )
        AND vGLBaseSeg <> 'NOGL'
    ;

    UPDATE dbo.U_EGLORACSIM_GlBase
    SET MapCompany = CASE WHEN CHARINDEX('-',MapGLAcctNumber) > 1 THEN
                        SUBSTRING(dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','0','After',''),0,CHARINDEX('-',dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','0','After','')))
                        ELSE MapGLAcctNumber
                      END
        ,MapSegment = CASE WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) > 0 AND len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) <> 1 THEN
                        SUBSTRING(dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','1','After',''),0,CHARINDEX('-',dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','1','After','')))
                        WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) = 1 THEN
                            dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','1','After','')
                        ELSE ''
                      END
        ,MapChgLocation = CASE WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) > 1 AND len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) <> 2 THEN
                        SUBSTRING(dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','2','After',''),0,CHARINDEX('-',dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','2','After','')))
                        WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) = 2 THEN
                            dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','2','After','')
                        ELSE ''
                      END
        ,MapCostCenter = CASE WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) > 2 AND len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) <> 3 THEN
                        SUBSTRING(dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','3','After',''),0,CHARINDEX('-',dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','3','After','')))
                        WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) = 3 THEN
                            dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','3','After','')
                        ELSE ''
                      END
        ,MapBaseAccount = CASE WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) > 3 AND len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) <> 4 THEN
                        SUBSTRING(dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','4','After',''),0,CHARINDEX('-',dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','4','After','')))
                        WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) = 4 THEN
                            dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','4','After','')
                        ELSE ''
                      END
        ,MapJob = CASE WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) > 4 AND len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) <> 5 THEN
                            SUBSTRING(dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','5','After',''),0,CHARINDEX('-',dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','5','After','')))
                        WHEN len(MapGLAcctNumber) - len(replace(MapGLAcctNumber, '-', '')) = 5 THEN
                            dbo.dsi_fnlib_GetStringPart(RTRIM(LTRIM(MapGLAcctNumber)),'-','5','After','')
                        ELSE ''
                  END
        ;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EGLORACSIM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EGLORACSIM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGLORACSIM_drvTbl;
    SELECT DISTINCT
         drvCompany = MapCompany
        ,drvSegment = MapSegment
        ,drvChgLocation = MapChgLocation
        ,drvCostCenter = MapCostCenter
        ,drvBaseAccount = MapBaseAccount
        ,drvDebit = CAST(SUM(vDebitAmt) AS VARCHAR(255))
        ,drvCredit = CAST('0.00' AS VARCHAR(255))
        ,drvDescription = CAST(CONCAT(RTRIM(LTRIM(vCode)),' - ',LTRIM(RTRIM(VCodeDesc))) AS VARCHAR(255))
        ,drvJob = MapJob
    INTO dbo.U_EGLORACSIM_drvTbl
    FROM dbo.vw_Dsi_Tmpalloc WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON vCOID = CmpCOID
    JOIN dbo.U_EGLORACSIM_GlBase WITH (NOLOCK)
        ON vGLAcctNumber = MapGLAcctNumber
    WHERE (
               (@ExportCode = 'EORACLEGL')
            OR (@ExportCode = 'EJDEUSAGL' AND CmpAddressCountry = 'USA')
            OR (@ExportCode = 'EJDECANGL' AND CmpAddressCountry = 'CAN')
          )
        AND vGLBaseSeg <> 'NOGL'
        AND vDebitAmt > 0.00
    GROUP BY MapCompany, MapSegment, MapChgLocation, MapCostCenter, MapBaseAccount, MapJob,
             CONCAT(RTRIM(LTRIM(vCode)),' - ',LTRIM(RTRIM(VCodeDesc)))
    HAVING SUM(vDebitAmt) <> 0.00 OR SUM(vCreditAmt) <> 0.00
    ;

    ---------------------------------
    -- DETAIL RECORD - Now insert Credits
    ---------------------------------
    INSERT INTO dbo.U_EGLORACSIM_drvTbl
    SELECT DISTINCT
         drvCompany = MapCompany
        ,drvSegment = MapSegment
        ,drvChgLocation = MapChgLocation
        ,drvCostCenter = MapCostCenter
        ,drvBaseAccount = MapBaseAccount
        ,drvDebit = '0.00'
        ,drvCredit = CAST(SUM(vCreditAmt) AS VARCHAR(500))
        ,drvDescription = CONCAT(RTRIM(LTRIM(vCode)),' - ',LTRIM(RTRIM(VCodeDesc)))
        ,drvJob = MapJob

    FROM dbo.vw_Dsi_Tmpalloc WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON vCOID = CmpCOID
    JOIN dbo.U_EGLORACSIM_GlBase WITH (NOLOCK)
        ON vGLAcctNumber = MapGLAcctNumber
    WHERE (
               (@ExportCode = 'EORACLEGL')
            OR (@ExportCode = 'EJDEUSAGL' AND CmpAddressCountry = 'USA')
            OR (@ExportCode = 'EJDECANGL' AND CmpAddressCountry = 'CAN')
          )
        AND vGLBaseSeg <> 'NOGL'
        AND vCreditAmt > 0.00
    GROUP BY MapCompany, MapSegment, MapChgLocation, MapCostCenter, MapBaseAccount, MapJob,
             CONCAT(RTRIM(LTRIM(vCode)),' - ',LTRIM(RTRIM(VCodeDesc)))
    HAVING SUM(vDebitAmt) <> 0.00 OR SUM(vCreditAmt) <> 0.00
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEGLORACSIM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EGLORACSIM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EGLORACSIM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202031'
       ,expStartPerControl     = '202202031'
       ,expLastEndPerControl   = '202202109'
       ,expEndPerControl       = '202202109'
WHERE expFormatCode = 'EGLORACSIM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEGLORACSIM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EGLORACSIM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EGLORACSIM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EGLORACSIM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EGLORACSIM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGLORACSIM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EGLORACSIM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGLORACSIM', 'UseFileName', 'V', 'Y'


-- End ripout