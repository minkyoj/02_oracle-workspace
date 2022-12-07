--
------------------------------ QUIZ 1----------------------------------------

-- ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;�����, ����� ��ȸ�� �ȵ���!!
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- � �������� �ִ���, �ذ�� SQL�� �ۼ�

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

------------------------------ QUIZ 1----------------------------------------
-- �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ����
-- (�μ��ڵ�, �μ��� �ѱ޿���, �μ��� ��ձ޿�, �μ��� �����)
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;

-- � �������� �ִ��� , �ذ�� SQL�� �ۼ�

SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;

-----------------------------------------------------------------------------
-- ���������
-- JOIN ���� (��������, �ܺ�����, ���...)  �� Ư¡, ����
-- �Լ� ���� 

-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ� (SALARY * 1.1)
-- J6�� ����� �޿��� 15% �λ� (SALARY * 1.15)
-- J5�� ����� �޿��� 20% �λ� (SALARY * 1.2)

SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "�λ�� �޿�"
FROM EMPLOYEE;


-- '21/09/28'�� ���� ���ڿ��� ������ '2021-09-28'�� ǥ���غ���
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD')
FROM DUAL;

-- '210908'�� ���� ���ڿ��� ������ 2021�� 9�� 8�� ǥ��
SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"��" FMMM"��" DD"��"')
FROM DUAL;


