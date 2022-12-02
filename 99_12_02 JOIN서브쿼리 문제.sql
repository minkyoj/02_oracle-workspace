--1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_ID = DEPT_CODE AND J.JOB_CODE = E.JOB_CODE
AND SUBSTR(EMP_NO, 1, 1) = 7
AND SUBSTR(EMP_NO, 8, 1) = 2
AND EMP_NAME LIKE '��%';

--2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
SELECT EMP_ID, EMP_ID, SUBSTR(SYSDATE, 1, 2) - SUBSTR(TO_DATE(SUBSTR(EMP_NO, 1, 6)),1,2), DEPT_TITLE, JOB_NAME
FROM EMPLOYEE, DEPARTMENT, JOB;

SELECT SUBSTR(SYSDATE, 1, 2) FROM DUAL;

--3. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND EMP_NAME LIKE '%��%';

--4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE AND DEPT_CODE = DEPT_ID
AND (DEPT_CODE IN ('D5','D6'));

--5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE
AND BONUS IS NOT NULL;

--6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE
AND E.JOB_CODE = J.JOB_CODE;

--7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

--8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ


--9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�)
--10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
--11. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
--11-1. JOIN�� HAVING ���
--11-2. �ζ��� �� ���
--12. �μ� ��� �μ� �� �޿� �հ� ��ȸ