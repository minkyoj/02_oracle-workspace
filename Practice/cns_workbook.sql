-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭"
-- ���� ǥ���ϵ��� �Ѵ�.
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT DEPARTMENT_NAME || '�� ������' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����" 
FROM TB_DEPARTMENT;

-- 3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--ã�� ������ ����)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' AND DEPARTMENT_NO = 001 AND SUBSTR(STUDENT_SSN, 8, 1) = 2;

-- 4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
-- �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
-- A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
-- ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
-- ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.

SELECT *
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
-- ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.

SELECT CLASS_NAME
FROM TB_CLASS
WHERE preattending_class_no IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

-- 10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ ��������
-- �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE, 1, 2) = 02
AND SUBSTR(STUDENT_ADDRESS, 1, 2) = '����' AND absence_yn = 'N';

---------------------------------------------------------------------------
-- [Addtional SELECT - �Լ�]

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
-- ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
-- ǥ�õǵ��� �Ѵ�.)

SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", ENTRANCE_DATE AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE ASC;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
-- �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL
-- ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
-- �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
-- 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ����������
-- ����Ѵ�.)

SELECT PROFESSOR_NAME AS "�����̸�",
        EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6), 'RRMMDD') AS "����"
FROM TB_PROFESSOR
ORDER BY ;

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
-- ?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)

SELECT SUBSTR(PROFESSOR_NAME, 2, 3)
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? �̶�,
-- 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE TO_NUMBER((EXTRACT(YEAR FROM ENTRANCE_DATE))) - TO_NUMBER((EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))))) > 19;


-- 6. 2020�� ũ���������� ���� �����ΰ�?

SELECT TO_CHAR(TO_DATE(201225),'DAY') FROM DUAL;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
-- �� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'),
-- TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?

SELECT TO_DATE('99/10/11','YY/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11','YY/MM/DD') FROM DUAL;
SELECT TO_DATE('99/10/11','RR/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11','RR/MM/DD') FROM DUAL;

-- 8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
-- ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
-- �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
-- �ڸ������� ǥ������.

SELECT ROUND (SUM(POINT) / COUNT(*), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
-- ��µǵ��� �Ͻÿ�.

SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT (*) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
-- �ۼ��Ͻÿ�.

SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
-- �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
-- �Ҽ��� ���� �� �ڸ������� ǥ������.

--SELECT DISTINCT(SUBSTR(TERM_NO, 1, 4)) AS "�⵵ �� ����", SUM(POINT)
SELECT (SUBSTR(TERM_NO, 1, 4)) AS "�⵵", ROUND(SUM(POINT) / COUNT(POINT), 1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY (SUBSTR(TERM_NO, 1, 4));

-- 13. �а� �� ���л� ���� �ľ��ϰ����Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO AS "�а��ڵ��", COUNT(DECODE(ABSENCE_YN,'Y',0)) AS "���л���"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. � SQL
-- ������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(DISTINCT STUDENT_SSN) > 1;

-- 15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
-- ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
-- ǥ���Ѵ�.)

SELECT SUBSTR(TERM_NO, 1, 4) AS "�⵵", SUBSTR(TERM_NO, 5, 2) AS "�б�", ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4)), ROLLUP(SUBSTR(TERM_NO, 5, 2))
ORDER BY 1, 2;


------
-- [Additional SELECT - Option]

-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
-- ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.

SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.

SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY TO_NUMBER(SUBSTR(STUDENT_SSN, 1, 6)) DESC;

-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�,
-- �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
-- "������ �ּ�" �� ��µǵ��� �Ѵ�.

SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%' AND
      SUBSTR(STUDENT_ADDRESS, 1, 3) IN ('������', '��⵵')
ORDER BY 1 ASC;

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
-- �ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
-- ������ ����)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = 005
ORDER BY PROFESSOR_SSN ASC;

-- 5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
-- ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
-- �ۼ��غ��ÿ�.

SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100' AND TERM_NO = 200402
ORDER BY 2 DESC, 1 ASC;

-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL
-- ���� �ۼ��Ͻÿ�.

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME 
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO;

