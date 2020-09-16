-- day13
/*
    ���Ϲ�ȣ
    ���Ͽ��������̸� 2.jpg
    �����̸� 1.jpg
    �۹�ȣ
    �������� /upload/boardimg/
    ����ũ��
    ��뿩�� check IN(Y, N)
*/
/*
    ����ó��
    ==> PL/SQL�� �����ϴ� ���� �߻��ϴ� ��Ÿ�� ������ ���ܶ�� ���Ѵ�.
        �̰��� �ʿ��ϸ� �ڹٿ� �����ϰ� ������ ������ �˾ƺ� �� �ִ�.
        
        �ڹٿ��� �������� 
        ���ܰ� �߻��ϸ� �� ���� ��� PL/SQL ����� ������� �ʴ´�.
        ���� ������ ������ �ľ��Ͽ� ������ �����ʴ� ������ �ľ��� �� ���� ���̴�.
        
    PL/SQL������ ������ ����
    
        1. �̸� ���ǵ� ����
            ==> PL/SQL���� ���� �߻��ϴ� 20���� ������ ���ܿ� ���ؼ�
                ���� �ڵ尪�� ������ �̸��� ������� ���� ���ܸ� ���Ѵ�.
                
                �ڵ������� �߻��ϱ� ������ ���� Ư���� ��ġ�� ���� �ʾƵ� ����ó���� �� �� �ִ�.
                
        2. �̸� ���ǵ��� ���� ����
            ==> ���� �߻����� �ʱ� ������ �̸��� ������� ������ �ʾ�����
                PL/SQL �����Ϸ��� �˰� �ִ� ���ܸ� ���Ѵ�.
                
                �̸� �̸��� �ڵ尪�� �����ڰ� ������ ��( ==> ���ܸ� ������ �� )
                ����ؾ� �ϴ� �����̴�.
                
        3. ����� ����
            ==> PL/SQL �����Ϸ��� ���� ���ϴ� ���ܸ� ���Ѵ�.
                �ڹٿ����� ����ڰ� ������ �߻��ϴ� ���ܿ� ������ ��
                
                �̸� �̸��� ������ �ο��Ͽ� �ϳ��� ���ܸ� ����� ���� ��
                                        +
                �ʿ��� ������ ������ ���ܶ�� ��������� �Ѵ�.( ������ ���ܸ� �߻���Ų��. )
                
    ���� ó�� ���� ]
        
        EXCEPTION
            WHEN    �����̸�    THEN
                ó������;
            WHEN    �����̸�    THEN
                ó������;
            ....
            WHEN    OTHERS      THEN
                ó������;
                
    ���� ]
        EXCEPTION ���� ���ν����� ���� �������� �;� �Ѵ�.
        �ٽø���
        ����ó�� �� �ٸ������� ���� �ȵȴ�.
-------------------------------------------------------------------------------------------------------
EXCEPTION��	            ������ȣ 	                        ��    ��        
-------------------------------------------------------------------------------------------------------
NO_DATA_FOUND	        ORA-01403	        �����͸� ��ȯ���� ���� SELECT��
TOO_MANY_ROWS	        ORA-01422	        �� �� �̻��� ��ȯ�� SELECT��
INVALID_CURSOR	        ORA-01001	        �߸��� CURSOR ���� �߻�
ZERO_DIVIDE	            ORA-01476	        0���� ������
DUP_VAL_ON_INDEX	    ORA-00001	        UNIQUE COLUMN�� �ߺ��� ���� �Է��� ��
CURSOR_ALREADY_OPEN	    ORA-06511	        �̹� ���� �ִ� Ŀ���� ���� ���
INVALID_NUMBER	        ORA-01722	        ���ڿ��� ���ڷ� ��ȯ���� ���� ���
LOGIN_DENIED	        ORA-01017	        ��ȿ���� ���� ����ڷ� LOGON �õ�
NOT_LOGGED_ON	        ORA-01012	        PL/SQL ���α׷��� ����Ŭ�� ������� ���� ���¿��� ȣ��
PROGRAM_ERROR	        ORA-06501	        PL/SQL ���ο� ����
STORAGE_ERROR	        ORA-06500	        PL/SQL�� �޸� ����
TIMEOUT_ON_RESOURCE	    ORA-00051	        ����Ŭ�� �ڿ��� ��ٸ��� ���� �ð� �ʰ� �߻�
VALUE_ERROR	            ORA-06502	        ���, ���� ��� ũ�Ⱑ �ٸ� ���� �߻�
-------------------------------------------------------------------------------------------------------
*/

