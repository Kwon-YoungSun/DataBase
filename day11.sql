-- day11

/*
    for ���
        
        ���� 1 ]
            
            FOR �����̸� IN (���Ǹ��) LOOP
                ó������
                ...
            END LOOP;
            
            �ǹ� ]
                ���� ����� ����� ������ ���پ� ����� ��
                ���ϴ� ������ ó���ϵ��� �Ѵ�.
                
            ���� ]
                FOR ��ɿ��� ����� ������ �̸� ������ �ʾƵ� �ȴ�.
                �� ������ �ڵ������� %ROWTYPE ������ �ȴ�.
                %ROWTYPE ������ ���������� ��������� ������ �ȴ�.
                
                �� ]
                    
                    FOR e IN(SELECT * FROM emp) LOOP
                        ó������
                    END LOOP;
                    ==> �̶� ���� e �� �ڵ������� %ROWTYPE ������ �ǰ�
                            e���� ������� empno, ename, sal, mgr, .... �� ������ �ȴ�.
                            ���� ���� ����
                                e.empno, e.ename, e.sal, ....
                            �� �������� ������ ����ؾ� �Ѵ�.
                            
                
        ���� 2 ]
                
            FOR �����̸� IN ���۰� .. ���ᰪ LOOP
                ó������
                ...
            END LOOP;
            
                �ǹ� ]
                    ���۰����� ���ᰪ ���� 1�� �������Ѽ�
                    ó�������� �ݺ��Ѵ�.
*/

-- ������� �̸��� ����ϴ� ���� ���ν����� �ۼ��ϼ���.
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

-- 1 ���� 10 ���� ������ִ� ���� ���ν����� �ۼ��ϰ� �����ϼ���.
DECLARE
BEGIN
    DBMS_OUTPUT.ENABLE;
    -- data�� Select ���� ����� �ζ��� �信 ��Ī�� ���� �Ͱ� ���� ����� �Ѵ�.
    FOR data IN (SELECT rownum rno, ename FROM emp) LOOP
        DBMS_OUTPUT.PUT_LINE(data.rno || ' ��° ��� ] ' || data.ename);
    END LOOP;
END;
/

/*
    WHILE ���
        
        ���� 1 ]
            
            WHILE ���ǽ� LOOP
                ó������
            END LOOP;
            
            �ǹ� ]
                ���ǽ��� ���ΰ�� ó�������� �ݺ��ؼ� �����ϼ���.
                
        ���� 2 ]
            
            WHILE ���ǽ�1 LOOP
                ó������
                
                EXIT WHEN ���ǽ�2;
            END LOOP;
            
            �ǹ� ]
                ���ǽ�1�� ���̸� �ݺ�������
                ���� ���ǽ�2�� ���̸� �ݺ��� �����Ѵ�.
                ��, �ڹ��� break�� ���� ����� �ϴ� �����
                        EXIT WHEN
                �����̴�.
                
                
        LOOP(DO ~ WHILE) ���
            ���� ]
            
                LOOP
                    ó������
                    EXIT WHEN ���ǽ�;
                END LOOP;
                
---------------------------------------------------------------------------------------------                
     
        ���ǹ�
        
            IF ���
            
                ���� 1 ]
                    
                    IF ���ǽ� THEN
                        ó������
                    END IF;
                    
                ���� 2 ]
                
                    IF ���ǽ� THEN
                        ó������1
                    ELSE
                        ó������2
                    END IF;
                    
                ���� 3 ]
                    
                    IF ���ǽ� THEN
                        ó������1
                    ELSIF ���ǽ� THEN
                        ó������2
                    ...
                    ELSE
                        ó������N
                    END IF;
*/

