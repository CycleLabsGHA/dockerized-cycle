#
# This Feature smoke tests core connection types with Cycle
#
Feature: CI Infrastructure

#
# Import our configuration file that links either our dev/local secrets (local.conf), or our production secrets (secrets.conf) Jenkins/Azure DevOps Secret variables to Cycle variables.
#

Background:
If I verify file "combined/local.conf" exists
Then I assign values from config file "combined/local.conf" to variables
Else I assign values from config file "combined/secrets.conf" to variables
EndIf

@db
Scenario: SQL Server - Cycle CI
When I connect to Microsoft SQLServer database at "mssql2019.ci.cyclelabs.io" logged in as "cycl" with password $pw_sql_db
And I execute SQL "SELECT TOP 1 CityName FROM [cycl-ci-wwi].Application.Cities where [CityName] = 'Atlanta';"
Then I verify SQL status is 0

@db
Scenario: Azure SQL Server - Cycle CI
When I connect to Microsoft SQLServer database at "cyclesql4782.database.windows.net;Database=cycle" logged in as "CloudSAe82b3f46" with password $pw_azuresql
	And I execute SQL "SELECT TOP 1 [LastName],[FirstName],[Address],[City] FROM [dbo].[Persons]"
Then I verify SQL status is 0

@db
Scenario: DB2 - Cycle CI
When I connect to DB2 database "SAMPLE" at "db2.ci.cyclelabs.io:50000" logged in as "db2inst1" with password $pw_db2
	And I execute SQL "SELECT service_level, fixpack_num, bld_level FROM TABLE (sysproc.env_get_inst_info()) as A;"
Then I verify SQL status is 0

@db
Scenario: MySQL - Cycle CI
When I connect to MySQL database "employees" at "mysql57.ci.cyclelabs.io" port 3306 logged in as "employees" with password $pw_mysql
	And I execute SQL "select * from departments where dept_name = 'Development';"
Then I verify SQL status is 0


@term
Scenario: Telnet/Linux - Cycle CI
Given I open terminal connected to "telnet.ci.cyclelabs.io:23" sized to 25 lines and 80 columns
When I see "login:" on last line in terminal within 15 seconds
	And I enter "cycl-ci" in terminal
	And I see "assword:" on last line in terminal within 15 seconds
	And I enter $pw_telnet in terminal
Then I see "~]$" on last line in terminal within 15 seconds
	And I close terminal

@term
Scenario: OpenSSH/Linux - Cycle CI
When I open terminal with SSH encryption connected to "openssh.ci.cyclelabs.io:22" logged in as "cycl-ci" $pw_openssh sized to 25 lines and 80 columns
Then I see "~]$" on last line in terminal within 15 seconds
	And I close terminal
   
@moca
Scenario: JDA MOCA - Cycle CI 2021.1.1
When I connect to MOCA at "https://cycl-pdbd-wm202111-moca.wm-servers.com/service" logged in as "LSEXTON" with password $pw_moca
	And I execute MOCA command "[update adrmst set first_name = 'PDBD-WM2021111' where adr_id = (select adr_id from les_usr_ath where usr_id = 'LSEXTON')]"
Then I verify MOCA status is 0
When I execute MOCA command "publish data where instance = @@MOCA_ENVNAME"
	And I verify MOCA status is 0
	And I assign row 0 column "instance" to variable "instance"
Then I verify text $instance is equal to "cycl-dev"
When I execute MOCA command "[update les_mls_cat set mls_text = 'PDBD-WM202111' where mls_id = 'ttlAbout' and locale_id = 'US_ENGLISH' and prod_id = 'LES' and FRM_ID = 'LES' and vartn = 'RF' and srt_seq = 0 and cust_lvl = 0]"
Then I reset terminal device "RDT001" in warehouse "WMD1"
	And I reset terminal device "SSH001" in warehouse "WMD1"
	And I close MOCA connection

@rf
Scenario: JDA RF - TELNET - Cycle CI 2021.1.1
Given I open terminal connected to "cycl-pdbd-wm202111-rf.wm-servers.com:46062" for terminal "RDT001" sized to 16 lines and 20 columns
If I see "Terminal ID:" in terminal within 30 seconds
	Then I type "RDT001" in terminal
	And I press keys ENTER in terminal
EndIf
Then I see "User ID:" in terminal within 30 seconds
When I press keys ESC+F3 in terminal
Then I see "Function Keys" in terminal within 5 seconds
When I type "N" in terminal
Then I see "Gold Keys" in terminal within 5 seconds
When I type "0" in terminal
Then I see "PDBD-WM202111" in terminal within 5 seconds
When I press keys F1 in terminal
Then I see "User ID:" in terminal within 5 seconds
	And I close terminal

@refs
Scenario: JDA REFS - Cycle CI 2021.1.1
When I open "Chrome" web browser on remote "http://chrome-connection-test:4444/wd/hub"
	And I navigate to "https://cycl-pdbd-wm202111.wm-servers.com" in web browser within 30 seconds
	And I see " Blue Yonder Group, Inc." in web browser within 30 seconds
	And I type "LSEXTON" in web browser
	And I press keys TAB in web browser
	And I type "LARRY#01" in web browser
	And I press keys ENTER in web browser
Then I see "Hello" in web browser within 30 seconds
Then I see "PDBD-WM202111" in web browser within 30 seconds
	And I close web browser
