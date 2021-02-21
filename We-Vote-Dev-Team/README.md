
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

## About The Project 

The main scope of this project is to create a database that contains voting results from the 2017 City of Calgary Municipal Elections and relate the results to communities within the city. Target users include running candidates for Mayor, Councillor, and School Board Trustees in the 2021 election and thereafter.  Individuals interested in analyzing voting statistics in 2017 are identified as potential users as well. This database will help users 1) analyze voter turnouts 2) identify voting behavior based on different demographics such as income, age, percentage of voters with children, gender, and percentage of homeowners. Furthermore, it should be noted that the granularity of the data is limited to polling stations by wards. Ward boundaries are updated to reflect the recent changes made in the 2020 Ward Boundary Review. From here, stations and communities that are most active are identified by taking the percentage of eligible voters with the percentage of those who voted. The presented voting results in this database are from Special and Regular voting stations across the city.

### Built With 
This project was built using the following tools to first prepare and clean the data, and then build a relational database.

- Micosoft Excel
- Micosoft SQL Server

## Getting Started

To get started with this project, the following actions need to be taken:
- Download the dataset
- Download and install SQL Server
- Download and install SQL Server Management Studio

### Prerequisites
Two csv files contain the clean date used in this project and they can be found here:

File [VotingCandidateDataMaster](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Project_Dataset/VotingCandidateDataMaster.csv) contains Calgary Municipal election Results from 2017 from Regular and Special voting stations. The information provided in this file are: new ward IDs (based on 2020 ward boundaries), old ward IDs (based on 2017 ward boundaries), voting station IDs (from 2017 Municipal Election Results), candidate information, and voting results.

File [CommunityDataMaster](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Project_Dataset/CommunityDataMaster.csv) contains community demographics information from the 2016 Civic Census in Calgary. The information listed in this file is community names, community population, population, and percentage of community residents in different age groups, income groups, as well as their homeownership, citizenship, and family status.

The two source data files are linked by NewWardIDs (based on 2020 ward boundaries), OldWardIDs (based on 2017 ward boundaries), and VotingStationIDs (from 2017 Municipal Election Results).

[The Entity Relationship Diagram](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Database_Planning_Documents/ER_Diagram.pdf) is a high-level overview of the tables in the database and their relationship. Similar to ERD, [Table Diagram](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Database_Planning_Documents/Table_Diagram.pdf) represents tables and their relationships but it provides more details on the attributes, Primary Key, and Foreign Key assignments in each table. Finally, the [Database Attributes document](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Database_Planning_Documents/DB_Attributes.pdf), lists all the tables, tables attributes, and their corresponding data type.

[The Coding Standard](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Development_Team_Documents/SQL_Coding_Standards-Dec09-2020.pdf), summarizes best IT practices implemented by the team to ensure the hardcode structure of the database is presented in a consistent form. This document can be used by future database developers who are responsible to update and maintain the database. 

[The database security and backup plan](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Development_Team_Documents/Database_Security_and_Backup_Plan.pdf), details the Development team's recommendations to safeguard the database against potential threats to its integrity, including unauthorized modification and loss of data. 

[The development team's progress report](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Development_Team_Documents/Progress_Report_Development_Team.pdf) provides a brief explanation on decisions made during the development phase. It explains the teams' decision process and challenges encountered during the development phase.

[The Database Training Manual](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Development_Team_Documents/We%20Vote%20Database%20Training%20Manual.pdf) provides simplified guidelines on the steps required to create a database backup, assign sysadmin and database owner roles, update tables and change the data type in the "We Vote" database.

[The Project Phase 2 Recommendations](https://github.com/TechSkillsBVC/We-Vote/blob/Dev-Team/Development_Team_Documents/We%20Vote%20Project%20Phase%202%20Recommendations.pdf) is a summary of the recommendations for building and deploying the We Vote project Phase 2 items. The topic in this document includes Transition Database to Azure and The Hosting Website, Update Database Tables, and Dashboard Wireframe.

### Installation

#### Download and install SQL Server

Download and installation of SQL Server are required to build the database.

In this project, the Free specialized **Express** version of SQL server was used. Use the following [link](https://www.microsoft.com/en-ca/sql-server/sql-server-downloads/) to download and install SQL Server.

#### Download and install SQL Server Management Studio
Use the following [link](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15) to open the page to download SQL Server Management Studio (SSMS).

## Usage
This database allows the user to view The City of Calgary’s historical election results and compare the data to community demographic information associated with the corresponding Wards and Voting Stations.

Users can create queries to select the Candidate, Ward, Voting Station, or Community they would like to retrieve information about.

Always use BEGIN TRAN, COMMIT/ROLLBACK with UPDATE, DELETE, DROP and TRUNCATE statements (Refer to Section 4.1 of the Coding Standard for more details).

## Contributing
1-	Install [GitHub Desktop](https://desktop.github.com/) on your machine.

2-	Choose the Desired Repository.
![1-1](https://user-images.githubusercontent.com/67971090/104071894-4ef5b780-51c7-11eb-86a1-20dbf90a45c1.png)

3-	Select the desired branch and clone the project to your machine.

![1-2](https://user-images.githubusercontent.com/67971090/104071761-0dfda300-51c7-11eb-905c-0df5ca9fce70.png)

4-	Update the latest code by selecting "pull origin".

![3-3](https://user-images.githubusercontent.com/67971090/104072132-c9bed280-51c7-11eb-90bd-a1ff7ab7e857.png)
 
5-	Go to the generated folder in your machine commit the changes and push to Github.

![5-1](https://user-images.githubusercontent.com/67971090/104072333-48b40b00-51c8-11eb-98bd-4c80952520a5.png)
 

## Contact
The "WeVote" database is owned and managed by Kourtney Branagan. She is assigned as the db_owner and sysadmin with all permissions. The final dashboard generated from the "WeVote" database will be hosted on the owner's website: [Calgary Election Candidates](https://www.calgaryelectioncandidates.com/).

This database was created by Development Team, as part of the Bow Valley College Tech Skills Initiative program.

*Development Team Members:* [Adeyemi Owoseni](https://github.com/Yemi92), [Ashley Huscroft](https://github.com/ahuscroft), [Atena Vahedian](https://github.com/atena-data), [Leysan Gilfanova](https://github.com/Leysan89), [Mahmoudreza Karimkhaninejad](https://github.com/Reza-Nejad) and [Mohammad Mosihuzzaman](https://github.com/mromel25).

## Acknowledgements 
We would like to express our special thanks and gratitude to the Bow Valley College Tech Skills management team as well as Kourtney Branagan who gave us the golden opportunity to do this wonderful project titled The We-Vote Project. This project helped us in carrying out a lot of research and we came to know about so many new things as far as building a database is concerned. Indeed, we are thankful to them.
Secondly, we would also like to thank the project manager, business analyst, documentation, data cleaning team, and quality assurance team who helped us a lot in finalizing this project within the limited time frame.
