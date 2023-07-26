# Covid Data SQL Guided Project
A SQL project to gain an understanding of global COVID-19 data between 24/02/2020 and 07/02/2023. 
This project mainly involves a brief overview of the data, looking at the number of cases/deaths/vaccinations overall as well as by date.
This project is intended to demonstrate usage of basic SQL querying as well as exploring datasets within SQL.

The majority of this project has been completed through a tutorial by AlexTheAnalyst on YouTube. Therefore, a large proportion of this code isn't my own, but has been used to improve my understanding of SQL code as well as giving me the opportunity to investigate by myself with the skills covered.

### Table of Contents
* [Installation](#installation)
* [Usage](#usage)
* [Interesting Findings and Issues Encountered](#interesting-findings-and-issues-encountered)
* [SQL Commands Functions Skills Used in this Project](#sql-commands-functions-skills-used-in-this-project)
* [Contributors to Project](#contributors-to-project)

### Installation
Download the ZIP file located under the green 'Code' tab. This file should contain both the main code and two CSV files 'CovidDeaths' and 'CovidVaccinations' which contain the datasets used in this project. Extract to a folder of your choosing.

Make sure both SQL server and SSMS are installed on your system.

To import the data from the CSVs into SSMS, first create a new database within SSMS, which I have entitled "Portfolio Project".
After this, right click on the database within Object Explorer and select "Tasks --> Import Flat File...".
This opens a window where you can import the CSVs individually from their location file. This enables you to give them individual table names and modify the column types of the data.

<img src="https://user-images.githubusercontent.com/125564099/224351408-a97901c3-5c70-40c4-87a2-95b56f3cce9c.png" width=50%>

When naming the tables, name the table from 'CovidDeaths.csv', 'CovidDeaths' and 'CovidVaccinations.csv', 'CovidVaccinations'.

When modifying the column types, please note that many columns should allow null values. In addition, many columns have incorrect typing by default, which will have to be changed manually depending on the contents within that column.
For instance, 'population' may be classed as an int, however, values may exceed the limit of 2,147,483,647, meaning this may have to be changed to bigint.

<img src="https://user-images.githubusercontent.com/125564099/224351587-23fbd162-54ce-4850-a01f-9551816e0623.png" width=50%>

When this has been completed for both datasets, open the queries included in the ZIP file, which should now execute without error.


### Usage
The query files included contain small queries that summarise the data in different ways. Ideally, these should be executed individually by highlighting a single query at a time and pressing 'Execute'. Make sure to use the name of your database (e.g. Portfolio Project) instead of 'master'.

![image](https://user-images.githubusercontent.com/125564099/224350911-a0a059a6-311e-41df-ac01-de73733f9172.png)


'CovidDeaths Explore Query.sql' contains queries that gain an understanding of the data used primarily within the CovidDeaths dataset.
'CovidVaccinations Joined with CovidDeaths.sql' contains queries that involve looking at vaccination data after joining the datasets CovidVaccinations and CovidDeaths.

Comments are included that explain the goal of each individual query along with some other comments to explain any issues encountered or interesting findings.

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


#### Gathering cumulative vaccinations each day
Using the PARTITION BY clause with the OVER clause, we can create a column which adds together the 'new_vaccinations' column with the 'CumulativeVaccinations' column. Here we can see the total number of vaccinations alongside the number of new vaccinations per day for each country.

![image](https://user-images.githubusercontent.com/125564099/224353965-b57bd284-bace-4caf-9f35-f889f248082b.png)

#### Which countries have the highest percentage vaccinated?
Using a CTE, we can display the countries that have seen the highest percentage of their population vaccinated. This can be achieved by finding the cumulative new vaccinations per day and then dividing the maximum value (total vaccinations) by the population of that country.
Below, we can see that some countries have well over 100% of their population vaccinated. From this, we can assume that a large proportion of the population has been vaccinated multiple times. However, this does not tell us the proportion of the population that has not been vaccinated at all.

![image](https://user-images.githubusercontent.com/125564099/224356693-43441a39-4a99-426d-8747-6f59d583f630.png)

#### What percentage of the population have been fully vaccinated and vaccinated at least once?
Utilising a similar technique as before, but with the columns 'people_vaccinated' and 'people_fully_vaccinated', we can display the countries by the percentage of the population that are fully vaccinated and partially vaccinated. This then gives an idea of the proportion of the population that aren't vaccinated.

Below, we can see that the percentages are no longer above 300% as seen previously. However, there are still countries with over 100% of their population being fully or partially vaccinated.
Gibraltar has a population of 32,677, but 42,175 people have been vaccinated at least once, and 41,465 people have been fully vaccinated. This leads to 126.9% of Gibraltar's population being fully vaccinated. This may suggest that visitors to Gibraltar may have received vaccinations whilst in the territory.

![image](https://user-images.githubusercontent.com/125564099/224358393-d8450d10-77c4-43e8-8a63-6ee99a56ccb5.png)

### SQL Commands/Functions/Skills Used in this Project
* SELECT, WHERE, ORDER BY, GROUP BY, JOIN, ON
* MAX(), SUM(), CAST()
* CREATE VIEW, OVER(), PARTITION BY, CREATE TABLE, DROP TABLE
* Using aliases for tables and columns

### Contributors to Project
* Ben Wallace 
* AlexTheAnalyst - whose content has been used to gain an understanding of SQL techniques as well as explore the dataset further.
