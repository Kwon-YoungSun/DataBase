-- Ʈ������ : ����Ŭ���� �۾��� ó���ϱ� ���� �۾��� ����
-- ������ : �÷��� ���� �� �ִ� �Ӽ����� ����

-- scott ������ ������ �ִ� emp ���̺��� �����ؼ� tmp01 ���̺��� �����.

CREATE TABLE tmp01
AS
    SELECT
        *
    FROM
        scott.emp
;


SELECT * FROM tmp01;

-- tmp01�� �����͸� ��� �����Ѵ�.
DELETE FROM tmp01;

rollback;

SELECT * FROM tmp01;

TRUNCATE table tmp01;

SELECT * FROM tmp01;

rollback;

SELECT * FROM tmp01;

----------------------------------------------------------------------------------------------------

/*
    DDL ���
*/

-- 1. ���̺� �����
/*
        ���� 1 ] - �������� ���� �÷��� ����� ���
        
            CREATE TABLE ���̺��̸�(
                �ʵ��̸�    ������Ÿ��(����),
                �ʵ��̸�    ������Ÿ��(����),
                ...
            );
        
        ���� 2 ] - ���������� �߰��ؼ� ����� ���
        
            CREATE TABLE ���̺��̸�(
                �ʵ��̸�    ������Ÿ��(����)
                    CONSTRAINT  ���������̸�  ��������
                    CONSTRAINT  ���������̸�  ��������,
                �ʵ��̸�    ������Ÿ��(����)
                    CONSTRAINT  ���������̸�  ��������,
                    CONSTRAINT  ���������̸�  ��������,
                    ...
            );
*/

-- DEFAULT

CREATE TABLE AVT
AS
    SELECT
        *
    FROM
        free.avatar
    WHERE
        1 = 2
;
drop table avt;

/*
        ��ó�� �÷��� �ΰ� �Է� ó���� ���� �������� ������
        null �����Ͱ� �ԷµǴ� ���� ����� �ȴ�.
*/

/*
        ���̺� �����ؿ� �� not null �������� �̿���
        �⺻Ű, ����ũ, üũ ���� ���������� �����ؿ��� �ʴ´�.
*/

------------------------------------------------------------------------------------------------
/*
        ���� ]
            DDL ��� - ������ ���� ��� : �����ͺ��̽��� ��ü�� �ٷ�� ���
        
        ���̺� ����
                
            1. �÷� �߰�
                
                ���� ]

                    ALTER TABLE ���̺��̸�
                    ADD (
                        �ʵ��̸�    ������Ÿ��(����),
                        �ʵ��̸�    ������Ÿ��(����),
                        ...
                    );
            
            2. �÷��̸� ����
                
                ���� ]
                    
                    ALTER TABLE ���̺��̸�
                    RENAME COLUMN   �����̸�    TO     �ٲ��̸�;
                    
            3. ������ ����
            
                ���� ]
                    
                    ALTER TABLE
                        ���̺��̸�
                    MODIFY  �����ʵ��̸�  ������Ÿ��(����);

            4. �ʵ����
            
                ���� ]
                    
                    ALTER TABLE
                        ���̺��̸�;
                    DROP COLUMN �ʵ�(�÷�)�̸�;
                    
*/

-- ���� ]     ano�� ���̸� ���� 2�ڸ��� �����ϼ���.
ALTER TABLE
    avt
MODIFY ano NUMBER(2);       -- �����Ͱ� ���� ��쿡�� ����

-- ���ڸ����� ����� �÷����� ����
-- 100, 101

-------------------------------------------------------------------------------------------------------------
/*
        4. ���̺��̸� ����
            
                ���� ]
                    
                    ALTER TABLE ���̺��̸�
                    RENAME TO �ٲ����̺��̸�;
*/

/*
        ���̺� �����ϱ�
        
        4. DROP
        
            ���� ]
            
                DROP    �����Ұ�ü����    ��ü�̸�;
                
            �� ]
                DROP TABLE AVT01;
                
            ���� 2 ]
            
                DROP    TABLE   ���̺��̸�   purge; ==> �����뿡 �����ʰ� ���� �����ϼ���.
*/

