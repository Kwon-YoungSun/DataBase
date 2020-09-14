CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT AVT_NO_PK PRIMARY KEY,
    aname VARCHAR2(30 CHAR)
        CONSTRAINT AVT_NAME_UK UNIQUE
        CONSTRAINT AVT_NAME_NN NOT NULL,
    afile VARCHAR2(50 CHAR)
        CONSTRAINT AVT_FILE_UK UNIQUE
        CONSTRAINT AVT_FILE_NN NOT NULL,
    dir VARCHAR2(50 CHAR)
        CONSTRAINT AVT_DIR_NN NOT NULL,
    len NUMBER
        CONSTRAINT AVT_LEN_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT AVT_GEN_NN NOT NULL
        CONSTRAINT AVT_GEN_CK CHECK(gen IN('M', 'F'))
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man1', 'img_avatar1.png', '/img/avatar/', 0, 'M'
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man2', 'img_avatar2.png', '/img/avatar/', 0, 'M'
);
INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man3', 'img_avatar3.png', '/img/avatar/', 0, 'M'
);
INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man4', 'img_avatar4.png', '/img/avatar/', 0, 'F'
);
INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man5', 'img_avatar5.png', '/img/avatar/', 0, 'F'
);
INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man6', 'img_avatar6.png', '/img/avatar/', 0, 'F'
);

----------------------------------------------------------------------------

-- È¸¿ø Å×ÀÌºí »ý¼º
CREATE TABLE member(
    mno NUMBER(6)
        CONSTRAINT MEMB_NO_PK PRIMARY KEY,
    name VARCHAR2(13 CHAR)
        CONSTRAINT MEMB_NAME_NN NOT NULL,
    id VARCHAR2(20 CHAR)
        CONSTRAINT MEMB_ID_UK UNIQUE
        CONSTRAINT MEMB_ID_NN NOT NULL,
    pw VARCHAR2(30 CHAR)
        CONSTRAINT MEMB_PW_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT MEMB_GEN_NN NOT NULL
        CONSTRAINT MEMB_GEN_CK CHECK(gen IN('M', 'F')),
    ano NUMBER(2)
        CONSTRAINT MEMB_ANO_FK REFERENCES avatar(ano)
        CONSTRAINT MEMB_ANO_NN NOT NULL,
    tel VARCHAR2(12 CHAR)
        CONSTRAINT MEMB_TEL_UK UNIQUE,
    mail VARCHAR2(30 CHAR)
        CONSTRAINT MEMB_MAIL_UK UNIQUE,
    signdate DATE
        CONSTRAINT MEMB_SD_NN NOT NULL,
    nickname VARCHAR2(18 CHAR)
        CONSTRAINT MEMB_NICK_UK UNIQUE
        CONSTRAINT MEMB_NICK_NN NOT NULL
);


CREATE TABLE board(
    bno NUMBER(6)
        CONSTRAINT BD_NO_PK PRIMARY KEY,
    nickname VARCHAR2(18)
        CONSTRAINT BD_NICK_FK REFERENCES member(nickname)
        CONSTRAINT BD_NICK_NN NOT NULL,
    title VARCHAR2(300)
        CONSTRAINT BD_TI_NN NOT NULL,
    contents VARCHAR2(4000)
        CONSTRAINT BD_CON_NN NOT NULL,
    hits NUMBER(5)
        CONSTRAINT BD_HIT_NN NOT NULL,
    wrdate DATE
        CONSTRAINT BD_DATE_NN NOT NULL,
    attatched VARCHAR2(50)
);


ALTER TABLE board
DROP COLUMN birth;

ALTER TABLE member
ADD (
    birth DATE
);

ALTER TABLE member
MODIFY
    ano DEFAULT 11
;

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    '±è³²ÁØ', 'namjoon', '1234', 'M', 11, '01012345678', 'namjoon@naver.com', '2010/08/14', 'RM', '1994/09/12' 
);

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    '¹ÎÀ±±â', 'shooky', '1111', 'M', 12, '01024243636', 'shooky@naver.com', '2010/11/07', 'SUGA', '1993/03/09' 
);

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    'Á¤È£¼®', 'mang', '2846', 'M', 13, '01096095740', 'mang@naver.com', '2010/12/24', 'JHOPE', '2020/12/24' 
);

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    'ÀüÁ¤±¹', 'cooky', '9876', 'M', 11, '01009012948', 'cooky@naver.com', '2011/06/03', 'ÄíÅ°', '1997/09/01' 
);

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    '±èÅÂÇü', 'tata', '0903', 'M', 13, '01012310903', 'tata@naver.com', '2011/09/03', 'ÅÂÅÂ', '1995/12/30' 
);

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    '¹ÚÁö¹Î', 'chimmy', '0515', 'M', 11, '01005151013', 'chimmy@naver.com', '2012/05/15', 'Ä¡¹Ì', '1995/10/13' 
);

INSERT INTO member
VALUES(
    (SELECT NVL(MAX(mno), 1000) + 1 from member),
    '±è¼®Áø', 'jean', '0729', 'M', 12, '01007291204', 'jean@naver.com', '2012/07/29', 'RJ', '1992/12/04' 
);




