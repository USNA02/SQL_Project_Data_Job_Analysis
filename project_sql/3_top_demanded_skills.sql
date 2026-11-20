/*
? Questions to Answer
What are the top-paying jobs for my role?
What are the skills required for these top-paying roles?
What are the most in-demand skills for my role?
What are the top skills based on salary for my role?
What are the most optimal skills to learn?
a. Optimal: High Demand AND High Paying
*/
SELECT
    sd.skills,
    COUNT(sjd.skill_id) AS demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id =  sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True

GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 20;
