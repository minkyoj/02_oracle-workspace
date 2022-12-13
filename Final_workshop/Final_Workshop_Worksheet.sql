-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT * FROM TB_BOOK;

SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
-- �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT * FROM TB_WRITER;

SELECT *
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE MOBILE_NO LIKE '019%'
        AND WRITER_NM LIKE '��%'
        ORDER BY WRITER_NM)
WHERE ROWNUM < 2;

-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)

SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_WRITER;

SELECT COUNT(*) AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
WHERE COMPOSE_TYPE = '�ű�';

-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (�������°� ��ϵ��� ���� ���� ������ ��) // COMPOSE_TYPE , 

SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;

SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) > 300;

-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�

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

-- 13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
-- ������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
-- ǥ�õǵ��� �� ��)

CREATE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
    FROM TB_BOOK_TRANSLATOR
    JOIN TB_BOOK USING (BOOK_NO)
    JOIN TB_WRITER USING (WRITER_NO)
    WHERE SUBSTR(TO_CHAR(ISSUE_DATE, 'YYYYMMDD'), 1, 4) = 2007
    WITH READ ONLY;

GRANT CREATE VIEW TO FINAL;

SELECT * FROM VW_BOOK_TRANSLATOR;


-- ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
-- ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)

/*
���ǻ�      �繫�� ��ȭ��ȣ     �ŷ�����
�� ���ǻ�   02-6710-3737     Default �� ���
*/

SELECT * FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER
VALUES('�� ���ǻ�', '02-6710-3737', DEFAULT);

-- 15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�.

SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(WRITER_NM) > 1;

---- ��������

-- 16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
-- NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)


SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_AUTHOR;

UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = NVL(COMPOSE_TYPE, '����');

/*
SELECT COMPOSE_TYPE
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NULL;


ROLLBACK;
*/

-- 17.  �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰���
-- �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT * FROM TB_WRITER;

SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02-%'
AND OFFICE_TELNO LIKE '%-___-%';

-- 18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT WRITER_NM
FROM TB_WRITER
WHERE MONTHS_BETWEEN('06/01/01' , REGIST_DATE) >= 372;

-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
-- ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
-- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 

SELECT BOOK_NM, PRICE,
    CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
         ELSE '�ҷ�����'
         END AS "������"
FROM TB_BOOK
WHERE STOCK_QTY < 10
AND PUBLISHER_NM = 'Ȳ�ݰ���'
ORDER BY STOCK_QTY DESC,
BOOK_NM ASC;


-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
-- ��������,�����ڡ�,�����ڡ��� ǥ���� ��)

SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK_AUTHOR;

SELECT B.BOOK_NM AS "������", WRITER_NM AS "����"
FROM TB_BOOK_TRANSLATOR BT
JOIN TB_BOOK B USING (BOOK_NO)
JOIN TB_WRITER W USING (WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';


SELECT BA.WRITER_NO
FROM TB_BOOK_TRANSLATOR BT
JOIN TB_BOOK B USING (BOOK_NO)
JOIN TB_WRITER W USING (WRITER_NO)
JOIN TB_BOOK_AUTHOR BA USING (BOOK_NO)
WHERE BOOK_NM = '��ŸƮ��';

SELECT *
FROM TB_BOOK_AUTHOR
WHERE WRITER_NO = 286;

INSERT INTO TB_WRITER
VALUES ('286', '��ƮȦƮ �������� ����(GOTTHOLD EPHRAIM LESSING)', NULL, NULL, NULL, NULL, NULL);

-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
-- ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
-- ������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
-- ������ ǥ�õǵ��� �� ��)

SELECT BOOK_NM AS "������", STOCK_QTY AS "������", PRICE AS "����(Org)", (PRICE - (PRICE*0.2)) AS "����(New)"
FROM TB_BOOK
WHERE MONTHS_BETWEEN(SYSDATE , ISSUE_DATE) > 360
AND STOCK_QTY >= 90
ORDER BY ������ DESC,
'����(Org)' DESC,
'����(New)' ASC;


