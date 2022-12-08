--
/*
검색조건

DEPT_CODE가 D9이거나 D6이고 SALARY이 300만원 이상이고 BONUS가 있고

남자이고 이메일주소가 _ 앞에 3글자 있는

사원의 EMP_NAME, EMP_NO, DEPT_CODE, SALARY를 조회

*/

-- 작성된 쿼리구문

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY

FROM EMPLOYEE

WHERE DEPT_CODE='D9' OR DEPT_CODE='D6' AND SALARY > 3000000

AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- 문제점
-- 1. AND, OR 연산자 중 우선순위가 AND에 있기 때문에 OR에 괄호를 쳐줘야한다.
-- 2. SALARY가 3000000 이상이 아니라 초과(>)로 기술되어있다. 이상(>=)으로 바꿔주어야한다.
-- 3. BONUS가 있다는 것은 BONUS가 NULL값이 아니어야 하므로 BONUS IS NULL이 아닌 BONUS IS NOT NULL 이다.
-- 4. 이메일주소를 확인하는 LIKE문이 잘못되었다 와일드카드를 활용하여 ESCAPE문을 작성해야한다.
-- 5. 남자라는 조건이 WHERE절에 기술되지 않았다.

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY, EMAIL

FROM EMPLOYEE

WHERE (DEPT_CODE='D9' OR DEPT_CODE='D6') AND SALARY >= 3000000

AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL

AND SUBSTR(EMP_NO, 8, 1) IN (1, 3);

/*
다음과 같이 NULL값을 비교하였는데 정상적으로 작동하지 않았다 그 이유를 원인(10점)에 작성하고
정상적으로 작동하기 위한 SQL구문을 조치내용(10점)에 작성하여라 (총 20점)



문제 SQL문

SELECT * FROM EMPLOYEE WHERE BONUS = NULL AND MANAGER_ID !=NULL;

NULL값에 대한 비교처리가 되지 않았다.
*/


SELECT * FROM EMPLOYEE WHERE BONUS = NULL AND MANAGER_ID !=NULL;

문제점 : NULL값의 존재여부를 확인하고 싶을때는 =, !=와 같은 동등비교 연산자가 아닌
IS NULL, IS NOT NULL의 표현을 사용해야한다.

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL;