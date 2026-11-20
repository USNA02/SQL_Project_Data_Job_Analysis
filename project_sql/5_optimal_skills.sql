/*
Questions to Answer
What are the top-paying jobs for my role?
What are the skills required for these top-paying roles?
What are the most in-demand skills for my role?
What are the top skills based on salary for my role?
What are the most optimal skills to learn?
a. Optimal: High Demand AND High Paying

ANSWER:
What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
Identify skills in high demand and associated with high average salaries for Data Analyst roles
Concentrates on remote positions with specified salaries
Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis

*/
WITH skills_demand AS(
SELECT
    sjd.skill_id,
    sd.skills,
    COUNT(sjd.skill_id) AS demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id =  sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst' 
     AND  jpf.salary_year_avg IS NOT NULL
     AND jpf.job_work_from_home = True

GROUP BY
   sjd.skill_id,
   sd.skills


),
average_salary AS(
    SELECT
    sjd.skill_id,
    sd.skills,
    ROUND (AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id =  sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst'
    AND  jpf.salary_year_avg IS NOT NULL
    AND jpf.job_work_from_home = True
    
GROUP BY
    sjd.skill_id,
    sd.skills

)

SELECT
skills_demand.skill_id,
skills_demand.skills,
skills_demand.demand_count,
average_salary.avg_salary
FrOM 
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    skills_demand.demand_count DESC,
    average_salary.avg_salary DESC
LIMIT 30;


