-- 문제들을 rowtype을 이용해서 처리하세요.
/*
    문제 1 ]
        emp01 테이블에서 이름이 특정 글자수인 사원들의 급여를 20% 인상하는 프로시저를 작성해서
        실행하세요.
        프로시저 이름은 sal_up03
*/
CREATE OR REPLACE PROCEDURE sal_up03(
    len IN NUMBER
)
IS

BEGIN
    UPDATE
        emp01
    SET
        sal = sal * 1.2
    WHERE
        LENGTH(ename) = len
    ;

    
    DBMS_OUTPUT.PUT_LINE('이름이 ' || len || ' 글자인 사원들의 급여를 20% 인상하였습니다!' );
END;
/

/*
    문제 2 ]
        사원번호를 입력하면 사원의 이름, 직급, 부서이름, 부서위치를 출력해주는 프로시저(e_info02)를 작성해주세요.

*/

/*
    문제 3 ] 사원의 이름을 입력하면 사원번호, 사원이름, 직급, 급여, 급여등급을 출력해주는
                   프로시저(e_info031)를 작성하고 실행하세요.
*/
CREATE OR REPLACE PROCEDURE e_info031(
    name IN emp.ename%TYPE
)
IS
    iemp emp%ROWTYPE;
    igrade salgrade%ROWTYPE;
BEGIN
    SELECT
        empno, job, sal, grade
    INTO
        iemp.empno,  iemp.job, iemp.sal, igrade.grade
    FROM
        emp, salgrade
    WHERE
        name = ename
        AND sal BETWEEN losal AND hisal
    ;
    
    DBMS_OUTPUT.PUT_LINE('입력된 사원이름 : ' || name);
    DBMS_OUTPUT.PUT_LINE('입력된 사원번호 : ' || iemp.empno);
    DBMS_OUTPUT.PUT_LINE('입력된 사원직급 : ' || iemp.job);
    DBMS_OUTPUT.PUT_LINE('입력된 사원급여 : ' || iemp.sal);
    DBMS_OUTPUT.PUT_LINE('입력된 급여등급 : ' || igrade.grade);
END;
/

exec e_info031('SMITH');

/*
    문제 4 ]
        사원의 번호를 입력하면
        사원이름, 사원직급, 상사이름
        을 출력해주는 프로시저(e_info04)를 작성하고 실행하세요.
        
        힌트 ]
            OUTER JOIN 사용하세요.
*/
CREATE OR REPLACE PROCEDURE e_info04(
    ino IN emp.empno%TYPE
)
IS
    iemp emp%ROWTYPE;
    semp emp%ROWTYPE;
    
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        e.ename,  e.job, s.ename
    INTO
        iemp.ename, iemp.job, semp.ename
    FROM
        emp e, emp s
    WHERE
        e.mgr = s.empno(+)
        AND ino = e.empno
    ;
    
    DBMS_OUTPUT.PUT_LINE('입력한 사원번호 : ' || ino);
    DBMS_OUTPUT.PUT_LINE('사원이름: ' || iemp.ename);
    DBMS_OUTPUT.PUT_LINE('사원직급: ' || iemp.job);
    DBMS_OUTPUT.PUT_LINE('상사이름: ' || semp.ename);
END;
/
exec e_info04(7839);