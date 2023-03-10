-- Join the two tables on location and date columns
select * from CovidDeaths dea
Join CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date


-- Break down number of new vaccinations per country per day 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations from CovidDeaths dea
Join CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- Look at cumulative vaccinations per country per day
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location, dea.date) as CumulativeVaccinations
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- Look at total vaccinations in a country vs population
-- Use CTE
-- There is an issue with the results to the code above. It reveals that 330% of Cuba is vaccinated, from this, we can assume that a large proportion of the population has been vaccinated multiple times.
-- However, this information does not tell us the population of Cuba that haven't been vaccinated at all.
-- We will need to analyse the 'people_vaccinated' and 'people_fully_vaccinated' columns to find this out
With PopVac (Continent, Location, Date, Population, NewVaccinations, CumulativeVaccinations) as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location, dea.date) as CumulativeVaccinations
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select location, (max(CumulativeVaccinations)*1.0/Population)*100 as PercentageVaccinated from PopVac
group by location, Population
order by PercentageVaccinated desc


-- Display countries by their percentage of residents fully vaccinated or vaccinated at least once
-- You can see that the number of people vaccinated in Gibraltar exceeds that of their population - this may suggest that outsiders have received vaccinations whilst in Gibraltar
With PopVac (Continent, Location, Date, Population, PeopleVaccinated, PeopleFullyVaccinated) as
(
select dea.continent, dea.location, dea.date, dea.population, vac.people_vaccinated, vac.people_fully_vaccinated
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select location, population, max(PeopleVaccinated) as PeopleVaccinated, max(PeopleFullyVaccinated) as PeopleFullyVaccinated, (max(PeopleVaccinated)*1.0/Population)*100 as PercentageVaccinated, (max(PeopleFullyVaccinated)*1.0/Population)*100 as PercentageFullyVaccinated from PopVac
group by location, Population
order by PercentageFullyVaccinated desc


-- Check the numbers of Gibraltar to see if they are correct (they are)
select dea.continent, dea.location, dea.population, vac.people_vaccinated, vac.people_fully_vaccinated from CovidDeaths dea
Join CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
	where dea.location like '%gibraltar%'


-- Temp Table
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
CumulativeVaccinations numeric
)


insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location, dea.date) as CumulativeVaccinations
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

select *, (CumulativeVaccinations/Population)*100
from #PercentPopulationVaccinated

go


Create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location, dea.date) as CumulativeVaccinations
from CovidDeaths dea
join CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

go


-- Select all the data from the view
select * from PercentPopulationVaccinated