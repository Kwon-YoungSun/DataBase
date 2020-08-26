-- ����ó���Լ��� ����ؼ� �ذ��ϼ���.

/*
    ������� ������ �츮���� ��ȸ�ϼ���.
        
        MANAGER - ������
        SALESMAN - ������
        CLERK   - ���
        ANALYST - �м���
        PRESIDENT - ����
        
*/
SELECT
    ename ����̸�,
    /*
    DECODE(job, 'MANAGER', '������',
                'SALESMAN', '������',
                'CLERK', '���',
                'ANALYST', '�м���',
                'PRESIDENT', '����') ����
    */
    
    /*
    CASE WHEN job = 'MANAGER' THEN '������'
         WHEN job = 'SALESMAN' THEN '������'
         WHEN job = 'CLERK' THEN '���'
         WHEN job = 'ANALYST' THEN '�м���'
         WHEN job = 'PRESIDENT' THEN '����'
    END ����
    */
    
    CASE job WHEN 'MANAGER' THEN '������'
             WHEN 'SALESMAN' THEN '������'
             WHEN 'CLERK' THEN '���'
             WHEN 'ANALYST' THEN '�м���'
             WHEN 'PRESIDENT' THEN '����'
    END ����
FROM
    emp
;

/*
    2. �� �μ����� ���ʽ��� �ٸ��� �����ؼ� �����Ϸ��Ѵ�.
        
        10 - �޿��� 10%
        20 - �޿��� 15%
        30 - �޿��� 20%
        �� ����Ŀ�̼ǿ� ���ؼ� �����Ϸ��� �Ѵ�.
        ���� Ŀ�̼��� ���� ����� 0���� �ؼ� ����ϱ�� �ϰ�
        ����� �̸�, �޿�, ����Ŀ�̼�, ����Ŀ�̼�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�,
    sal �޿�,
    comm ����Ŀ�̼�,
    
    /*
    CASE deptno WHEN 10 THEN sal*1.1 + NVL(comm, 0)
                WHEN 20 THEN sal*1.15 + NVL(comm, 0)
                WHEN 30 THEN sal*1.2 + NVL(comm, 0)
    END ����Ŀ�̼�
    */
    
    DECODE(deptno, 10, sal*1.1 + NVL(comm, 0),
                   20, sal*1.15 + NVL(comm, 0),
                   30, sal*1.2 + NVL(comm, 0)) ����Ŀ�̼�
    
FROM
    emp
;

/*
    3. �Ի�⵵�� ��������
        80 - 'A'
        81 - 'B'
        82 - 'C'
        �� �̿��� �ؿ� �Ի��� ������ 'D' �������
        
        �������
            ����̸�, �Ի���, ������
        �� ��ȸ�ϼ���.
*/  
SELECT
    ename ����̸�, hiredate �Ի���,
    /*
    DECODE(TO_CHAR(hiredate, 'YY'), '80', 'A',
                                    '81', 'B',
                                    '82', 'C',
                                          'D' ) ������
    */
    
    CASE TO_CHAR(hiredate, 'YY') WHEN '80' THEN 'A'
                                 WHEN '81' THEN 'B'
                                 WHEN' 82' THEN 'C'
                                 ELSE 'D'
                                 END ������
FROM
    emp
;

/*
    4. ����� �̸��� 4�����̸� 'Mr.' �� �̸� �տ� ���̰�
        4���ڰ� �ƴϸ� �̸� �ڿ� '���'�� �ٿ��� ��ȸ�Ϸ��� �Ѵ�.
        �������
        �����ȣ, ����̸�, ����̸����ڼ�
        �� ��ȸ�ϼ���.
*/
SELECT
    empno �����ȣ,
    /*
    CASE WHEN LENGTH(ename) = 4 THEN 'Mr. ' || ename
         ELSE ename || ' ���'
    END ����̸�,
    LENGTH(ename) ����̸����ڼ�
    */
    
    DECODE(LENGTH(ename), 4, 'Mr.' || ename,
            ename || '���') ����̸����ڼ�
FROM
    emp