-- �����ȣ�� �Է��ϸ� ����̸�, �μ���ȣ, ������ ��ȸ�ϴ� �������ν����� �ۼ��ؼ� �����ϼ���.
-- ��, ���� ��ȣ�� �Է��ϸ� '�������� �ʴ� ���' �Դϴ�. ��� ��µǰ� �ϼ���.
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
        
        DBMS_OUTPUT.PUT_LINE('����̸� | �μ���ȣ | ���� ');
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 40, '-'));
        DBMS_OUTPUT.PUT_LINE(RPAD(i_emp.ename, 9, ' ') || ' | ' || RPAD(i_emp.deptno, 12, ' ') || ' | ' || i_emp.job);
    ELSE
        DBMS_OUTPUT.PUT_LINE(eno || ' �� ����� �������� �ʴ� ����Դϴ�.' );
    END IF;
END;
/

exec e_info03(8000);

/*
    ���� 1 ]
        FOR ~ LOOP ���� ����ؼ� ������ 5���� ����ϼ���.
        
        ��ȭ ]
            �������� ����ϼ���.
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
    ���� 2 ]
        IF ~ ELSIF ������ ����ؼ�
            emp01 ���̺��� ����� ������ ��ȸ�ϴµ�
            �����ȣ, ����̸�, �μ���ȣ, �μ��̸�
            �� �������� ��ȸ�ϰ�
            �μ���ȣ�� 10�� �̸� 'ȸ���'
                                20�� - ���ߺ�
                                30�� - ������
                                40�� - ���
            �� ����ϼ���.
*/
DECLARE
    part VARCHAR2(20 CHAR);
BEGIN
    FOR e IN (SELECT empno eno, ename name, deptno dno FROM emp01) LOOP
        IF(e.dno = 10) THEN
            part := 'ȸ���';
        ELSIF(e.dno = 20) THEN
            part := '���ߺ�';
        ELSIF(e.dno = 30) THEN
            part := '������';
        ELSE
            part := '���';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(LPAD('=', 47, '='));
        DBMS_OUTPUT.PUT_LINE(' �����ȣ | ����̸� | ' || RPAD(LPAD('�μ���ȣ', 10, ' '), 12, ' ') || ' | �μ��̸� ');
        DBMS_OUTPUT.PUT_LINE(LPAD('-', 50, '-'));
        DBMS_OUTPUT.PUT_LINE(LPAD(RPAD(TO_CHAR(e.eno), 6, ' '), 9, ' ') || ' | '|| RPAD(e.name, 8, ' ') || 
                                    ' | '|| LPAD(RPAD(e.dno, 11, ' '), 17, ' ') || ' | ' || RPAD(part, 8, ' '));

    END LOOP;
END;
/


--  �Ի� �⵵�� �Է��ϸ� �ش� �ؿ� �Ի��� ������� �����ȣ, ����̸�, �Ի����� ����ϴ� �������ν���(proc01)�� �����
-- �����ϼ���.

CREATE OR REPLACE PROCEDURE proc01(
    date IN VARCHAR2
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('�Է� �⵵ : ' || date);
    DBMS_OUTPUT.PUT_LINE(' ');
    FOR e IN(SELECT empno eno, ename name, hiredate FROM emp) LOOP
        IF(date = TO_CHAR(e.hiredate, 'YY')) THEN
            DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || e.eno);
            DBMS_OUTPUT.PUT_LINE('����̸� : ' || e.name);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || e.hiredate);
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/

exec proc01(82);


