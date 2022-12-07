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

-----------------------------------------------------------------------------
-- 서술형대비
-- JOIN 종류 (내부조인, 외부조인, 등등...)  별 특징, 역할
-- 함수 종류 

-- 직원의 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10% 인상 (SALARY * 1.1)
-- J6인 사원은 급여를 15% 인상 (SALARY * 1.15)
-- J5인 사원은 급여를 20% 인상 (SALARY * 1.2)

SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;


-- '21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보기
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD')
FROM DUAL;

-- '210908'와 같은 문자열을 가지고 2021년 9월 8일 표현
SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"년" FMMM"월" DD"일"')
FROM DUAL;


