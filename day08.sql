/*
        ��(View)
        ==> ���� ����� ����� �ϳ��� â������ �ٶ� �� �ִ� â���� �ǹ��Ѵ�.
        
            �� ]
                    SELECT * FROM AVATAR;
                    ==> �� ���Ǹ���� �����ϸ� ����� �����µ� �� ��� �߿��� �Ϻκи� �� �� �ִ� â���� ����
                            ����ϴ� ��.
                    
                    ==> ���� ����ϴ� ������ ���Ǹ���� ���� ������ ����
                            �� ���� ����� ����� �ս��� ó���� �� �ֵ��� �ϴ� ���̴�.
                    
                    ���� ����
                        1. �ܼ� ��
                            ==> �ϳ��� ���̺��� �̿��ؼ� ������� �並 �ǹ��Ѵ�.
                                    ���� ��� DML ����� �����ϴ�.
                                    
                                    ���� ]
                                        �ܼ� ��� �׷��Լ��� ������� ��� select ��� �̿��� DML ����� ��� �Ұ��ϴ�.
                                    
                        2. ���� ��
                            ==> �� �� �̻��� ���̺��� �̿��ؼ�(�����ؼ�) ������� ��
                                    **
                                    select�� �����ϰ� �ٸ� DML ����� ����� �Ұ����ϴ�.
-----------------------------------------------------------------------------------------------------------------------
    ���� ]
        ��Ģ������ ����� ������ �����ڰ� ����� �ϸ� �� �� �ִ�.
        ��, �����ڴ� ������ �������� �� ������ ���ѿ� ���� ����� �� �ִ� ����� ������ �� �ִ�.
        
        ���� SCOTT ������ SELECT, UPDATE, DELETE, INSERT, CREATE TABLE, SELECT ANY TABLE, DROP TABLE...
        ����� �����̴�.
        
        ������ �並 ����� ����� ���� SCOTT, HELLO ������ ����� ���°� �ƴϴ�.
        
        ***
        ����
        ������ �������� Ư�� ������ ����� �� �ִ� ����� ������ �ο������ �Ѵ�.
        
        ���� �ο� ���
        
            ���� 1 ]
                
                GRANT ����, ����, ... TO �����̸�;
      
*/

select ano, aname from avatar WHERE gen = 'M';

SELECT * FROM hello.avatar;

  --> SYSTEM �������� �����ؼ� 
GRANT CREATE VIEW TO scott;
GRANT SELECT ANY TABLE TO scott;
GRANT CREATE VIEW TO hello;
                
GRANT CREATE VIEW TO free;


/*
        �� ����� ���
        
                ���� 1 ]
                
                    CREATE VIEW ���̸�
                    AS 
                            �信�� ����� �����͸� ������ ���Ǹ��
                    ;
*/

-- SCOTT ������ EMP���̺��� �����ȣ, ����̸�, �޿��� ���� �並 ����� ����.

CREATE VIEW esal
AS
    SELECT
        EMPNO, ENAME, SAL
    FROM
        SCOTT.EMP   
;

SELECT * FROM esal;

-- ������� �μ��� �μ� �ִ�޿�, �μ��ּұ޿�, �μ���ձ޿�, �μ��޿��հ�, �μ�����, �μ���ȣ �� �� �� �ִ� �並 ����� ����.
DROP VIEW dsal;

-- GROUP �Լ��� ���� ������� �信�� INSERT, DELETE, UPDATE�� �� ���� ����.

