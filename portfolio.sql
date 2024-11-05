USE Portfolio;
/*SELECT *
FROM dbo.CovidDeaths$
ORDER By 3,4 
*/
/*
SELECT *
FROM dbo.CovidVaccinations$
ORDER By 3,4 
*/
/*
SELECT  Location,date,total_cases,new_cases,total_deaths,Population
FROM dbo.CovidDeaths$
ORDER BY 1,2
*/
*
/*SELECT  Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM dbo.CovidDeaths$
Where location Like '%Kenya%'
ORDER BY 1,2
*/
SELECT  Location ,population,MAX(total_cases)as  HighestInfectionCount,MAX(total_cases/population)*100 as PercentPopulationInfected
FROM dbo.CovidDeaths$
--Where location Like '%Kenya%'
GROUP BY location,population
ORDER BY PercentPopulationInfected desc

-- countries with hifhest death count per population

SELECT Location,MAX(cast(Total_deaths as int)) as Deathcount
FROM dbo.CovidDeaths$
WHERE continent is not null
GROUP BY Location
ORDER BY Deathcount desc


SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
FROM dbo.CovidVaccinations$ vac
JOIN CovidDeaths$ dea
 ON vac.location = dea.location
 and vac.date=dea.date
 WHERE dea.continent is not null
 ORDER BY 2,3