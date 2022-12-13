--
/*
    < Ʈ���� TRIGGER >
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX)
    ȸ��Ż��� ������ ȸ�����̺� �����͸� DELETE�� �� ��ٷ� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó���ؾߵȴ�.
    �Ű�Ƚ���� ���� ���� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT)�� �� ���� �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�ؾ� �� ��
    
    * Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
      > BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
      > AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
      > STATEMENT TRIGGER (����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
      > ROW TRIGGER (��Ʈ����) : �ش� SQL�� ������ �� ���� �Ź� Ʈ���� ����
                                (FOR EACH ROW �ɼ� ����ؾߵ�)
                                > :OLD - BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�)
                                > :NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(������ �ڷ�)
    * Ʈ���� ��������
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER        INSERT|UPDATE|DELETE ON ���̺��
    [FOR EACH ROW]
    �ڵ����� ������ ����;
     �� [DECLARE
            ��������]
        BEGIN
            ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ����������(�ڵ�����) ������ ����)
        [EXCEPTION
            ����ó������;]
        END;
        /
    
*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޼��� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '�̼���', '111111-2222222', 'D7', 'J7', 'S2', SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(501, '�ָ�', '222222-2222222', 'D8', 'J7', 'S2', SYSDATE);

--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� ������ ������ ���̺� (TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,               -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,            -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,            -- �귣��
    PRICE NUMBER,                           -- ����
    STOCK NUMBER DEFAULT 0                  -- ������
);

-- ��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������20', '�Ｚ', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������14', '����', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '�����', '������', 600000, 20);

SELECT * FROM TB_PRODUCT;
COMMIT;

-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,               -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT,     -- ��ǰ��ȣ
    PDATE DATE NOT NULL,                    -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                 -- ��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���')) -- ����(�԰� / ���)
);

-- �̷� ��ȣ�� �Ź� ���ο� ��ȣ �߻����Ѽ� �� �� �ְ� �����ִ� ������ (SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���ó�¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');
-- 200�� ��ǰ�� �������� 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- �ش� Ʈ������ Ŀ��

-- 210�� ��ǰ�� ���ó�¥�� 5�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '���');
-- 210�� ��ǰ�� �������� 5 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205�� ��ǰ�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- 205�� ��ǰ�� �������� 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 200;

ROLLBACK;

-- 205�� ��ǰ�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- 205�� ��ǰ�� �������� 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �Ź� �ڵ����� �������� UPDATE �ǰԲ� Ʈ���� ����

/*
    - ��ǰ�� �԰�� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + �����԰�ȼ���(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �����԰�Ȼ�ǰ��ȣ(INSERT�� �ڷ��� PCODE��);
    
    - ��ǰ�� ���� ��� => �ش��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - �������ȼ���(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �������Ȼ�ǰ��ȣ(INSERT�� �ڷ��� PCODE��);
*/

-- :NEW �����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� => ������ ����
    IF (:NEW.STATUS = '�԰�')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- ��ǰ�� ���� ��� => ������ ����
    IF (:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE; 
    END IF;
END;
/

-- 210�� ��ǰ�� ���� ��¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '���');

-- 200�� ��ǰ�� ���ó�¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');

--------------------------------------------------------------

-- �л� ���̺� ����
-- TB_STU
-- �÷� : �й�, �̸�, ����(M,F), ��ȭ��ȣ, ��������(����Ʈ ����)
-- STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS
-- �й������� ����(SEQ_STU_NO)
-- 900������ �����ϰ� (900,901)

-- ������ 5�� �����

-- ���� ���̺� ����
-- TB_ABSENCE
-- �÷� : ���й�ȣ, �й�(�ܷ�Ű), ��������, ���п���(CHECK Y N) => DEFAULT Y
-- ABS_NO, STU_NO, ABS_DATE, ABS_STATUS
-- ���� ������ ����
-- 1������ �����ϰ�

-- �л��� ������ ��쿡 ���� ���̺� INSERT ��Ű��
-- �������̺��� ���п��ΰ� Y�� �Ǵ� ��� 
-- �л����̺��� �������θ� �������� �����Ѵ�.
-- �л����̺��� �������ΰ� ������ �Ǵ� ���
-- �ش絥���͸� DELETE ó�� �Ѵ�.

