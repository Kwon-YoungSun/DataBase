/*
    1. 1년은 365일 이라고 가정하고
        사원의 근무일 수 를 년 단위로 표시하고
        대신 소수이하는 버리세요.
        
        표시형식 ]
        
            사원이름    입사일     근무년수
            SMITH       80/00/00    40 년
*/
SELECT
    ename 사원이름,
    hiredate 입사일,
--    FLOOR((SYSDATE - hiredate) / 365.0 + 1) || ' 년' 근무년수
    FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate) / 12.0 + 1) || ' 년' 근무년수
FROM
    emp
;

/*
    2. 사원의 이름, 입사일, 근무일을 조회하세요.
        단 근무일은 년, 월 단위로 표현하세요. --> 체킹
*/
SELECT
    ename 사원이름,
    hiredate 입사일,
    CONCAT(
        FLOOR((SYSDATE - hiredate) / 365.0 + 1) || '년 ', -- 년
        FLOOR(MOD(SYSDATE-hiredate, 365.0) / 12) || '개월' -- 개월
    ) 근무일
FROM
    emp
;

/*
    3. 사원이 첫급여를 받을 때 까지 근무일 수를 조회하세요.
*/
SELECT
    ename 사원이름, sal 사원급여, hiredate 입사일, LAST_DAY(hiredate) 첫월급날,
    LAST_DAY(hiredate) - hiredate + 1 || ' 일' "첫급여 D-DAY"
FROM
    emp
; --> 체킹

/*
    4. 사원이 입사후 맞이하는 첫 토요일을 조회하세요.
*/
SELECT
    ename 사원이름, hiredate 입사일, NEXT_DAY(hiredate, '토') 첫토요일
FROM
    emp
; --> 체킹

/*
    5. 근무년수는 입사한 달의 1일을 기준으로 산출해야 한다.
        사원의 근무년수 기준일을 조회하세요.
        단, 15일 이전 입사자는 해당 월을 기준일로 하고
        16일 이후 입사자는 해당 월의 다음달을 기준으로 한다.
*/
SELECT
    ename 사원이름, hiredate 입사일,
    ROUND(hiredate, 'MONTH') 근무년수기준일
FROM
    emp
;
/*
    6. 사원중 월요일에 입사한 사원의 사원이름, 입사요일을 조회하세요.
*/
SELECT
    ename 사원이름, hiredate 입사일,
    TO_CHAR(hiredate, 'DAY') 입사요일
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'DAY') = '월요일'
;

/*
    7. 사원 급여 중에서 백단위가 0인 사원의 사원이름, 급여 를 조회하세요.
    
    힌트 ]
        문자열로 변환후 처리한다.
        
*/
SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
    SUBSTR(TO_CHAR(sal), -3, 1) = '0'
;
    
/*
    8. 사원의 사원이름, 급여, 커미션을 조회하세요.
        단, 커미션이 없는 사원은 NONE으로 표시되게 조회하세요.
*/
SELECT
    ename 사원이름, sal 급여,
--    NVL(TO_CHAR(comm), 'NONE') 커미션
--    NVL2(TO_CHAR(comm), TO_CHAR(comm), 'NONE') 커미션
--    COALESCE(TO_CHAR(comm), 'NONE') 커미션
      DECODE(comm, NULL, 'NONE',
            TO_CHAR(comm)
      ) 커미션
FROM
    emp
;

/*

*/