/*
        ���� 4 ]
            �μ���ȣ�� �Է��ϸ� �ش� �μ� �������
                �����ȣ, ����̸�, ����, �μ���ȣ, �μ��̸�
            �� ����ϴ� �������ν���(proc02)�� �����ϰ� �����ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc02(
    no emp.deptno%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('�Է��� �μ� ��ȣ : ' || no);
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
            DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || data.eno);
            DBMS_OUTPUT.PUT_LINE('����̸� : ' || data.name);
            DBMS_OUTPUT.PUT_LINE('���� : ' || data.job);
            DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || data.dno);
            DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || data.dname);
            
            DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

exec proc02(20);

/*
        ���� 5 ]
            ����̸��� �Է��ϸ� �ش� ����� �ҼӺμ���
                    �μ��ִ�޿�, �μ��ּұ޿�, �μ���ձ޿�, �μ��޿��հ�, �μ�����
            �� ����ϴ� �������ν���(proc03)�� �����ϰ� �����ϼ���.
            
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
    DBMS_OUTPUT.PUT_LINE('�Է��� ��� �̸� : ' || name);
    
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
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || idno);
        DBMS_OUTPUT.PUT_LINE('�μ��ִ�޿� : ' || imax);
        DBMS_OUTPUT.PUT_LINE('�μ��ּұ޿� : ' || imin);
        DBMS_OUTPUT.PUT_LINE('�μ���ձ޿� : ' || iavg);
        DBMS_OUTPUT.PUT_LINE('�μ��޿��հ� : ' || isum);
        DBMS_OUTPUT.PUT_LINE('�μ����� : ' || icount);
        
END;
/

exec proc03('MILLER');

/*
        ���� 6 ]
            ������ �Է��ϸ� 
            �ش� ������ ���� �������
                ����̸�, �޿�, �μ��̸�
            �� ����ϴ� ���ν���(proc04)�� �����ϰ� �����ϼ���.
*/
CREATE OR REPLACE PROCEDURE proc04(
    injob emp.job%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('**** �Է��� ���� : ' || injob || ' ****');
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
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || data.ename);
        DBMS_OUTPUT.PUT_LINE('�޿� : ' || data.sal);
        DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || data.dname);
        
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

exec proc04('PRESIDENT');

/*
        ���� 7 ]
            �̸��� �Է��ϸ�
            �ش� �����
                �����ȣ, ����̸�, ����, �޿�, �޿����
            �� ����ϴ� ���ν����� �����ϰ� �����ϼ���.
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
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || data.empno);
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || data.ename);
        DBMS_OUTPUT.PUT_LINE('���� : ' || data.job);
        DBMS_OUTPUT.PUT_LINE('�޿� : ' || data.sal);
        DBMS_OUTPUT.PUT_LINE('�޿���� : ' || data.grade);
    END LOOP;
        
END;
/

exec proc05('SMITH');


----------------------------------------------------------------------------------------------------------------------------------
/*
        ���̺� Ÿ�� ����
        ==> PL/SQL���� �迭�� ǥ���ϴ� ���
        
            ���� ]
                �ڹٿ��� �迭 ����� ���
                
                    ������Ÿ��[]     �����̸�    =   NEW     ������Ÿ��[����];
                    
            ���� 1 ]
                
                TYPE �̸� IS TABLE OF ������Ÿ��1
                INDEX BY ������Ÿ��2;
                
                ���� ]    
                    ������Ÿ��1
                    ==> ������ ���� �������� ���
                    
                    ������Ÿ��2
                    ==> �迭�� �ε����� ����� �������� ����
                            (99.9% BINARY INTEGER   :   0, 1, 2, 3, ....)
                            
            ���� 2 ]
            
                �����̸�        ���̺��̸�;
                ==> ���ǵ� ���̺��̸��� ���·� ������ ���弼��.
                
            ���� ]
                ��� ���̺� Ÿ���̶� ������ �������� �ʴ´�.
                ���� ���� ���̺� Ÿ���� �����ϰ�
                ���ǵ� ���̺�Ÿ���� �̿��ؼ� ������ �����ؾ� �Ѵ�.

                ���� ]
                    �ڹ��� HashMap �� ���
                    
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
        ����  ]
            �μ���ȣ�� �Է��ϸ�
            �� �μ� �Ҽ��� �������
                �̸�, ����, �޿�
            �� ����ϴ� ���ν����� �ۼ��ϼ��� �����ϼ���.
            ��, ���̺�Ÿ���� ������ ����ؼ� ó���ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc06(
    dno IN emp01.deptno%TYPE
)
IS
    /*
            ����� ���� �� ���� �����̹Ƿ�
            �� ����� �Ѳ����� ����ϱ� ���ؼ��� �迭�� �����ؾ� �Ѵ�.
            �̶� �迭����
            �̸�, ����, �޿��� ����� ������ �־�� �ϰ�
            
            ���� ���̺��� 3���� �����ؾ� �Ѵ�.
            
    */
    TYPE name_tab IS TABLE OF emp01.ename%TYPE -- name_tab Ÿ���� ����.
    INDEX BY BINARY_INTEGER;
    
    TYPE job_tab IS TABLE OF emp01.job%TYPE -- job_tab Ÿ���� ����.
    INDEX BY BINARY_INTEGER;
    
    TYPE sal_tab IS TABLE OF emp01.sal%TYPE    -- sal_tab Ÿ���� ����.
    INDEX BY BINARY_INTEGER;
    
    /*
        ���� ������ ������� ���� �ƴϰ�
        �̷� �迭�� ����� �������� ������ �Ϳ� �Ұ��ϴ�.
        
        �� ���ǵ� ���̺��� �̿��ؼ� ���� ������ ������ �Ѵ�.
    */
    
    -- ���� ����
    -- �����̸�     Ÿ��;
    vname name_tab;
    vjob job_tab;
    vsal sal_tab;
    
    -- �迭�� ����� �ε��� ������ �����.
    i BINARY_INTEGER := 0;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    FOR tmp IN (SELECT ename, job, sal FROM emp01 WHERE deptno = dno) LOOP
        -- ����Ŭ�� �ε����� 1���� �����̱� ������
        i := i + 1;
        
        -- ����� �迭�� ����Ų��.
        vname(i) := tmp.ename;
        vjob(i) := tmp.job;
        vsal(i) := tmp.sal;
    END LOOP;
    
    -- ���� ������ �ϳ��� ������ ����Ѵ�.
    FOR cnt IN 1 .. i LOOP
    