;
/*
    5. �μ���ȣ�� 10 �Ǵ� 20�̸� �޿� + Ŀ�̼��� ����� ����ϼ���.
        (Ŀ�̼��� ������ 0���� ���)
        �� �̿��� �μ��� �޿��� ����ϵ��� ���� ����� �ۼ��ؼ�
        
        ����̸�, �μ���ȣ, �޿�, Ŀ�̼�, ���ޱݾ�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, deptno �μ���ȣ, sal �޿�, comm Ŀ�̼�,
    /*
    CASE WHEN deptno IN(10,20) THEN sal + NVL(comm, 0)
         ELSE sal
    END ���ޱݾ�
    */
    
    DECODE(deptno, 10, sal + NVL(comm,0),
                   20, sal + NVL(comm,0),
                   sal) ���ޱ޾�
FROM
    emp
;

/*
    6. �Ի��� ������ �����, �Ͽ����� ������� �޿��� 20% �����ؼ� �����ϰ�
        �� �̿��� ����� 10% �����ؼ� �����Ϸ��Ѵ�.
        
        �������
            ����̸�, �Ի���, �Ի����, �޿�, ���޿�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, hiredate �Ի���, TO_CHAR(hiredate, 'DAY') �Ի����,
    sal �޿�,
    /*
    CASE WHEN TO_CHAR(hiredate, 'DAY') IN('�����', '�Ͽ���') THEN sal*1.2
         ELSE sal * 1.1
    END ���޿�
    */
    DECODE(TO_CHAR(hiredate, 'DAY'), '�����', sal*1.2,
                                     '�Ͽ���', sal*1.2,
                                               sal*1.1) ���޿�
FROM
    emp
;
/*
    7. �ٹ��������� 470���� �̻��̸� Ŀ�̼��� 500 �߰��ؼ� �����ϰ�(Ŀ�̼��� ������
        0���� ���)
        �ٹ��������� 470���� �̸��̸� Ŀ�̼��� ���� Ŀ�̼Ǹ� �����ϵ��� �Ϸ��Ѵ�.
        �������
            ����̸�, Ŀ�̼�, �Ի���, �Ի簳����, ����Ŀ�̼�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, comm Ŀ�̼�, hiredate �Ի���, FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) �ٹ�������,
    CASE WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) >= 470 THEN NVL(comm, 0) + 500
         ELSE NVL(comm, 0)
    END ����Ŀ�̼�
 
FROM
    emp
;
/*
    8. �̸��� ���ڼ��� 5���� �̻��� ����� �̸��� 3����**�� ���̰�
        4���� ������ ����� �̸��� �״�� ��ȸ�Ϸ��� �Ѵ�.
        
        �������
            ����̸�, �̸����ڼ�, �����̸�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, LENGTH(ename) �̸����ڼ�,
    CASE WHEN LENGTH(ename) >= 5 THEN RPAD(SUBSTR(ename, 1, 3), LENGTH(ename), '*')
         ELSE ename
    END �����̸�
FROM
    emp
;

----------------------------------------------------------------------------------------
-- day04

/*
    �׷��Լ�
    ==> �������� �����͸� �ϳ��� ���� ������ ����ϴ� �Լ�
    
    ***
    ����
        �׷��Լ��� ���� ����� �Ѱ��� ������ �ȴ�.
        ���� �׷��Լ��� ����� ������ ������ ���� ȥ���ؼ� ����� �� ����.
        ( ==> �ʵ�, ������ �Լ��� ���� ����� �� ����.)
        ���� ����� �������θ� ������ �Ͱ��� ȥ���� �� �ִ�.
        �׷��Լ��͸� ���� ����� �� �ִ�.
*/

SELECT ename FROM emp; -- 14���� ����� ��ȸ

SELECT SUM(sal) �޿����� FROM emp; -- �Ѱ��� ����� ��ȸ

SELECT ename, SUM(sal) FROM emp; -- ����� �� ����.

SELECT
    ename, SUM(sal)
FROM
    emp
WHERE
    ename = 'SMITH'
;   ------------------------------ ���� ����� �� ����.

/*
    1. SUM
        ==> �������� �հ踦 ��ȯ���ִ� �Լ�
        
        ���� ]
            SUM(�ʵ��̸�)
*/

SELECT
    SUM(sal) �޿��հ�
FROM
    emp
WHERE
    deptno = 10 --------------------- 10�� �μ� ������� �޿� �հ�
;

SELECT deptno, sal, empno FROM emp;

/*
    2. AVG
        ==> �������� ����� ���ϴ� �Լ�
        
        ���� ]
            AVG(�ʵ��̸� Ȥ�� �����)
        
        ���� ]
            NULL �����ʹ� ����� ����ϴ� �κп��� ������ ���ܵȴ�.
*/
SELECT
    SUM(sal) �޿��հ�, FLOOR(AVG(sal)) �޿����
FROM
    emp
;

SELECT
    SUM(comm) Ŀ�̼��հ�, FLOOR(AVG(comm)) Ŀ�̼���� -- NULL �����ʹ� �ǳʶڴ�.
FROM
    emp
;

/*
    ����� 550�� Ŀ�̼��� �ִ� ������� �հ踦 Ŀ�̼��� �ִ� ������� ���� ������̴�.
    ������ null�� ��� ���꿡�� ���ܰ� �Ǳ� �����̴�.
    ������� ī��Ʈ ���� �ʴ´�.
*/
-- Ŀ�̼��� �ִ� �����
SELECT
    COUNT(*) Ŀ�̼��ִ»����
FROM
    emp
WHERE
    comm IS NOT NULL
;

SELECT
    COUNT(comm) Ŀ�̼��ִ»����
FROM
    emp
;

/*
    3. COUNT
        ==> ������ �ʵ� �߿��� �����Ͱ� �����ϴ� �ʵ��� ������ ��ȯ���ִ� �Լ�
        
        �� ]
            ����߿��� Ŀ�̼��� �޴� ����� ���� ��ȸ
            SELECT COUNT(comm) FROM emp;
        
        ���� ]
            �ʵ��̸� ��ſ� * �� ����ϸ�
            ������ �ʵ��� ī��Ʈ�� ���� ���� ��
            �� ����߿��� ���� ū���� �˷��ְ� �ȴ�.
*/

-- ����� ��簡 �����ϴ� �����
SELECT COUNT(mgr) FROM emp;

-- ������� ��ȸ�ϼ���.
SELECT COUNT(*) FROM emp;

/*
    4. MAX / MIN
        ==> ������ �ʵ��� ������ �߿��� ���� ū �Ǵ� ���� �����͸� ��ȯ���ִ� �Լ�
*/

-- ����� �޿��� �ְ�޿��ڿ� �ּұ޿����� �޿��� ��ȸ�ϼ���.
SELECT
    MAX(sal) �ְ�޿�, MIN(sal) �ּұ޿�
FROM
    emp
;

/*
    (�� ������ �����Ƿ� ���� �� ����.)
    
    5. STDDEV    ==> ǥ�������� ��ȯ���ش�.
                     ǥ�� ����(standard deviation)�� �л��� �������� ���̴�.
                     
    6. VARIANCE  ==> �л��� ��ȯ���ش�.
                     �� �����͵��� ��հ��� ���� ���� ���
*/

-- ���� ] ������� ������ �������� ��ȸ�ϼ���.
SELECT COUNT(DISTINCT job) FROM emp;

----------------------------------------------------------------------------------------
/*
    GROUP BY
    ==> �׷��Լ��� ����Ǵ� �׷��� �����ϴ� ��
    
    �� ]
        �μ����� �޿��� �հ踦 ���ϰ��� �Ѵ�.
        ���޺��� �޿��� ����� ��ȸ�ϰ��� �Ѵ�.
        
    ���� ]
        SELECT
            �׷��Լ�, �׷�����ʵ�
        FROM
            ���̺��̸�
        [WHERE
            ]
        GROUP BY
            �ʵ��̸�
        [ORDER BY
            ]    
        ;
*/
SELECT
    deptno �μ���ȣ, SUM(sal) �μ��޿��հ�
FROM
    emp
GROUP BY
    deptno
--ORDER BY
--    deptno ASC
;

SELECT
    job ����, ROUND(AVG(sal), 2) ���ޱ޿����
FROM
   emp 
GROUP BY
    job
--ORDER BY
--    job ASC
;

-- ���޺� �����, �޿��Ѿ�, �޿������ ��ȸ�ϼ���.
SELECT
    job ����, COUNT(*) �����, SUM(sal) �޿��Ѿ�, ROUND(AVG(sal), 2) �޿����
FROM
    emp
GROUP BY
    job
;

--------------------------------------------------------------------------------
/*
    1. �� �μ����� �ּ� �ݾ��� ��ȸ�ϼ���.
*/
SELECT
    deptno �μ���, MIN(sal) �ּұݾ�
FROM
    emp
GROUP BY
    deptno
;

/*
    2. �� ��å�� �޿��� �Ѿװ� ��ձݾ��� ��ȸ�ϼ���.
*/
SELECT
    job ��å,
    SUM(sal) �޿��Ѿ�, ROUND(AVG(sal), 2) ��ձݾ�
FROM
    emp