CREATE VIEW DSAL
AS
    SELECT
        deptno, MAX(sal) max, min(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
    FROM
        emp
    GROUP BY
        deptno
;

-- scott.dept ���̺��� ����
CREATE TABLE dept
AS
    SELECT
        *
    FROM
        scott.dept   
;

CREATE TABLE salgrade
AS
    SELECT
        *
    FROM
        scott.salgrade
;

-- emp, dept ���̺��� �̿��ؼ�
-- �μ���ȣ, �μ��ִ�޿�, �μ��ּұ޿�, �μ��޿��հ�, �μ���ձ޿�, �μ�����, �μ��̸�, �μ���ġ
-- �� �� �� �ִ� �並 �����.
CREATE VIEW dptsal
AS
    SELECT
        deptno, max, min, avg, sum, cnt, dname, loc
    FROM
        (
            SELECT
                deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
            FROM
                emp
            GROUP BY
                deptno
        ),
        dept
    WHERE
        dno = deptno
;

select * from dptsal;

-- EMP, DEPT ���̺��� ����ؼ�
-- �����ȣ, ����̸�, �޿�, �μ���ȣ, �μ��̸�, �μ���ġ�� �� �� �ִ� �並 ���弼��.
CREATE VIEW temp01
AS
    SELECT
        empno, ename, sal, e.deptno, dname, loc
    FROM
        emp  e, dept d
    WHERE
        e.deptno = d.deptno   
;

select * from temp01;

/*
    ���� 1 ]
        emp ���̺��� ��� �� �μ���ȣ�� 10���� ������� ������ �� �� �ִ� �並 ���弼��.
*/

CREATE VIEW Test01
AS
    SELECT
        *
    FROM
        emp
    WHERE
        deptno = 10
;
/*
    ���� 2 ]
        ����� �̸��� 4������ ������� ������ �� �� �ִ� �並 ���弼��.
*/
CREATE VIEW Test02
AS
    SELECT
        *
    FROM
        emp
    WHERE
        LENGTH(ename) = 4
;
-- ���� 3 ] �並 ����� ����ؼ� ����� �μ� ��ձ޿����� ���� �޴� ����� �����ȣ, ����̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϼ���.
-- ***
CREATE VIEW test03
AS
    SELECT
        empno, ename, sal, deptno, ROUND(avg, 2) davg
    FROM
        emp,
        (   -- �ζ��� �� : �μ��� �ְ�޿�, �ּұ޿�, ���, �μ�����, �Ѱ�
            SELECT
                deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt, SUM(sal) sum
            FROM
                emp
            GROUP BY
                deptno
        )
    WHERE
        deptno = dno -- ������ ��.
;


SELECT
    empno, ename, t.deptno, dname
FROM
    test03 t, dept d
WHERE
    sal > davg
    AND t.deptno = d.deptno
;

-- ���� 3-1 ] ����� �μ� �ּұ޿��� ����� �����ȣ, ����̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϼ���.(�������Ƿ� �ذ�)

SELECT
    empno �����ȣ, ename ����̸�, e.deptno �μ���ȣ, dname �μ��̸�
FROM
    emp e, dept d,
    (
        SELECT
            deptno dno, MIN(sal) min
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    e.deptno = d.deptno
    AND e.deptno = dno
    -- ��������� ��������
    AND sal = min
;


SELECT
    empno �����ȣ, ename ����̸�, e.deptno �μ���ȣ, dname �μ��̸�
FROM
    emp e, dept d,
    (
        SELECT
            deptno dno, AVG(sal) avg
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    e.deptno = d.deptno
    AND e.deptno = dno
    -- ��������� ��������
    AND sal > avg
;

-----------------------------------------------------------------------------------------------------
SELECT * FROM dsal;

INSERT INTO
    esal
VALUES(
    9000, 'DOOLY', 20
);

DROP VIEW esal;

CREATE VIEW esal
AS
    SELECT
        empno, ename, sal
    FROM
        emp
;

INSERT INTO
    esal
VALUES(
    8000, 'DOOLY', 50
);

select * from esal;

select * from emp;

rollback;


/*
    ���� 2 ]
        
            DML ������� �����͸� ������ ��
            ����� �����ʹ� �⺻ ���̺� ������ �ǹǷ�
            �� ���忡�� ���� �� �����͸� ������ ����� �� ���� �� �ִ�.
            
            ==> �̷� ������ �ذ��ϱ� ���� ���
                    �ڽ��� ����� �� ���� �����ʹ� ������ �Ұ����ϵ��� �� �� �ִ�.
                    
            ���� ]
                
                CREATE VIEW ���̸�
                AS
                        ���Ǹ��
                WITH CHECK OPTION
*/

-- 20 �μ��� ����� ������ �� �� �ִ� �� VIEW 02�� �����.
CREATE VIEW view02
AS
    SELECT
        *
    FROM
        emp
    WHERE
        deptno = 20
;

UPDATE
    view02
SET
    deptno = 40
WHERE
    deptno = 20
;

select * from view02;

rollback;

DROP VIEW VIEW02;

CREATE VIEW view02
AS
    SELECT
        *
    FROM
        emp
    WHERE
        deptno = 20
WITH CHECK OPTION
;

-- ���� 3 ] �μ���ȣ�� 30���� ������� ����̸�, ����, �μ���ȣ�� �� �� �ִ� �並 ���弼��.
--               ��, ���� �����Ͱ� �ϳ��� �������� �ʵ��� ������ �� ���� �ϼ���.

CREATE VIEW test04
AS
    SELECT
        ename, job, deptno
    FROM
        emp
    WHERE
        deptno = 30
WITH CHECK OPTION
;

/*
    ���� ]
        ���̺� ������������ �̹� �����ϴ� ���̸��� ������ ���̸����δ� �並 ������ ���Ѵ�.
        
        ���� �̸��� �䰡 �־ ���� �� �ִ� ���
        
            ���� ]
                    
                    CREATE OR REPLACE VIEW ���̸�
                    AS
                            ���Ǹ��
                            
                    ;
*/

-- ���� 4 ] �μ���ȣ�� 10, 20���� ������� ����̸�, ����, �μ���ȣ�� �� �� �ִ� ��(VIEW03)�� ���弼��.
--               ��, ���� �����Ͱ� �ϳ��� �������� �ʵ��� ������ �� ���� �ϼ���.