/*  
    ���� ������ �ڹ��� �Ʒ� ������ ���� �ƶ���.
    int i = 0;
    for(i = 0; i < 10; i++){
        ���๮
    }
    System.out.println(i);  ==> 10�� ��µ�.
*/
        DBMS_OUTPUT.PUT_LINE(vname(cnt) || ' | ' || vjob(cnt) || ' | ' || vsal(cnt));
    END LOOP;
END;
/

exec proc06(10);

/*
        ���ڵ� Ÿ��(row type)
        ==> ������ ����� ������ ������ ����� ���
        
                %ROWTYPE �� �ϳ��� ���̺��� �̿��ؼ�
                ��� ������ �ڵ����� ����� ����̾���.
                ���ڵ�Ÿ���� ����ڰ� ������ ��� ������ ���� �� �ִٴ� ���̰� �ִ�.

                ����� ��� ]
                    
                    1. ���ڵ� Ÿ���� �����Ѵ�.
                        
                        ���� ]
                            
                            TYPE    ���ڵ��̸�   IS      RECORD(
                                ��������̸�  ������Ÿ��,
                                ��������̸�  ������Ÿ��,
                                ....
                            );
                            
                    2. ���ǵ� ���ڵ�Ÿ���� �̿��ؼ� ������ �����Ѵ�.
        
                        ���� ]
                            �����̸�    ���ڵ�Ÿ���̸�;
                        
                        
*/