-- user01 �̶�� ������ ������.
CREATE USER user01 IDENTIFIED BY ABCD;

DROP USER user01;

CREATE USER user01 IDENTIFIED BY ABCD;

ALTER USER user01 IDENTIFIED BY user ACCOUNT UNLOCK;
/*
        IDENTIFIED BY - ��й�ȣ �����ϴ� ���
        ACCOUNT UNLOCK - ���� ��� �������
*/

--------------------------------------------------------------------------------------------------------

/*
    ���� ]
        ����Ŭ�� 10G���� ������ ������ �̿��ؼ�
        ������ ���̺��� �����뿡 �����ϵ��� �� ���Ҵ�.
        
        ������ ����
        
            1. �����뿡 �ִ� ��� ���̺� ���� �����
                
                purge recyclebin;
                
            2. �����뿡 �ִ� Ư�� ���̺� ���� �����ϱ�
                
                purge table ���̺��̸�;
            
            3. ������ Ȯ���ϱ�
                
                show RECYCLEBIN;
                
            4. �����뿡 ���� ���̺� �����ϱ�
                
                FLASHBACK   TABLE   ���̺��̸�   TO BEFORE DROP;
*/
-- 1.
purge recyclebin;


-- 2.

-- avatar ���̺��� �����ؼ� avt01 ���̺��� ����� �ٷ� �����Ѵ�.
CREATE TABLE
    avt01
AS
    SELECT
        *
    FROM
        free.avatar;

-- �����뿡�� avt01 ���̺��� ���� �����Ѵ�.
DROP TABLE avt01;

-- ������ ����
SHOW RECYCLEBIN;

-- ���� �����ϱ�
PURGE TABLE AVT01;

-- �����ϱ�
CREATE TABLE
    avt01
AS
    SELECT
        *
    FROM
        free.avatar;

DROP TABLE avt01;

FLASHBACK TABLE avt01 TO BEFORE DROP;

-- ALTER ���, DROP ��� ���ַ� ����.

-----------------------------------------------------------------------------------------------------------------------------
/*
        ���� ����(���Ἲ üũ)
        ==> �����ͺ��̽��� ���α׷��� ���꿡�� �۾��� �� �ʿ��� �����͸� �������ִ� ���� ���α׷��̴�.
                ���� �����ͺ��̽��� ���� �����ʹ� �Ϻ���(������ ����) ������ ���� �Ѵ�.
                ������ �����͸� �Է��ϴ� ���� ����� ���̰�
                ���� �Ϻ��� �����͸� ������ �� ���� �ȴ�.
                
                ������ ���̺� ������ �ȵ� �����ͳ�? ������ �ȵǴ� ������ ���� �̸� ������ �������ν�
                �����͸� �Է��ϴ� ����� �߸� �Է��ϸ�
                �� �����ʹ� �ƿ� �Է��� ��Ű�� ���ϵ��� �����ϴ� ������ �ϴ� ����̴�.
                
                ==> �����ͺ��̽��� �̻������� ������ �������� �ϴ� �۾�
                
                ���� �� ����� �ݵ�� �ʿ��� ����� �ƴϴ�.
                (�Է��ϴ� ����� ���������� �Է��ϸ� �ذ�ȴ�.)
                �Ǽ��� �̿��� ������ �� �ֵ��� �ϴ� ����̴�.
                
                ���� ]
                    
                    NOT NULL
                        ==> �� ���� ������ ������ �ʵ�� �ݵ�� �����Ͱ� �����ؾ� �ϴ� �ʵ����� ������ ��.
                                �� ���Ἲ üũ�� �ִ� �ʵ忡 �����Ͱ� �Է��� ���� ������
                                �Է��� �� ���� �����͸� ��� �Է��� �� ���� �ȴ�.
                                
                    UNIQUE
                        ==> �� ���� ������ ������ �ʵ�� �ٸ� �����Ϳ� �ݵ�� ���� �� �� �־�� �Ѵ�.
                                ��, �ش� �ʵ��� ���� �ٸ� ���� �ش� �ʵ��� ���� ������ �Ǿ�� �Ѵ�.
                                ���� ���� �����Ͱ� �Էµ��� ���ϵ��� ���� ����� ������ �ִ�.
                                
                    PRIMARY KEY
                        ==> NOT NULL + UNIQUE
                                ���̺��� �ϳ��� �÷����� �ο����� �� �ִ� ��������
                                
                    FOREIGN KEY
                        ==> �ٸ� ���̺��� �⺻Ű(PRIMARY KEY) �Ǵ� ����Ű(UNIQUE)�� �����ؾ߸� �ϴ� ��������
                                �����ϴ� ���̺��� ������ �̿��� �����Ͱ� �ԷµǴ� ���� �����ϴ� ���
                                
                                ���� ]
                                    ���̺��� ������ ���� �����ϴ� �����Ͱ� �ִ� ���̺��� ���� ��������� �Ѵ�.
                                
                                ���� ������ �÷� : �⺻Ű, UNIQUE ���������� �����Ǿ��ִ� �÷�    
                    
                    CHECK
                        ==> �����Ͱ� �̸� ���س��� �����͸� �Է��� �� �ֵ��� �ϴ� ��������
                                
                                            
*/