CREATE OR REPLACE VIEW view03
AS
    SELECT
        ename, job, deptno
    FROM
        emp
    WHERE
        deptno IN(10, 20)
WITH CHECK OPTION
;

/*
    �� �����ϱ�
        ���� ]
            DROP VIEW ���̸�;
*/

DROP VIEW view03;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
        �ζ��� ��(Inline View)
        ==> SELECT ���� ����� ������ ���ϴ� ����� ��ȸ�� �ȴ�.
                �̰��� �ζ��� ���� �̾߱� �Ѵ�.
                
                ��, ��� �ζ��� ���߿��� ���� ����ϴ� �ζ��� �並 �����ѳ��� ����ϴ� �����̴�.
                
                ��ȸ���Ǹ���� ����� ��������� ������ ������ �ζ��κ�� �̾߱� �Ѵ�.
                
                *
                �ζ��� ��� �ϳ��� �������̺��̴�.
                (���̺��̶� �ʵ�� ���ڵ�� ������ �����͸� �Է��ϴ� ����)
                ���� �ζ��� ��� �ϳ��� ���̺�� �ٽ� ������ �����ϴ�.
                �ᱹ ���̺��� ����ؾ� �ϴ� ������ �ζ��� �並 ����ص� �ȴ�.
                
                �� ]
                    SELECT
                        empno
                    FROM
                        (
                            SELECT
                                empno, ename, deptno
                            FROM
                                emp
                        )
                    WHERE
                        deptno = 10
                    ;
                        
                    SELECT
                        ename, sal
                    FROM
                        (
                            SELECT
                                empno, ename, job
                            FROM
                                emp
                        )
                    ; -->   �� ���� ������ ����. �ֳ��ϸ� ���̺��� ���뿡 sal �ʵ尡 �������� �ʱ� ������

---------------------------------------------------------------------------------------------------------------------------
        �ζ��� �並 ����ؾ� �ϴ� ����
            ���� ���̺� �������� �ʴ� �����͸� �߰������� ����ؾ� �ϴ� ��쿡
            Ư�� �ζ��� �並 ����Ѵ�.
---------------------------------------------------------------------------------------------------------------------------

***** ���� �߿�
���� ]
    ROWNUM
    ==> ������ ���������� �����ϴ� �ʵ�� �ƴϰ�
            ����Ŭ�� ������ִ� ������ �ʵ��
            �����Ͱ� �Էµ� ������ ǥ���ϴ� �ʵ��̴�.
            
            �� ]
                SELECT
                    rownum, ename, job
                FROM
                    emp
                ;
                
            �����͸� ������ �Ŀ� �ٿ��ִ� ��ȣ�̹Ƿ�
            ORDER BY ���� �̿��Ͽ� Ư�� �÷��� �������� ������ ���,
            ������ ���̺��� �ζ��� ��� �Ͽ� rownum�� �ٿ��־�� �Ѵ�.
            
            ����! �� ���� ��ȣ�� �ٿ��ִ� ���� �ƴ�.
            �� �� �� �� ������ ������ �ϳ��� ��ȣ�� �ٿ��ִ� ����.
