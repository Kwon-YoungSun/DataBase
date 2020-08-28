-- ANSI 조인을 이용하여 해결하세요.

/*
    문제 1 ]
        직급이 'MANAGER'인 사원의
        이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/
-- NATURAL JOIN
SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름
FROM
    emp NATURAL JOIN dept
WHERE
    job = 'MANAGER'
;

-- INNER JOIN(equi join)
SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름
FROM
    emp INNER JOIN dept
ON
    emp.deptno = dept.deptno
WHERE
    job = 'MANAGER'
;


/*
    문제 2 ]
        급여가 가장 적은 사람의
        이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회하세요.
*/
-- 1. NATURAL JOIN
SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름, loc 부서위치
FROM
    emp NATURAL JOIN dept
WHERE
    sal = (
            SELECT
                MIN(sal)
            FROM
                emp
          )
;

-- 2. INNER JOIN(equi join)
SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름, loc 부서위치
FROM
    emp INNER JOIN dept
ON
    emp.deptno = dept.deptno
WHERE
    sal = (
            SELECT
                MIN(sal)
            FROM
                emp
          )    
;


/*
    문제 3 ]
        사원이름이 5글자인 사원의
        이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/
-- INNER JOIN(Non Equi Join)
SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급
FROM
    emp INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
WHERE
    LENGTH(ename) = 5
;

/*
    문제 4 ]
        입사일이 81년이면서 직급이 CLERK 인 사원의
        이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/

SELECT
    ename 이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급, dname 부서이름, loc 부서위치
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
WHERE
    TO_CHAR(hiredate, 'YY') = '81'
    AND job = 'CLERK'
;

/*
    문제 5 ]
        사원의 이름, 직급, 급여, 상사이름, 급여등급을 조회하세요.
*/  
SELECT
    e.ename 이름, e.job 직급, e.sal 급여, s.ename 상사이름, grade 급여등급
FROM
-- emp 테이블과 salgrade 테이블 INNER JOIN(Non Equi Join)
    emp e INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
-- emp 테이블과 emp 테이블 OUTER JOIN
LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
;

/*
    문제 6 ]
        사원의
        이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급을 조회하세요.
*/
SELECT
    e.ename 이름, e.job 직급, e.sal 급여, s.ename 상사이름, dname 부서이름, loc 부서위치, grade 급여등급
FROM
-- 사원테이블과 부서테이블 INNER JOIN(Equi Join)
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
-- 사원 테이블과 급여등급테이블 INNER JOIN(Non Equi Join)
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
-- 사원테이블과 사원테이블 OUTER JOIN
LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno

;

/*
    문제 7 ]
        사원의
        이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급을 조회하는데
        회사 평균급여보다 급여가 높은 사원만 조회하세요.
*/
SELECT
    e.ename 이름, e.job 직급, e.sal 급여, s.ename 상사이름, dname 부서이름, loc 부서위치, grade 급여등급
FROM
-- 사원테이블과 부서테이블 INNER JOIN(Equi Join)
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
-- 사원 테이블과 급여등급테이블 INNER JOIN(Non Equi Join)
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
-- 사원테이블과 사원테이블 OUTER JOIN
LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
WHERE
-- 회사 평균급여보다 급여가 높은 사원만 조회
    e.sal > (
            SELECT
                AVG(sal)
            FROM
                emp
          )
;
/*
    문제 8 ]
        사원의 이름, 직급, 급여, 부서번호, 부서이름, 부서위치를 조회하세요.
        단, 사원이 없는 부서도 같이 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, sal 급여, d.deptno 부서번호, dname 부서이름, loc 부서위치
FROM
-- 사원테이블과 부서테이블 OUTER JOIN
    emp e RIGHT OUTER JOIN dept d
ON
    e.deptno = d.deptno
;

--------------------------------------------------------------------------------

-- 사원수가 가장 많은 부서의 사원중 부서평균급여보다 많이 받는 사원들의
-- 사원이름, 직급, 급여, 부서번호, 부서평균급여, 부서원수를 조회하세요.

--------------------------------------------------------------------------------
-- 1. 인라인 뷰를 사용하지 않는 방법
SELECT
    ename 사원이름, job 직급, sal 급여, deptno 부서번호,
    (
        SELECT
            ROUND(AVG(sal), 2)
        FROM
            emp
        WHERE
            deptno = e.deptno
        GROUP BY
            deptno
    ) 부서평균급여,
    (
        SELECT
            COUNT(*)
        FROM
            emp
        WHERE
            deptno = e.deptno
        GROUP BY
            deptno
    ) 부서원수
FROM
    emp e
WHERE
-- 사원수가 가장 많은 부서의 사원 중
    deptno = (
                SELECT
                    deptno
                FROM
                    emp
                GROUP BY
                    deptno
                HAVING
                    COUNT(*) = (
                     SELECT
                        MAX(COUNT(*))
                     FROM
                        emp
                     GROUP BY
                        deptno
                )
             )
-- 부서평균급여보다 많이 받는 사원들의
    AND sal > (
                SELECT
                    AVG(sal)
                FROM
                    emp
                WHERE
                    deptno = e.deptno
                GROUP BY
                    deptno
              )
;