/*
        ����  ]
            �μ���ȣ�� �Է��ϸ�
            �� �μ� �Ҽ��� �������
                �̸�, ����, �޿�
            �� ����ϴ� ���ν����� �ۼ��ϼ��� �����ϼ���.
            ��, ���̺�Ÿ���� ������ ����ؼ� ó���ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc07(
    dno emp01.deptno%TYPE
    -- �Է� ������ �Ķ���� ���� ����
)
IS
    -- 1. ���ڵ�Ÿ�� ����
    TYPE e_record IS RECORD(
        vname   emp01.ename%TYPE,
        vjob        emp01.job%TYPE,
        vsal         emp01.sal%TYPE
    );
    
    -- 2. ���ڵ�Ÿ���� �̿��ؼ� ������ �����Ѵ�.(���� ���������� ���� �ʾƵ� �������)
    -- dsal e_record;
    
    -- 3. ���̺�Ÿ���� ���� �Ѵ�.
    TYPE etab IS TABLE OF e_record
    INDEX BY BINARY_INTEGER;
    
    -- 4. ���̺� Ÿ�� ���������.
    result etab;
    
    cnt BINARY_INTEGER := 0;    -- ī���ͺ��� ���� �� �ʱ�ȭ
BEGIN
    FOR data IN (SELECT ename, job, sal FROM emp01 WHERE deptno = dno) LOOP
        cnt := cnt + 1;
        result(cnt).vname := data.ename;
        result(cnt).vjob := data.job;
        result(cnt).vsal := data.sal;
    END LOOP;
        
        -- ���
        FOR i IN 1 .. cnt LOOP
             DBMS_OUTPUT.PUT_LINE(result(i).vname || ' | ' || result(i).vjob || ' | ' || result(i).vsal);
        END LOOP;
END;
/

exec proc07(20);

/*
    ���� 8 ]
        ����̸��� �Է��ϸ�
            �̸�, ����, �޿�, �޿����
        �� ������ִ� ���ν����� �����ϰ� �����ϼ���.
        ��, ���ڵ� Ÿ������ ó���ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc08(
    name emp01.ename%TYPE
)
IS
    -- 1. ���ڵ�Ÿ���� �����.
    TYPE e_record IS RECORD(
        vname   emp01.ename%TYPE,
        vjob        emp01.job%TYPE,
        vsal         emp01.sal%TYPE,
        vgr          salgrade.grade%TYPE
    );
    
    -- 2. ���ڵ�Ÿ���� ������ �����.
    result e_record;

BEGIN
-- 3. ���Ǹ���� ������ ����� ���ڵ�Ÿ�� ������ ��´�.
    FOR data IN (SELECT ename, job, sal, grade FROM emp01, salgrade WHERE sal BETWEEN losal AND hisal AND name = ename) LOOP
        result.vname := data.ename;
        result.vjob := data.job;
        result.vsal := data.sal;
        result.vgr := data.grade;
        
    END LOOP;
    
    -- 4. ����Ѵ�.
 
        DBMS_OUTPUT.PUT_LINE(result.vname || ' | ' || result.vjob || ' | ' || result.vsal);
END;
/

exec proc08('SMITH');

/*
        ���� 9 ]
            �����ȣ�� �Է��ϸ�
                ����̸�, �������, �μ���ȣ, �μ���ġ
            �� ������ִ� ���ν���(proc10)�� �����ϰ� �����ϼ���.
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
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || result.vname);
    DBMS_OUTPUT.PUT_LINE('������� : ' || result.vjob);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || result.vdno);
    DBMS_OUTPUT.PUT_LINE('�μ���ġ : ' || result.vloc);
END;
/

exec proc10(7369);

/*
        ���� 10 ]
            �μ���ȣ�� �Է��ϸ�
                ����̸�, �������, �μ��̸�, �μ���ġ
            �� ������ִ� ���ν����� �ۼ��ϰ� �����ϼ���.
            ��, ���̺�Ÿ�԰� ���ڵ�Ÿ�� ������ ����ؼ� ó���ϼ���.
            
            ��Ʈ ]
                ������ ������� ���� Ÿ���� ��������� �Ѵ�.
                
                ==>
                    1. ���ڵ�Ÿ���� �����Ѵ�.
                    
                    2. ���ڵ�Ÿ���� ����� ���̺�Ÿ���� �����Ѵ�.
                    
                    3. ���̺�Ÿ�� �迭������ �����.
                    
*/

CREATE OR REPLACE PROCEDURE proc11(
    dno emp01.deptno%TYPE
)
IS
-- 1. ���ڵ�Ÿ���� �����Ѵ�.
    TYPE e_record IS RECORD(
        vname emp01.ename%TYPE,
        vjob emp01.job%TYPE,
        vdname dept.dname%TYPE,
        vloc dept.loc%TYPE
    );

-- 2. ���ڵ�Ÿ���� ����� ���̺�Ÿ���� �����Ѵ�.
        TYPE etab IS TABLE OF e_record
        INDEX BY BINARY_INTEGER;
        
--  3. ���̺�Ÿ�� �迭������ �����.        
        result etab;
        
        cnt BINARY_INTEGER := 0;
 
BEGIN
    FOR data IN(
           -- 4.  ����̸�, �������, �μ��̸�, �μ���ġ
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