--�Ʒ��� SQL������ �μ� �� ��� ������ 2,800,000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�.
--����� �ùٸ��� �ʴٰ� �� ��, �� ����(20��)�� �ùٸ��� ������ ��ġ����(20��)�� ���� �׸� �°� ����Ͻÿ�. (�� 40��)

SELECT DEPT, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMP
WHERE SALARY > 2800000
GROUP BY DEPT
ORDER BY DEPT ASC;

1. WHERE�� ������ ������ �ڹٲ����.
 => HAVING���� ����ؾ��Ѵ�.
2.


SELECT DEPT, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMP
GROUP BY DEPT
HAVING FLOOR(AVG(SALARY)) > 2800000
ORDER BY DEPT ASC;


SELECT DEPT_CODE, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2800000
ORDER BY DEPT_CODE ASC;

-------------------------

MNO | NUMBER | PRIMARY KEY | ȸ����ȣ

MNAME | VARCHAR2(300) | NOT NULL | ȸ����

ADDRESS | VARCHAR2(1000) | �� | �ּ�

TEL | VARCHAR2(13) | UNIQUE | ����ó



----- < ������ SQL > -----

INSERT INTO MEMBER_KH VALUES(1, 'ȫ�浿', '����� ������', '011-0000-0000');

INSERT INTO MEMBER_KH VALUES(2, '��浿', '�λ�� �ؿ�뱸', '010-0000-0000');

INSERT INTO MEMBER_KH VALUES(3, '�谩ȯ', '��õ�� ������', '019-0000-0000');

PRIMARY KEY �� �ĺ����� ���ҷ� �ڵ������� NOT NULL, UNIQUE�� ���������� ������ ������ ���� ���� ��� �� ����.
������ �� ��Ȳ������ PRIMARY KEY�� MNO�� ������ 1�� �ߺ��ؼ� ���� ������ UNIQUE�������ǿ� ����Ǿ� ������ ����.


������ �޿��� �λ��ϰ��� �Ѵ�
�����ڵ尡 J7�� ������ �޿��� 8%�� �λ��ϰ�,

�����ڵ尡 J6�� ������ �޿��� 7%�� �λ��ϰ�,

�����ڵ尡 J5�� ������ �޿��� 5%�� �λ��Ѵ�.

�� �� ������ ������ 3%�� �λ��Ѵ�.

���� ���̺�(EMP)���� ������(EMPNAME), �����ڵ�(JOBCODE), �޿�(SALARY), �λ�޿�(�� ����)��

��ȸ�ϼ���(��, DECODE�� �̿��ؼ� ����Ͻÿ�.) (20��)

SELECT EMPNAME AS "�̸�", JOBCODE, SALARY,
       DECODE(JOBCODE, 'J7', SALARY * 1.08,
                        'J6', SALARY * 1.07,
                        'J5', SALARY * 1.05,
                        SALARY * 1.03) AS "�λ�޿�"
FROM EMP;

SELECT * FROM EMPLOYEE;


SELECT EMP_NAME AS "������", JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.08,
                        'J6', SALARY * 1.07,
                        'J5', SALARY * 1.05,
                        SALARY * 1.03)AS "�λ�޿�"
FROM EMPLOYEE;