*/
SELECT
    empno
FROM
    (
        SELECT
            empno, ename, deptno
        FROM
            emp
    )
WHERE
    deptno = 10
;
      
SELECT
    ename, sal -- ERROR
FROM
    (
        SELECT
            empno, ename, job
        FROM
            emp
    )
;

--> rownum : ������ �Ŀ� �ٿ��ִ� ��ȣ��. ����!!

SELECT
    ROWNUM no, e.*
FROM
    (SELECT
        ename, job
    FROM
        emp
    ORDER BY
        ename) e
;

-- ���� 3 ] ������� �����ȣ, ����̸�, �޿��� ��ȸ�ϼ���.
-- ��, ��ȸ�� ������� ������ �޿��� ���� ������� 1���� �ѹ����� �Ǽ� ��ȸ�ǰ� �ϼ���.
SELECT
    rownum no, e.*
FROM
    (SELECT
        empno, ename, sal
    FROM
        emp
    ORDER BY
        sal DESC) e
;

-- ***
-- �� �������� �޿��� 5��°���� 7��°�� ���� �޴� ����� ��ȸ�ϼ���.
CREATE VIEW test05
AS
    SELECT
        rownum no, e.*
    FROM
        (SELECT
            empno, ename, sal
        FROM
            emp
        ORDER BY
            sal DESC) e
;

SELECT
    *
FROM
    test05
WHERE
    no BETWEEN 5 AND 7
;
---------------------------------------------------------
SELECT
    RNO, EMPNO, ENAME, SAL
FROM
    (SELECT
        rownum rno, empno, ename, sal
    FROM
        (
            SELECT
                empno, ename, sal
            FROM
                EMP
            ORDER BY
                sal DESC
        )   
    )
WHERE
    rno BETWEEN 5 AND 7
;

-- ������̺��� �Ի����� 7��°�� �Ի��� ����� �����ȣ, ����̸�, �Ի����� ��ȸ�ϼ���.

SELECT
    no, empno, ename, hiredate
FROM
    (SELECT
        rownum no, empno, ename, hiredate
    FROM
        (SELECT
            empno, ename, hiredate
        FROM
            emp
        ORDER BY
            hiredate DESC)
    )
WHERE
    no = 7
;

