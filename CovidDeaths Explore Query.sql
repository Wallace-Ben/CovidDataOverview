select * from CovidDeaths
where continent is not null
order by 3, 4  

select * from CovidVaccinations
order by 3, 4  

-- Select data to be used
select location, date, total_cases, new_cases, total_deaths, population from CovidDeaths
order by 1,2

-- Look at total cases vs total deaths in the UK - what percentage of total cases resulted in death?
select location, date, total_cases, total_deaths, (total_deaths*1.0/total_cases)*100 as percentage_deaths from CovidDeaths
where location like '%kingdom%'
order by 1,2


-- Look at total cases vs population in the UK - what percentage of the population has contracted Covid?
select location, date, total_cases, population, (total_cases*1.0/population)*100 as PercentageCases from CovidDeaths
where location like '%kingdom%'
order by 1,2


-- Look at countries with highest infection rate vs population - which countries have had the highest percentage of their population infected with Covid
select location, max(total_cases) as MaxInfectionCount, population, Max((total_cases*1.0/population)*100) as PercentPopulationInfected from CovidDeaths
group by location, population
order by 4 desc


-- Look at countries with the highest death count
-- Without the WHERE statement, results include locations such as 'World' and 'High Income', which have continent values of NULL - therefore to display only countries, select where 'continent' is not null.
select location, max(total_deaths) as TotalDeathCount from CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc


-- Look at continents with the highest death count - this includes 'World' and 'High Income' - these are values where 'continent' column is NULL
select location, max(total_deaths) as TotalDeathCount from CovidDeaths
where continent is null
group by location
order by TotalDeathCount desc


-- Look at continents with highest death count per population
select location, (max(total_deaths)*1.0/population)*100 as DeathRatePercentage from CovidDeaths
where continent is null
group by location, population
order by DeathRatePercentage desc


-- Look at continents with highest death rate per total cases
select location, (max(total_deaths)*1.0/max(total_cases))*100 as DeathRatePercentage from CovidDeaths
where continent is null
group by location, population
order by DeathRatePercentage desc


-- Display worldwide cases per day and death percentage
select date, sum(new_cases) as NoCases, sum(new_deaths) as NoDeaths, (sum(new_deaths*1.0)/sum(new_cases))*100 as DeathPercentage from CovidDeaths
where continent is not null
group by date
order by 1,2