-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;

-- 8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
-- �ۼ��Ͻÿ�.

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C , TB_PROFESSOR P
WHERE C.DEPARTMENT_NO = P.DEPARTMENT_NO;

-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. �̿�
-- �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C , TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = P.DEPARTMENT_NO
AND D.DEPARTMENT_NO = C.DEPARTMENT_NO
AND D.CATEGORY = '�ι���ȸ';

-- 10. �������а��� �л����� ������ ���Ϸ��� �Ѵ�. �����а� �л����� "�й�", "�л� �̸�",
-- "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
-- �ݿø��Ͽ� ǥ���Ѵ�.)

SELECT S.STUDENT_NO AS "�й�", S.STUDENT_NAME AS "�л��̸�", ROUND(AVG(POINT),1)
FROM TB_STUDENT S, TB_GRADE G, TB_DEPARTMENT D
WHERE S.STUDENT_NO = G.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.DEPARTMENT_NAME = '�����а�'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY 1;


-- 11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
-- ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
-- �ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
-- ��µǵ��� ����.

SELECT DEPARTMENT_NAME AS "�а��̸�", STUDENT_NAME AS "�л��̸�" , PROFESSOR_NAME AS "���������̸�"
FROM TB_DEPARTMENT D, TB_STUDENT S, TB_PROFESSOR P
WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
--AND D.DEPARTMENT_NO = P.DEPARTMENT_NO
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
AND S.STUDENT_NO = 'A313047';

-- 12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ�
-- SQL ������ �ۼ��Ͻÿ�.

SELECT STUDENT_NAME, SUBSTR(TERM_NO, 1, 6) AS "TERM_NAME"
FROM TB_STUDENT S, TB_CLASS C, TB_GRADE G
WHERE S.STUDENT_NO = G.STUDENT_NO
AND G.CLASS_NO = C.CLASS_NO
AND SUBSTR(TERM_NO, 1, 4) = 2007
AND CLASS_NAME = '�ΰ������'
ORDER BY 1;

-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
-- �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�

/*
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D, TB_CLASS_PROFESSOR P
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND P.CLASS_NO = C.CLASS_NO
AND CATEGORY = '��ü��'
AND PROFESSOR_NO IS NULL;
*/
SELECT CLASS_NAME, DEPARTMENT_NAME FROM TB_CLASS 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO) 
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL;

-- 14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
-- �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
-- ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
-- ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����.

SELECT S.STUDENT_NAME "�л��̸�", NVL(P.PROFESSOR_NAME, '�������� ������') "��������"
FROM TB_STUDENT S
JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
WHERE D.DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY STUDENT_NO;

-- 15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
-- �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(G.POINT),8)
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(G.POINT) >= 4.0
ORDER BY 1;

-- 16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT C.CLASS_NO, C.CLASS_NAME, ROUND(AVG(G.POINT),8)
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
JOIN TB_GRADE G ON (C.CLASS_NO = G.CLASS_NO)
WHERE D.DEPARTMENT_NAME = 'ȯ�������а�' AND C.CLASS_TYPE LIKE '����%'
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY 1;

-- 17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ�
-- SQL ���� �ۼ��Ͻÿ�.

SELECT S.STUDENT_NAME, S.STUDENT_ADDRESS
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = (
    SELECT DEPARTMENT_NAME
    FROM TB_DEPARTMENT D
    JOIN TB_STUDENT S ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
    WHERE STUDENT_NAME = '�ְ���');
    
-- 18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ����
-- �ۼ��Ͻÿ�.

SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT 
      JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
      JOIN TB_GRADE USING(STUDENT_NO) 
      WHERE DEPARTMENT_NAME = '������а�' 
      GROUP BY STUDENT_NO, STUDENT_NAME 
      ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;

-- 19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL���� ã�Ƴ��ÿ�.
-- (��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.)

SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT),1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY = (
                  SELECT CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = 'ȯ�������а�')
                  AND CLASS_TYPE LIKE '����%'
GROUP BY DEPARTMENT_NAME;