-----------------------------------------------------------------------------------------------------------------------------------
/*
        ������(SIQUENCE)
        ==> ���̺��� ����� �� ���� �������� PK�� �ʼ������� �����ؾ� �Ѵ�.
        
        ���� ���
            ����� �����ϴ� ���̺��� �����
            �� ����� ������ �� �ִ� �����ΰ��� �־�� �Ѵٴ� ���̴�.
            ���� �츮�� ������ �ִ� EMP ���̺�����
            �����ȣ(EMPNO)�� �̿��ؼ� ó���ϰ� �ִ�.
            
        ���� ���̺��� �̰��� ��Ȯ�ϰ� �����Ͽ� ó���� �� ������
        �׷��� ���� ���̺� �����Ѵ�.
        
        ���� ���ڸ�
            �Խ��� ������ �����ϴ� ���̺��� ����ٸ�
            ����, �۾���, �ۼ���, ����, ... �� ������
            �̰� �߿��� ��Ȯ�ϰ� �� ���� ������ �� �ִ� ������ �ϴ� �ʵ尡 �������� �ʴ´�.
        
        �̷� ���� �Ϸù�ȣ�� �̿��ؼ� �� ������ �ϵ��� �ϰ� �ִ�.
        
        ���� �� �Ϸù�ȣ�� ����� �ߺ��Ǹ� �ȵǰ�( <== �⺻Ű�� �۵��� ���̱� ������)
        �׸��� ����� �����Ǿ�� �ȵȴ�.
        ==> �����ͺ��̽��� ������ �Է��ϴ� ����� ������ �߻��� �� �ִ�.
        
        �������� �̷� �������� �ذ��ϱ� ���ؼ� ��Ÿ�� ����̴�.
        �ڵ������� �Ϸù�ȣ�� ������ִ� ������ �ϴ� �����̴�.
        
        ��� ]
            1. �������� ����� ���´�,
            2. �����ͺ��̽��� �Ϸù�ȣ�� �Է��� �ʿ��ϸ� �������� ���������� ��ȣ�� ����� �޶�� ��û�Ѵ�.
                    ==> �����͸� insert ��ų �� �Ϸù�ȣ�κ��� ���������� ��Ź�ϸ� �ȴ�.
                    
                    
    ������ ����� ���
    
        ���� ]
            
            CREATE SEQUENCE �������̸�
                START WITH ��ȣ
                ==> �߻��� �Ϸù�ȣ�� ���۰��� �����Ѵ�.
                        ���� �����Ǹ� 1���� �����Ѵ�.
                        
                INCREMENT BY ����
                ==> �߻��� ��ȣ���� ������ �������� ����
                        �����ϸ� 1�� ����
                
                MAXVALUE ���� [ Ȥ�� NOMAXVALUE ]
                MINVALUE ���� [ Ȥ�� NOMINVALUE ]
                ==> �߻��� �Ϸù�ȣ�� �ִ� �ּڰ��� �����Ѵ�.
                        �����ϸ� NO�� ����Ѵ�.
                
                CYCLE �Ǵ� NOCYCLE
                ==> �߻��� �Ϸù�ȣ�� �ִ񰪿� ������ ���� �ٽ� ó������ �������� ���θ� ����
                        �����ϸ� NOCYCLE
                
                CACHE �Ǵ� NOCACHE
                ==> �Ϸù�ȣ �߻��� �ӽ� �޸𸮸� ������� ���θ� �����Ѵ�.
                        (�̸� ������ ������ �� �� ���� ���� �޸𸮿� �غ���ѳ����� ����)
                        ����ϸ� �ӵ��� ���������� �޸𸮰� �ٰ�
                        ���ϸ� �ӵ��� ���������� �޸𸮴� ���� �ʴ´�.
            ;
*/

-----------------------------------------------------------------------------------------------------------------------------
-- EMP ���̺��� ���������� �߰����ּ���.
-- PK, FK�� �߰����ּ���.

ALTER TABLE
    emp
ADD
    CONSTRAINT EMP_NO_PK PRIMARY KEY(empno)
;

ALTER TABLE
    dept
ADD
    CONSTRAINT DEPT_DNO_PK PRIMARY KEY(deptno)
;

-- *** ����! ����Ű ���� ������ ������ �� �ִ� �ʵ� : �⺻Ű �Ǵ� ����Ű�� ������ �ʵ常 ���� ����!!!
ALTER TABLE 
    emp
ADD
    CONSTRAINT EMP_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno)
;


----------------------------------------------------------------------------------------------------------------------------------

-- ���� ] 1���� 1�� �����ϴ� ������ SEQ1�� �ϳ� ������. ��, �ִ��� 100���� �Ѵ�.
CREATE SEQUENCE seq01
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100
    NOCYCLE
    NOCACHE
;

----------------------------------------------------------------------------------------------------------------------------------

/*
    ������ �����
        ==> �����͸� �Է��� �� �ڵ����� �Ϸù�ȣ�� �߻��ϱ� ���ؼ� �����.
                ���� INSERT ��ɿ� ����ϸ�
                
                    �������̸�.NEXTVAL
                �� ����ϸ� �ȴ�.
                
        ���� ]
            �������� ������ ����
            
                NEXTVAL         - �������� ������� ���� ��ȣ ������ȣ�� �����.
                CURRVAL         - �������� ���ݱ��� ���������� ���� ��ȣ�� ����ϴ� ����
                                                *****
                                                CURRVAL�� ������ ������ ������ִ�.
                                                CURRVAL�� NEXTVAL�� ������� ��ȣ�� ����ϴ� ����
*/

SELECT seq01.CURRVAL FROM dual;