SELECT name FROM emp01;
-- �̸� ���ǵ� ����
/*
    ���� 1 ]
        �μ� ��ȣ�� �Է¹޾Ƽ� �ش� �μ��� �����ȣ�� ����ϴ� ���ν����� �ۼ��ϼ���.
        ��, ���� �߻��ϸ� ����ó���� �̿��ؼ� ������ ������ ����ϵ��� �ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc21(
    dno IN emp01.deptno%TYPE
)
IS
    eno emp01.empno%TYPE;
BEGIN
    /*
        ������ �μ���ȣ�� ������ �˻��ϸ�
        ���� �̻��� ����� ���� �� �ִ�.
        FOR LOOP ������� ó���ؼ� ����ؾ� �Ѵ�.
        ������ �Ϻη� ������ �߻���Ű�� ���ؼ� ���ٸ� ������ ������� ó���� �����̴�.
    */
    SELECT
        empno
    INTO
        eno
    FROM
        emp01
    WHERE
        deptno = dno
    ;
    
    -- ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE(eno);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('### ���� : ���� ���� ��ȸ�Ǿ����ϴ�.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('### ���� : ��ȸ�� �����Ͱ� �����ϴ�.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�� �� ���� �����Դϴ�.');
END;
/
exec proc21(10);
exec proc21(40);
-------------------------------------------------------------------------------------------------------------
ALTER TABLE 
    emp01
ADD CONSTRAINT
    E01_NO_PK PRIMARY KEY(empno)
;

-- emp01.deptno�� ����Ű �������� �߰�
ALTER TABLE
    emp01
ADD CONSTRAINT
    E01_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno)
;

-- �̸� ���ǵ��� ���� ����
/*
    ���� 2 ]
        emp01 ���̺� ���ο� ����� �Է��ϴ� ���ν����� �ۼ��ϼ���.
        ��, ����̸��� �μ���ȣ�� �Է��ϵ��� �Ѵ�.
        ==> �����ȣ�� �Էµ��� ������ ������ �߻��Ѵ�.
            <== ���ܸ� �����ؼ� ó������ �Ѵ�.
*/

INSERT INTO
    emp01(ename, deptno)
VALUES(
    'dooly', 40
);


CREATE OR REPLACE PROCEDURE proc22(
    name emp01.ename%TYPE,
    dno emp01.deptno%TYPE 
)
IS
    -- ���ο� ����� ������ ���ܵ��� �̰����� ���Ǹ� �Ѵ�.
    -- �� ������ ��� ���ܸ� ���� ó���ؾ� �ϱ� ������
    -- ���� ���ܸ� ���Ǹ� �ϰ� ����Ѵ�.
    
    -- ���� ���� ���
    -- 1. ���ܿ� ����� �̸��� ���Ѵ�.
    --      ���� ]
    --              �����̸�    EXCEPTION;        
    pk_ecpt EXCEPTION;
    -- 2. ������ �̸��� ���� �߻��� �ڵ带 �����Ѵ�.
    --      ���� ]
    --              PRAGMA  EXCEPTION_INIT(�̸�, �ڵ尪);
    PRAGMA EXCEPTION_INIT(pk_ecpt, -1400);
BEGIN
    INSERT INTO
        emp01(ename, deptno)
    VALUES(
        name, dno
    );
EXCEPTION
    WHEN pk_ecpt THEN
        DBMS_OUTPUT.PUT_LINE('*** �����ȣ�� �ʼ� �Է� �����Դϴ�. ***');
END;
/

exec proc22('������', 10);

--------------------------------------------------------------------------------------------
/*
    3. ����� ����
    
    ���� 3 ]
        �μ���ȣ�� �Է¹޾Ƽ�
        �ش� �μ��� ���� ������� ����ϴ� ���ν����� �ۼ��ϼ���.
        ��, ������� 3�� ���ϸ� ������� �����ϴٴ� �޼����� ����ϵ���
        ����ó���� �ϼ���.
*/

