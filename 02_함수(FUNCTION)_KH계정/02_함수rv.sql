

/*
    < 함수 FUNCTION >
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환함
    
    - 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴 (매 행 마다 함수 실행 결과 반환)
    - 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴 (그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT절에 단일행 함수랑 그룹함수를 함께 사용 못함!!
       왜? 결과 행의 개수가 다르기 때문!!
       
    >> 함수식을 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
    
*/

/*
    < 문자 처리 함수 >
    
    * LENGTH / LENGTHB      => 결과값 NUMBER 타입
    
    LENGTH(컬럼|'문자열값') : 해당 문자열값의 글자수 반환
    LENGTHB(컬럼|'문자열값') : 해당 문자열 값의 바이트 수 반환
    
    '김', '나', 'ㄱ' 한글자당 3BYTE 김시연 9바이트
    영문자, 숫자, 특문 한글자당 1BYTE
    
*/

SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- DUAL : 가상테이블, 테이블 쓸 거 없을 때 쓰는 것

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- 매행마다 다 실행되고 있음! => 단일행 함수

/*
    * INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(칼럼|'문자열', '찾고자하는문자', ['찾을위치의 시작값', [순번]])     => 결과값은 NUMBER 타입!!
    
    찾을 위치의 시작값
    1 : 앞에서부터 찾겠다.
    -1 : 뒤에서부터 찾겠다
*/

SELECT INSTR('QWEQWEQWERQQQ', 'W') FROM DUAL; -- 찾을위치의 시작값은 1이 기본값 => 앞에서부터 찾음, 순번도 1이 기본값
SELECT INSTR('QWEQWEQWERQQQ', 'W', 1) FROM DUAL;
SELECT INSTR('QWEQWEQWERQQQ', 'W', -1) FROM DUAL;
SELECT INSTR('QWEQWEQWERQQQ', 'W', 1, 2) FROM DUAL;
SELECT INSTR('QWEQWEQWERQQQ', 'W', -1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_위치", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

------------------------------------------

/*
    * SUBSTRING
    문자열에서 특정 문자열을 추출해서 반환(자바에서 subString() 메소드와 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH]) => 결과값이 CHARACTER 타입
    - STRING : 문자타입컬럼 또는 '문자열값'
    - POSITION : 문자열을 추출할 시작위치값
    - LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)
*/

SELECT SUBSTR('IMHUNGRY', 2) FROM DUAL;
SELECT SUBSTR('IMHUNGRY', 2, 2) FROM DUAL;
SELECT SUBSTR('IMHUNGRY', 3, 3) FROM DUAL;
SELECT SUBSTR('IMHUNGRY', -2, 2) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

-- 여자 사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 남자 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1,3) -- 내부적으로 자동 형변환
ORDER BY EMP_NAME;

-- 함수 중첩사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "아이디"
FROM EMPLOYEE;

--------------------------------------------------

/*
    * LPAD / RPAD
    문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
    
    LPAD / RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자])
    
    문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열 반환
    
*/

-- 20만큼의 길이 중 EMAIL 컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채워짐
SELECT EMP_NAME, LPAD(EMAIL, 20) -- 덧붙이고자 하는 문자 생략시 기본값이 공백!
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** 나오게 조회 => 총 글자수 : 14
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(주민번호값으로 성별자리까지 추출한 문자열, 14, '*')
FROM EMPLOYEE;


---------------------------------------

/*
    < 숫자 처리 함수 >
    * ABS
    숫자의 절대값을 구해주는 함수
    
    ABS(NUMBER)     => 결과값은 NUMBER타입!!
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;

--------------------------------------
/*
    * MOD
    두 수를 나눈 나머지값을 반환해주는 함수
    
    MOD(NUMBER, NUMBER)     => 결과값 NUMBER타입
*/
SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------

/*
    * ROUND
    반올림한 결과를 반환
    
    ROUND(NUMBER, [위치])     => 결과값은 NUMBER 타입
    위치 생략시 0번째 자리에서 반올림
*/

