--

-- ���� ���� �ϱ� 
-------------------- QUIZ 1 ---------------------------
-- ���ʽ��� �ȹ����� �μ���ġ�� �ȵ� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL ���� ���� �������� �� ó�� ��������!!

-- ������ : 
-- �ذ��� : 

-- ��ġ�� SQL��
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;

-------------
-------------------- QUIZ 2 ---------------------------

-- �˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰�
-- BONUS�� �ְ� �����̸� �̸��� �ּҴ� _�տ� 3���ڸ� �ִ� �����
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALRARY, BONUS�� ��ȸ�Ϸ��Ѵ�.
-- ���������� ��ȸ�� �� �ȴٸ� �������� 2�� �̾�� �Ѵ�.

-- ���� ������ �����Ű���� �ۼ��� SQL���� �Ʒ��� ����
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- ���� SQL�� ����� ���ϴ� ����� ����� ��ȸ�� ���� �ʴ´�.
-- �̶� � ���������� �ִ��� ��� ã�Ƽ� �����Ͻÿ�.
-- ��ġ�� �Ϻ��� SQL���� �ۼ��� �� ��!

-- ������ : 5��
-- 1. ������ ���� ����
-- 2. AND OR �߸���
-- 3. �̻��ε� �ʰ���
-- 4. �̽�����������߉� INSTR����
-- 5. ���ʽ� ������


-- ���� ����
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2, 4) AND (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL;


-------------------- QUIZ 3 ---------------------------

-- [������������] CREATE USER ������ IDENTIFIED BY ��й�ȣ;

-- ������ : SCOTT, ��й�ȣ : TIGER ������ �����ϰ� �ʹ�!
-- �̶� �Ϲݻ���� ������ KH������ �����ؼ� CREATE USE SCOTT;�� �����ϴ� ���� �߻�!!

-- ������ 1. KH�������� �����ڰ��� ����
-- ������ 2. ����Է��ϼ�

-- ��ġ����1. �����ڰ�������
-- ��ġ����2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- ���� SQL(CREATE)�� ���� �� ������ ���� ������ �Ϸ��� �ߴ��� ����! 
-- �Ӹ� �ƴ϶� �ش� ������ ���̺� �������� �͵� ���� ����! �ֱ׷���?

-- ������. ����������� �Ѥ� ���̺���� ���� ��� ������ߵ� ��
-- ��ġ����. GRANT CONNECT, RESOURCE TO SCOTT;