CREATE OR REPLACE PROCEDURE proc23(
    dno emp01.deptno%TYPE
)
IS
    -- ���� ��¿� ���� ����
    cnt NUMBER := 0;
    
    -- ���� ����
    ecpt01 EXCEPTION;
BEGIN
    -- ���Ǹ��
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM
        emp01
    WHERE
        deptno = dno
    ;
    
    IF cnt <= 3 THEN
        -- ���� ���� �߻�
        -- ������ ���� ������ ���� ������ ������ ���ܸ� �߻�������� �Ѵ�.
        -- ���� ]
        --      RAISE   �����̸�;
        /*
            ���� ]
                �ڹٿ��� ������ ���� �߻���Ű�� ���
                    throw new ����();
        */
        RAISE ecpt01;
    END IF;
    
    -- ���
    DBMS_OUTPUT.PUT_LINE(dno || ' �� �μ��� ����� : ' || cnt);
EXCEPTION
    WHEN ecpt01 THEN
        DBMS_OUTPUT.PUT_LINE('### ���� ] ' || dno || ' �� �μ��� ������� ������ �μ��Դϴ�.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('### ERR ] �� �� ���� �����Դϴ�.');
END;
/

execute proc23(40);

/*
    ���� 4 ] -- ����� ���� ����
        emp01 ���̺� ����� �Է��ϴ� ���ν����� �ۼ��ϼ���.
        �Է� �����ʹ� �����ȣ, ����̸�, �μ���ȣ �� �Է��ϵ��� �ϰ�
        �����ȣ�� 4�ڸ� �̸��� ���� ����ó���� �ϵ��� �Ѵ�.
*/
CREATE OR REPLACE PROCEDURE proc24(
    ieno emp01.empno%TYPE,
    name emp01.ename%TYPE,
    idno emp01.deptno%TYPE
)
IS
    -- �����ȣ�� ���̸� ������ ���� ����
    len NUMBER;
    
    -- ���� ����
    len_expt EXCEPTION;
BEGIN
    len := LENGTH(ieno);
    
    IF(len < 4) THEN
        RAISE len_expt;
    END IF;
    
    INSERT INTO
        emp01(empno, ename, deptno)
    VALUES(
        ieno, name, idno
    );
EXCEPTION
    WHEN len_expt THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : �����ȣ�� 4�ڸ� �̸��Դϴ�.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : �� �� ���� �����Դϴ�.');
END;
/

exec proc24(123, '�Ѹ�', 20);
SELECT * FROM emp01;
rollback;

/*
    ���� 5 ]
        �μ� ��ȣ�� �޿��λ����� �Է¹޾Ƽ�
        �Ҽ� �μ����� �޿��� �λ��Ű�� ���ν����� �ۼ��ϼ���.
        ��, �μ������� 4�� �̸��� ���� ����ó���� �ϼ���.
        Ŀ���� WHERE CURRENT OF�� ����ؼ� ó���ϼ���.
*/
CREATE OR REPLACE PROCEDURE proc25(
    idno IN emp01.deptno%TYPE,
    upsal IN NUMBER
)
IS
    CURSOR cur01 IS
        SELECT
            empno
        FROM
            emp01
        WHERE
            deptno = idno
        FOR UPDATE
    ;
    
    CURSOR cnt_cur IS
        SELECT
            COUNT(*)
        FROM    
            emp01
        WHERE
            deptno = idno
    ;
    
    EXCEPTION expt01;
    
    cnt NUMBER := 0;
BEGIN
    FOR data IN cur01 LOOP
        
        UPDATE
            emp01
        SET
            sal = sal * (1+upsal/100)
        WHERE CURRENT OF cur01
        ;
        
        cnt := cnt + 1;
    END LOOP;
        
    IF(cnt < 4) THEN
        RAISE expt01;
    END IF;

EXCEPTION
    WHEN expt01 THEN
      DBMS_OUTPUT.PUT_LINE ('4�� �̸� ����');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('�� �� ���� ����');
END;
/

-------------------------------------------------
CREATE OR REPLACE PROCEDURE proc25(
    idno IN emp01.deptno%TYPE,
    upsal IN NUMBER
)
IS
--  �Ҽ� �μ������� ������ ���� ����
    cnt NUMBER;

--  ���� ����
    cnt_expt EXCEPTION;
    
--  �Ҽ� �μ������� ���ϴ� ���Ǹ�� Ŀ���� ����
    CURSOR cur01 IS
        SELECT
            COUNT(*)
        FROM
            emp01
        WHERE
            deptno = idno
    ;

BEGIN
--  Ŀ���� ����.
    OPEN cur01;
    
--  Ŀ���� �����´�. ���� cnt������ �����Ѵ�.
    FETCH
        cur01
    INTO
        cnt   
    ;

-- �μ������� 4�� �̸��� ��� ����ó���� �Ѵ�.
    IF(cnt < 4) THEN
        RAISE cnt_expt;
    END IF;
    

    UPDATE
        emp01
    SET
        sal = sal * (1+upsal/100)
    WHERE
        deptno = idno
    ;
    
    CLOSE cur01;
EXCEPTION
    WHEN cnt_expt THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : �μ������� 4�� �̸��Դϴ�!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : �� �� ���� �����Դϴ�!');
END;
/

select * from emp01;
exec proc25(20, 20);
rollback;

--------------------------------------------------------------------------------------------------------------------------

/*
    Ʈ����
    ==> DML ���� ����� �߻��ϸ�
        �ڵ������� �ٸ� ó���� �ϰ��� �� ��쿡 ����ϴ� ���ν����� ����
        
        ���� ���
            ȸ�� Ż���� Ż���ϰ��� �ϴ� ȸ���� ������
            ȸ�����̺��� �����͸� ���� ������ ���̺� �����ؾ� �ϴ� �۾��� ����Ǿ�� �Ѵ�.
            ������ �Ϸ�Ǹ� ȸ�����̺��� �ش� ȸ���� ������ �����ؾ� �� ���̴�.
            �̷���� ����ϴ� ���� Ʈ�����̴�.
    
    ���� ]
        
        CREATE OR REPLACE TRIGGER Ʈ�����̸�
            BEFORE | AFTER      DML ���(DELETE | UPDATE | INSERT)
        ON
            ���̺��̸�
        [ FOR EACH ROW
            �����ϸ� DML ����� Ƚ���� ���� Ʈ���Ÿ� �����Ѵ�.
            ��, DML ����� �ѹ��̸� Ʈ���ŵ� �ѹ��� �����Ѵ�.
            
            ����ϰ� �Ǹ�
            ����Ǵ� �������� ������ŭ Ʈ���Ű� ����ȴ�.
        ]
        
        [ WHEN
            ���ǽ�
            
            -- Ʈ���Ű� �߻��ؾ� �ϴ� ���ǽ��� ����ϴ� �κ�
            �� ]
                WHEN
                    deptno = 10
            ��� �ϸ� �μ���ȣ�� 10���� ������ ����Ǹ� �׶��� Ʈ���Ÿ� �����ϼ���.
            
        ]
        BEGIN
            Ʈ���ſ� ����� ���� ��� ���
        END;
        /
    
    ���� ]
        Ʈ���Ű� �߻��ϸ� �ڵ������� ���� �ΰ��� �߻��Ѵ�.
            :OLD    -   ������ ������
            :NEW    -   ������ ������
        �� �� ������ ROWTYPE ������ �ش� ���̺��� �ʵ带 ����� ������ �����̴�.
        �� ]
            :OLD.ename - ������ ����̸�
            :NEW.ename - ������ ����̸�
        
        ���� ]
            :new, :old ������
            FOR EACH ROW�� �����ϸ� ����� �� ����.
            <== �����Ǵ� �������� ������ �������� �� �ֱ� ������
            
    ���� ]
        Ʈ���Ŵ� ����Ǵ� DML ��� ������ ���� �ٸ� ó���� �� �� �ִ�.
        
        ���� ]
            
            CREATE OR REPLACE TRIGGER Ʈ�����̸�
                BEFORE
                INSERT OR DELETE OR UPDATE
            ON
                ���̺��̸�
            
            FOR EACH ROW
            BEGIN
                -- �̶� DML ����� ������ ���� ���� ó�� ���ش�.
                IF INSERTING THEN
                    INSERT ��� ����� �ؾ��� �۾�
                ELSIF DELETING THEN
                    DELETE ��� ����� �ؾ��� �۾�
                ELSIF UPDATING THEN
                    UPDATE ��� ����� �ؾ��� �۾�
                END IF;
            END;
            /
    
    ���� ]
        Ʈ���ſ��� ����ϴ� DML ����� �ڵ� Ŀ�Եȴ�.
        ���� COMMIT, ROLLBACK�� ����� �� ����.
*/

-- EMP01 ������ ��������� ������ ���̺��� �����.
CREATE TABLE E_BACKUP
AS
    SELECT
        *
    FROM
        emp01   
    WHERE
        1 = 2
;

-- ����� �߰�
ALTER TABLE e_backup
ADD
    firedate DATE DEFAULT SYSDATE
        CONSTRAINT EBACK_FDATE_NN NOT NULL
;

DROP TABLE E_BACKUP;
SELECT * FROM e_backup;

alter table e_backup
rename column firedate to hiredate;

SELECT * FROM e_backup;

GRANT CREATE ANY TRIGGER, ALTER ANY TRIGGER, DROP ANY TRIGGER TO hello;

-- ����� Ż���ϸ� �������̺� �����Ͱ� ������� �����͸� �����ϴ� ���ν����� �ۼ��ϼ���.
CREATE OR REPLACE TRIGGER trg01
    BEFORE DELETE
ON
    emp01
FOR EACH ROW
BEGIN
    INSERT INTO
        e_backup
    VALUES(
        :old.empno, :old.ename, :old.job, :old.mgr, :old.hiredate, :old.sal, :old.comm, :old.deptno, sysdate
    );
    
    DBMS_OUTPUT.PUT_LINE(:OLD.ename || '����� ����߽��ϴ�.');
END;
/

DELETE FROM emp01 WHERE deptno = 10;
SELECT * FROM emp01;
SELECT * FROM e_backup;

/*
    ���� ]
        8000�� ����� �Ի��ϸ�
        '8000�� ��� xxxx�� �Ի��߽��ϴ�.'
        ��� �޽����� ����ϴ� Ʈ���Ÿ� �ۼ��ϼ���.
*/
CREATE OR REPLACE TRIGGER add_emp
AFTER INSERT
ON
    emp01
FOR EACH ROW
WHEN(
    new.empno = 8000
)
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('8000 �� ��� ' || :NEW.ENAME || ' ����� �Ի��߽��ϴ�.');
END;
/

INSERT INTO emp01(empno, ename, deptno)
VALUES(8000, 'dooly', 40);

SELECT * FROM emp01;

rollback;


--------------------------------------------------------------------------------------------------------
/*
    �����ٷ�
    ==> Ư�� �ð��� �Ǹ� ���ϴ� ���Ǹ���� ����ǵ��� �ϴ� ����� ���Ѵ�.
        ��, ����Ŭ���� �������� �˷��־ �� �����ٴ�� �۾��� �����Ѵٰ� �ؼ�
        �����ٷ� �� �θ���.

    �۾� ���� ]
        
        1. ������ ���Ǹ���� �����ϴ� ���ν����� ����� ���´�.
        2. ���α׷��� ���
            ==> �����ٷ� ������ ���α׷�(1���� ���� ���ν���)�� ����� ���ƾ� �Ѵ�.
            
        3. �������� ���
            ==> ���� ���ν����� ��������� �����ϴ� ������ ����� ���� ��.
            
        4. �� ���
            ==> 2���� ����� 3���� ������ ���ļ� �ϳ��� ������ �۾��� �ϼ��ϴ� �ܰ�
*/

-- 1�п� �ѹ��� �ڵ������� �����Ͱ� �Էµǵ��� �غ���.

-- ���̺� �غ�
CREATE TABLE test01(
    no NUMBER(3),
    wdate Date
);

-- �����ٷ� �۾��� �Ѵ�.

-- 1. ���ν����� �ۼ��Ѵ�.
CREATE OR REPLACE PROCEDURE proc31
IS
BEGIN
    INSERT INTO
        test01
    VALUES(
        (
            SELECT
                NVL(MAX(no)+1, 100)
            FROM
                test01
        ),
        sysdate
    );
END;
/

-- 2. ���α׷��� ����Ѵ�.
/*
    ���� ]
        BEGIN
            DBMS_SCHEDULER.CREATE_PROGRAM(
                program_name    =>  '�������̸�',
                program_action  =>  '����� ���ν����̸�',
                -- ���ν����� �̿����� �ʰ�
                -- ���� ���Ǹ���� ���� ����� ����.
                program_type = 'STORED_PROCEDURE',
                -- ���� ��(program action)���� ���Ǹ���� ���� �ۼ��ߴٸ�
                -- EXECUTABLE �̶�� ����ϸ� �ȴ�.
                comment     =>  '������ ����',
                enabled     => TRUE
                -- ����� ���� Ȱ��ȭ �ϼ���. ��� �ǹ�
            );            
        END;
        /
*/

-- system �������� �۾��Ѵ�.
grant create any procedure, execute any program to hello;
grant create any job to hello;

-- hello �������� �۾��Ѵ�.
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        program_name => 'prog1',
        program_action => 'proc31',
        program_type => 'STORED_PROCEDURE',
        comments      => '�׽�Ʈ�뽺���ٷ�',
        enabled      => TRUE
    );
