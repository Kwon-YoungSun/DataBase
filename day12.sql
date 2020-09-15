-- day12

/*
    Ŀ��(Cursor)
    ==> ������ ����Ǵ� ���� ����� ����ϴ� ����
        
        ���� ����ϴ� ���Ǹ���� �ѹ��� ���� ��
        �� ���Ǹ���� ������ ����ؼ�
        ��ġ ������ ����ϵ��� ���Ǹ���� �����ϴ� ��.
        
    ���� ]

        1. ������(�Ͻ���) Ŀ��
            ==> ����Ŭ���� �̸� ����� ���� �������ִ� Ŀ���� ���Ѵ�.        
                �츮�� ���ݱ��� ����ߵ���
                ���� ���� ����� ���� ��� ��ü�� �ǹ�
            
            ���� ]
                Ŀ������ ���� ����(�������)�� �����Ѵ�.
                
                SQL%ROWCOUNT
                ==> ������ ��Ÿ�� ���ڵ�(��, ROW)�� ������ ����ϴ� ����    
                
                SQL%FOUND
                ==> �������� �����ϴ��� ���θ� ����ϴ� ����
                    
                SQL%NOTFOUND
                ==> �������� �������� �ʴ��� ���θ� ����ϴ� ����
                
                SQL%ISOPEN
                ==> Ŀ���� ����������� ���θ� ����ϴ� ����
                
        2. ����� Ŀ��
            
            
*/

/*
    ������ Ŀ�� ���� ]
    
        �����ȣ�� �Է��ϸ�
        �� ����� �̸��� �˷��ִ� ���ν����� �ۼ��ϼ���.
        ��, �����ȣ�� �߸� �ԷµǸ� '�ش� ����� ���� ����Դϴ�.' �� ��µǰ� �ϼ���.
*/

-- ���� ��� ( : COUNT(*) ȣ���ؼ� ó���ϴ� ��� )
CREATE OR REPLACE PROCEDURE proc11(
    eno emp01.empno%TYPE
)
IS
    -- �̸� ����� ����
    name emp01.ename%TYPE;
    
    -- ī��Ʈ ����� ����
    cnt NUMBER;
BEGIN
    -- ����� ī��Ʈ ��ȸ
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM    
        emp01
    WHERE
        empno = eno
    ;
    
    -- ī��Ʈ�� ���� ����ó��
    IF cnt >= 1 THEN
        SELECT
            ename
        INTO
            name
        FROM
            emp01
        WHERE
            empno = eno
        ;
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || eno);
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || name);
    ELSE
        DBMS_OUTPUT.PUT_LINE('[ '|| eno || ' ] �� ����� ���� ����Դϴ�.');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE proc11(
    eno emp01.empno%TYPE
)
IS
    -- �̸� ����� ����
    name emp01.ename%TYPE;
    
    -- ī��Ʈ ����� ����
    cnt NUMBER;
BEGIN
    -- ����� ī��Ʈ ��ȸ
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM    
        emp01
    WHERE
        empno = eno
    ;
    
    -- ī��Ʈ�� ���� ����ó��
    IF cnt >= 1 THEN
        SELECT
            ename
        INTO
            name
        FROM
            emp01
        WHERE
            empno = eno
        ;
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || eno);
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || name);
    ELSE
        DBMS_OUTPUT.PUT_LINE('[ '|| eno || ' ] �� ����� ���� ����Դϴ�.');
    END IF;
END;
/

execute proc11(8000);


-- ������ Ŀ���� ����ϴ� ���
CREATE OR REPLACE PROCEDURE proc11(
    eno emp01.empno%TYPE
)
IS
    name emp01.ename%TYPE;
BEGIN
    SELECT
        ename
    INTO
        name
    FROM
        emp01
    WHERE
        empno = eno
    ;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || eno);
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || name);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('[ '|| eno || ' ] �� ����� ���� ����Դϴ�.');
END;
/

exec proc11(7369);

