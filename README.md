# CovidDataOverview - (Unfinished)
A SQL project to gain an understanding of global COVID-19 data between 24/02/2020 and 07/02/2023. 
This project mainly involves a brief overview of the data, looking at the number of cases/deaths/vaccinations overall as well as by date.
This project is intended to demonstrate usage of basic SQL querying as well as exploring datasets within SQL.

### Table of Contents
* [Installation](#Installation)
* [Usage](#Usage)
* [Interesting Findings and Issues Encountered](#Interesting-Findings-and-Issues-Encountered)

### Installation
Download the ZIP file located under the green 'Code' tab. This file should contain both the main code and two CSV files 'CovidDeaths' and 'CovidVaccinations' which contain the datasets used in this project. Extract to a folder of your choosing.

Make sure both SQL server and SSMS are installed on your system.

To import the data from the CSVs into SSMS, first create a new database within SSMS, which I have entitled "Portfolio Project".
After this, right click on the database within Object Explorer and select "Tasks --> Import Flat File...".
This opens a window where you can import the CSVs individually from their location file. This enables you to give them individual table names and modify the column types of the data.

When naming the tables, name the table from 'CovidDeaths.csv', 'CovidDeaths' and 'CovidVaccinations.csv', 'CovidVaccinations'.

When modifying the column types, please note that many columns should allow null values. In addition, many columns have incorrect typing by default, which will have to be changed manually depending on the contents within that column.
For instance, 'population' may be classed as an int, however, values may exceed the limit of 2,147,483,647, meaning this may have to be changed to bigint.

When this has been completed for both datasets, open the queries included in the ZIP file, which should now execute without error.


### Usage
The query files included contain small queries that summarise the data in different ways. Ideally, these should be executed individually by highlighting a single query at a time and pressing 'Execute'.

'CovidDeaths Explore Query.sql' contains queries that gain an understanding of the data used primarily within the CovidDeaths dataset.
'CovidVaccinations Joined with CovidDeaths.sql' contains queries that involve looking at vaccination data after joining the datasets CovidVaccinations and CovidDeaths.

Comments are included that explain the goal of each individual query along with potentially some other comments to explain any issues encountered or interesting findings.

### Interesting Findings and Issues Encountered
#### Which country sees the highest number of cases vs population?
Dividing the total number of cases by the population of each country and ordering in descending order, we can see that Cyprus has had the highest percentage of its population infected with Covid-19.

![image](https://user-images.githubusercontent.com/125564099/224314421-4ed68ca6-588e-499f-9d57-896ddf767e9c.png)

#### Which countries have seen the highest number of Covid-19 deaths?
Looking at which countries have seen the highest number of deaths of Covid-19, I encountered an error. Locations included 'World' and 'High Income', which aren't countries. These locations all share a null value within the 'continent' column. To exclude these values and display only countries, a WHERE statement is needed to select the locations where 'continent' is NOT NULL.

![image](https://user-images.githubusercontent.com/125564099/224315447-895a0ba3-4353-42e5-96ae-e641f351c837.png)

#### Which continents/groups saw the highest death rate?
Dividing max total deaths by max total cases, you can find the death rate of individual locations and groups. From the table below, it appears that people classed within 'Low Income' see the highest death rate, followed closely by Africa. This may partly be due to poorer living conditions as well as access to affordable healthcare.
Continents/groups such as Oceania and European Union see lower death rates, this may be due to their higher quality of living as well as precautions undertaken to attempt to contain the virus.

![image](https://user-images.githubusercontent.com/125564099/224319224-fc646be1-6602-46d8-8e72-dc8ffd33df9d.png)
