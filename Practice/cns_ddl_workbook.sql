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
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

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
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007291 TO PK_CATEGORY_NO;

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

-- 10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� �Ѵ�.
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.

SELECT * FROM TB_STUDENT;

CREATE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
   FROM TB_STUDENT;
   
SELECT * FROM VW_�л��Ϲ�����;
   
--DROP VIEW VW_�л��Ϲ�����;
   
-- ����
GRANT CREATE VIEW TO WORKBOOK;

-- 11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
-- �̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
-- �̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT
-- ���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)

SELECT * FROM TB_STUDENT;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_PROFESSOR;

CREATE VIEW VW_�������
AS SELECT STUDENT_NAME AS "�л��̸�", DEPARTMENT_NAME AS "�а��̸�",
          PROFESSOR_NAME AS "���������̸�"
   FROM TB_STUDENT
   JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
   JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO);

SELECT * FROM VW_�������;

-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.

CREATE VIEW VW_�а����л���
AS SELECT DEPARTMENT_NAME, COUNT(*) AS "STUDENT_COUNT"
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME;

-- 13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
-- �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT * FROM VW_�л��Ϲ�����;

UPDATE VW_�л��Ϲ�����
SET �л��̸� = '�ʹα�'
WHERE �й� = 'A213046';

-- 14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
-- ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.

CREATE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
   FROM TB_STUDENT
   WITH CHECK OPTION;

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