GROUP BY
    job
;
/*
    3. �Ի� �⵵���� ��� �޿��� �ѱ޿��� ��ȸ�ϼ���.
        �Ի�⵵, ��ձ޿�, �ѱ޿�
*/
SELECT
    TO_CHAR(hiredate, 'YYYY') || ' ��' �Ի�⵵, ROUND(AVG(sal), 2) ��ձ޿�, SUM(sal) �ѱ޿�
FROM
    emp
GROUP BY
    TO_CHAR(hiredate, 'YYYY')
;

/*
    4. �� �⵵�� �Ի��� ������� ��ȸ�ϼ���.
        �Ի�⵵, �����
*/
SELECT
    TO_CHAR(hiredate, 'YYYY') || ' ��' �Ի�⵵, COUNT(*) || ' ��' �����
FROM
    emp
GROUP BY
    TO_CHAR(hiredate, 'YYYY')
;

/*
    5. ����̸��� ���ڼ��� 4, 5���� ����� ���� ��ȸ�ϼ���.
        ��, ����̸� ���ڼ��� �׷�ȭ�ؼ� ��ȸ�ϼ���.
*/
SELECT
    LENGTH(ename) || ' ��' �̸����ڼ�, COUNT(*) || ' ��' �����
FROM
    emp
WHERE
    LENGTH(ename) IN (4, 5)
GROUP BY
    LENGTH(ename)
;
/*
    6. 81�⵵�� �Ի��� ����� ���� ��å���� ��ȸ�ϼ���.
*/
SELECT
    job ��å, COUNT(*) || ' ��' �����
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'YY') = '81'
GROUP BY
    job
;
--------------------------------------------------------------------------------
/*
    HAVING
    ==> GROUP BY ���� �׷�ȭ�� ��� ���� �׷��߿���
        ��ȸ����� ����� �׷��� �����ϴ� ���ǽ�
        
    **
    ���� ]
        WHERE ������ ��꿡 ���Ե� �����͸� �����ϴ� �������̰�
        HAVING ������ ����� ���� �� ��ȸ ����� �������� ������ �����ϴ� �������̴�.
*/

SELECT
    job ����, count(*) ������
FROM
    emp
WHERE
    deptno = 10
GROUP BY
    job
;

-- �μ����� ��� �޿��� ����ϼ���.
-- ��, �� �μ��� ��ձ޿��� 2000 �̻��� �μ��� ��ȸ�ϼ���.
SELECT
    deptno �μ���ȣ,
    ROUND(AVG(sal), 2) ��ձ޿�
FROM
    emp
GROUP BY
    deptno
HAVING
    AVG(sal) >= 2000
;

-- ���޺��� ������� ��ȸ�ϼ���.
-- ��, ������� 1���� ������ �����ϰ� ��ȸ�ϼ���.
SELECT
    job ����, COUNT(*) �����
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(*) <> 1
;

---------------------------------------------------------------------------------
/*
    7. ����̸��� ���̰� 4, 5������ ����� ���� �μ����� ��ȸ�ϼ���.
        ��, ������� �ѻ�� �̸��� �μ��� �����ϰ� ��ȸ�ϼ���.
*/
SELECT
    deptno �μ���, COUNT(*) || ' ��' �����
FROM
    emp
WHERE
    LENGTH(ename) IN (4, 5) -- ����̸��� 4,5����
GROUP BY
    deptno -- �μ��� �׷�ȭ
HAVING
    COUNT(*) >= 1 -- ������� �ѻ�� �̻�
;
/*
    8. 81�⵵ �Ի��� ����� ��ü �޿��� ��å���� ��ȸ�ϼ���.
        ��, ���޺� ��ձ޿��� 1000 �̸��� ������ ��ȸ���� �����ϼ���.
*/
SELECT
    job ���޸�, SUM(sal) ��ü�޿� -- ��ü �޿���
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'YY') = 81 -- 81�⵵ �Ի��� �����
GROUP BY
    job -- ��å���� ��ȸ�ϼ���.
HAVING
    AVG(sal) >= 1000 -- ���޺� ��ձ޿��� 1000 �̸��� ������ ��ȸ���� �����ϼ���.
