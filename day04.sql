-- 조건처리함수를 사용해서 해결하세요.

/*
    사원들의 직급을 우리말로 조회하세요.
        
        MANAGER - 관리자
        SALESMAN - 영업직
        CLERK   - 사원
        ANALYST - 분석가
        PRESIDENT - 사장
        
*/
SELECT
    ename 사원이름,
    /*
    DECODE(job, 'MANAGER', '관리자',
                'SALESMAN', '영업직',
                'CLERK', '사원',
                'ANALYST', '분석가',
                'PRESIDENT', '사장') 직급
    */
    
    /*
    CASE WHEN job = 'MANAGER' THEN '관리자'
         WHEN job = 'SALESMAN' THEN '영업직'
         WHEN job = 'CLERK' THEN '사원'
         WHEN job = 'ANALYST' THEN '분석가'
         WHEN job = 'PRESIDENT' THEN '사장'
    END 직급
    */
    
    CASE job WHEN 'MANAGER' THEN '관리자'
             WHEN 'SALESMAN' THEN '영업직'
             WHEN 'CLERK' THEN '사원'
             WHEN 'ANALYST' THEN '분석가'
             WHEN 'PRESIDENT' THEN '사장'
    END 직급
FROM
    emp
;

/*
    2. 각 부서별로 보너스를 다르게 적용해서 지급하려한다.
        
        10 - 급여의 10%
        20 - 급여의 15%
        30 - 급여의 20%
        를 기존커미션에 더해서 지급하려고 한다.
        만약 커미션이 없는 사람은 0으로 해서 계산하기로 하고
        사원의 이름, 급여, 기존커미션, 적용커미션
        을 조회하세요.
*/
SELECT
    ename 사원이름,
    sal 급여,
    comm 기존커미션,
    
    /*
    CASE deptno WHEN 10 THEN sal*1.1 + NVL(comm, 0)
                WHEN 20 THEN sal*1.15 + NVL(comm, 0)
                WHEN 30 THEN sal*1.2 + NVL(comm, 0)
    END 적용커미션
    */
    
    DECODE(deptno, 10, sal*1.1 + NVL(comm, 0),
                   20, sal*1.15 + NVL(comm, 0),
                   30, sal*1.2 + NVL(comm, 0)) 적용커미션
    
FROM
    emp
;

/*
    3. 입사년도를 기준으로
        80 - 'A'
        81 - 'B'
        82 - 'C'
        그 이외의 해에 입사한 직원은 'D' 등급으로
        
        사원들의
            사원이름, 입사일, 사원등급
        을 조회하세요.
*/  
SELECT
    ename 사원이름, hiredate 입사일,
    /*
    DECODE(TO_CHAR(hiredate, 'YY'), '80', 'A',
                                    '81', 'B',
                                    '82', 'C',
                                          'D' ) 사원등급
    */
    
    CASE TO_CHAR(hiredate, 'YY') WHEN '80' THEN 'A'
                                 WHEN '81' THEN 'B'
                                 WHEN' 82' THEN 'C'
                                 ELSE 'D'
                                 END 사원등급
FROM
    emp
;

/*
    4. 사원의 이름이 4글자이면 'Mr.' 를 이름 앞에 붙이고
        4글자가 아니면 이름 뒤에 '사원'을 붙여서 조회하려고 한다.
        사원들의
        사원번호, 사원이름, 사원이름글자수
        를 조회하세요.
*/
SELECT
    empno 사원번호,
    /*
    CASE WHEN LENGTH(ename) = 4 THEN 'Mr. ' || ename
         ELSE ename || ' 사원'
    END 사원이름,
    LENGTH(ename) 사원이름글자수
    */
    
    DECODE(LENGTH(ename), 4, 'Mr.' || ename,
            ename || '사원') 사원이름글자수
FROM
    emp