-- ����Ű ��������( ==> SCOTT �������� �׽�Ʈ)
INSERT INTO
    emp(empno, ename, deptno)
VALUES(
    (SELECT NVL(MAX(empno) + 1, 1000) FROM emp),
    'hong', 50
);
rollback;

-- hello �������� �׽�Ʈ

-------------------------------------------------------------------------------------------------------------------------------
/*
        ���� ���� �����ϴ� ���
        
            1. ���̺��� ���鶧 �����ϴ� ���
            
                1) ���� �������� �������
                        ==> ����Ŭ�� �ʵ忡 ���������� ������ �� �̸��� ���� ������ ������
                                ����Ŭ�� ����� �̸��� �����ϰ� �Ǿ��ִ�.
                    
                    ���� ]
                        
                        CREATE TABLE ���̺��̸�(
                            �ʵ��̸� Ÿ��(����) ��������,
                            ...
                        );
                2) ����� �������� �������(<== ������)
*/

-- ���� �������� �߰�

CREATE TABLE ABC(
    ano number(2) PRIMARY KEY,
    name VARCHAR2(10 CHAR) NOT NULL
);

INSERT INTO abc(ano)
VALUES(
    10
);

INSERT INTO abc
VALUES(
    10, 'abc'
);

INSERT INTO abc
VALUES(
    10, 'abc'
);

/*
            2) ����� �������� �������(<== ������)
            
                ���� 1 ]
                    CREATE TABLE    ���̺��̸�(
                            �ʵ��̸�    Ÿ��(����)
                                CONSTRAINT ���������̸�   ��������
                                CONSTRAINT ���������̸�   ��������
                                ...
                            �ʵ��̸�    Ÿ��(����)
                                CONSTRAINT ���������̸�   ��������
                                CONSTRAINT ���������̸�   ��������,
                            ...
                    );
                
                ���� 2 ]
                    CREATE TABLE    ���̺��̸�(
                            �ʵ��̸�    Ÿ��(����),
                            �ʵ��̸�    Ÿ��(����),
                            ...
                            CONSTRAINT ���������̸�   ��������(�ʵ��̸�)
                    );
*/

DROP TABLE abc;

-- ����� ��������
-- ���� 1
CREATE TABLE ABC(
    ano NUMBER(4)
        CONSTRAINT ABC_NO_PK    PRIMARY KEY,
    name VARCHAR2(10 CHAR)
        CONSTRAINT ABC_NAME_NN  NOT NULL
);


INSERT INTO abc(ano)
VALUES(
    10
);

INSERT INTO abc
VALUES(
    10, 'abc'
);

DROP TABLE abc;

-- ���� 2
CREATE TABLE ABC(
    ano NUMBER(4),
    name VARCHAR2(10 CHAR)
        CONSTRAINT ABC_NAME_NN  NOT NULL,
    CONSTRAINT ABC_NO_PK    PRIMARY KEY(ano)
);