SELECT seq01.NEXTVAL FROM dual;

SELECT seq01.CURRVAL FROM dual;

SELECT seq01.CURRVAL cur, seq01.NEXTVAL next FROM dual;

-- �ӽ÷� �����͸� �Է��� ���̺��� �ϳ� �����.
CREATE TABLE tmp01(
    no NUMBER(3)
        CONSTRAINT TMP_NO_PK PRIMARY KEY,
    name VARCHAR2(10 CHAR) DEFAULT 'DOOLY'
        CONSTRAINT TMP01_NAME_NN NOT NULL
);

-- �����͸� ä������.
INSERT INTO
    tmp01(no)
VALUES(
    seq01.currval
);

INSERT INTO
    tmp01
VALUES(
    seq01.nextval, '������'
);

INSERT INTO
    tmp01
VALUES(
    seq01.nextval, '��ġ'
);

SELECT * FROM tmp01;

-- ���� �� ������ ������, nextval���� ����Ǿ� �������� 1�� �߰��ȴ�.
INSERT INTO
    tmp01
VALUES(
    seq01.nextval, 'aaaaaaaaaaa'
);

INSERT INTO
    tmp01
VALUES(
    seq01.nextval, '�����'
);

SELECT * FROM tmp01;

commit;
-- ����! �������Ƿ� �ѹ����� ����� �ͺ���, �������� ����� ���� ����ӵ��� �� ����.
-- ����� �����͸� ���� �� �������� �̿��ϴ� ���� �� �����ϴ�.

/*
    �������� ������
            ==> �������� ���̺� ���ӵ��� �ʰ� ���������� �۵��Ѵ�.
                    ��, �ѹ� ���� �������� ���� ���̺��� ����� �� �ִ�.
                    �̶� � ���̺��� �������� ����ϴ��� ����
                    nextval�� �׻� ���� ��ȣ�� ������ش�.
                    
                    �׸���
                    �Է¿� ���и� �ϴ��� nextval�� ȣ���ϸ�
                    �Է¿� ������ �� ���� ��ȣ�� ���� ��ȣ�� ����� �ȴ�.
                    
                    ���� �������� ����ϰ� �Ǹ� �߰��� ������ ��ȣ�� ���� �� �ִ�.
                    
                    
    ������ �����ϱ�
        ==> �������� ��ü�̱� ������ ������ ���� DDL ����� ����ؼ� ������ �ؾ� �Ѵ�.
        
        ���� ]
            ALTER SEQUENCE �������̸�
                    INCREMENT BY    ����
                    MAXVALUE        ����
                    MINVALUE         ����
                    CYCLE �Ǵ� NOCYCLE
                    CACHE �Ǵ� NOCACHE
            ;        
            
            ���� ]
                �������� ������ ���� ���۹�ȣ�� ������ �� ����.
                �ֳ��ϸ� �̹� �߻��� ��ȣ�� �ֱ� �����̴�.
                ���۹�ȣ�� ������ �������� ���۹�ȣ�� �ڵ����� ���۹�ȣ�� �ȴ�.
                
------------------------------------------------------------------------------------------------------------------------------
    ������ �����ϱ�
        ���� ]
            DROP SEQUENCE �������̸�;
            
*/

-- SEQ01�� �������� 3���� �����غ���.
ALTER SEQUENCE seq01
    INCREMENT BY 3
;

SELECT
    seq01.CURRVAL FROM DUAL;
    
SELECT
    seq01.NEXTVAL FROM DUAL;
    
-- SEQ01 �� ����
DROP SEQUENCE seq01;

-- ȸ���� �Ϸù�ȣ�� ������ִ� �������� ���弼��.
-- ��, ���۰��� 1000, �ִ밪�� 9999�� �ϰ� �ִ밪�� ���������� �ٽ� �ݺ����� �ʵ��� �ϰ�, ĳ����� �������
-- �ʴ� ������ 1�� �����ϰ� �����.

CREATE SEQUENCE seq01
    START WITH 1000
    MAXVALUE 9999
    NOCYCLE
    NOCACHE
    INCREMENT BY 1
;

SELECT seq01.NEXTVAL FROM dual;

SELECT seq01.CURRVAL FROM dual;

