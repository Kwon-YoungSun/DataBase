-- day11

/*
    for 명령
        
        형식 1 ]
            
            FOR 변수이름 IN (질의명령) LOOP
                처리내용
                ...
            END LOOP;
            
            의미 ]
                질의 명령의 결과를 변수에 한줄씩 기억한 후
                원하는 내용을 처리하도록 한다.
                
            참고 ]
                FOR 명령에서 사용할 변수는 미리 만들지 않아도 된다.
                이 변수는 자동적으로 %ROWTYPE 변수가 된다.
                %ROWTYPE 변수는 묵시적으로 멤버변수를 가지게 된다.
                
                예 ]
                    
                    FOR e IN(SELECT * FROM emp) LOOP
                        처리내용
                    END LOOP;
                    ==> 이때 변수 e 는 자동적으로 %ROWTYPE 변수가 되고
                            e에는 멤버변수 empno, ename, sal, mgr, .... 을 가지게 된다.
                            따라서 꺼낼 때는
                                e.empno, e.ename, e.sal, ....
                            의 형식으로 꺼내서 사용해야 한다.
                            
                
        형식 2 ]
                
            FOR 변수이름 IN 시작값 .. 종료값 LOOP
                처리내용
                ...
            END LOOP;
            
                의미 ]
                    시작값부터 종료값 까지 1씩 증가시켜서
                    처리내용을 반복한다.
*/

-- 사원들의 이름을 출력하는 무명 프로시저를 작성하세요.
/*
DECLARE
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR name IN (SELECT ename FROM emp) LOOP
        DBMS_OUTPUT.PUT_LINE(name);
    END LOOP;
END;
/
*/

-- 1 부터 10 까지 출력해주는 무명 프로시저를 작성하고 실행하세요.
DECLARE
BEGIN
    DBMS_OUTPUT.ENABLE;
    -- data는 Select 질의 명령의 인라인 뷰에 별칭을 붙인 것과 같은 기능을 한다.
    FOR data IN (SELECT rownum rno, ename FROM emp) LOOP
        DBMS_OUTPUT.PUT_LINE(data.rno || ' 번째 사원 ] ' || data.ename);
    END LOOP;
END;
/

/*
    WHILE 명령
        
        형식 1 ]
            
            WHILE 조건식 LOOP
                처리내용
            END LOOP;
            
            의미 ]
                조건식이 참인경우 처리내용을 반복해서 실행하세요.
                
        형식 2 ]
            
            WHILE 조건식1 LOOP
                처리내용
                
                EXIT WHEN 조건식2;
            END LOOP;
            
            의미 ]
                조건식1이 참이면 반복하지만
                만약 조건식2가 참이면 반복을 종료한다.
                즉, 자바의 break와 같은 기능을 하는 명령이
                        EXIT WHEN
                구문이다.
                
                
        LOOP(DO ~ WHILE) 명령
            형식 ]
            
                LOOP
                    처리내용
                    EXIT WHEN 조건식;
                END LOOP;
                
---------------------------------------------------------------------------------------------                
     
        조건문
        
            IF 명령
            
                형식 1 ]
                    
                    IF 조건식 THEN
                        처리내용
                    END IF;
                    
                형식 2 ]
                
                    IF 조건식 THEN
                        처리내용1
                    ELSE
                        처리내용2
                    END IF;
                    
                형식 3 ]
                    
                    IF 조건식 THEN
                        처리내용1
                    ELSIF 조건식 THEN
                        처리내용2
                    ...
                    ELSE
                        처리내용N
                    END IF;
*/

-- 사원번호를 입력하면 사원이름, 부서번호, 직급을 조회하는 무명프로시저를 작성해서 실행하세요.
-- 단, 없는 번호를 입력하면 '존재하지 않는 사원' 입니다. 라고 출력되게 하세요.
CREATE OR REPLACE PROCEDURE e_info03(
    eno IN emp.empno%TYPE
)
IS
    cnt NUMBER;
    i_emp emp%ROWTYPE;
BEGIN
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM
        emp01
    WHERE
        empno = eno
    ;
    
    IF cnt = 1 THEN
        SELECT
            *
        INTO
            i_emp
        FROM
            emp01
        WHERE
            empno = eno
        ;
        
        DBMS_OUTPUT.PUT_LINE('사원이름 | 부서번호 | 직급 ');
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 40, '-'));
        DBMS_OUTPUT.PUT_LINE(RPAD(i_emp.ename, 9, ' ') || ' | ' || RPAD(i_emp.deptno, 12, ' ') || ' | ' || i_emp.job);
    ELSE
        DBMS_OUTPUT.PUT_LINE(eno || ' 번 사원은 존재하지 않는 사원입니다.' );
    END IF;
