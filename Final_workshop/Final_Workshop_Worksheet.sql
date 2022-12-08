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