;
/*
    5. 부서번호가 10 또는 20이면 급여 + 커미션의 결과를 출력하세요.
        (커미션이 없으면 0으로 계산)
        그 이외의 부서는 급여만 출력하도록 질의 명령을 작성해서
        
        사원이름, 부서번호, 급여, 커미션, 지급금액
        을 조회하세요.
*/
SELECT
    ename 사원이름, deptno 부서번호, sal 급여, comm 커미션,
    /*
    CASE WHEN deptno IN(10,20) THEN sal + NVL(comm, 0)
         ELSE sal
    END 지급금액
    */
    
    DECODE(deptno, 10, sal + NVL(comm,0),
                   20, sal + NVL(comm,0),
                   sal) 지급급액
FROM
    emp
;

/*
    6. 입사한 요일이 토요일, 일요일인 사원들의 급여를 20% 증가해서 지급하고
        그 이외의 사원은 10% 증가해서 지급하려한다.
        
        사원들의
            사원이름, 입사일, 입사요일, 급여, 계산급여
        를 조회하세요.
*/
SELECT
    ename 사원이름, hiredate 입사일, TO_CHAR(hiredate, 'DAY') 입사요일,
    sal 급여,
    /*
    CASE WHEN TO_CHAR(hiredate, 'DAY') IN('토요일', '일요일') THEN sal*1.2
         ELSE sal * 1.1
    END 계산급여
    */
    DECODE(TO_CHAR(hiredate, 'DAY'), '토요일', sal*1.2,
                                     '일요일', sal*1.2,
                                               sal*1.1) 계산급여
FROM
    emp
;
/*
    7. 근무개월수가 470개월 이상이면 커미션을 500 추가해서 지급하고(커미션이 없으면
        0으로 계산)
        근무개월수가 470개월 미만이면 커미션을 현재 커미션만 지급하도록 하려한다.
        사원들의
            사원이름, 커미션, 입사일, 입사개월수, 지급커미션
        을 조회하세요.
*/
SELECT
    ename 사원이름, comm 커미션, hiredate 입사일, FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) 근무개월수,
    CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) >= 470 THEN NVL(comm, 0) + 500
         ELSE NVL(comm, 0)
    END 지급커미션
 
FROM
    emp
;
/*
    8. 이름의 글자수가 5글자 이상인 사람은 이름을 3글자**를 붙이고
        4글자 이하인 사람은 이름을 그대로 조회하려고 한다.
        
        사원들의
            사원이름, 이름글자수, 변경이름
        을 조회하세요.
*/
SELECT
    ename 사원이름, LENGTH(ename) 이름글자수,
    CASE WHEN LENGTH(ename) >= 5 THEN RPAD(SUBSTR(ename, 1, 3), LENGTH(ename), '*')
         ELSE ename
    END 변경이름
FROM
    emp
;

----------------------------------------------------------------------------------------
-- day04

/*
    그룹함수
    ==> 여러행의 데이터를 하나로 만들어서 뭔가를 계산하는 함수
    
    ***
    참고
        그룹함수는 오직 결과가 한개만 나오게 된다.
        따라서 그룹함수는 결과가 여러개 나오는 경우와 혼용해서 사용할 수 없다.
        ( ==> 필드, 단일행 함수와 같이 사용할 수 없다.)
        오직 결과가 한행으로만 나오는 것과만 혼용할 수 있다.
        그룹함수와만 같이 사용할 수 있다.
*/

SELECT ename FROM emp; -- 14개의 결과가 조회

SELECT SUM(sal) 급여총합 FROM emp; -- 한개의 결과가 조회

SELECT ename, SUM(sal) FROM emp; -- 사용할 수 없다.

SELECT
    ename, SUM(sal)
FROM
    emp
WHERE
    ename = 'SMITH'
;   ------------------------------ 역시 사용할 수 없다.

/*
    1. SUM
        ==> 데이터의 합계를 반환해주는 함수
        
        형식 ]
            SUM(필드이름)
*/

SELECT
    SUM(sal) 급여합계
FROM
    emp
WHERE
    deptno = 10 --------------------- 10번 부서 사원들의 급여 합계
;

SELECT deptno, sal, empno FROM emp;

