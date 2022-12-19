SELECT * FROM MEMBER WHERE USERNAME LIKE '%±æ%';


UPDATE MEMBER
SET USERPWD = '',
    EMAIL = '',
    PHONE = '',
    ADDRESS = ''
WHERE USERID = '';

DELETE FROM MEMBER
WHERE USERID = '';

SELECT * FROM PRODUCT;

DROP TABLE PRODUCT;
ROLLBACK;

CREATE SEQUENCE SEQ_PNO
NOCACHE;


CREATE TABLE TB_PRODUCT(
    PNO NUMBER,
    PNAME VARCHAR2(100),
    PRICE NUMBER,
    NATIONAL VARCHAR2(50),
    BRAND VARCHAR2(100),
    SSG_ABLE CHAR(1) CHECK (SSG_ABLE IN ('Y','N')),
    CATEGORY VARCHAR2(100),
    REG_DATE DATE
    );
    
"INSERT INTO MEMBER VALUES(SEQ_PNO.NEXTVAL, ' p.getpName() 		 ',
															         p.getPrice() 		,
															  'p.getNational()	 ',
															  'p.getBrand()		 '
															  'p.getSsgAble()	',
															  'p.getCategory()	',
															  SYSDATE)";

