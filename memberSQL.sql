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
    1000, 'euns', '12345', '������', 'euns@increpas.com',
    '010-3175-9042', 'M', 11
);

INSERT INTO
    member(mno, id, pw, name, mail, tel, gen, avt)
VALUES(
    1001, 'joo', '12345', '���ֿ�', 'joo@increpas.com',
    '010-1111-1111', 'F', 14
);

INSERT INTO
    member(mno, id, pw, name, mail, tel, gen, avt)
VALUES(
    1002, 'joseph', '12345', '�����', 'joseph@increpas.com',
    '010-2222-2222', 'M', 12
);

commit;

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    999, 'joo', '���ֿ�', 'joo@increpas.com',	'F',	15 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1000,	'euns',	'������',	'euns@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1001,	'euisan',	'���ǻ�',	'euisan@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1002,	'sun',	'�ǿ���',	'sun@increpas.com',	'F',	15 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1003,	'mygusdnd',	'������','mygusdnd@gmail.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1004, 'smkim',	'�輺��',	'kim@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1005, 'jjang',	'�强ȯ',	'jjang@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1006,	'joseph',	'�����',	'joseph@increpas.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1007,	'kys',	'�迵��',	'kys@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
  1008,	'dhgpcks',	'������',	'dhgpcks123@naver.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
  1009,'wook',	'������',	'wook@increpas.com',	'M',	13 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
  1010,	'jieun',	'������',	'jieun@increpas.com',	'F',	14 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1012,	'jeong',	'������',	'hujeong@increpas.com',	'M',	12 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
    1013,	'jiwoo',	'������',	'ckdn@increpas.com',	'M',	12 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1014,	'juhyun',	'������',	'juhyun@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1015,	'park',	'������', 'cj@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1016,	'jang',	'�����',	'jang@increpas.com',	'F',	16 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1017,	'jinwoo', '������',	'jinwoo@increpas.com',	'M',	11 , '12345'
);

INSERT INTO member(mno, id, name, mail, gen, avt, pw)
VALUES(
   1018,	'hh',	'����',	'h@increpas',	'M',	11 , '12345'
);

commit;
