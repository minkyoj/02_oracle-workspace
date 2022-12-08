--
/*
    DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP) �ϴ� ����
    
    < ALTER >
    ��ü�� �����ϴ� ����
    
    [ ǥ���� ]
    ALTER TABLE ���̺�� �����ҳ���;
    
    * �����ҳ���
    1) �÷� �߰� / ���� / ����
    2) �������� �߰� / ���� --> ������ �Ұ�! (�����ϰ��� �Ѵٸ� ������ �� ������ �߰�)
    3) �÷��� / �������Ǹ� / ���̺�� ����
*/

-- 1) �÷� �߰� / ���� / ����
-- 1_1) �÷� �߰� (ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] [CONSTRAINT �������Ǹ�] ��������
-- DEPT_COPY ���̺� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- ���ο� �÷��� ��������� �⺻������ NULL�� ä����

-- LNAME �÷� �߰� : VARCHAR2(20) �⺻�� : �ѱ�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1_2) �÷� ����(MODIFY)
--> �ڷ��� ����         : MODIFY �÷��� �ٲٰ����ϴ� �ڷ���
--> DEFAULT�� ����     : MODIFY �÷��� DEFAULT �ٲٰ����ϴ� �⺻ ��

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- �̰� ������!! �̹� �����Ͱ� ���ڰ� �ƴ� �͵� �������!
-- �����ϴ� �����Ͱ� ����߸� �̷��� �ٲܼ��� ����!

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- �̰͵� ���� �߻�!!
-- �̹� ����ִ� �����Ͱ� 10����Ʈ���� ŭ!!

-- DEPT_TITLE �÷��� VARCHAR2(50)���� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- LOCATION_ID �÷��� VARCHAR2(4)�� ����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- LNAME Į���� �⺻���� '����'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '����';
-- ����Ʈ���� �ٲ۴ٰ� �ؼ� ������ �߰��� �����Ͱ� �ٲ�°��� �ƴϴ�!!

-- ���� ���� ����
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '�̱�';

-- 1_3) �÷� ����(DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� �÷���
-- ������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2�κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- ���߻����� �ȵ� 
ALTER TABLE DEPT_COPY2
    DROP COLUMN DEPT_ID
    DROP COLUMN DEPT_TITLE;
    
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- ������!! �ּ� �Ѱ��� �÷��� �����ؾߵ�!!
-- ORA-12983: cannot drop all columns in a table
--------------------------------------------------------------------------------
-- 2) �������� �߰� / ����
/* 
    2_1) �������� �߰�
    PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)]
    UNIQUE      : ADD UNIQUE(�÷���)
    CHECK       : ADD CHECK(�÷��� ���� ����)
    NOT NULL    : MODIFY �÷��� NOT NULL | NULL => �̰ž��� �� ���
    
    �������Ǹ��� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
    
*/

-- DEPT_ID�� PRIMARY KEY �������� �߰� ADD
-- DEPT_TITLE�� UNIQUE �������� �߰� ADD
-- LNAME�� NOT NULL �������� �߰� MODIFY 

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

-- 2_2) �������� ���� : DROP CONSTRAINT �������Ǹ�
-- NOT NULL�� ������ �ȵǰ� MODIFY NULL �̰ɷ� ����������Ѵ�.

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
--------------------------------------------------------------------------------
--3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)
--3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--3_2) �������Ǹ� ���� : RENAME CONSTRAINT �������Ǹ� TO �ٲ��������Ǹ�
-- SYS_C007270 => DCOPY_DID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007270 TO DCOPY_DID_NN;

--3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
-- DEPT_COPY => DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
--------------------------------------------------------------------------------
-- ���̺� ����
DROP TABLE DEPT_TEST;

-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� �����ϸ� �ȵ�!!
-- ���࿡ �����ϰ��� �Ѵٸ�
-- ���1. �ڽ����̺� ���� ������ �� �θ����̺� �����ϴ� ���
-- ���2. �׳� �θ����̺� ���� �ϴµ� �������Ǳ��� ���� �����ϴ� ���
-- DROP TABLE ���̺�� CASCADE CONSTRAINT;