/*
    ���� ]
        �μ���ȣ�� �Է��ϸ� �ش� �μ��� ������� �޿��� 10% �λ��ϴ� ���ν����� �ۼ��ϼ���.
        �׸��� �λ�� ����� ��� �� ������ ����ϼ���.
*/
CREATE OR REPLACE PROCEDURE proc12(
    dno emp01.deptno%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    UPDATE  
        emp01
    SET
        sal = sal * 1.1
    WHERE
        deptno = dno
    ; -- �� ���Ǹ���� ����Ǵ� ���� ������ Ŀ���� ���ܳ���.
--    commit;
    DBMS_OUTPUT.PUT_LINE(dno || ' �� �μ� ' || SQL%ROWCOUNT || ' �� �޿� 10% �λ� �Ϸ�');
    
END;
/

execute proc12(20);

rollback;

SELECT * FROM EMP;

------------------------------------------------------------------------------------------------------------------------
/*
    ����� Ŀ��
    ==> ���� Ŀ���� �ǹ�ó��
        ���� ����ϴ� ���� ����� �̸� ���� ��
        �ʿ��ϸ� ���� ����� ������ �̿��ؼ� �����ϵ��� �ϴ� ��.
        
        ����� Ŀ���� ó�� ����
        
            1. ����� Ŀ���� �����.
                ( ==> ����� Ŀ���� �����Ѵ�. )
                
                ���� ] -- IS ���� ���
                    
                    CURSOR Ŀ���̸� IS
                        �ʿ��� ���Ǹ��
                        
            2. �ݵ�� Ŀ���� ���ν������� ���డ���ϵ��� ��ġ�Ѵ�.
                (Ŀ���� ���½�Ų��.)
                
                ���� ]
                    
                    OPEN Ŀ���̸�; -- BEGIN ���� ���
                    
            3. ���Ǹ���� �����Ѵ�.( Ŀ���� FETCH ��Ų��. )
            
                ���� ]
                
                    FETCH   Ŀ���̸�;
                    
            4. ����� ���� Ŀ���� ȸ���Ѵ�. (Ŀ���� CLOSE ��Ų��.)
            
                ���� ]
                    
                    CLOSE Ŀ���̸�;
                    
        ���� ]
            ���� Ŀ���� FOR LOOP ��� �ȿ��� ���Ǹ�
            �ڵ� OPEN, FETCH, CLOSE �� �ȴ�.
            
        ���� ]
            ����� Ŀ������ ��������� ����� �� �ִ�.
            ��������� �Ͻ���(������) Ŀ���� �����ϴ�.
                SQL%ROWCOUNT, SQL%FOUND, SQL%NOTFOUND, SQL%ISOPEN, ...
                
        ���� ]
            Ŀ���� �ʿ��ϸ� �Ķ���͸� �޾Ƽ� ����� �� �ִ�.
            (�Ķ���� ������ ������ �� �ִ�.)
            
            ���� ]
                
                CURSOR Ŀ���̸�(�Ķ���ͺ�������Ʈ ...) IS
                    ���Ǹ��
                ;
              
        ���� ]
            WHERE CURRENT OF ��
            ==> Ŀ���� �̿��ؼ� �ٸ� ���Ǹ���� �����ϱ� ���� ���
                �̸��׸� ��������ó��
                �ϳ��� ���Ǹ���� ������ �� �ʿ��� �������Ǹ�
                Ŀ���� �̿��ؼ� ����ϴ� ���
            
*/

/*
    CURSOR ���� ]
        �μ���ȣ�� �Է��ϸ�
            �μ��̸�, ��ձ޿�, �����
        �� ����ϴ� ���ν����� �ۼ��ϼ���.
        ��, ���Ǹ���� Ŀ���� �̿��ؼ� ó���ϼ���.
*/

SELECT
    dname �μ��̸�, avg ��ձ޿�, cnt �����
FROM
    (
        SELECT
            deptno dno, ROUND(AVG(sal), 2) avg, COUNT(*) cnt
        FROM
            emp01
        GROUP BY
            deptno
    ),
    dept d
WHERE
    dno = d.deptno

;

CREATE OR REPLACE PROCEDURE proc13(
    idno emp01.deptno%TYPE 
)
IS
    -- 1. Ŀ������
    CURSOR cur01 IS
    SELECT
        dname, avg, cnt
    FROM
        (
            SELECT
                deptno dno, ROUND(AVG(sal), 2) avg, COUNT(*) cnt
            FROM
                emp01
            GROUP BY
                deptno
        ),
        dept d
    WHERE
        dno = d.deptno
        AND dno = idno
    ;
    
    -- ��¿� ����� ���� ����
    buseo dept.dname%TYPE;
    pavg NUMBER;
    pcnt NUMBER;
BEGIN
    -- 2. Ŀ�� ��밡���ϵ��� �����ϰ�
    OPEN cur01;
    -- 3. ���Ǹ�� ����(Ŀ���� fetch ��Ų��.)
    FETCH 
        cur01
    INTO
        buseo, pavg, pcnt;
    
    -- ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || idno);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || buseo);
    DBMS_OUTPUT.PUT_LINE('��ձ޿� : ' || ROUND(pavg, 2));
    DBMS_OUTPUT.PUT_LINE('����� : ' || pcnt);
    
    -- 4. ����� ���� Ŀ�� ȸ��
    CLOSE cur01;
