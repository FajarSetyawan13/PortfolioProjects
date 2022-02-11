select * from portfolioproject.coviddeaths_csv
where continent is not null
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population from portfolioproject.coviddeaths_csv cc
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Show death percentage of Covid in Indonesia
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
from portfolioproject.coviddeaths_csv cc
where location = 'Indonesia' and continent is not null 
order by 2

-- Looking at Total Cases vs Population
-- Show what percentage of population got Covid in India
select location, date, total_cases, population, (total_cases/population)*100 as CasePercentage 
from portfolioproject.coviddeaths_csv cc
where location = 'India' and continent is not null 
order by 2

-- Looking at Countries with highest infected rate compared with population
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population)*100) as HighestInfectionPercentage
from portfolioproject.coviddeaths_csv cc
where continent is not null 
group by location
order by HighestInfectionPercentage desc 

-- Showing Countries with Highest Death Count per Population
select location, max(total_deaths) as TotalDeathCount
from portfolioproject.coviddeaths_csv cc
where continent is not null 
group by location
order by TotalDeathCount desc

-- Showing Continent with Highest Death Count
select continent, max(total_deaths) as TotalDeathCount
from portfolioproject.coviddeaths_csv cc
where continent is not null
group by continent
order by TotalDeathCount desc

-- Global Numbers
select date, SUM(new_cases) as GlobalCase, SUM(new_deaths) as GlobalDeath, ((sum(new_deaths))/(sum(new_cases)))*100 as GlobalDeathPercentage
from portfolioproject.coviddeaths_csv cc
where continent is not null 
group by date
order by date

-- Looking Total Population vs Vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
from portfolioproject.coviddeaths_csv dea 
join portfolioproject.covidvaccinations_csv vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null 
order by 2,3

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from portfolioproject.coviddeaths_csv dea 
join portfolioproject.covidvaccinations_csv vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- TEMP Table
create table PercentPopulationVaccinated
(
Continent varchar(255),
Location varchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from portfolioproject.coviddeaths_csv dea 
join portfolioproject.covidvaccinations_csv vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null 

select *, (RollingPeopleVaccinated/Population)*100 as VaccinationPercentage
from PercentPopulationVaccinated

-- Creating View to store data for later visualization
create view PercentPopulationVaccinated2 as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from portfolioproject.coviddeaths_csv dea 
join portfolioproject.covidvaccinations_csv vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null 

select * from percentpopulationvaccinated p 