/*
    2. AVG
        ==> 데이터의 평균을 구하는 함수
        
        형식 ]
            AVG(필드이름 혹은 연산식)
        
        참고 ]
            NULL 데이터는 평균을 계산하는 부분에서 완전히 제외된다.
*/
SELECT
    SUM(sal) 급여합계, FLOOR(AVG(sal)) 급여평균
FROM
    emp
;

SELECT
    SUM(comm) 커미션합계, FLOOR(AVG(comm)) 커미션평균 -- NULL 데이터는 건너뛴다.
FROM
    emp
;

/*
    결과값 550은 커미션이 있는 사원들의 합계를 커미션이 있는 사원수로 나눈 결과값이다.
    이유는 null은 모든 연산에서 제외가 되기 때문이다.
    사원수에 카운트 되지 않는다.
*/
-- 커미션이 있는 사원수
SELECT
    COUNT(*) 커미션있는사원수
FROM
    emp
WHERE
    comm IS NOT NULL
;

SELECT
    COUNT(comm) 커미션있는사원수
FROM
    emp
;

/*
    3. COUNT
        ==> 지정한 필드 중에서 데이터가 존재하는 필드의 갯수를 반환해주는 함수
        
        예 ]
            사원중에서 커미션을 받는 사원의 수를 조회
            SELECT COUNT(comm) FROM emp;
        
        참고 ]
            필드이름 대신에 * 를 사용하면
            각각의 필드의 카운트를 따로 구한 후
            그 결과중에서 가장 큰값을 알려주게 된다.
*/

-- 사원중 상사가 존재하는 사원수
SELECT COUNT(mgr) FROM emp;

-- 사원수를 조회하세요.
SELECT COUNT(*) FROM emp;

/*
    4. MAX / MIN
        ==> 지정한 필드의 데이터 중에서 가장 큰 또는 작은 데이터를 반환해주는 함수
*/

-- 사원중 급여가 최고급여자와 최소급여자의 급여를 조회하세요.
SELECT
    MAX(sal) 최고급여, MIN(sal) 최소급여
FROM
    emp
;

/*
    (잘 쓰이지 않으므로 참고만 해 두자.)
    
    5. STDDEV    ==> 표준편차를 반환해준다.
                     표준 편차(standard deviation)는 분산을 제곱근한 것이다.
                     
    6. VARIANCE  ==> 분산을 반환해준다.
                     각 데이터들의 평균값에 대한 차의 평균
*/

-- 문제 ] 사원들의 직급의 가지수를 조회하세요.
SELECT COUNT(DISTINCT job) FROM emp;

----------------------------------------------------------------------------------------
/*
    GROUP BY
    ==> 그룹함수에 적용되는 그룹을 지정하는 절
    
    예 ]
        부서별로 급여의 합계를 구하고자 한다.
        직급별로 급여의 평균을 조회하고자 한다.
        
    형식 ]
        SELECT
            그룹함수, 그룹기준필드
        FROM
            테이블이름
        [WHERE
            ]
        GROUP BY
            필드이름
        [ORDER BY
            ]    
        ;
*/
SELECT
    deptno 부서번호, SUM(sal) 부서급여합계
FROM
    emp
GROUP BY
    deptno
--ORDER BY
--    deptno ASC
;

SELECT
    job 직급, ROUND(AVG(sal), 2) 직급급여평균
FROM
   emp 
GROUP BY
    job
--ORDER BY
--    job ASC
;

-- 직급별 사원수, 급여총액, 급여평균을 조회하세요.
SELECT
    job 직급, COUNT(*) 사원수, SUM(sal) 급여총액, ROUND(AVG(sal), 2) 급여평균
FROM
    emp
GROUP BY
    job
;

--------------------------------------------------------------------------------
/*
    1. 각 부서별로 최소 금액을 조회하세요.
*/
SELECT
    deptno 부서명, MIN(sal) 최소금액
FROM
    emp
GROUP BY
    deptno
;

