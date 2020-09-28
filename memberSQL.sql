CREATE TABLE member(
    mno NUMBER(4)
        CONSTRAINT MEMB_NO_PK PRIMARY KEY,
    id VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_ID_UK UNIQUE
        CONSTRAINT MEMB_ID_NN NOT NULL,
    pw VARCHAR2(8 CHAR)
        CONSTRAINT MEMB_PW_NN NOT NULL,
    name VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_NAME_NN NOT NULL,
    mail VARCHAR2(50 CHAR)
        CONSTRAINT MEMB_MAIL_UK UNIQUE
        CONSTRAINT MEMB_MAIL_NN NOT NULL,
    tel VARCHAR2(13 CHAR)
        CONSTRAINT MEMB_TEL_UK UNIQUE
        CONSTRAINT MEMB_TEL_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT MEMB_GEN_CK CHECK (gen IN ('F', 'M'))
        CONSTRAINT MEMB_GEN_NN NOT NULL,
    avt NUMBER(2)
        CONSTRAINT MEMB_AVT_NN NOT NULL
        CONSTRAINT MEMB_AVT_FK REFERENCES avatar(ano),
    joinDate Date DEFAULT sysdate
        CONSTRAINT MEMB_JOIN_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT MEMB_SHOW_NN NOT NULL
        CONSTRAINT MEMB_SHOW_CK CHECK (isshow IN('Y', 'N'))
);


INSERT INTO
    member(mno, id, pw, name, mail, tel, gen, avt)
VALUES(
    1000, 'euns', '12345', 'ÀüÀº¼®', 'euns@increpas.com',
    '010-3175-9042', 'M', 11
);

INSERT INTO
    member(mno, id, pw, name, mail, tel, gen, avt)
VALUES(
    1001, 'joo', '12345', '±èÁÖ¿µ', 'joo@increpas.com',
    '010-1111-1111', 'F', 14
);

INSERT INTO
    member(mno, id, pw, name, mail, tel, gen, avt)
VALUES(
    1002, 'joseph', '12345', 'À±¿ä¼Á', 'joseph@increpas.com',
    '010-2222-2222', 'M', 12
);

commit;

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    999, 'joo', '±èÁÖ¿µ', 'joo@increpas.com',	'F',	15 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1000,	'euns',	'ÀüÀº¼®',	'euns@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1001,	'euisan',	'±èÀÇ»ê',	'euisan@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1002,	'sun',	'±Ç¿µ¼±',	'sun@increpas.com',	'F',	15 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1003,	'mygusdnd',	'¼­Çö¿õ','mygusdnd@gmail.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1004, 'smkim',	'±è¼º¹Î',	'kim@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1005, 'jjang',	'Àå¼ºÈ¯',	'jjang@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1006,	'joseph',	'À±¿ä¼Á',	'joseph@increpas.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1007,	'kys',	'±è¿µ¼±',	'kys@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
  1008,	'dhgpcks',	'¿ÀÇýÂù',	'dhgpcks123@naver.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
  1009,'wook',	'À¯º´¿í',	'wook@increpas.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
  1010,	'jieun',	'ÇÏÁöÀº',	'jieun@increpas.com',	'F',	14 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1012,	'jeong',	'Á¤Çö¿í',	'hujeong@increpas.com',	'M',	12 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1013,	'jiwoo',	'ÀÌÁö¿ì',	'ckdn@increpas.com',	'M',	12 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1014,	'juhyun',	'±èÁÖÇö',	'juhyun@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1015,	'park',	'¹ÚÂùÁ¾', 'cj@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1016,	'jang',	'Àå¼öÁø',	'jang@increpas.com',	'F',	16 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1017,	'jinwoo', '¹ÚÁø¿ì',	'jinwoo@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1018,	'hh',	'ÇÑÈÆ',	'h@increpas',	'M',	11 , '12345'
);

commit;
