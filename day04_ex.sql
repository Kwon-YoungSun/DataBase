-- day04 과제

/*
    1. 이름이 SMITH 사원과 동일한 직급을 가진 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    job = (
            SELECT
                job
            FROM
                emp    
            WHERE
                ename = 'SMITH'
          )
;

/*
    2. 사원들의 평균급여보다 적게 받는 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    sal < (
            SELECT
                AVG(sal)
            FROM
                emp
          )
;
/*
    3. 최고급여자의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    sal = (
            SELECT
                MAX(sal)
            FROM
                emp
          )
;
/*
    4. KING 사원보다 늦게 입사한 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    hiredate > (
                    SELECT
                        hiredate
                    FROM
                        emp
                    WHERE
                        ename = 'KING'
               )
;
/*
    5. 각 사원의 급여의 평균급여의 차이를 조회하세요. 
*/
SELECT
    ename 사원이름, sal 급여,
    ROUND( 
        sal - (
                SELECT
                    AVG(sal)
                FROM
                    emp
              )
    , 2) "급여-평균급여"
        
FROM
    emp group by ename, sal
;

/*
    6. 부서의 급여합계가 가장 높은 부서의 사원들의 정보를 조회하세요. 
*/

/*
SELECT
    *
FROM
    emp
WHERE
    deptno = (
                SELECT
                    deptno
                FROM 
                    emp
                WHERE
                    sal = (SELECT MAX(sal) FROM emp GROUP BY deptno)
                
            )
;
*/

SELECT
    *
FROM
    emp
WHERE
    deptno = (   -- 부서별 급여합계
                        SELECT
                            dno
                        FROM (
                            SELECT
                                deptno dno, SUM(sal) sum
                            FROM
                                emp
                            GROUP BY
                                deptno
                        )
                        WHERE
                            sum = (
                                            SELECT
                                                MAX(sum)
                                            FROM(
                                                SELECT
                                                     deptno dno, SUM(sal) sum
                                                FROM
                                                    emp
                                                 GROUP BY
                                                    deptno
                                                )
                                        )
                        
    )
;


/*
    7. 커미션을 받는 직원이 한사람이라도 있는 부서의 소속 사원들의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    deptno = ( -- 커미션을 받는 직원이 한 사람이라도 있는 부서번호 조회
                SELECT
                    DISTINCT deptno
                FROM
                    emp
                WHERE
                    comm IS NOT NULL
                    AND
                    comm <> 0
                
             )
;

/*
    8. 평균급여보다 급여가 높고 이름이 4글자 또는 5글자인 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
-- 평균급여보다 급여가 높고
    sal > (
                SELECT
                    AVG(sal)
                FROM
                    emp
            )
    AND
-- 이름이 4글자 또는 5글자인
    LENGTH(ename) IN (4, 5)
;

/*
    9. 사원의 이름이 4글자로된 사원과 같은 직급의 사원들의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    job IN (
                SELECT
                    job -- 직급의
                FROM
                    emp
                WHERE
                    LENGTH(ename) = 4 -- 사원의 이름이 4글자로된 사원과 같은(SALESMAN, PRESIDENT, ANALYST)
          )
;

/*
    10. 입사년도가 81년이 아닌 사원과 같은 부서에 있는 사원의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    deptno IN (
                SELECT
                    deptno -- 같은 부서에 있는
                FROM
                    emp
                WHERE
                    TO_CHAR(hiredate, 'YYYY') <> '1981' -- 입사년도가 81년이 아닌 사원과
             )
;
/*
    11. 직급별 평균급여보다 조금이라도 많이 받는 사원의 정보를 조회하세요.(ANY)
*/
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
                SELECT
                    AVG(sal) -- MIN : 1037.5
                FROM
                    emp
                GROUP BY
                    job
            )
;

/*
    12. 입사년도별 평균급여보다 많이 받는 사람의 정보를 조회하세요.
*/
SELECT
    *
FROM
    emp
WHERE
    sal > ALL (
            SELECT
                AVG(sal) -- 2050(1987), 800(1980), 1300(1982), 2282.5(1981)
            FROM
                emp
            GROUP BY
                TO_CHAR(hiredate, 'YYYY')
          )
;

/*
    13. 최고 급여자의 이름길이와 같은 이름길이를 갖는 사원이 존재하면
        모든 사원의 정보를 조회하고
        아니면 조회하지 마세요.(EXISTS)
*/
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
                SELECT
                    LENGTH(ename) -- KING
                FROM
                    emp
                WHERE
                    sal = (
                            SELECT
                                MAX(sal)
                            FROM
                                emp
                        )
                    
            )
;
