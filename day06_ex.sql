-- day06 ����
-- INSERT, UPDATE, DELETE

-- hello ������ scott ������ ������ �ִ�
-- emp ���̺��� ������ �����ؼ� ���弼��.
CREATE TABLE sample01
AS
    SELECT
        *
    FROM
        scott.emp
    WHERE
        1 = 2
;
SELECT * FROM sample01;


-- dept ���̺� ������ �����ؼ� ���弼��.
CREATE TABLE dept
AS
    SELECT
        *
    FROM
        scott.dept
    WHERE
        1 = 2
;
SELECT * FROM dept;

-- salgrade ���̺��� �����ͱ��� �����ؼ� ���弼��.
CREATE TABLE salgrade
AS
    SELECT
        *
    FROM
        scott.salgrade
;
SELECT * FROM salgrade;

-- INSERT
-- �츮�� ģ�� 5���� �����͸� sample01 ���̺� �Է��ϼ���.
-- job�� emp ���̺��� ������ ����ϵ��� �Ѵ�.

INSERT INTO
    sample01
VALUES(
    1001, '�ǿ���', 'MANAGER', 9999, SYSDATE, 3000, 1500, 30   
)
;

INSERT INTO
    sample01
VALUES(
    1002, '������', 'CLERK', 9999, SYSDATE, 2000, 1000, 10   
)
;

INSERT INTO
    sample01
VALUES(
    1003, '������', 'CLERK', 9999, SYSDATE, 2500, 500, 10   
)
;


INSERT INTO
    sample01
VALUES(
    1004, '������', 'ANALYST', 9999, SYSDATE, 3500, 1500, 30   
)
;

INSERT INTO
    sample01
VALUES(
    9999, '�賲��', 'BOSS', NULL, TO_DATE('2013/06/13', 'YYYY/MM/DD'), 5000, 2000, 40
)
;

/*
    dept ���̺� �����͸� �߰��ϴµ�
    10 - ��ȹ��    - ����
    20 - �λ��    - ���ǵ�
    30 - ���ߺ�    - ����
    40 - ȸ���    - ����
    
    �߰����ּ���.
*/

INSERT INTO
    dept
VALUES(
    10, '��ȹ��', '����')    
;

INSERT INTO
    dept
VALUES(
    20, '�λ��', '���ǵ�')
;

INSERT INTO
    dept
VALUES(
    30, '���ߺ�', '����')
;

INSERT INTO
    dept
VALUES(
    40, 'ȸ���', '����')
;


-----------------------------------------------------------------------------------------------

/*
    scott������ ������ �ִ� emp, dept ���̺��� �����Ϳ� �Բ� �����ؼ�
    semp, sdept�� �����
    
    
    1. ����� �޿��� �ϰ������� 10% �λ��ؼ� �����ϼ���.
    
    2. �޿��� 10% �� �λ��ϰ�
        �Ի����� ���� ��¥�� �����ϼ���.
        
    3. ������ SALESMAN �� ����� ������ SALES �� �����ϼ���.
    
    4. �μ���ȣ�� 10���� ����� �����ϼ���.
    
*/
-- semp ����
CREATE TABLE semp
    AS
        SELECT
            *
        FROM
            scott.emp
;
SELECT * FROM semp;

-- sdept ����
CREATE TABLE sdept
    AS
        SELECT
            *
        FROM
            scott.dept
;
SELECT * FROM sdept;


-- 1. ����� �޿��� �ϰ������� 10% �λ��ؼ� �����ϼ���.
UPDATE
    semp
SET
    sal = sal * 1.1
;

-- 2. �޿��� 10% �� �λ��ϰ�
--        �Ի����� ���� ��¥�� �����ϼ���.
UPDATE
    semp
SET
    sal = sal * 1.1,
    hiredate = SYSDATE
;

-- 3. ������ SALESMAN �� ����� ������ SALES �� �����ϼ���.
UPDATE
    semp
SET
    job = 'SALES'
WHERE
    job = 'SALESMAN'
;

-- 4. �μ���ȣ�� 10���� ����� �����ϼ���.
DELETE FROM semp
WHERE
    deptno = 10
;

SELECT * FROM semp;



