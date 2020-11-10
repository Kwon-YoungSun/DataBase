CREATE TABLE guestboard(
    gno NUMBER(4)
        CONSTRAINT GBOARD_NO_PK PRIMARY KEY,
    g_mno NUMBER(4)
        CONSTRAINT GBOARD_MNO_FK REFERENCES member(mno)
        CONSTRAINT GBOARD_MNO_UK UNIQUE
        CONSTRAINT GBOARD_MNO_NN NOT NULL,
    body VARCHAR2(200 CHAR)
        CONSTRAINT GBOARD_BD_NN NOT NULL,
    wdate DATE DEFAULT sysdate
        CONSTRAINT GBOARD_DATE_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT GBOARD_SHOW_CK CHECK(isshow IN ('Y', 'N'))
        CONSTRAINT GBOARD_SHOW_NN NOT NULL
);

INSERT INTO 
    guestboard(gno, g_mno, body)
VALUES(
    (SELECT NVL(MAX(gno)+1, 1001) FROM guestboard),
    1, 'ÀÎ»ñ¸»À» µî·ÏÇÏ¼¼¿ä!'
);

SELECT
    gno, id, body, wdate, afile
FROM
    guestboard, member, avatar 
WHERE
    g_mno = mno
    AND avt = ano
ORDER BY
    wdate DESC
;

SELECT
    COUNT(*) cnt
FROM
    member, guestboard
WHERE
    g_mno = mno
    AND id = 'sun'
;



CREATE TABLE reboard(
    bno NUMBER(5)
        CONSTRAINT REBD_NO_PK PRIMARY KEY,
    b_mno NUMBER(5)
        CONSTRAINT REBD_MNO_FK REFERENCES member(mno)
        CONSTRAINT REBD_MNO_NN NOT NULL,
    body VARCHAR2(500 CHAR)
        CONSTRAINT REBD_BD_NN NOT NULL,
    upno NUMBER(5),
    wdate DATE DEFAULT SYSDATE
        CONSTRAINT REBD_DATE_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT REBD_SHOW_NN NOT NULL
        CONSTRAINT REBD_SHOW_CK CHECK (isshow IN('Y', 'N'))
);

-- 댓글게시판에 글을 7개 등록하세요.
INSERT INTO
    reboard(bno, b_mno, body)
VALUES(
    (SELECT NVL(MAX(bno) + 1, 10001) FROM reboard), ?, ?
);

SELECT
    NVL(MAX(bno) + 1, 10001)
FROM
    reboard
;