/*
    2. 각 직책별 급여의 총액과 평균금액을 조회하세요.
*/
SELECT
    job 직책,
    SUM(sal) 급여총액, ROUND(AVG(sal), 2) 평균금액
FROM
    emp
GROUP BY
    job
;
/*
    3. 입사 년도별로 평균 급여와 총급여를 조회하세요.
        입사년도, 평균급여, 총급여
*/
SELECT
    TO_CHAR(hiredate, 'YYYY') || ' 년' 입사년도, ROUND(AVG(sal), 2) 평균급여, SUM(sal) 총급여
FROM
    emp
GROUP BY
    TO_CHAR(hiredate, 'YYYY')
;

/*
    4. 각 년도별 입사한 사원수를 조회하세요.
        입사년도, 사원수
*/
SELECT
    TO_CHAR(hiredate, 'YYYY') || ' 년' 입사년도, COUNT(*) || ' 명' 사원수
FROM
    emp
GROUP BY
    TO_CHAR(hiredate, 'YYYY')
;

/*
    5. 사원이름의 글자수가 4, 5개인 사원의 수를 조회하세요.
        단, 사원이름 글자수를 그룹화해서 조회하세요.
*/
SELECT
    LENGTH(ename) || ' 개' 이름글자수, COUNT(*) || ' 명' 사원수
FROM
    emp
WHERE
    LENGTH(ename) IN (4, 5)
GROUP BY
    LENGTH(ename)
;
/*
    6. 81년도에 입사한 사원의 수를 직책별로 조회하세요.
*/
SELECT
    job 직책, COUNT(*) || ' 명' 사원수
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'YY') = '81'
GROUP BY
    job
;
--------------------------------------------------------------------------------
/*
    HAVING
    ==> GROUP BY 절로 그룹화한 경우 계산된 그룹중에서
        조회결과에 적용될 그룹을 지정하는 조건식
        
    **
    참고 ]
        WHERE 조건은 계산에 포함될 데이터를 선택하는 조건절이고
        HAVING 조건은 계산을 끝낸 후 조회 결과를 보여줄지 말지를 결정하는 조건절이다.
*/

SELECT
    job 직급, count(*) 직원수
FROM
    emp
WHERE
    deptno = 10
GROUP BY
    job
;

-- 부서별로 평균 급여를 계산하세요.
-- 단, 각 부서의 평균급여가 2000 이상인 부서만 조회하세요.
SELECT
    deptno 부서번호,
    ROUND(AVG(sal), 2) 평균급여
FROM
    emp
GROUP BY
    deptno
HAVING
    AVG(sal) >= 2000
;

-- 직급별로 사원수를 조회하세요.
-- 단, 사원수가 1명인 직급은 제외하고 조회하세요.
SELECT
    job 직급, COUNT(*) 사원수
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(*) <> 1
;

---------------------------------------------------------------------------------
/*
    7. 사원이름의 길이가 4, 5글자인 사원의 수를 부서별로 조회하세요.
        단, 사원수가 한사람 미만인 부서는 제외하고 조회하세요.
*/
SELECT
    deptno 부서명, COUNT(*) || ' 명' 사원수
FROM
    emp
WHERE
    LENGTH(ename) IN (4, 5) -- 사원이름이 4,5글자
GROUP BY
    deptno -- 부서별 그룹화
HAVING
    COUNT(*) >= 1 -- 사원수가 한사람 이상
;
/*
    8. 81년도 입사한 사람의 전체 급여를 직책별로 조회하세요.
        단, 직급별 평균급여가 1000 미만인 직급은 조회에서 제외하세요.
*/
SELECT
    job 직급명, SUM(sal) 전체급여 -- 전체 급여를
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'YY') = 81 -- 81년도 입사한 사람의
GROUP BY
    job -- 직책별로 조회하세요.
HAVING
    AVG(sal) >= 1000 -- 직급별 평균급여가 1000 미만인 직급은 조회에서 제외하세요.
