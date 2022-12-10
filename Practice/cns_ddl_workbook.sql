--
/*
1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺���
�ۼ��Ͻÿ�.

���̺� �̸�
TB_CATEGORY

�÷�
NAME, VARCHAR2(10)
USE_YN, CHAR(1), �⺻���� Y �� ������
*/

CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

/*
2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.

���̺��̸�
TB_CLASS_TYPE

�÷�
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)
*/

CREATE TABLE TB_CLASS_TYPE (
    NO VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

DROP TABLE TB_CLASS_TYPE;

/*
3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������
�˾Ƽ� ������ �̸��� ����Ѵ�.)
*/

ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

/*
4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
*/

ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*
5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
*/

ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

/*
6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
���� ���·� ��������.
(ex. CATEGORY_NAME)
*/

ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CATEGORY_NO;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;

/*
7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ����
�����Ͻÿ�.
Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
*/
-- ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007270 TO DCOPY_DID_NN;

ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007292 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007150 TO PK_CATEGORY_NO;

/*
8. ������ ���� INSERT ���� ��������.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;
*/

INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

/*
9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
*/

--ALTER TABLE DEPT_COPY
--   ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)

ALTER TABLE TB_DEPARTMENT
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

--15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
--������ �ǰ� �ִ�. (2005~2009) �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
--�ۼ��غ��ÿ�.

-- ������
SELECT *
FROM (SELECT CLASS_NO AS "�����ȣ", CLASS_NAME AS "�����̸�", COUNT(*) AS "������������(��)"
        FROM TB_CLASS
        JOIN TB_GRADE USING (CLASS_NO)
        WHERE SUBSTR(TERM_NO, 1, 4) IN ('2005', '2006', '2007', '2008', '2009')
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY COUNT(*) DESC)
WHERE ROWNUM <= 3;

-- ������
SELECT V.�����ȣ
     , V.�����̸�
     , V."������������(��)"
  FROM (SELECT C.CLASS_NO �����ȣ
             , C.CLASS_NAME �����̸�
             , COUNT(*) "������������(��)"
          FROM TB_CLASS C
          JOIN TB_GRADE G ON(C.CLASS_NO = G.CLASS_NO)
         WHERE SUBSTR(G.TERM_NO, 1, 4) IN ('2005', '2006', '2007', '2008', '2009')
         GROUP BY C.CLASS_NO, C.CLASS_NAME
         ORDER BY 3 DESC) V
 WHERE ROWNUM < 4;
 
 -- ����������
 SELECT �����ȣ, �����̸�, ������������
FROM (
SELECT C.CLASS_NO �����ȣ, C.CLASS_NAME �����̸�, COUNT(S.STUDENT_NO) ������������
FROM TB_STUDENT S, TB_CLASS C, TB_GRADE G
WHERE S.STUDENT_NO = G.STUDENT_NO
AND G.CLASS_NO = C.CLASS_NO
AND EXTRACT(YEAR FROM (TO_DATE(G.TERM_NO,'YYYYMM'))) BETWEEN 2005 AND 2009
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY 3 DESC)
WHERE ROWNUM <= 3;




-- DML --
/*
1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
��ȣ, �����̸�
------------
01, �����ʼ�
02, ��������
03, �����ʼ�
04, ���缱��
05. ������
*/

INSERT INTO TB_CLASS_TYPE
    VALUES('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE
    VALUES('02', '��������');
INSERT INTO TB_CLASS_TYPE
    VALUES('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE
    VALUES('04', '���缱��');
INSERT INTO TB_CLASS_TYPE
    VALUES('05', '������');

/*
2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� ����.
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
���̺��̸�
TB_�л��Ϲ�����
�÷�
�й�
�л��̸�
�ּ�
*/

CREATE TABLE TB_�л��Ϲ�����
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
   FROM TB_STUDENT;

--SELECT * FROM TB_�л��Ϲ�����;

/*
3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� ����.
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
�ۼ��Ͻÿ�)
���̺��̸�
TB_������а�
�÷�
�й�
�л��̸�
����⵵ <= ���ڸ� �⵵�� ǥ��
�����̸�
*/

SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) AS "����⵵", PROFESSOR_NAME AS "�����̸�"
FROM TB_STUDENT
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO);
/*
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'YYYYMMDD'))
FROM TB_STUDENT;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) FROM TB_STUDENT;
SELECT TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD') FROM TB_STUDENT;
*/

CREATE TABLE TB_������а�
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) AS "����⵵", PROFESSOR_NAME AS "�����̸�"
   FROM TB_STUDENT
   JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO);

SELECT * FROM TB_������а�;


-- 4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��,
-- �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
/*
SELECT CAPACITY, ROUND(CAPACITY * 1.1)
FROM TB_DEPARTMENT;
*/

UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1);


-- 5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ�
-- �Ѵ�. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
/*
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';
*/
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
WHERE STUDENT_NO = 'A413042';

-- 6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ��
-- �����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
-- (��. 830530-2124663 ==> 830530 )

-- SELECT SUBSTR(STUDENT_SSN, 1, 6) FROM TB_STUDENT;

UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT * FROM TB_STUDENT;

-- 7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������
-- �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش�
-- ������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.
/*
SELECT TERM_NO, STUDENT_NAME, POINT, CLASS_NAME
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE STUDENT_NAME = '�����'
AND TERM_NO = 200501
AND CLASS_NAME = '�Ǻλ�����';
*/

UPDATE TB_GRADE
SET POINT = 3.5 -- 1.5
WHERE (STUDENT_NO, TERM_NO) = (SELECT STUDENT_NO, TERM_NO
                  FROM TB_GRADE
                  JOIN TB_STUDENT USING (STUDENT_NO)
                  JOIN TB_CLASS USING (CLASS_NO)
                  WHERE STUDENT_NAME = '�����'
                  AND TERM_NO = 200501
                  AND CLASS_NAME = '�Ǻλ�����');

-- ROLLBACK;

-- 8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.


SELECT POINT, ABSENCE_YN
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE ABSENCE_YN = 'Y';
  

DELETE
FROM (SELECT POINT, ABSENCE_YN
    FROM TB_GRADE
    JOIN TB_STUDENT USING (STUDENT_NO)
    WHERE ABSENCE_YN = 'Y');


-- ROLLBACK;

