END;
/

exec e_info03(8000);

/*
    문제 1 ]
        FOR ~ LOOP 문을 사용해서 구구단 5단을 출력하세요.
        
        심화 ]
            구구단을 출력하세요.
*/
DECLARE
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR no IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(no || ' X ' || 5 || ' = ' || no * 5);
    END LOOP;
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR no IN 2 .. 9 LOOP
        FOR no2 IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(no || ' X ' || no2 || ' = ' || no * no2);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

/*
    문제 2 ]
        IF ~ ELSIF 구문을 사용해서
            emp01 테이블의 사원의 정보를 조회하는데
            사원번호, 사원이름, 부서번호, 부서이름
            의 형식으로 조회하고
            부서번호가 10번 이면 '회계부'
                                20번 - 개발부
                                30번 - 영업부
                                40번 - 운영부
            로 출력하세요.
*/
DECLARE
    part VARCHAR2(20 CHAR);
BEGIN
    FOR e IN (SELECT empno eno, ename name, deptno dno FROM emp01) LOOP
        IF(e.dno = 10) THEN
            part := '회계부';
        ELSIF(e.dno = 20) THEN
            part := '개발부';
        ELSIF(e.dno = 30) THEN
            part := '영업부';
        ELSE
            part := '운영부';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(LPAD('=', 47, '='));
        DBMS_OUTPUT.PUT_LINE(' 사원번호 | 사원이름 | ' || RPAD(LPAD('부서번호', 10, ' '), 12, ' ') || ' | 부서이름 ');
        DBMS_OUTPUT.PUT_LINE(LPAD('-', 50, '-'));
        DBMS_OUTPUT.PUT_LINE(LPAD(RPAD(TO_CHAR(e.eno), 6, ' '), 9, ' ') || ' | '|| RPAD(e.name, 8, ' ') || 
                                    ' | '|| LPAD(RPAD(e.dno, 11, ' '), 17, ' ') || ' | ' || RPAD(part, 8, ' '));

    END LOOP;
END;
/


--  입사 년도를 입력하면 해당 해에 입사한 사원들의 사원번호, 사원이름, 입사일을 출력하는 저장프로시저(proc01)을 만들고
-- 실행하세요.