;
/*
    9. 81�⵵ �Ի��� ����� �� �޿��� ����� �̸� ���ڼ����� �׷�ȭ�ϼ���.
        ��, �� �޿��� 2000 �̸��� ���� �����ϰ�
        �ѱ޿��� ���� �������� ���� ������ ������������ �����ؼ�
        ��ȸ�ϼ���.
*/
SELECT
    LENGTH(ename) �̸�����, SUM(sal) �ѱ޿�
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'YY') = '81' -- 81�⵵ �Ի��� �����
GROUP BY
    LENGTH(ename) -- ����� �̸� ���ڼ����� �׷�ȭ�ϼ���.
HAVING
    SUM(sal) >= 2000 -- �� �޿��� 2000 �̸��� ���� �����ϰ�
ORDER BY
    SUM(sal) DESC -- �� �޿��� ���� �������� ���� ������ ������������ �����ؼ� ��ȸ�ϼ���.
;

/*
    10. ����� �̸����ڼ��� 4, 5 �� ����� �μ��� ������� ��ȸ�ϼ���.
        ��, ������� 0���� ���� �����ϰ� 
        �μ���ȣ ������������ �����ؼ� ��ȸ�ϼ���.
*/
SELECT
   deptno �μ���ȣ, COUNT(*) || '��'����� -- ��� ���� ��ȸ�ϼ���.
FROM
    emp
WHERE
    LENGTH(ename) IN(4,5) -- ����� �̸����ڼ��� 4, 5�� �����
GROUP BY
    deptno  -- �μ���
HAVING
    COUNT(*) <> 0 -- ��, ������� 0���� ���� �����ϰ�
ORDER BY
    deptno ASC -- �μ���ȣ ������������ �����ؼ� ��ȸ�ϼ���.
;
/*
    EXTRA ]
        �μ����� �޿��� ��ȸ�ϴµ�
        10���μ��� ��ձ޿��� ��ȸ�ϰ�
        20���μ��� �޿��հ踦 ��ȸ�ϰ�
        30���μ��� �μ� �ְ�޿��� ��ȸ�ϼ���.
*/
SELECT
    deptno �μ���ȣ,
/*
    CASE WHEN deptno = 10 THEN CONCAT(ROUND(AVG(sal), 2), ' (��ձ޿�)') -- 10���μ��� ��ձ޿��� ��ȸ�ϰ�
         WHEN deptno = 20 THEN CONCAT(SUM(sal), ' (�޿��հ�)') --  20���μ��� �޿��հ踦 ��ȸ�ϰ�
         WHEN deptno = 30 THEN CONCAT(MAX(sal), ' (�μ��ְ�޿�)') --  30���μ��� �μ� �ְ�޿��� ��ȸ�ϼ���.
    END ��ȸ���
*/

/*
    CASE deptno WHEN 10 THEN CONCAT(ROUND(AVG(sal), 2), ' (��ձ޿�)') -- 10���μ��� ��ձ޿��� ��ȸ�ϰ�
         WHEN 20 THEN CONCAT(SUM(sal), ' (�޿��հ�)') --  20���μ��� �޿��հ踦 ��ȸ�ϰ�
         WHEN 30 THEN CONCAT(MAX(sal), ' (�μ��ְ�޿�)') --  30���μ��� �μ� �ְ�޿��� ��ȸ�ϼ���.
    END ��ȸ���
*/

    DECODE(deptno, 10, CONCAT(ROUND(AVG(sal), 2), '(��ձ޿�)'),
                   20, CONCAT(SUM(sal), ' (�޿��հ�)'),
                    CONCAT(MAX(sal), ' (�μ��ְ�޿�)')) ��ȸ���
FROM
    emp
GROUP BY
    deptno -- �μ����� �޿��� ��ȸ�ϴµ�
;

---------------------------------------------------------------------------------------------------------------
/*
    ��������
    ==> ���� ��� �ȿ� �ٽ� ���� ����� ���� �� ���� ��������(��������)�� �Ѵ�.
    
    ���� ]
        ���������� from ���� ��ġ�ϴ� �������Ǹ�
            �ζ��κ�(Inline View)
        ��� �θ���.
        �̶� �� �������Ǵ� ������ ����� ���̺�� ����� �ϰ� �ȴ�.
*/

-- 'SMITH' ����� �Ҽ� �μ��� ������� ������ ��ȸ�ϼ���.
SELECT
    empno, ename, hiredate, deptno
FROM
    emp
WHERE
    deptno = ( SELECT
                    deptno
                FROM
                    emp
                WHERE
                    ename = 'SMITH')
;

SELECT
    dno, max, min, avg, cnt