END;
/

exec proc13(30);

-- FOR LOOP �������� Ŀ��
-- ���� ] �μ����� �μ��̸�, �μ���ձ޿�, ����� �� ����ϴ� ���ν����� �ۼ��ϰ� �����ϼ���.
--        ��, Ŀ���� �̿��ؼ� ó���ϼ���.

CREATE OR REPLACE PROCEDURE proc14
IS
    -- 1. Ŀ�� �����.
    CURSOR d_info01 IS
        SELECT
            dname, ROUND(AVG(sal), 2) avg, COUNT(*) cnt
        FROM
            emp01 e, dept d
        WHERE
            e.deptno = d.deptno
        GROUP BY
            dname
        ;
BEGIN
    -- 2. Ŀ�� ����.
    -- 3. Ŀ�� ��ġ
    -- 4. Ŀ�� �ݴ´�.
    -- FOR LOOP �� ����ϰ� �� ��� �� ���ܰ�� �ڵ����� ó���ȴ�.
    -- ���� OPEN, FETCH, CLOSE �� �ʿ����.
    
    DBMS_OUTPUT.PUT_LINE(' �μ��̸� | ��ձ޿� | �μ����� ');
    FOR data IN d_info01 LOOP
        DBMS_OUTPUT.PUT_LINE(data.dname || ' | ' || data.avg || ' | ' || data.cnt);
    END LOOP;
END;
/

exec proc14;

-----------------------------------------------------------------------------------------------------------------
/*
    ����� Ŀ���� ��������� ����� �� �ִ�.
    
    ���� ]
        ����� �̸�, ����, �޿��� ����ϴ� ���ν����� �ۼ��ϰ� �����ϼ���.
        ��, Ŀ���� �̿��ؼ� ó���ϰ�
        ���������� ��µ� ��� ���� ���� ����ϵ��� �ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc15
IS
    -- Ŀ�� �����.
    CURSOR e_info IS
        SELECT
            ename, job, sal
        FROM
            emp01
        ;
    
    -- ���ڵ� Ÿ�� ����
    TYPE e01 IS RECORD(
        name emp01.ename%TYPE,
        ejob emp01.job%TYPE,
        esal emp01.sal%TYPE
    );
    
    -- ���ڵ� ���� ����
    data e01;
BEGIN
    -- FOR LOOP ������ OPEN, FETCH, CLOSE�� �ʿ䰡 ����. <== �ڵ����� ó�����ش�.
    --  ==> �ݺ����� ����� �� Ŀ���� �ݾƹ����Ƿ� ����� �� �� ����.
    -- ���� �Ϲ� �ݺ������� ó���Ѵ�.
    
    OPEN e_info;
    
    -- Ŀ�� �ݺ��ؼ� �����Ѵ�.
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    LOOP
        -- ī���� ������ �����Ƿ�
        FETCH e_info INTO data;
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || data.name);
        DBMS_OUTPUT.PUT_LINE('������� : ' || data.ejob);
        DBMS_OUTPUT.PUT_LINE('����޿� : ' || data.esal);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
        
        EXIT WHEN e_info%NOTFOUND;
    END LOOP;
    
    -- ��ȸ�� ��� �� ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE('***** �ѻ���� : ' || e_info%ROWCOUNT || ' *****');
    -- Ŀ�� �ݰ�
    CLOSE e_info;
END;
/

execute proc15;

-------------------------------------------------------------------------------------------------------------------
/*
    Ŀ�������� �Ķ���͸� �޾Ƽ� ����� �� �ִ�.
    
    ���� ]
        �μ���ȣ�� �Է��Ͽ� �ش� �μ��� ����̸��� ����ϴ� ���ν����� �ۼ��ϰ� �����ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc16
IS
    CURSOR namelist(
        dno emp01.deptno%TYPE
    )
    IS
        SELECT
            ename
        FROM
            emp01
        WHERE
            deptno = dno
    ;
BEGIN
    -- 10�� �μ� ������
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('### 10 �μ� ����̸� ###');
    FOR data IN namelist(10) LOOP
        DBMS_OUTPUT.PUT_LINE(data.ename);
    END LOOP;
    
    -- 20�� �μ� ������
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('### 20 �μ� ����̸� ###');
    FOR data IN namelist(20) LOOP
        DBMS_OUTPUT.PUT_LINE(data.ename);
    END LOOP;
    
    -- 30�� �μ� ������
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('### 30 �μ� ����̸� ###');
    FOR data IN namelist(30) LOOP
        DBMS_OUTPUT.PUT_LINE(data.ename);
    END LOOP;
END;
/

exec proc16;

------------------------------------------------------------------------------------------------------
/*
    WHERE CURRENT OF ��
        �������Ǵ�ſ� Ŀ���� �̿��ϴ� ���
        
    ���� ]
        �μ���ȣ�� ������ �Է¹޾Ƽ�
        �ش� �μ��� �����޿����� ������ �Է¹��� �������� �����ϴ� ���ν����� ����� �����ϼ���.
*/

