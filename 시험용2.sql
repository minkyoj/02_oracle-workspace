--
/*
�˻�����

DEPT_CODE�� D9�̰ų� D6�̰� SALARY�� 300���� �̻��̰� BONUS�� �ְ�

�����̰� �̸����ּҰ� _ �տ� 3���� �ִ�

����� EMP_NAME, EMP_NO, DEPT_CODE, SALARY�� ��ȸ

*/

-- �ۼ��� ��������

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY

FROM EMPLOYEE

WHERE DEPT_CODE='D9' OR DEPT_CODE='D6' AND SALARY > 3000000

AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- ������
-- 1. AND, OR ������ �� �켱������ AND�� �ֱ� ������ OR�� ��ȣ�� ������Ѵ�.
-- 2. SALARY�� 3000000 �̻��� �ƴ϶� �ʰ�(>)�� ����Ǿ��ִ�. �̻�(>=)���� �ٲ��־���Ѵ�.
-- 3. BONUS�� �ִٴ� ���� BONUS�� NULL���� �ƴϾ�� �ϹǷ� BONUS IS NULL�� �ƴ� BONUS IS NOT NULL �̴�.
-- 4. �̸����ּҸ� Ȯ���ϴ� LIKE���� �߸��Ǿ��� ���ϵ�ī�带 Ȱ���Ͽ� ESCAPE���� �ۼ��ؾ��Ѵ�.
-- 5. ���ڶ�� ������ WHERE���� ������� �ʾҴ�.

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY, EMAIL

FROM EMPLOYEE

WHERE (DEPT_CODE='D9' OR DEPT_CODE='D6') AND SALARY >= 3000000

AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL

AND SUBSTR(EMP_NO, 8, 1) IN (1, 3);

/*
������ ���� NULL���� ���Ͽ��µ� ���������� �۵����� �ʾҴ� �� ������ ����(10��)�� �ۼ��ϰ�
���������� �۵��ϱ� ���� SQL������ ��ġ����(10��)�� �ۼ��Ͽ��� (�� 20��)



���� SQL��

SELECT * FROM EMPLOYEE WHERE BONUS = NULL AND MANAGER_ID !=NULL;

NULL���� ���� ��ó���� ���� �ʾҴ�.
*/


SELECT * FROM EMPLOYEE WHERE BONUS = NULL AND MANAGER_ID !=NULL;

������ : NULL���� ���翩�θ� Ȯ���ϰ� �������� =, !=�� ���� ����� �����ڰ� �ƴ�
IS NULL, IS NOT NULL�� ǥ���� ����ؾ��Ѵ�.

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL;