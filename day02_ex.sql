-- 1. 사원의 이름, 직급, 입사일, 급여를 조회하세요.
--      급여가 많은 사람부터 조회되게 하세요.
    
SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여
FROM
    emp
ORDER BY
    sal DESC
;

/*
    2. 사원의 이름, 직급, 입사일, 부서번호를 조회하세요.
        단, 부서번호 순으로 정렬해서 조회하고
        같은 부서면 입사일 순서대로 조회되게 하세요.
*/
SELECT
    ename 이름, job 직급, hiredate 입사일, deptno 부서번호    
FROM
    emp
ORDER BY
    deptno DESC, hiredate ASC
;

/*
    3. 입사일이 5월인 사원의 이름, 직급, 입사일을 조회하세요.
        단, 입사일이 빠른 사람부터 조회되게 하세요.
*/
SELECT
    ename 이름, job 직급, hiredate 입사일
FROM
    emp
ORDER BY
    hiredate
;

/*
    4. 커미션을 27% 인상하여
        사원의 이름, 급여, 커미션, 인상커미션을 조회하세요.
        단, 커미션이 없는 사람은 100으로 하고 계산하기로 한다.
        단, 반올림해서 소수 2자리까지 표현하세요.
*/
SELECT
    ename 이름, sal 급여, comm 커미션, ROUND(NVL(comm, 100)*1.27, 2) 인상커미션
FROM
    emp
;

/*
    5. 사원의 이름, 급여, 커미션, 급여합계를 조회하세요.
        급여합계는 커미션 + 급여로 계산하고
        커미션이 없는 사람은 0을 커미션으로 받는 것으로 한다.
        단, 소수 첫째자리에서 버림을 해서 조회한다.
*/
SELECT
    ename 이름, sal 급여, comm 커미션, TRUNC((sal + NVL(comm, 0)), 1) 급여합계
FROM
    emp
;

/*
    6. 급여가 짝수인 사람만
        사원이름, 급여를 조회하세요.
        단, 단일행 함수를 사용해서 처리하세요.
*/
SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
    MOD(sal, 2) = 0
;

/*
    7. 급여가 100으로 나누어 떨어지는 사원의
        사원번호, 사원이름, 급여를 조회하세요.
        단, 단일행 함수를 사용해서 처리하세요.
*/
SELECT
    empno 사원번호, ename 사원이름, sal 급여
FROM
    emp
WHERE
    MOD(sal, 100) = 0
;
--------------------------------------------------------------------------------
-- 문자열 처리함수
/*
    8. 사원의 이름이 5글자 이하인 사원의
        사원번호, 사원이름, 부서번호를 조회하세요.(LIKE 쓰지 말것)
*/
SELECT
    empno 사원번호, ename 사원이름, deptno 부서번호
FROM
    emp
WHERE
    LENGTH(ename) <= 5
;

/*
    9. 사원이름이 'N'으로 끝나는 사원의
        사원번호, 사원이름을 조회하세요.
*/
SELECT
    empno 사원번호, ename 사원이름
FROM
    emp
WHERE
    INSTR(ename, 'N') = LENGTH(ename)
;

/*
    10. 사원이름에 'A'가 들어있는 사원의
        사원번호, 사원이름, 사원급여를 조회하세요.
*/
SELECT
    empno 사원번호, ename 사원이름, sal 사원급여
FROM
    emp
WHERE
    INSTR(ename, 'A') <> 0
;

/*
    11. 사원들의
        사원번호, 사원이름 을 조회하세요.
        사원이름은 마지막 두글자는 표현하고
        나머지 문자는 * 로 교체해서 조회하세요.

        예 ]
            SMITH
            ==> ***TH
*/

SELECT
    empno 사원번호, 
    LPAD(
        SUBSTR(ename, -2), -- 뒤에서부터 두번째
        LENGTH(ename),-- 만들어줄 길이,
        '*'-- 대체문자
    ) 사원이름
FROM
    emp
;

/*
    12. 사원의 사원번호, 사원이름을 조회하세요.
    
        사원이름은 첫글자와 마지막 글자는 표현하고
        나머지 문자는 *로 교체해서 조회하세요.
        
        예 ]
            SMITH
            ==> S***H
*/
SELECT
    empno 사원번호,
    CONCAT(
        SUBSTR(ename, 1, 1),
        LPAD(
            SUBSTR(ename, -1, LENGTH(ename-1) * -1),
            LENGTH(ename),
            '*'
        )
    ) 사원이름
FROM
    emp
;

/*
    13. 사원의 사원이름, 급여를 조회하세요.
        급여는 첫자리만 표현하고 나머지는 #으로 교체해서 표현하세요.
        
        
*/