------

-- �л� ���̺� ����
-- TB_STU
-- �÷� : �й�, �̸�, ����(M,F), ��ȭ��ȣ, ��������(����Ʈ ����)
-- STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS
CREATE TABLE TB_STU(
    STU_NO NUMBER,           -- �й�
    STU_NAME VARCHAR2(20),   -- �̸�
    GENDER CHAR(1) CHECK(GENDER IN ('M','F')),         -- ����
    PHONE VARCHAR2(20),      -- ��ȭ��ȣ
    STU_STATUS VARCHAR2(20) DEFAULT '����'
);

-- �й������� ����(SEQ_STU_NO)
-- 900������ �����ϰ� (900,901)
CREATE SEQUENCE SEQ_STU_NO
START WITH 900;

-- ������ 5�� �����
INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '����', 'M', '010-1111-1111', DEFAULT);
INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '������', 'F', '010-2222-2222', '����');
INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '�ڹڹ�', 'M', '010-3333-3333', DEFAULT);
INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '������', 'F', '010-4444-4444', '����');
INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '������', 'F', '010-5555-5555', DEFAULT);

ALTER TABLE TB_STU ADD PRIMARY KEY(STU_NO);

-- ���� ���̺� ����
-- TB_ABSENCE
-- �÷� : ���й�ȣ, �й�(�ܷ�Ű), ��������, ���п���(CHECK Y N) => DEFAULT Y
-- ABS_NO, STU_NO, ABS_DATE, ABS_STATUS
CREATE TABLE TB_ABSENCE(
    ABS_NO NUMBER,           -- ���й�ȣ
    STU_NO NUMBER REFERENCES TB_STU,   -- �й�
    ABS_DATE DATE,         -- ��������
    ABS_STATUS CHAR(1) DEFAULT 'Y' CHECK(ABS_STATUS IN ('Y','N'))      -- ���п���
);

-- ���� ������ ����
-- 1������ �����ϰ�
CREATE SEQUENCE SEQ_ABS_NO
START WITH 1;

-- �л��� ������ ��쿡 ���� ���̺� INSERT ��Ű��
---- �������̺��� ���п��ΰ� Y�� �Ǵ� ��� 
---- �л����̺��� �������θ� �������� �����Ѵ�.
-- �л����̺��� �������ΰ� ������ �Ǵ� ���
-- �ش絥���͸� DELETE ó�� �Ѵ�.





CREATE OR REPLACE TRIGGER TRG_S01
AFTER UPDATE ON TB_STU
FOR EACH ROW
BEGIN
    -- �л��� ������ ��쿡 ���� ���̺� INSERT
    IF (:NEW.STU_STATUS = '����')
        THEN
            INSERT INTO TB_ABSENCE
            VALUES (SEQ_ABS_NO.NEXTVAL, :NEW.STU_NO, SYSDATE, 'Y');
    END IF;
    /*
    -- �л����̺��� �������ΰ� ������ �Ǵ� ��� �ش絥���͸� DELETE ó�� �Ѵ�.
    IF (:NEW.STU_STATUS = '����')
        THEN
            DELETE FROM TB_STU
            WHERE STU_NO = :NEW.STU_NO;
            DELETE FROM TB_ABSENCE
            WHERE STU_NO = :NEW.STU_NO;
    END IF;
    */
END;
/

INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '������', 'F', '010-5555-5555', '����');
INSERT INTO TB_STU
    VALUES(SEQ_STU_NO.NEXTVAL, '������', 'M', '010-5555-5555', '����');

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 904;

   -- ���� ���̺� ���п��ΰ� N���� �ٲ�°��
   -- �л����̺��� �������� �������� ����

CREATE OR REPLACE TRIGGER TRG_S02
AFTER UPDATE ON TB_ABSENCE
FOR EACH ROW
BEGIN
    IF (:NEW.ABS_STATUS = 'N')
        THEN
            UPDATE TB_STU
            SET STU_STATUS = '����'
            WHERE STU_NO = :NEW.STU_NO;
    END IF;
END;
/

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NAME = '������';

UPDATE TB_ABSENCE
SET ABS_STATUS = 'N'
WHERE STU_NO = 909;