UPDATE
    emp01
SET
    job = '����' 
WHERE
    empno = (
                SELECT
                    empno
                FROM
                    emp01
                WHERE
                    deptno = 10
                    AND sal = (
                                SELECT
                                    MIN(sal)
                                FROM
                                    emp01
                                WHERE
                                    deptno = 10
                              )
            )
;

-- cursor
CREATE OR REPLACE PROCEDURE proc17(
    dno emp01.deptno%TYPE,
    ijob emp01.job%TYPE
)
IS
    -- ��ȸ ���Ǹ���� Ŀ�� �����Ѵ�.
    CURSOR no_cur IS
        SELECT
            empno
        FROM
            emp01
        WHERE
            deptno = dno
            AND sal = (
                        SELECT
                            MIN(sal)
                        FROM
                            emp01
                        WHERE
                            deptno = dno
                      )
        FOR UPDATE
        -- �� Ŀ���� UPDATE ���Ǹ�ɿ� �ΰ������� ���Ǵ� Ŀ������ ������ �����̴�.
        ;
BEGIN
    FOR data IN no_cur LOOP
        UPDATE
            emp01
        SET
            job = ijob
        WHERE CURRENT OF no_cur
        ;
        /*
            �� UPDATE ���Ǹ���� ������ IS ���� ������ Ŀ���� �̿��ؼ�
            Ŀ���� ����� �̿��ؼ� ������ �����.
        */
    END LOOP;
END;
/


select * from emp01 where deptno = 10;

exec proc17(10, '������');

rollback;


/*
    ����̸��� �޿��� �Է¹޾Ƽ�
    �Է¹��� ����� �Ҽ� �μ��� �ּұ޿����� �޿��� �Է±޿��� �����ϴ�
    ���ν����� ����� �����ϼ���.
    ��, Ŀ���� �̿��� ����ó�� ����(WHERE CURRENT OF)�� ����ؼ� ó���ϼ���.
*/
-- �Է¹��� ����� �Ҽ� �μ��� ���Ѵ�.
SELECT
    deptno
FROM
    emp01
WHERE
    ename = 'SMITH'
;

-- �Է¹��� ����� �Ҽ� �μ��� �ּұ޿��ڸ� ���Ѵ�.
SELECT
    empno
FROM
    emp01
WHERE
    sal = (
            SELECT
                MIN(sal)
            FROM
                emp01
            WHERE
                deptno = 10
            )
;


CREATE OR REPLACE PROCEDURE proc18(
    name IN emp01.ename%TYPE,
    isal IN emp01.sal%TYPE
)
IS
    -- �Է� ���� ����� �Ҽ� �μ��� �����ϴ� ����
    dno emp01.deptno%TYPE;
    
    -- �Է¹��� ����� �Ҽ� �μ��� �ּұ޿��ڸ� ���ϴ� Ŀ��
    CURSOR min_cur IS
        SELECT
            empno
        FROM
            emp01
        WHERE
            deptno = dno
            AND
            sal = (
                    SELECT
                        MIN(sal)
                    FROM
                        emp01
                    WHERE
                        deptno = dno
                  )
            FOR UPDATE
        ;
BEGIN
    SELECT
        deptno
    INTO
        dno
    FROM
        emp01
    WHERE
        ename = name
    ;

    FOR data IN min_cur LOOP
        UPDATE
            emp01
        SET
            sal = isal
        WHERE CURRENT OF min_cur
        ;
    END LOOP;
END;
/

SELECT * FROM emp01 WHERE deptno = 10;
exec proc18('KING', 8000);
rollback;

-- �Խ��� 10��, ȸ�� 5�� �̻�
