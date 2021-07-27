select sum(new_cases) as Total_cases, sum(new_deaths) as Total_deaths, sum(new_deaths)/sum(new_cases)*100 as DeathPercentage
from portfolioproject.coviddeaths_csv cc 
where continent != ""
order by 1,2

select location, sum(new_deaths) as TotalDeathCount
from portfolioproject.coviddeaths_csv cc 
where continent = ""
and location not in ("World", "European Union", "International")
group by location 
order by TotalDeathCount desc

select location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected
from portfolioproject.coviddeaths_csv cc 
group by location, population
order by PercentPopulationInfected desc

select location, population, date, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected
from portfolioproject.coviddeaths_csv cc 
group by location, population, date
order by PercentPopulationInfected desc