;
/*
    9. 81년도 입사한 사람의 총 급여를 사원의 이름 문자수별로 그룹화하세요.
        단, 총 급여가 2000 미만인 경우는 제외하고
        총급여가 높은 순서에서 낮은 순서로 내림차순으로 정렬해서
        조회하세요.
*/
SELECT
    LENGTH(ename) 이름길이, SUM(sal) 총급여
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'YY') = '81' -- 81년도 입사한 사람의
GROUP BY
    LENGTH(ename) -- 사원의 이름 문자수별로 그룹화하세요.
HAVING
    SUM(sal) >= 2000 -- 총 급여가 2000 미만인 경우는 제외하고
ORDER BY
    SUM(sal) DESC -- 총 급여가 높은 순서에서 낮은 순서로 내림차순으로 정렬해서 조회하세요.
;

/*
    10. 사원의 이름문자수가 4, 5 인 사원의 부서별 사원수를 조회하세요.
        단, 사원수가 0명인 경우는 제외하고 
        부서번호 오름차순으로 정렬해서 조회하세요.
*/
SELECT
   deptno 부서번호, COUNT(*) || '명'사원수 -- 사원 수를 조회하세요.
FROM
    emp
WHERE
    LENGTH(ename) IN(4,5) -- 사원의 이름문자수가 4, 5인 사원의
GROUP BY
    deptno  -- 부서별
HAVING
    COUNT(*) <> 0 -- 단, 사원수가 0명인 경우는 제외하고
ORDER BY
    deptno ASC -- 부서번호 오름차순으로 정렬해서 조회하세요.
;
/*
    EXTRA ]
        부서별로 급여를 조회하는데
        10번부서는 평균급여를 조회하고
        20번부서는 급여합계를 조회하고
        30번부서는 부서 최고급여를 조회하세요.
*/
SELECT
    deptno 부서번호,
/*
    CASE WHEN deptno = 10 THEN CONCAT(ROUND(AVG(sal), 2), ' (평균급여)') -- 10번부서는 평균급여를 조회하고
         WHEN deptno = 20 THEN CONCAT(SUM(sal), ' (급여합계)') --  20번부서는 급여합계를 조회하고
         WHEN deptno = 30 THEN CONCAT(MAX(sal), ' (부서최고급여)') --  30번부서는 부서 최고급여를 조회하세요.
    END 조회결과
*/

/*
    CASE deptno WHEN 10 THEN CONCAT(ROUND(AVG(sal), 2), ' (평균급여)') -- 10번부서는 평균급여를 조회하고
         WHEN 20 THEN CONCAT(SUM(sal), ' (급여합계)') --  20번부서는 급여합계를 조회하고
         WHEN 30 THEN CONCAT(MAX(sal), ' (부서최고급여)') --  30번부서는 부서 최고급여를 조회하세요.
    END 조회결과
*/

    DECODE(deptno, 10, CONCAT(ROUND(AVG(sal), 2), '(평균급여)'),
                   20, CONCAT(SUM(sal), ' (급여합계)'),
                    CONCAT(MAX(sal), ' (부서최고급여)')) 조회결과
FROM
    emp
GROUP BY
    deptno -- 부서별로 급여를 조회하는데
;

---------------------------------------------------------------------------------------------------------------
/*
    서브질의
    ==> 질의 명령 안에 다시 질의 명령이 포함 된 것을 서브질의(서브쿼리)라 한다.
    
    참고 ]
        서브질의중 from 절에 위치하는 서브질의를
            인라인뷰(Inline View)
        라고 부른다.
        이때 이 서브질의는 질의의 결과를 테이블로 사용을 하게 된다.
*/

-- 'SMITH' 사원의 소속 부서의 사원들의 정보를 조회하세요.
SELECT
    empno, ename, hiredate, deptno
FROM
    emp
WHERE
    deptno = ( SELECT
                    deptno
                FROM
                    emp
                WHERE
                    ename = 'SMITH')
;

SELECT
    dno, max, min, avg, cnt
