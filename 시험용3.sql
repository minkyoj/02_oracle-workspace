--

-- QUIZ1
CREATE USER TEST IDENTIFIED BY 1234; ����
-- User TEST(��)�� �����ƽ��ϴ�.
-- ���������� �ϰ� ���� => ����!

-- �� ������ ������?
�����������ڳ�
GRANT CONNECT, RESOURCE TO TEST;


-- QUIZ2 (JOIN)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY,
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- ���� �� ���̺��� �ִٴ� �����Ͽ�
-- �� ���̺� �����ؼ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�Ҳ���
-- �̶� ������ SQL��
SELECT EMPNO, EMPNAME,JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING(JOBNO);
-- ����
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

JOBNO�� TB_EMP���ۿ� ���ڳ�.. ���ι��߸���

SELECT EMPNO, EMPNAME,JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON (JOBCODE);


-- QUIZ3 (JOIN ����)

-- �Ʒ��� SQL������ �μ��� �����հ谡 15,000,000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�.
-- �� ����� �ùٸ��� �ʴٰ� �� �� �� ���ΰ� ��ġ����

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY > 15000000
GROUP BY DEPT_CODE;

--
������������ �غ���߉�

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;



-- QUIZ 4
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES(1, '����1��', 30);
INSERT INTO QUIZ4 VALUES(1, '����2��', 50);
-- �־ȵǴ���

�����̸Ӹ�Ű�ݤ��� �׷� ����ũ�� �����ε� ����ũ�� �����



-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ� (SALARY * 1.1)
-- J6�� ����� �޿��� 15% �λ� (SALARY * 1.15)
-- J5�� ����� �޿��� 20% �λ� (SALARY * 1.2)

SELECT DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J7', SALARY * 1.2)
FROM EMPLOYEE;


-- '21/09/28'�� ���� ���ڿ��� ������ '2021-09-28'�� ǥ���غ���

SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD') FROM DUAL;

-- '210908'�� ���� ���ڿ��� ������ 2021�� 9�� 8�� ǥ��

SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"��"FMMM"��"DD"��"') FROM DUAL;


-- 5000000 �̻� ��ް����� 3500000�̻� �߱ް����� �� �� �ʱް�����
-- CASE WHEN

SELECT EMP_NAME, SALARY, CASE WHEN SALARY > 5000000 THEN '��ް�����'
                              WHEN SALARY > 3500000 THEN '�߱ް�����'
                              WHEN SALARY <= 3500000 THEN '�ʱް�����'
                         END
FROM EMPLOYEE;