SELECT ROUND(123.456) FROM DUAL; -- 위치 생략시 디폴트값0
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 5) FROM DUAL; -- 위치보다 큰 수 입력시 그대로나옴
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-------------------------------------
/*
    * CEIL
    올림처리 해주는 함수
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.152) FROM DUAL; -- 5이상 아니어도 무조건 그냥 올림, 위치지정 불가
------------------------------------
/*
    * FLOOR
    소수점 아래 버림처리하는 함수
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.152) FROM DUAL; -- 무조건 버림, 위치지정 불가
SELECT FLOOR(123.999) FROM DUAL;
-----------------------------------
/*
    * TRUNC(절삭하다)
    위치 지정 가능한 버림처리해주는 함수
    
    TRUNC(NUMBER, [위치])
*/
SELECT TRUNC(123.456) FROM DUAL; -- 위치지정 안하면 FLOOR랑 동일함
SELECT TRUNC(123.456, 1) FROM DUAL; -- 소수점 아래 첫째자리까지 표현하고 싶다
SELECT TRUNC(123.456, -1) FROM DUAL; -- 해당위치 뒤로 버린다.
----------------------------------
/*
    < 날짜 처리 함수 >
*/

-- * SYSDATE : 시스템 날짜 및 시간 반환 (현재 날짜 및 시간)
SELECT SYSDATE FROM DUAL; -- 클릭해서 확인해보면 시간도 확인이 가능

-- * MONTHS_BETWEEN (DATE1, DATE2) : 두 날짜 사이의 개월 수 => 내부적으로 DATE1 - DATE2 후 나누기 30,31이 진행됨.
-- => 결과값은 NUMBER 타입
-- EMPLOYEE에서 사원명, 근무일수, 근무개월수
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "근무개월수"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜를 리턴
-- => 결과값 : DATE 타입
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- EMPLOYEE에서 사원명, 입사일, 입사 후 6개월이 된 날짜
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "수습이 끝난 날짜"
FROM EMPLOYEE;

-- * NEXT_DAY (DATE, 요일(문자|숫자)) : 특정날짜 이후에 가장 가까운 해당 요일의 날짜를 반환해주는 함수
-- => 결과값은 DATE타입
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
-- 1. 일요일, 2. 월요일 ... 7. 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; -- 언어가 KOREAN이라 안됌

-- 언어 변경
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : 해당월의 마지막 날짜를 구해서 반환
-- => 결과값은 DATE타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE에서 사원명, 입사일, 입사한달의 마지막날짜, 입사한 달에 근무한 일수
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT : 특정 날짜로부터 년도|월|일 값을 추출해서 반환하는 함수
    
    EXTRACT(YEAR FROM DATE) : 년도만 추출
    EXTRACT(MONTH FROM DATE) : 월만 추출
    EXTRACT(DAY FROM DATE) : 일만 추출
*/

-- 사원명, 입사년도, 입사월, 입사일
SELECT EMP_NAME,
EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
EXTRACT(DAY FROM HIRE_DATE)  AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도", "입사월", "입사일";

------------------------------------------------------------

/*
    < 형변환 함수 >
    
    * TO_CHAR() : 숫자 타입 또는 날짜 타입의 값을 문자타입으로 변환시켜주는 함수
    
    TO_CHAR(숫자|날짜, [포맷])            => 결과값은 CHARACTER 타입!!
*/

-- 숫자타입 => 문자타입
SELECT TO_CHAR(1234) FROM DUAL; -- '1234'로 바뀌어 있음
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5칸짜리 공간 확보, 오른쪽정렬, 빈칸 공백
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 빈칸 0으로 채운다.
SELECT TO_CHAR(1234, 'L99999' FROM DUAL; -- 현재 설정된 나라(LOCAL)의 화폐단위
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- 날짜타입 => 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 클릭해보면 다름! 날짜타입은 시간 나옴
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- HH : 12시간형식
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- HH24 : 24시간 형식
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- EX) 1990년 02월 06일 형식으로
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') -- 없는 포맷 제시할때는 ""으로 표현
FROM EMPLOYEE;

-- 년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;
       
-- 월과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-------------------------------------------------------------
/*
    * TO_DATE : 숫자타입 또는 문자타입 데이터를 날짜타입으로 변환시켜주는 함수
    
    TO-DATE(숫자|문자, [포맷])        => 결과값 : DATE 타입
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL; -- 에러발생
SELECT TO_DATE('070101') FROM DUAL; -- 첫글자가 0인 경우는 문자타입으로 변경하고 해야함

SELECT TO_DATE('041030 143000') FROM DUAL; -- 에러발생
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; -- 2014년
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 2098년 => 무조건 현재세기로 반영

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL; -- 2014년
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 1998년
-- RR : 해당 두자리 년도 값이 50미만일 경우 현재 세기 반영, 50 이상일 경우 이전세기 반영