FROM
    (
        SELECT
            deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
--    dno = 10
--  max = MAX(max) -> 에러    
    max = (
            SELECT
                MAX(sal)
            FROM
                emp
            )
;

/*
    서브질의의 결과에 따른 사용법
        
        ***
        1. 서브질의의 조회결과가 오직 한개의 데이터인 경우
            ==> 하나의 데이터로 보고 데이터를 사용할 수 있는 경우에는 모두 사용한다.
            
            1) SELECT 출력에 사용할 수 있다.
                ***
                이때 서브질의의 조회결과는 반드시 단일행 단일필드로 조회되어야 한다.
                
            2) 조건절에 사용할 수 있다.
                
        2. 
*/

-- SMITH 사원의 정보를 조회하는데
-- 사원번호, 사원이름, 급여, 부서번호, 부서최고급여 를 조회하세요.

SELECT
    empno, ename, sal, deptno,
    (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE -- deptno에 사원이름이 'SMITH'인 사원의 부서번호를 조회함.
           deptno = (
                SELECT
                    deptno
                FROM
                    emp
                WHERE
                    ename = 'SMITH'
           )
    ) 부서최고급여
FROM
    emp
WHERE
    ename = 'SMITH'
;

-- 10번 부서 사원의 정보를 조회하는데
-- 사원번호, 사원이름, 급여, 부서번호, 부서최고급여 를 조회하세요.
SELECT
    empno, ename, sal, deptno,
    (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE 
            deptno = 20
    ) 부서최고급여
FROM
    emp
WHERE
    deptno = 20
;


SELECT
    empno, ename, 100 * 3
FROM
    emp
;

/*
        2. 서브질의의 결과가 두행 이상 나오는 경우
            ==> 이 경우는 조건절에서만 사용가능 하다.
                이때 IN, ANY, ALL, EXIST 연산자를 사용해서 조건절에서 처리한다.
            
            참고 ]
                IN
                    여러개의 데이터중 한개가 일치하면 되는 경우
                
                ANY
                    여러개의 데이터중 한개만 맞으면 되는 경우

                ALL
                    여러개의 데이터중 모두 맞아야 되는 경우
                    
                EXIST
                    여러개의 데이터중 하나만 맞으면 되는 경우
                    비교대상이 없이 사용한다.
                    서브질의의 결과가 있느냐 없느냐로 판단하는 연산자
*/

-- 직급이 'CLEAR'인 사원과 같은 부서에 속한 사원의 정보를 조회하세요.
SELECT
    empno, ename, deptno, job
FROM
    emp
WHERE
    deptno IN (
            SELECT
                DISTINCT deptno
            FROM    
                emp
            WHERE
                job = 'CLERK' -- (10, 20, 30)
                AND ename <> 'JAMES' -- (10, 20)
    )
;

SELECT
    *
FROM
    emp
WHERE
    deptno NOT IN (30, 40, 50)
;


-- 사원의 정보를 조회하는데
-- 모든 부서의 평균급여보다 많이 받는 사원의 정보를 조회하세요.
/*
SELECT
    *
FROM
    emp
WHERE
    sal > ALL (
                SELECT
                    AVG(sal)
                FROM
                    emp
                GROUP BY
                    deptno
          ) -- ==> (???, ???, ???)
;
*/

SELECT
    *
FROM
    emp
WHERE
    sal > (
                SELECT
                    MAX(avg)
                FROM
                    (
                        SELECT
                            AVG(sal) avg
                        FROM
                            emp
                        GROUP BY
                            deptno
                    )
                
          )
;

-- 각 부서의 평균급여를 하나라도 많이 받는 사원의 정보를 조회하세요.
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
                SELECT
                    AVG(sal)
                FROM
                    emp
                GROUP BY
                    deptno
          ) -- ==> (???, ???, ???)
;

-- All ] 사원중 부서번호가 40인 사원이 있으면 모든 사원의 정보를 조회하세요.
SELECT
    *
FROM
    emp
WHERE
    EXISTS (    -- 비교대상 없이 사용한다.
                SELECT
                    *
                FROM
                    emp
                WHERE
                    deptno <> 40
            )
;

--------------------------------------------------------------------------------------
