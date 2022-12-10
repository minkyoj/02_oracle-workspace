-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT * FROM TB_BOOK;

SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
-- �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT * FROM TB_WRITER;

SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM TB_WRITER
WHERE MOBILE_NO LIKE '019%'
AND WRITER_NM LIKE '��%'
ORDER BY WRITER_NM;

-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)

SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_WRITER;

SELECT WRITER_NM AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
WHERE COMPOSE_TYPE = '�ű�';

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (�������°� ��ϵ��� ���� ���� ������ ��) // COMPOSE_TYPE , 

SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;


SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
WHERE PAGE >= 300;

-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�

SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC;


SELECT *
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
        ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

-- 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� ��
-- ��)

/*
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;

SELECT WRITER_NM AS "�۰� �̸�", COUNT (*) AS "�Ǽ�"
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NM
ORDER BY COUNT(*) DESC;
*/

SELECT *
FROM (SELECT WRITER_NM AS "�۰� �̸�", COUNT (*) AS "�Ǽ�"
        FROM TB_BOOK_AUTHOR
        JOIN TB_WRITER USING (WRITER_NO)
        GROUP BY WRITER_NM
        ORDER BY COUNT(*) DESC)
WHERE ROWNUM <= 3;

-- 9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
-- ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)

SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK; 
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_BOOK_AUTHOR; --
--��Ʈ
SELECT * FROM TB_BOOK
WHERE BOOK_NO IN (2001092003, 2001092002,2001092001);

SELECT *
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
JOIN TB_BOOK USING (BOOK_NO);

SELECT WRITER_NO, ISSUE_DATE
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
JOIN TB_BOOK USING (BOOK_NO)
GROUP BY WRITER_NO, ISSUE_DATE;


UPDATE TB_WRITER
SET REGIST_DATE = ?






/*
SELECT MIN(ISSUE_DATE)
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
GROUP BY WRITER_NO;
*/

UPDATE TB_WRITER W
SET REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                   FROM TB_BOOK
                   JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
                   GROUP BY WRITER_NO
                   HAVING W.WRITER_NO = WRITER_NO);

SELECT * FROM TB_WRITER;

-- 10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
-- �� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
-- ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)

/*
�Ӽ�     �÷�        Ÿ��           Null     PK FK    ���� ���̺�
���� ��ȣ BOOK_NO    VARCHAR2(10) NOT NULL  Y  Y     TB_BOOK
�۰� ��ȣ WRITER_NO  VARCHAR2(10) NOT NULL  Y  Y     TB_WRITER
���� ��� TRANS_LANG VARCHAR2(60) NULL      N  N 
*/

SELECT * FROM TB_BOOK;

CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK,
    WRITER_NO VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);

SELECT * FROM TB_BOOK_TRANSLATOR;

-- 11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
-- ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
-- ������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
-- �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
/*
SELECT BOOK_NO, WRITER_NO
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');
*/
INSERT INTO TB_BOOK_TRANSLATOR (
SELECT BOOK_NO, WRITER_NO, NULL
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����')
);

DELETE
FROM (SELECT BOOK_NO, WRITER_NO
      FROM TB_BOOK_AUTHOR
      WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����')
      );


SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK_AUTHOR;

-- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_TRANSLATOR;


SELECT BOOK_NM, WRITER_NM
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)
WHERE SUBSTR(TO_CHAR(ISSUE_DATE, 'YYYYMMDD'), 1, 4) =
      2007;


