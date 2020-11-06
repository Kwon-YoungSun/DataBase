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
    1, '인삿말을 등록하세요!'
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



