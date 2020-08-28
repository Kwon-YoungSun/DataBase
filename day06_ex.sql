-- day06 문제
-- INSERT, UPDATE, DELETE

-- hello 계정에 scott 계정이 가지고 있는
-- emp 테이블을 구조만 복사해서 만드세요.
CREATE TABLE sample01
AS
    SELECT
        *
    FROM
        scott.emp
    WHERE
        1 = 2
;
SELECT * FROM sample01;


-- dept 테이블도 구조만 복사해서 만드세요.
CREATE TABLE dept
AS
    SELECT
        *
    FROM
        scott.dept
    WHERE
        1 = 2
;
SELECT * FROM dept;

-- salgrade 테이블은 데이터까지 복사해서 만드세요.
CREATE TABLE salgrade
AS
    SELECT
        *
    FROM
        scott.salgrade
;
SELECT * FROM salgrade;

-- INSERT
-- 우리반 친구 5명의 데이터를 sample01 테이블에 입력하세요.
-- job은 emp 테이블의 직급을 사용하도록 한다.

INSERT INTO
    sample01
VALUES(
    1001, '권영선', 'MANAGER', 9999, SYSDATE, 3000, 1500, 30   
)
;

INSERT INTO
    sample01
VALUES(
    1002, '김태형', 'CLERK', 9999, SYSDATE, 2000, 1000, 10   
)
;

INSERT INTO
    sample01
VALUES(
    1003, '박지민', 'CLERK', 9999, SYSDATE, 2500, 500, 10   
)
;


INSERT INTO
    sample01
VALUES(
    1004, '민윤기', 'ANALYST', 9999, SYSDATE, 3500, 1500, 30   
)
;

INSERT INTO
    sample01
VALUES(
    9999, '김남준', 'BOSS', NULL, TO_DATE('2013/06/13', 'YYYY/MM/DD'), 5000, 2000, 40
)
;

/*
    dept 테이블에 데이터를 추가하는데
    10 - 기획부    - 수원
    20 - 인사부    - 여의도
    30 - 개발부    - 구로
    40 - 회계부    - 강남
    
    추가해주세요.
*/

INSERT INTO
    dept
VALUES(
    10, '기획부', '수원')    
;

INSERT INTO
    dept
VALUES(
    20, '인사부', '여의도')
;

INSERT INTO
    dept
VALUES(
    30, '개발부', '구로')
;

INSERT INTO
    dept
VALUES(
    40, '회계부', '강남')
;


-----------------------------------------------------------------------------------------------

/*
    scott계정이 가지고 있는 emp, dept 테이블을 데이터와 함께 복사해서
    semp, sdept를 만들고
    
    
    1. 사원의 급여를 일괄적으로 10% 인상해서 수정하세요.
    
    2. 급여를 10% 더 인상하고
        입사일을 오늘 날짜로 변경하세요.
        
    3. 직급이 SALESMAN 인 사원만 직급을 SALES 로 변경하세요.
    
    4. 부서번호가 10번인 사원만 삭제하세요.
    
*/
-- semp 생성
CREATE TABLE semp
    AS
        SELECT
            *
        FROM
            scott.emp
;
SELECT * FROM semp;

-- sdept 생성
CREATE TABLE sdept
    AS
        SELECT
            *
        FROM
            scott.dept
;
SELECT * FROM sdept;


-- 1. 사원의 급여를 일괄적으로 10% 인상해서 수정하세요.
UPDATE
    semp
SET
    sal = sal * 1.1
;

-- 2. 급여를 10% 더 인상하고
--        입사일을 오늘 날짜로 변경하세요.
UPDATE
    semp
SET
    sal = sal * 1.1,
    hiredate = SYSDATE
;

-- 3. 직급이 SALESMAN 인 사원만 직급을 SALES 로 변경하세요.
UPDATE
    semp
SET
    job = 'SALES'
WHERE
    job = 'SALESMAN'
;

-- 4. 부서번호가 10번인 사원만 삭제하세요.
DELETE FROM semp
WHERE
    deptno = 10
;

SELECT * FROM semp;



