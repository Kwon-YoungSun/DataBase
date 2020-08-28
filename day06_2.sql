-- emp ���̺� ����
/*
    ���̺� ���� ���
        ���� 1]
        CREATE TABLE ���̺��̸�(
            �÷��̸�    ������Ÿ��[(����)]     [ DEFAULT ������ ],
            �÷��̸�    ������Ÿ��[(����)]     [ DEFAULT ������ ],
            �÷��̸�    ������Ÿ��[(����)]     [ DEFAULT ������ ],
            �÷��̸�    ������Ÿ��[(����)]     [ DEFAULT ������ ]
        );
        
        ���� 2]
        CREATE TABLE ���̺��̸�(
            �÷��̸�    ������Ÿ��[(����)]     [ DEFAULT ������ ]
                CONSTRAINT  ���������̸�  �������Ǳ���,
            �÷��̸�    ������Ÿ��[(����)]     [ DEFAULT ������ ]
                CONSTRAINT  ���������̸�  �������Ǳ���,
            ...
        );
        
        ��������
            PRIMARY KEY
            ==> CONSTRAINT ���������̸� PRIMARY KEY,
            
*/
-- dept ���̺� ����
CREATE TABLE dept(
    deptno NUMBER(2)
        CONSTRAINT DPT_NO_PK PRIMARY KEY,
    dname VARCHAR2(10 CHAR)
        CONSTRAINT DPT_NAME_NN NOT NULL,
    loc VARCHAR2(15 CHAR)
        CONSTRAINT DPT_LOC_NN NOT NULL
);


-- emp ���̺� ����
CREATE TABLE emp(
    empno NUMBER(4)
        CONSTRAINT EMP_ENO_PK PRIMARY KEY,
    ename VARCHAR2(10 CHAR)
        CONSTRAINT EMP_NAME_NN NOT NULL,
    job VARCHAR2(15 CHAR)
        CONSTRAINT EMP_JOB_NN NOT NULL,
    mgr NUMBER(4),
    hiredate DATE
        CONSTRAINT EMP_DAY_NN NOT NULL,
    sal NUMBER(8) DEFAULT 3000000
        CONSTRAINT EMP_SAL_NN NOT NULL,
    comm NUMBER(8),
    deptno NUMBER(2)
        CONSTRAINT EMP_DNO_FK REFERENCES dept(deptno)
);

-- salgrade ���̺� ����
CREATE TABLE salgrade(
    grade NUMBER(2)
        CONSTRAINT SGRD_GRD_PK PRIMARY KEY,
    losal NUMBER(8)
        CONSTRAINT SGRD_LSAL_NN NOT NULL,
    hisal NUMBER(8)
        CONSTRAINT SGRD_HSAL_NN NOT NULL
);
/*
    dept ���̺� �����͸� �߰��ϴµ�
    10 - ��ȹ��    - ����
    20 - �λ��    - ���ǵ�
    30 - ���ߺ�    - ����
    40 - ȸ���    - ����
    
    �߰����ּ���.
*/
-- �μ��������̺� ������ �Է�
INSERT INTO
    dept  
VALUES(
    10, '��ȹ��', '����'
);

INSERT INTO
    dept  
VALUES(
    20, '�λ��', '���ǵ�'
);

INSERT INTO
    dept  
VALUES(
    30, '���ߺ�', '����'
);

INSERT INTO
    dept  
VALUES(
    40, 'ȸ���', '����'
);

COMMIT;

-- ������� ���̺� ������ �Է�
INSERT INTO
    emp(empno, ename, job, mgr, hiredate, comm, deptno)
VALUES(
    1000, '������', '����', NULL, TO_DATE('2020/07/16', 'YY/MM/DD'), NULL, 10
)
;

SELECT * FROM emp;

INSERT INTO
    emp(empno, ename, job, mgr, hiredate, comm, deptno)
VALUES(
    1001, '���ֿ�', '����', 1000, '2020/07/22', 500, 40
)
;

SELECT * FROM emp;

-- ������ �޿��� �����޿��� 400% �λ��ؼ� �����ϼ���.
UPDATE
    emp
SET
    sal = sal * 4
WHERE
    mgr IS NULL
;

INSERT INTO
    emp
VALUES(
    (SELECT NVL(MAX(empno) + 1, 1000) FROM emp),
    '������', '�м�����', 1001, SYSDATE, 5000000, 450, 30
);


--------------------------------------------------------------------------------------
/*
    ���� ���� ]
        
        �Խ��� ���̺��� �����ϼ���.
        �Խ����� ����� ���� ������� �����ϱ�� �Ѵ�.
        
        �ۼ����̺� ]
            ȸ�����̺�
            �ƹ�Ÿ���̺� - �ƹ�Ÿ��ȣ, �ƹ�Ÿ�����̸�, �ƹ�Ÿ����
            �Խ������̺�
        
        �ۼ����� ]
            ER MODEL
            ERD
            ���̺� ����
            DDL ��� SQL
            ������ �Է� DML ��� SQL ����
*/










