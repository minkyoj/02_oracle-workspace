--
------------------------------ QUIZ 1----------------------------------------

-- ROWNUM을 활용해서 급여가 가장 높은 5명을 조회하고 싶었으나, 제대로 조회가 안됐음!!
-- 이때 작성된 SQL문이 아래와 같음
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 어떤 문제점이 있는지, 해결된 SQL문 작성

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

------------------------------ QUIZ 1----------------------------------------
-- 부서별 평균급여가 270만원을 초과하는 부서들에 대해
-- (부서코드, 부서별 총급여합, 부서별 평균급여, 부서별 사원수)
-- 이때 작성된 SQL문이 아래와 같음
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;

-- 어떤 문제점이 있는지 , 해결된 SQL문 작성

SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;