FROM
    (
        SELECT
            deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
--    dno = 10
--  max = MAX(max) -> ����    
    max = (
            SELECT
                MAX(sal)
            FROM
                emp
            )
;

/*
    ���������� ����� ���� ����
        
        ***
        1. ���������� ��ȸ����� ���� �Ѱ��� �������� ���
            ==> �ϳ��� �����ͷ� ���� �����͸� ����� �� �ִ� ��쿡�� ��� ����Ѵ�.
            
            1) SELECT ��¿� ����� �� �ִ�.
                ***
                �̶� ���������� ��ȸ����� �ݵ�� ������ �����ʵ�� ��ȸ�Ǿ�� �Ѵ�.
                
            2) �������� ����� �� �ִ�.
                
        2. 
*/

-- SMITH ����� ������ ��ȸ�ϴµ�
-- �����ȣ, ����̸�, �޿�, �μ���ȣ, �μ��ְ�޿� �� ��ȸ�ϼ���.

SELECT
    empno, ename, sal, deptno,
    (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE -- deptno�� ����̸��� 'SMITH'�� ����� �μ���ȣ�� ��ȸ��.
           deptno = (
                SELECT
                    deptno
                FROM
                    emp
                WHERE
                    ename = 'SMITH'
           )
    ) �μ��ְ�޿�
FROM
    emp
WHERE
    ename = 'SMITH'
;

-- 10�� �μ� ����� ������ ��ȸ�ϴµ�
-- �����ȣ, ����̸�, �޿�, �μ���ȣ, �μ��ְ�޿� �� ��ȸ�ϼ���.
SELECT
    empno, ename, sal, deptno,
    (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE 
            deptno = 20
    ) �μ��ְ�޿�
FROM
    emp
WHERE
    deptno = 20
;


SELECT
    empno, ename, 100 * 3
FROM
    emp
;

/*
        2. ���������� ����� ���� �̻� ������ ���
            ==> �� ���� ������������ ��밡�� �ϴ�.
                �̶� IN, ANY, ALL, EXIST �����ڸ� ����ؼ� ���������� ó���Ѵ�.
            
            ���� ]
                IN
                    �������� �������� �Ѱ��� ��ġ�ϸ� �Ǵ� ���
                
                ANY
                    �������� �������� �Ѱ��� ������ �Ǵ� ���

                ALL
                    �������� �������� ��� �¾ƾ� �Ǵ� ���
                    
                EXIST
                    �������� �������� �ϳ��� ������ �Ǵ� ���
                    �񱳴���� ���� ����Ѵ�.
                    ���������� ����� �ִ��� �����ķ� �Ǵ��ϴ� ������
*/

-- ������ 'CLEAR'�� ����� ���� �μ��� ���� ����� ������ ��ȸ�ϼ���.
SELECT
    empno, ename, deptno, job
FROM
    emp
WHERE
    deptno IN (
            SELECT
                DISTINCT deptno
            FROM    
                emp
            WHERE
                job = 'CLERK' -- (10, 20, 30)
                AND ename <> 'JAMES' -- (10, 20)
    )
;

SELECT
    *
FROM
    emp
WHERE
    deptno NOT IN (30, 40, 50)
;


-- ����� ������ ��ȸ�ϴµ�
-- ��� �μ��� ��ձ޿����� ���� �޴� ����� ������ ��ȸ�ϼ���.
/*
SELECT
    *
FROM
    emp
WHERE
    sal > ALL (
                SELECT
                    AVG(sal)
                FROM
                    emp
                GROUP BY
                    deptno
          ) -- ==> (???, ???, ???)
;
*/

SELECT
    *
FROM
    emp
WHERE
    sal > (
                SELECT
                    MAX(avg)
                FROM
                    (
                        SELECT
                            AVG(sal) avg
                        FROM
                            emp
                        GROUP BY
                            deptno
                    )
                
          )
;

-- �� �μ��� ��ձ޿��� �ϳ��� ���� �޴� ����� ������ ��ȸ�ϼ���.
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
                SELECT
                    AVG(sal)
                FROM
                    emp
                GROUP BY
                    deptno
          ) -- ==> (???, ???, ???)
;

-- All ] ����� �μ���ȣ�� 40�� ����� ������ ��� ����� ������ ��ȸ�ϼ���.
SELECT
    *
FROM
    emp
WHERE
    EXISTS (    -- �񱳴�� ���� ����Ѵ�.
                SELECT
                    *
                FROM
                    emp
                WHERE
                    deptno <> 40
            )
;

--------------------------------------------------------------------------------------