/*
        2. �̹� ������� ���̺��� ���������� �߰��ϴ� ���
        
            ���� 1 ]  ����� �������� ���
                ALTER TABLE ���̺��̸�
                ADD CONSTRAINT ���������̸�   ��������(�ʵ��̸�);
                
                
            ���� 2 ]  ���� �������� ���
                ALTER TABLE ���̺��̸�
                ADD     ��������(�ʵ��̸�);
*/

CREATE TABLE ABC(
    ano NUMBER(4),
    name VARCHAR2(10 CHAR),
    tel VARCHAR2(13 CHAR)
);
-- ����� �������� �߰�
ALTER TABLE abc
ADD CONSTRAINT ABC_NO_PK PRIMARY KEY(ANO);

-- ���� �������� �߰�
ALTER TABLE abc
ADD UNIQUE(tel);

/*
        ***
        ���� ]
            NOT NULL ���������� ���̺��� ������� �Ŀ� �߰��ϴ� ������ �ƴϰ�
            ���̺��� ������ �����ϴ� �����̴�.
        
            �ֳ��ϸ� NOT NULL�� ���������� ������� ������
            ����� �ȵ� ���� �ƴϰ�
            NULL�� ����ϴ� ������������ ����� �� �����̴�.
            
            ���� NOT NULL�� �ʵ��� �Ӽ��� �����ϴ� ������� ���������� �����ؾ� �Ѵ�.
*/

ALTER TABLE abc
MODIFY name
CONSTRAINT ABC_NAME_NN NOT NULL; 

/*
    ��ϵ� �������� Ȯ���ϴ� ���
    ==> ��ϵ� ���� ������ ����Ŭ�� ���̺��� �̿��ؼ� �����ϰ� �ִ�.
            �� ���̺��� �̸���
                USER_CONSTRAINTS
            ��� ���̺��̴�.
            
    ���� ]
            CONSTRAINT_TYPE �� ����
            
                P       - PRIMARY KEY
                R       - FOREIGN KEY
                U       - UNIQUE
                C       - CHECK �Ǵ� NOT NULL
*/

SELECT
    CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM
    user_constraints
WHERE
    table_name = 'ABC'
;

------------------------------------------------------------------------------------------------------------------------

/*
    �������� �����ϴ� ���
        ���� ]
            
            ALTER TABLE ���̺��̸�
            DROP CONSTRAINT ���������̸�;
           
        ���� ]
            �⺻Ű(PRIMARY KEY)�� ��� ���������� �̸��� ���� ������ �� �ִ�.
            <== �⺻Ű�� �� ���̺� �Ѱ��� �����ϱ� ������
            
            ���� ]
            
                ALTER TABLE ���̺��̸�
                DROP PRIMARY KEY;
*/

ALTER TABLE abc
DROP PRIMARY KEY;

SELECT
    *
FROM
    USER_CONSTRAINTS
WHERE
    TABLE_NAME = 'ABC'
;


INSERT INTO ABC
VALUES(
    10, 'RED'
);

INSERT INTO ABC
VALUES(
    11, 'GREEN'
);

INSERT INTO ABC
VALUES(
    12, 'BLUE'
);


ALTER TABLE ABC
DROP COLUMN TEL;


COMMIT;

/*
        �������� �̸� ����� ��Ģ
            
                [ �����̸�_ ]���̺��̸�_�ʵ��̸�_��������
                
                �� ]
                    ABC_NO_PK
                    
*/
ALTER TABLE ABC
ADD CONSTRAINT ABC_NO_PK   PRIMARY KEY(ano);

ALTER TABLE ABC
ADD CONSTRAINT ABC_NAME_UK UNIQUE(name);

CREATE TABLE kcolor(
    kno NUMBER(3)   -- �⺻Ű
        CONSTRAINT KCLR_NO_PK PRIMARY KEY,
    cname VARCHAR2(10 CHAR)
        CONSTRAINT KCLR_NAME_NN NOT NULL,
    rcode NUMBER(2)
        CONSTRAINT KCLR_CODE_FK REFERENCES abc(ano)
);