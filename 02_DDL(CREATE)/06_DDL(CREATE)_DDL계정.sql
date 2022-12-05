--
-- DDL ����� �����ϰ� ����� Ŀ�ؼ�, ���ҽ� ���� �ο��� ��!! (��PC)

/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ �����ϰ�(ALTER)�ϰ�,
    ���� ��ü�� ����(DROP)�ϴ� ���
    ��, ���� ������ ���� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �����.
    
    ����Ŭ���� �����ϴ� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
                                  �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
                                  ���ν���(PROCEDURE), �Լ�(FUNCTION), ���Ǿ�(SYNONYM),
                                  �����(USER)
                                  
    < CREATE >
    ��ü�� ������ �����ϴ� ����
*/

/*
    1. ���̺� ����
    - ���̺��̶�? ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                 ��� �����͵��� ���̺��� ���ؼ� �����!!
                 (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��!)
                 
    [ ǥ���� ]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
    );
    
    * �ڷ���
    - ���� (CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��)) => �ݵ�� ũ�� ���� �ؾ���!!
    > CHAR : �ִ� 2000����Ʈ ���� ���� ����. ������ ���� �ȿ����� ����� / �������� (������ ũ�⺸�� �� �������� ���͵� �������� ä����)
             ������ ���ڼ��� �����͸��� ��� ��� ��� (GENDER, Y N)
    
    > VARCHAR2 : �ִ� 4000����Ʈ ���� ���� ����, �������� (���� ���� ���� ������ ũ�Ⱑ ������)
                 ������� �����Ͱ� ������ �𸣴� ��� ��� 
    
    
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
*/
--> ȸ���� ���� �����͸� ��� ���� MEMBER �����ϱ� 
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;
-- ���� �÷Ÿ� ��Ÿ�� �߻��ߴٸ�..?
-- �ٽ� ����� �ɱ�? ���� �����ϰ� �ٽ��ϵ� �ؾ���

-- [����] USER_TABLES : ���� �� ������ ������ �ִ� ���̺� ���� �� �� ����!
SELECT * FROM USER_TABLES;

-- [����] USER_TAB_COLUMNS : �� ����ڰ� ������ �ִ� ���̺� ���� ��� �÷� �� �� ����
SELECT * FROM USER_TAB_COLUMNS;

-----------------------------------------------------------------------------
/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ���� ������)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    
    >> �߸� �ۼ��ؼ� �������� ��� ���� �� �ٽ� �����ϸ� ��!!
    
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

-- ���̺� �����ϰ��� �� �� : DROP TABLE ���̺��;
DROP TABLE MEMBER;

-- ���̺� �����͸� �߰���Ű�� ���� (DML : INSERT)
-- INSERT INTO ���̺�� VALUES(��1, ��2, ...);

SELECT * FROM MEMBER;

-- INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '�����'); => �� �Է� ���ϸ� ������!!
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', 'aaa@naver.com', '20/12/30');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', null, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- ��ȿ���� ���� �����Ͱ� ���� ����.. ���� ������ �ɾ������.
-------------------------------------------------------------------------------
/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ� (��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    - ������ ���Ἲ ������ �������� �Ѵ�!!
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� (��, �ش� �÷��� ���� NULL�� ���ͼ��� �ȵǴ� ���)
    ���� / ������ NULL���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ����� ũ�� 2������ ���� (�÷�������� / ���̺������)
    * NOT NULL ���������� ������ �÷�������� �ۿ� �ȵ�!!
    
*/
-- �÷�������� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', null, 'Ȳ����', '��', null, 'aaa@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- �ǵ��ߴ���� ������!! (NOT NULL �������ǿ� ����Ǿ� ���� �߻�!!)
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass01', 'Ȳ����', null, null, null);
-- > ���̵� �ߺ��Ǿ��������� �ұ��ϰ� �� �߰���.. ��_��

---------------------------------------------------------------------------------
/*
    * UNIQUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ��������
    ���� / ������ ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ���� �߻�!!
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- > �÷����� ��� 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- ���̺� ���� ��� : ��� �÷� �� ������ �� �������� ��� 
--                  ��������(�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) --> ���̺� ���� ���
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', 'Ȳ����', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007090) violated
-- unique �������ǿ� ����Ǿ���!! insert ����!!
--> ���� ������ �������Ǹ����� �˷���!! (Ư�� �÷��� � ������ �ִ��� ���� �˷������� ����!!)
--> ���� �ľ��ϱⰡ �����!!
--> �������� �ο��� �������Ǹ� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��ع�����.

/*
    * �������� �ο��� �������Ǹ���� �����ִ� ���
    
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������, 
        �÷��� �ڷ���
    ); 
    
    > ���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���, 
        �÷��� �ڷ���
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    ); 
    
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL, 
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) --> ���̺� ���� ���
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', 'Ȳ����', null, null, null);
-- ORA-00001: unique constraint (DDL.MEMID_UQ) violated

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', 'Ȳ����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '�̰���', '��', null, null);
-- > ������ ��ȿ�� ���� �ƴѰ� ���͵� �� INSERT �ȴ�.. => �̷��� �ȵ�!!

-------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����!
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('��', '��')) -- ���̺������
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES (1, 'user01', 'pass01', '�����', '��', null, null);

INSERT INTO MEM_CHECK
VALUES (2, 'user02', 'pass02', 'Ȳ����', '��', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007100) violated
-- CHECK �������ǿ� ����Ǿ��� ������ ���� �߻�
-- ���� GENDER �÷��� ������ ���� �ְ��� �Ѵٸ� CHECK �������ǿ� �����ϴ� ���� �־�ߵ�!!

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', 'Ȳ����', null, null, null);
-- NOT NULL�� �ƴϸ� NULL�� �����ϱ���!

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '�̰���', null, null, null);
-----------------------------------------------------------------------
/*
    * PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ���� ����(�ĺ����� ����)
    
    EX) �й�, ȸ����ȣ, �����ȣ(EMP_ID), �μ��ڵ�(DEPT_ID), �����ڵ�(JOB_CODE), �ֹ���ȣ, �����ȣ, ����� ��ȣ, ...
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ������.
    
    * ���ǻ��� : �� ���̺�� ������!! �Ѱ��� ���� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- �÷��������
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺������
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', 'Ȳ����', '��', null, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- �⺻Ű�� �ߺ����� �������� �� �� (UNIQUE �������ǿ� ����)

INSERT INTO MEM_PRI
VALUES(null, 'user02', 'pass02', 'Ȳ����', '��', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� NULL�� �������� �� �� (NOT NULL �������ǿ� �����)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', null, null);

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- �÷��������
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺������
);

-- ORA-02260: table can have only one primary key
-- �⺻Ű �ϳ��� �ȴ�!!

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- ��� PRIMARY KEY �������� �ο�(����Ű)
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '�����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass01', 'Ȳ����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '�̰���', null, null, null);

INSERT INTO MEM_PRI2
VALUES(null, 'user01', 'pass01', '�̰���', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY�� �����ִ� �� �÷����� ����!! NULL�� ������� ����!!!

-- ����Ű ��� ���� (���ϱ�, ���ƿ�, ����)
-- ���ϱ� : �� ��ǰ�� �÷��� �� ���� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�
CREATE TABLE TB_LIKE(
    MEM_ID VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_ID, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE
VALUES('user01', '��', SYSDATE);

INSERT INTO TB_LIKE
VALUES('user02', '��', SYSDATE);

INSERT INTO TB_LIKE
VALUES('user01', '��', SYSDATE);

----------------------- �ǽ� --------------------------

CREATE TABLE TB_STOCKS(
    STOCKS_NO VARCHAR(10),
    STOCKS_NAME VARCHAR(50),
    MARKET VARCHAR(10) CONSTRAINT MARKET_NN NOT NULL
    CONSTRAINT MARKET_CHECK CHECK(MARKET IN ('�ڽ���','�ڽ���','KOSPI','KOSDAQ')),
    SECTORS VARCHAR(150),
    CORP_ADD VARCHAR(500),
    EST_DATE DATE,
    CRAPE_DATE DATE,
    STOCKS_COUNT NUMBER,
    CONSTRAINT SNONAME_PK PRIMARY KEY(STOCKS_NO, STOCKS_NAME)
);

SELECT * FROM TB_STOCKS;

COMMENT ON COLUMN TB_STOCKS.STOCKS_NO IS '�����ȣ';
COMMENT ON COLUMN TB_STOCKS.STOCKS_NAME IS '�����';
COMMENT ON COLUMN TB_STOCKS.MARKET IS '����';
COMMENT ON COLUMN TB_STOCKS.SECTORS IS '����';
COMMENT ON COLUMN TB_STOCKS.CORP_ADD IS '�ּ�';
COMMENT ON COLUMN TB_STOCKS.EST_DATE IS 'â����';
COMMENT ON COLUMN TB_STOCKS.CRAPE_DATE IS '������';
COMMENT ON COLUMN TB_STOCKS.STOCKS_COUNT IS '������';

INSERT INTO TB_STOCKS
VALUES(LPAD('5930', 6, '0'), '�Ｚ����', 'KOSPI', '�̵���ȭ�� ������', '��⵵ ������ ���뱸 �Ｚ�� 129 �Ｚ���ڰ������� (��)16677', '69/01/13', '75/06/11', 5969782550);
INSERT INTO TB_STOCKS
VALUES(LPAD('35720', 6, '0'), 'īī��', 'KOSPI', '���� �� ��Ÿ ���ͳ� �����Ű� ���񽺾�', '����Ư����ġ�� ���ֽ� ÷�ܷ� 242 (��)63309', '95/02/16', '17/07/10', 445335988);
INSERT INTO TB_STOCKS
VALUES(LPAD('5380', 6, '0'), '�����ڵ���', 'KOSPI', '�¿��� �� ��Ÿ ������ �ڵ��� ������', '����Ư���� ���ʱ� �帪�� 12 (��)06797', '67/12/29', '74/06/28', 213668187);
INSERT INTO TB_STOCKS
VALUES(LPAD('112040', 6, '0'), '�����̵�', 'KOSDAQ', '���� �¶��� ���� ����Ʈ���� ���� �� ���޾�', '��⵵ ������ �д籸 ����Ǳ���644���� 49 (��)13493', '00/02/10', '09/12/18', 33796962);
INSERT INTO TB_STOCKS
VALUES(LPAD('21320', 6, '0'), 'KCC�Ǽ�', 'KOSDAQ', '�ǹ� �Ǽ���', '����Ư���� ���ʱ� ������� 587 KCC �Ǽ� (��)06526', '89/01/27', '01/08/21', 21400000);

SELECT * FROM TB_STOCKS;

DROP TABLE TB_STOCKS;

CREATE TABLE TB_USER (
    USER_ID VARCHAR(30),
    STOCKS_NAME VARCHAR(50),
    INTERESTED_STOCK VARCHAR(50),
    CONSTRAINT IDSTOCK_PK PRIMARY KEY(USER_ID, STOCKS_NAME)
);

COMMENT ON COLUMN TB_USER.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN TB_USER.STOCKS_NAME IS '�����';
COMMENT ON COLUMN TB_USER.INTERESTED_STOCK IS '��������';

SELECT * FROM TB_USER;

INSERT INTO TB_USER
VALUES('ASD123','īī��', NULL);
INSERT INTO TB_USER
VALUES('QWE55','�����ڵ���', NULL);
INSERT INTO TB_USER
VALUES('AAA222','�Ｚ����', NULL);