END;
/

/*
    3. ������ ���
        ==> ���� ���������� �̸� �����ϴ� ��.
        
        ���� ]
            BEGIN
                DBMS_SCHEDULER.CREATE_SCHEDULE(
                    schedule_name => '�������̸�'
                    start_date => '���۳�¥',
                    end_date => ������,
                    repeat_interval => �ݺ��ֱ�
                    comments => '�����Ѽ���'
                );
            END;
            /
                
        ���� ]
            start_date, end_date �� �����ص� �������.
            start_date �� �����ϸ� ����� �������� �������� �����ȴ�.
            end_date�� �����ϸ� ������ �ݺ��Ѵ�.
            
            �� ]
                ���ù� 12�ú��� �������� �����ϰ� �ʹٸ�
                start_data => (TRUNC(SYSDATE) + 0 / 24) + 1,
                                0 - ���� �ð�
                                1 - ���÷κ��� ���� ��¥(������ ��¥)
        
        ���� ]
            repeat_interval�� �ݺ��ֱ⸦ �Է��ϴ� �κ�
            repeat_interval => FREQ=#;INTERVAL=@ �� �������� �����Ѵ�.
                #   - ������ �ǹ��Ѵ�.
                    �� ]
                        HOURLY      - �ð�����
                        MINUTELY    - �а���
                        DAILY       - �ϰ���
                        
                @   - �����ֱ�
                
            �� ]
                repeat_interval => FREQ=MINUTELY;INTERVAL=1
            
*/


BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        schedule_name => 'one_min_sch01',
        repeat_interval => 'FREQ=MINUTELY;INTERVAL=1',
        comments => 'every 1 min'
    );
END;
/

-- 4. �� ��� : ������ ���� �ΰ����� ���ļ� �۾������� �����.
/*
    ���� ]
        BEGIN
            DBMS_SCHEDULER.CREATE_JOB(
                job_name => '�۾������̸�',
                program_name => '���α׷��̸�',
                schedule_name => '�������̸�',
                comments => '�������ڸ�Ʈ',
                enabled => TRUE
            );
        END;
        /
*/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name => 'test_job1',
        program_name => 'prog1',
        schedule_name => 'one_min_sch01',
        comments => 'test batch program',
        enabled => TRUE
    );
END;
/



/*
    �����ٷ� �����ϱ�
        execute DBMS_SCHEDULER.DROP_JOB('test_job1', false);
        execute DBMS_SCHEDULER.DROP_PROGRAM('prog1', false);
        execute DBMS_SCHEDULER.DROP_SCHEDULE('one_min_sch01', false);
*/

execute DBMS_SCHEDULER.DROP_JOB('test_job1', false);
execute DBMS_SCHEDULER.DROP_PROGRAM('prog1', false);
execute DBMS_SCHEDULER.DROP_SCHEDULE('one_min_sch01', false);

delete from test01;

-- ������ ����
SELECT
    empno, ename, mgr, level
FROM
    emp01
START WITH
    mgr IS NULL
CONNECT BY
    PRIOR empno = mgr
ORDER SIBLINGS BY
    empno
;