CREATE OR REPLACE PROCEDURE proc01(
    date IN VARCHAR2
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('입력 년도 : ' || date);
    DBMS_OUTPUT.PUT_LINE(' ');
    FOR e IN(SELECT empno eno, ename name, hiredate FROM emp) LOOP
        IF(date = TO_CHAR(e.hiredate, 'YY')) THEN
            DBMS_OUTPUT.PUT_LINE('사원번호 : ' || e.eno);
            DBMS_OUTPUT.PUT_LINE('사원이름 : ' || e.name);
            DBMS_OUTPUT.PUT_LINE('입사일 : ' || e.hiredate);
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/

exec proc01(82);


/*
        문제 4 ]
            부서번호를 입력하면 해당 부서 사원들의
                사원번호, 사원이름, 직급, 부서번호, 부서이름
            을 출력하는 저장프로시저(proc02)를 제작하고 실행하세요.
*/

CREATE OR REPLACE PROCEDURE proc02(
    no emp.deptno%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('입력한 부서 번호 : ' || no);
    FOR data IN 
        (
            SELECT
                empno eno, ename name, job, e.deptno dno, dname
            FROM
                emp01 e, dept d
            WHERE
                e.deptno = d.deptno
                AND d.deptno = no
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('사원번호 : ' || data.eno);
            DBMS_OUTPUT.PUT_LINE('사원이름 : ' || data.name);
            DBMS_OUTPUT.PUT_LINE('직급 : ' || data.job);
            DBMS_OUTPUT.PUT_LINE('부서번호 : ' || data.dno);
            DBMS_OUTPUT.PUT_LINE('부서이름 : ' || data.dname);
            
            DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

exec proc02(20);

/*
        문제 5 ]
            사원이름을 입력하면 해당 사원의 소속부서의
                    부서최대급여, 부서최소급여, 부서평균급여, 부서급여합계, 부서원수
            를 출력하는 저장프로시저(proc03)를 제작하고 실행하세요.
            
*/

CREATE OR REPLACE PROCEDURE proc03(
    name emp.ename%TYPE
)
IS
    idno emp.deptno%TYPE;
    imax NUMBER(6);
    imin NUMBER(6);
    iavg NUMBER(6);
    isum NUMBER(6);
    icount NUMBER(6);
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('입력한 사원 이름 : ' || name);
    
        SELECT
            dno, max, min, avg, sum, cnt
        INTO
            idno, imax, imin, iavg, isum, icount
        FROM
            (  
            SELECT
               deptno dno, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg, SUM(sal) sum, COUNT(*) cnt
            FROM
                emp01
            GROUP BY
                deptno
            ), emp
        WHERE
            dno = deptno
            AND ename = name
        ;
        DBMS_OUTPUT.PUT_LINE('부서번호 : ' || idno);
        DBMS_OUTPUT.PUT_LINE('부서최대급여 : ' || imax);
        DBMS_OUTPUT.PUT_LINE('부서최소급여 : ' || imin);
        DBMS_OUTPUT.PUT_LINE('부서평균급여 : ' || iavg);
        DBMS_OUTPUT.PUT_LINE('부서급여합계 : ' || isum);
        DBMS_OUTPUT.PUT_LINE('부서원수 : ' || icount);
        
END;
/

exec proc03('MILLER');

/*
        문제 6 ]
            직급을 입력하면 
            해당 직급을 가진 사원들의
                사원이름, 급여, 부서이름
            을 출력하는 프로시저(proc04)를 제작하고 실행하세요.
*/
CREATE OR REPLACE PROCEDURE proc04(
    injob emp.job%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('**** 입력한 직급 : ' || injob || ' ****');
    DBMS_OUTPUT.PUT_LINE(' ');
    FOR data IN(
    SELECT
        ename, sal, dname
    FROM
        emp01 e, dept d
    WHERE
        job = injob
        AND e.deptno = d.deptno
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || data.ename);
        DBMS_OUTPUT.PUT_LINE('급여 : ' || data.sal);
        DBMS_OUTPUT.PUT_LINE('부서이름 : ' || data.dname);
        
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

exec proc04('PRESIDENT');

/*
        문제 7 ]
            이름을 입력하면
            해당 사원의
                사원번호, 사원이름, 직급, 급여, 급여등급
            을 출력하는 프로시저를 제작하고 실행하세요.
*/

CREATE OR REPLACE PROCEDURE proc05(
    name emp.ename%TYPE
)
IS
BEGIN
     DBMS_OUTPUT.ENABLE;
    
    FOR data IN
    (
        SELECT
            empno, ename, job, sal, grade
        FROM
            emp, salgrade
        WHERE
            sal BETWEEN losal AND hisal
            AND ename = name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || data.empno);
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || data.ename);
        DBMS_OUTPUT.PUT_LINE('직급 : ' || data.job);
        DBMS_OUTPUT.PUT_LINE('급여 : ' || data.sal);
        DBMS_OUTPUT.PUT_LINE('급여등급 : ' || data.grade);
    END LOOP;
        
END;
/

exec proc05('SMITH');


----------------------------------------------------------------------------------------------------------------------------------
/*
        테이블 타입 변수
        ==> PL/SQL에서 배열을 표현하는 방법
        
            참고 ]
                자바에서 배열 만드는 방법
                
                    데이터타입[]     변수이름    =   NEW     데이터타입[길이];
                    
            형식 1 ]
                
                TYPE 이름 IS TABLE OF 데이터타입1
                INDEX BY 데이터타입2;
                
                참고 ]    
                    데이터타입1
                    ==> 변수에 기억될 데이터의 멤버
                    
                    데이터타입2
                    ==> 배열의 인덱스로 사용할 데이터의 형태
                            (99.9% BINARY INTEGER   :   0, 1, 2, 3, ....)
                            
            형식 2 ]
            
                변수이름        테이블이름;
                ==> 정의된 테이블이름의 형태로 변수를 만드세요.
                
            참고 ]
                사실 테이블 타입이란 변수는 존재하지 않는다.
                따라서 먼저 테이블 타입을 정의하고
                정의된 테이블타입을 이용해서 변수를 선언해야 한다.

                참고 ]
                    자바의 HashMap 의 경우
                    
                    HashMap map = new HashMap();
                    map.put("ENO", 7369);
                    map.put("JOB", 'CLERK);
                    map.put("SAL", 800);
                    
                    list.add(map);
                    
*/
SELECT
    empno eno, job, sal
FROM   
    emp01
WHERE
    deptno = 10
;

/*
        예제  ]
            부서번호를 입력하면
            그 부서 소속의 사원들의
                이름, 직급, 급여
            를 출력하는 프로시저를 작성하세고 실행하세요.
            단, 테이블타입의 변수를 사용해서 처리하세요.
*/

CREATE OR REPLACE PROCEDURE proc06(
    dno IN emp01.deptno%TYPE
)
IS
    /*
            결과가 여러 행 나올 예정이므로
            이 결과를 한꺼번에 기억하기 위해서는 배열을 선언해야 한다.
            이때 배열에는
            이름, 직급, 급여를 기억할 공간이 있어야 하고
            
            따라서 테이블이 3개가 존재해야 한다.
            
    */
    TYPE name_tab IS TABLE OF emp01.ename%TYPE -- name_tab 타입을 만듦.
    INDEX BY BINARY_INTEGER;
    
    TYPE job_tab IS TABLE OF emp01.job%TYPE -- job_tab 타입을 만듦.
    INDEX BY BINARY_INTEGER;
    
    TYPE sal_tab IS TABLE OF emp01.sal%TYPE    -- sal_tab 타입을 만듦.
    INDEX BY BINARY_INTEGER;
    
    /*
        아직 변수가 만들어진 것은 아니고
        이런 배열을 사용할 예정임을 정의한 것에 불과하다.
        
        이 정의된 테이블을 이용해서 실제 변수를 만들어야 한다.
    */
    
    -- 변수 선언
    -- 변수이름     타입;
    vname name_tab;
    vjob job_tab;
    vsal sal_tab;
    
    -- 배열에 사용할 인덱스 변수를 만든다.
    i BINARY_INTEGER := 0;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    FOR tmp IN (SELECT ename, job, sal FROM emp01 WHERE deptno = dno) LOOP
        -- 오라클은 인덱스가 1부터 시작이기 때문에
        i := i + 1;
        
        -- 결과를 배열에 기억시킨다.
        vname(i) := tmp.ename;
        vjob(i) := tmp.job;
        vsal(i) := tmp.sal;
    END LOOP;
    
    -- 기억된 내용을 하나씩 꺼내서 출력한다.
    FOR cnt IN 1 .. i LOOP
    
/*  
    위의 구문은 자바의 아래 구문과 같은 맥락임.
    int i = 0;
    for(i = 0; i < 10; i++){
        실행문
    }
    System.out.println(i);  ==> 10이 출력됨.
*/
        DBMS_OUTPUT.PUT_LINE(vname(cnt) || ' | ' || vjob(cnt) || ' | ' || vsal(cnt));
    END LOOP;
END;
/

exec proc06(10);

/*
        레코드 타입(row type)
        ==> 강제로 멤버를 가지는 변수를 만드는 방법
        
                %ROWTYPE 은 하나의 테이블을 이용해서
                멤버 변수를 자동으로 만드는 방법이었다.
                레코드타입은 사용자가 지정한 멤버 변수를 만들 수 있다는 차이가 있다.

                만드는 방법 ]
                    
                    1. 레코드 타입을 정의한다.
                        
                        형식 ]
                            
                            TYPE    레코드이름   IS      RECORD(
                                멤버변수이름  데이터타입,
                                멤버변수이름  데이터타입,
                                ....
                            );
                            
                    2. 정의된 레코드타입을 이용해서 변수를 선언한다.
        
                        형식 ]
                            변수이름    레코드타입이름;
                        
                        
*/


/*
        예제  ]
            부서번호를 입력하면
            그 부서 소속의 사원들의
                이름, 직급, 급여
            를 출력하는 프로시저를 작성하세고 실행하세요.
            단, 테이블타입의 변수를 사용해서 처리하세요.
*/

CREATE OR REPLACE PROCEDURE proc07(
    dno emp01.deptno%TYPE
    -- 입력 데이터 파라미터 변수 선언
)
IS
    -- 1. 레코드타입 정의
    TYPE e_record IS RECORD(
        vname   emp01.ename%TYPE,
        vjob        emp01.job%TYPE,
        vsal         emp01.sal%TYPE
    );
    
    -- 2. 레코드타입을 이용해서 변수를 선언한다.(지금 문제에서는 쓰지 않아도 상관없음)
    -- dsal e_record;
    
    -- 3. 테이블타입을 정의 한다.
    TYPE etab IS TABLE OF e_record
    INDEX BY BINARY_INTEGER;
    
    -- 4. 테이블 타입 변수만든다.
    result etab;
    
    cnt BINARY_INTEGER := 0;    -- 카운터변수 선언 및 초기화
BEGIN
    FOR data IN (SELECT ename, job, sal FROM emp01 WHERE deptno = dno) LOOP
        cnt := cnt + 1;
        result(cnt).vname := data.ename;
        result(cnt).vjob := data.job;
        result(cnt).vsal := data.sal;
    END LOOP;
        
        -- 출력
        FOR i IN 1 .. cnt LOOP
             DBMS_OUTPUT.PUT_LINE(result(i).vname || ' | ' || result(i).vjob || ' | ' || result(i).vsal);
        END LOOP;
END;
/

exec proc07(20);

/*
    문제 8 ]
        사원이름을 입력하면
            이름, 직급, 급여, 급여등급
        을 출력해주는 프로시저를 제작하고 실행하세요.
        단, 레코드 타입으로 처리하세요.
*/

CREATE OR REPLACE PROCEDURE proc08(
    name emp01.ename%TYPE
)
IS
    -- 1. 레코드타입을 만든다.
    TYPE e_record IS RECORD(
        vname   emp01.ename%TYPE,
        vjob        emp01.job%TYPE,
        vsal         emp01.sal%TYPE,
        vgr          salgrade.grade%TYPE
    );
    
    -- 2. 레코드타입의 변수를 만든다.
    result e_record;

BEGIN
-- 3. 질의명령을 보내고 결과를 레코드타입 변수에 담는다.
    FOR data IN (SELECT ename, job, sal, grade FROM emp01, salgrade WHERE sal BETWEEN losal AND hisal AND name = ename) LOOP
        result.vname := data.ename;
        result.vjob := data.job;
        result.vsal := data.sal;
        result.vgr := data.grade;
        
    END LOOP;
    
    -- 4. 출력한다.
 
        DBMS_OUTPUT.PUT_LINE(result.vname || ' | ' || result.vjob || ' | ' || result.vsal);
END;
/

exec proc08('SMITH');

/*
        문제 9 ]
            사원번호를 입력하면
                사원이름, 사원직급, 부서번호, 부서위치
            를 출력해주는 프로시저(proc10)을 제작하고 실행하세요.
*/
CREATE OR REPLACE PROCEDURE proc10(
    no emp.empno%TYPE
)
IS
    TYPE e_record IS RECORD(
        vname emp01.ename%TYPE,
        vjob emp01.job%TYPE,
        vdno emp01.deptno%TYPE,
        vloc dept.loc%TYPE
    );
    
    result e_record;
    
BEGIN
    SELECT
        ename, job, e.deptno, loc
    INTO
       result
    FROM
        emp01 e, dept d
    WHERE
        e.deptno = d.deptno
        AND empno = no
    ;
    
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || result.vname);
    DBMS_OUTPUT.PUT_LINE('사원직급 : ' || result.vjob);
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || result.vdno);
    DBMS_OUTPUT.PUT_LINE('부서위치 : ' || result.vloc);
END;
/

exec proc10(7369);

/*
        문제 10 ]
            부서번호를 입력하면
                사원이름, 사원직급, 부서이름, 부서위치
            를 출력해주는 프로시저를 작성하고 실행하세요.
            단, 테이블타입과 레코드타입 변수를 사용해서 처리하세요.
            
            힌트 ]
                변수를 만들려면 먼저 타입이 만들어져야 한다.
                
                ==>
                    1. 레코드타입을 선언한다.
                    
                    2. 레코드타입을 기억할 테이블타입을 선언한다.
                    
                    3. 테이블타입 배열변수를 만든다.
                    
*/

CREATE OR REPLACE PROCEDURE proc11(
    dno emp01.deptno%TYPE
)
IS
-- 1. 레코드타입을 선언한다.
    TYPE e_record IS RECORD(
        vname emp01.ename%TYPE,
        vjob emp01.job%TYPE,
        vdname dept.dname%TYPE,
        vloc dept.loc%TYPE
    );

-- 2. 레코드타입을 기억할 테이블타입을 선언한다.
        TYPE etab IS TABLE OF e_record
        INDEX BY BINARY_INTEGER;
        
--  3. 테이블타입 배열변수를 만든다.        
        result etab;
        
        cnt BINARY_INTEGER := 0;
 
BEGIN
    FOR data IN(
           -- 4.  사원이름, 사원직급, 부서이름, 부서위치
        SELECT
            ename, job, dname, loc
        FROM
            emp01 e, dept d
        WHERE
            e.deptno = d.deptno
            AND dno = e.deptno
    ) LOOP
        cnt := cnt + 1;
        
        result(cnt) := data;
    END LOOP;
    
    FOR i IN 1 .. cnt LOOP
        DBMS_OUTPUT.PUT_LINE(result(i).vname || ' | ' || result(i).vjob || ' | ' || result(i).vdname || ' |  ' || result(i).vloc);
    END LOOP;
END;
/

exec proc11(20);