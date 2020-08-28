-- day05

/*
    JOIN(����)
    ==> �ΰ� �̻��� ���̺� �ִ� ������ ���ÿ� �˻��ϴ� ���
    
    ���� ]
        ����Ŭ�� ER(ENTITY RELATION) ������ �����ͺ��̽���� �Ѵ�.(������ �����ͺ��̽�)
        
        ER ���¶�?
            ��ƼƼ������ �����̼ǽ� ���踦 �̿��ؼ� �����͸� �����Ѵ�.
        
        ���� ��� ���θ����� �ǸŰ����� �ϰ��� �ϸ�
        
        ����      -   �̸�, �ּ�, ��ȭ��ȣ
        ����      -   �ֹ�����  
        ������    -   ��ǰ�̸�, ����, ����ȸ��, ...
        �
        
        �ǿ���     ���ν� ������ 010-6232-6752  20/08/27    �����޽� ���ý���Ʈ��ġ     1
        �����     ����� ���Ǳ� 010-5569-8600  20/08/27    �����޽� ���ý���Ʈ��ġ     3
        ������     ��õ�� ���� 010-3843-4798  20/08/27    LG �׷�  LG ��Ʈ��          1
        ������     ����� ���Ǳ� 010-5569-8600  20/08/26    LG �׷�  LG ��Ʈ��          5
        
        ������ �̷��� ������ ���ƾ� �ϴµ�...
        �ߺ� �����ʹ� �ٸ� ���̺�� �����ϵ��� �Ѵ�.
        
        ��������    --------->  ��ƼƼ
            �ǿ��� �����޽�     1   20/08/27
            ����� �����޽�     3   20/08/27
            ������ �׷�         1   20/08/27
            ������ �׷�         5   20/08/26
        
        
        ����������
            �ǿ���     ���ν� ������ 010-6232-6752
            �����     ����� ���Ǳ� 010-5569-8600  
            ������     ��õ�� ���� 010-3843-4798
            ������     ����� ���Ǳ� 010-5569-8600  
        
        ��ǰ����
            �����޽� ���ý���Ʈ��ġ
            LG �׷�   LG ��Ʈ��
        
        �� ���·� �и��ؼ� �����Ѵ�.
    
        ���� ]
            ����Ŭ�� ó������ �������� ���̺��� ���ÿ� �˻��ϴ� ����� �̹� ������ �ִ�.
            ==> ��ó�� �ΰ� �̻��� ���̺��� ���ÿ� �˻��ϸ�
                Cartesian Product �� ��������� �� ����� �˻��ϰ� �ȴ�.
                
        �����̶�?
            Cartesian Product �� ���ؼ� ź���� ����� �߿���
            ���ϴ� ������� �̾Ƴ��� ���
        
    1. Inner Join   -- cartesian product �� ��� ���� �ȿ��� �����͸� �����ϴ� ����
        ==> ���� �Ϲ����� ���� ���
            �ΰ��� ���̺� �߿��� ���� �����͸� ��� ��ȸ�ϴ� ����
        
        ���� ]
            SELECT
                ��ȸ�ʵ�, ....
            FROM
                ���̺�1, ���̺�2, ...
            WHERE
                �������ǽ�
            ;
            
        1) Equi Join
            --> ����� �����ڷ� �����͸� �����ϴ� ����
        
        2) Non-Equi Join
            --> ����� �����ڰ� �ƴ� �����ڷ� �����͸� �����ϴ� ����
                
        
    2. Outer Join   -- cartesian product �� ��� ���� �ȿ� ���� �����͸� �����ϴ� ����
        ������� ���� ���� �����͸� ����
        
    3. SELF JOIN
        - �ϳ��� ���̺��� ������ �����ؼ� ���ϴ� �����͸� ��ȸ�ϴ� ����
    
*/
SELECT
    *
FROM
    emp, dept
;

select * from emp;


SELECT
    *
FROM
    emp e, emp s
WHERE
    e.mgr = s.empno
;   

-- none-equi join

SELECT
    *
FROM
    emp, salgrade
WHERE
--  sal BETWEEN losal AND hisal
    sal >= losal AND sal <= hisal
;

--------------------------------------------------------------------------------
-- Equi Join
-- ����� �̸�, ����, �޿�, �μ���ȣ, �μ��̸��� ��ȸ�ϼ���.
SELECT
    ename �̸�, job ����, sal �޿�, emp.deptno �μ���ȣ, dname �μ��̸�
FROM
    emp, dept
WHERE
    -- ��������
    emp.deptno = dept.deptno
;

-- Non-Equi Join
-- ����� �����ȣ, ����̸�, �������, ����޿�, �޿���� �� ��ȸ�ϼ���.
SELECT
    empno �����ȣ, ename ����̸�, job �������, sal ����޿�, grade �޿���� 
FROM
    emp, salgrade
WHERE
/*
    sal >= losal
    AND sal <= hisal
*/ 
    sal BETWEEN losal AND hisal
;

/*
    ���ο����� ���� ���� �̿��� �Ϲ������� �󸶵��� ����� �� �ִ�.
*/

-- 81�� �Ի��� ����� ����̸�, ����, �μ���ȣ, �μ���ġ �� ��ȸ�ϼ���.
SELECT
    ename ����̸�, job ����, hiredate �Ի���, e.deptno �μ���ȣ, loc �μ���ġ
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') = '81'
;

-- SELF JOIN
-- ����� �����ȣ, ����̸�, �������, �μ���ȣ, ����̸� �� ��ȸ�ϼ���.
SELECT
    e1.empno �����ȣ, e1.ename ����̸�, e1.job �������, e1.deptno �μ���ȣ, e2.ename ����̸�
FROM    
    emp e1, emp e2
WHERE
    e1.empno = e2.mgr
;

/*
    Outer Join
        ==> ��ȸ�� �����Ͱ� Cartesian Product ���� ���� �����͸� ��ȸ�ϴ� ����
        
        ���� ]
            SELECT
                ��ȸ�� �ʵ�
            FROM
                ���̺�1, ���̺�2
            WHERE
                ���̺�1.�ʵ�(+) = ���̺�2.�ʵ�(+)
            ;
            
            ���ǻ��� ]
                (+) ��ȣ�� NULL �� ǥ�õǾ�� �� ������ �ʿ� �ٿ��ش�.                
*/

SELECT
    *
FROM
    emp e, emp s
WHERE
    e.mgr = s.empno(+) -- NULL ���� ������ ���̺� �ʿ� +�� ���δ�.    
;

/*
    ���� ]
        ���̺��� ������ FROM ���� ������ �Ǹ�
        ��κ� �߰��� ���̺� ������ŭ ���� ������ �ο��Ǿ�� �Ѵ�.
        �̶� �������ڴ� AND�� �����ϸ� �ȴ�.
*/

-- ����� ����̸�, �Ի���, �޿�, �޿����, �μ���ȣ, �μ��̸��� ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���, sal �޿�, grade �޿����, e.deptno �μ���ȣ, dname �μ��̸�
FROM
    emp e, dept d, salgrade
WHERE
    -- �μ����̺�� ������̺� ����
    e.deptno = d.deptno
    -- ������̺�� �޿�������̺� ����
    AND sal BETWEEN losal AND hisal
;

-- ���� ] ����� �����ȣ, ����̸�, ����, �޿�, �޿����, ����ȣ, ����̸�, �μ���ȣ, �μ���ġ �� ��ȸ�ϼ���.
SELECT
    e.empno �����ȣ, e.ename ����̸�, e.job ����, e.sal �޿�, grade �޿����, e.mgr ����ȣ, s.ename ����̸�, e.deptno �μ���ȣ, loc �μ���ġ
FROM
    -- ������̺�, �μ����̺�, �޿���� ���̺�
    emp e, emp s, dept d, salgrade
WHERE
    -- ������̺�� �μ����̺� ����
    e.deptno = d.deptno
    -- ������̺�� �޿�������̺� ����
    AND e.sal BETWEEN losal AND hisal
    -- ������̺� self join
    AND e.mgr = s.empno(+)
;

--------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
    ���� 1 ]
        ������ 'MANAGER'�� �����
        �̸�, ����, �Ի���, �޿�, �μ��̸��� ��ȸ�ϼ���.
*/
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, dname �μ��̸�
FROM
--  ���� ���̺�� �μ� ���̺�
    emp, dept
WHERE
    job = 'MANAGER'
    AND emp.deptno = dept.deptno
;
/*
    ���� 2 ]
        �޿��� ���� ���� �����
        �̸�, ����, �Ի���, �޿�, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
*/
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, dname �μ��̸�, loc �μ���ġ
FROM
--  ���� ���̺�� �μ� ���̺�
    emp, dept
WHERE
--  �μ��̸� ����
    emp.deptno = dept.deptno
        
-- �޿��� ���� ���� ���
    AND sal = (
                SELECT
                    MIN(sal)
                FROM
                    emp
              )
;
/*
    ���� 3 ]
        ����̸��� 5������ �����
        �̸�, ����, �Ի���, �޿�, �޿������ ��ȸ�ϼ���.
*/
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, grade �޿����
FROM
--  ��� ���̺�� �޿���� ���̺�
    emp, salgrade
WHERE
--  �޿���� ����
    sal BETWEEN losal AND hisal
--  ����̸��� 5����
    AND LENGTH(ename) = 5
;
/*
    ���� 4 ]
        �Ի����� 81���̸鼭 ������ CLERK �� �����
        �̸�, ����, �Ի���, �޿�, �޿����, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
*/
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, grade �޿����, dname �μ��̸�, loc �μ���ġ
FROM
--  ��� ���̺�, �޿�������̺�, �μ����̺�
    emp, salgrade, dept
WHERE
--  �Ի����� 81���̸鼭 ������ CLERK�� ���
    TO_CHAR(hiredate, 'YY') = '81'
    AND job = 'CLERK'
--  ������̺�� �޿�������̺� ����
    AND sal BETWEEN losal AND hisal
--  ������̺�� �μ����̺� ����
    AND emp.deptno = dept.deptno
;
/*
    ���� 5 ]
        ����� �̸�, ����, �޿�, ����̸�, �޿������ ��ȸ�ϼ���.
*/  
SELECT
    e.ename �̸�, e.job ����, e.sal �޿�, s.ename ����̸�, grade �޿����
FROM
-- ������̺� �� ����, �޿���� ���̺�
    emp e, emp s, salgrade
WHERE
--  Self Join
    e.mgr = s.empno(+)
-- ������̺�� �޿���� ���̺� ����
    AND e.sal BETWEEN losal AND hisal
;
/*
    ���� 6 ]
        �����
        �̸�, ����, �޿�, ����̸�, �μ��̸�, �μ���ġ, �޿������ ��ȸ�ϼ���.
*/
SELECT
    e.ename �̸�, e.job ����, e.sal �޿�, s.ename ����̸�, dname �μ��̸�, loc �μ���ġ, grade �޿����
FROM
    emp e, emp s, dept d, salgrade
WHERE
--  Self Join
    e.mgr = s.empno(+)
-- ������̺�� �μ����̺� ����
    AND e.deptno = d.deptno
-- ������̺�� �޿���� ���̺� ����
    AND e.sal BETWEEN losal AND hisal    
;
/*
    ���� 7 ]
        �����
        �̸�, ����, �޿�, ����̸�, �μ��̸�, �μ���ġ, �޿������ ��ȸ�ϴµ�
        ȸ�� ��ձ޿����� �޿��� ���� ����� ��ȸ�ϼ���.
*/
SELECT
    e.ename �̸�, e.job ����, e.sal �޿�, s.ename ����̸�, dname �μ��̸�, loc �μ���ġ, grade �޿����
FROM
    emp e, emp s, dept d, salgrade
WHERE
--  Self Join
    e.mgr = s.empno(+)
-- ������̺�� �μ����̺� ����
    AND e.deptno = d.deptno
-- ������̺�� �޿���� ���̺� ����
    AND e.sal BETWEEN losal AND hisal
-- ȸ�� ��ձ޿����� �޿��� ���� ����� ��ȸ
    AND e.sal > (
                    SELECT
                        AVG(sal)
                    FROM
                        emp
                )
;

/*
    ���� 8 ]
        ����� �̸�, ����, �޿�, �μ���ȣ, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
        ��, ����� ���� �μ��� ���� ��ȸ�ϼ���.
*/
SELECT
    ename �̸�, job ����, sal �޿�, dept.deptno �μ���ȣ, dname �μ��̸�, loc �μ���ġ
FROM
-- ��� ���̺�� �μ� ���̺�
    emp, dept
WHERE
-- ������̺�� �μ� ���̺� ����
    emp.deptno(+) = dept.deptno
;

-- �޿��� �μ� ��ձ޿����� ���� �����
--      �����ȣ, ����̸�, �޿�, �μ���ձ޿�, �μ������, �μ��޿��հ踦 ��ȸ�ϼ���.
/*
    Inline View : �������� �� from ���� ��ġ�ϴ� ��������
    
                    �ζ��� �䵵 ���ο� ����� �� �ִ�.
*/

-- 10�� �μ��� �޿����
SELECT
    avg(sal)
FROM
    emp
WHERE
    deptno = 10
;

SELECT
    empno �����ȣ, ename ����̸�, sal �޿�, e.deptno �μ���ȣ,
    (
        SELECT
            ROUND(AVG(sal), 2)
        FROM
            emp
        WHERE
            deptno = e.deptno -- deptno�� ���� �ִ� deptno�̰�, e.deptno�� ���ϰ��� �ϴ� deptno �̴�.
    ) �μ���ձ޿�,
    (
        SELECT
            COUNT(*)
        FROM
            emp
        WHERE
            deptno = e.deptno
    ) �μ������,
    (
        SELECT
            SUM(sal)
        FROM
            emp
        WHERE
            deptno = e.deptno
    ) �μ��ݾ��հ�
FROM
    emp e
WHERE
    sal > (
                SELECT
                    AVG(sal)
                FROM
                    emp
                WHERE
                    deptno = e.deptno
                GROUP BY
                    deptno
                
          )
;


--      �����ȣ, ����̸�, �޿�, �μ���ȣ, 
--      �μ���ձ޿�, �μ������, �μ��޿��հ� �� ��ȸ�ϼ���.
SELECT
    empno, ename, sal, deptno, ROUND(avg, 2), cnt, sum
FROM
    emp,
    (
        SELECT
            deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt, SUM(sal) sum
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    deptno = dno
;





-- ������� ���� ���� �μ��� �μ���ȣ, �μ��޿��հ�, �μ����� �� ��ȸ�ϼ���.
/*
SELECT
    DISTINCT deptno �μ���ȣ,
    (
        SELECT
            SUM(sal)
        FROM
            emp
        WHERE
            deptno = e.deptno
        GROUP BY
            deptno
    ) �μ��޿��հ�,
    (
        SELECT
            COUNT(*)
        FROM
            emp
        WHERE
            deptno = e.deptno
        GROUP BY
            deptno
    ) �μ�����
FROM
    emp e
WHERE 
    deptno = (  
                SELECT
                    dno
                FROM
                  (
                    SELECT
                        COUNT(*) cnt, deptno dno
                    FROM
                        emp
                    GROUP BY
                        deptno
                  )
                WHERE
                    cnt = (
                            SELECT
                                MAX(cnt)
                            FROM 
                                (
                                   SELECT
                                        COUNT(*) cnt, deptno dno
                                   FROM
                                        emp
                                   GROUP BY
                                        deptno 
                                )
                                
                          )
            )
;
*/

SELECT
    deptno �μ���ȣ, SUM(sal) �μ��޿��հ�, COUNT(*) �μ�����
FROM
    emp
GROUP BY
    deptno
HAVING
    count(*) = (
                    SELECT
                        max(count(*))
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
;


SELECT
    *
FROM
    hr.employees
;

-- quiz. first_name �� �ι�° ���ڰ� 'a' �� ����� ������ ��ȸ�ϼ���.
SELECT
    *
FROM
    hr.employees
WHERE
--    first_name LIKE '_a%'
    SUBSTR(first_name, 2, 1) = 'a'
;


/*
    ANSI JOIN
    ==> ���� ����� �����ͺ��̽�(DBMS)�� ���� ������ �޶�����.
        
        ANSI SQL �̶�?
            �̱��� ANSI ��ȸ���� ���������� ���డ���� ���Ǹ���� ���� ����ϵ��� �س��� ��.
            
    1. CROSS JOIN
        ==> ����Ŭ������ Cartesion Product �� ������ ���ΰ� ���� ����
        
        ���� ]
            SELECT
                �ʵ��̸�
            FROM
                ���̺�1    CROSS JOIN  ���̺�2
            ;
*/

SELECT
    *
FROM
    emp, dept
;

-- Ansi Cross Join
SELECT
    *
FROM
    emp CROSS JOIN dept
;

/*
    ANSI INNER JOIN
        1. EQUI JOIN
        
        2. NON-EQUI JOIN
        
        3. SELF JOIN
------------------------------------------------------------------------------------------------------------        
        INNER JOIN
        
        ���� ]
            SELECT
                ��ȸ�� �ʵ�
            FROM
                ���̺�1 INNER JOIN ���̺�2
            ON
                �������ǽ�
            ;
            
        ���� ]
         ANSI JOIN������ 
         ���� ������ ON�� ����ϰ�
         �Ϲ� ������ WHERE ���� ����ϴ� ���� ��Ģ���� �Ѵ�.
*/

-- ����� �̸�, ����, �μ��̸��� ��ȸ�ϼ���.
SELECT
    ename ����̸�, job ����, dname �μ��̸�
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
WHERE
    ename = 'WARD'
;

/*
    ANSI OUTER JOIN
    ==> ORACLE OUTER JOIN�� ���� ����
        ���� ���ǽĿ� �����ϴ� �����͸� ��ȸ�ϰ�
        ���� ���ǽĿ� ���� �ʴ� �����ʹ� ������� �����Ѵ�.
        �̷� ��� ���� ���ǽĿ� ���Ե��� �ʴ� �����͵�
        ��ȸ�� ���Եǵ��� �ϴ� ���ǽ��� OUTER JOIN �̴�.
    
    ���� ]
        SELECT
        
        FROM
            ���̺�1 [ LEFT | RIGHT | FULL ] OUTER JOIN ���̺�2
        ON
            �������ǽ�
        ;
        
        ���� ]
            LEFT | RIGHT | FULL �� �ǹ�
            ����Ŭ ������ (+) �� ���ݴ��� ����
            ���ǿ� ���� �ʾƼ� ��ȸ���� ���ܵ� �������� ��ġ�� �����Ѵ�.
            �� �������̺� �ִ� �����͸� ��������
                ���������̺� �ִ� �����͸� ���������� �����ϴ� ���̴�.
            
            �����Ͱ� �ִ� �������� �������ָ� �ȴ�.
            ����Ŭ ������ �����Ͱ� ���� ����(NULL�� ǥ�õǾ�� �� ����)�� +�� �ٿ��ش�.
            
        ���� ]
            ����Ŭ ���ο����� Ǯ�ƿ��� ������ ������� ��������
            ANSI JOIN ������ ���� ��� ���� �� �ֵ��� �ϰ� ������
            �̶� FULL �̶�� ���� �ȴ�.
*/

-- ����� ����̸�, ����, ����ȣ, ����̸�, ��������� ��ȸ�ϼ���.

SELECT
    e.ename ����̸�, e.job �������, e.mgr ����ȣ, s.ename ����̸�, s.job �������
FROM
    emp e LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
;

-- ����� ����̸�, ����, �޿�, �μ���ȣ, �μ���ġ, �޿������ ��ȸ�ϼ���.
SELECT
    ename, job, sal, e.deptno, loc, grade
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
;

--------------------------------------------------------------------------------------------------------
/*
    NATURAL JOIN
    ==> �ڵ��������� �ؼ��ϸ� �ȴ�.
        �ݵ�� ���� ���ǽĿ� ����ϴ� �ʵ��� �̸��� �����ϰ�
        �ݵ�� ������ �ʵ尡 �Ѱ��� ��쿡 ���ؼ� ����� �� �ִ� ����
        
        ���� ]
            SELECT
                �ʵ��̸�
            FROM
                ���̺�1  NATURAL JOIN  ���̺�2
            ;
        
        ���� ]
            ON �� ���� ������?
            ������ ���� �������� �����̴�.
            ��, �� ���̺� ���� �̸��� �ʵ尡 �� �Ѱ��� �ִٴ� ������������
            �ڵ������� �� �ʵ带 �̿��ؼ� �����ϰ� �ȴ�.
*/

-- ����� ����̸�, ����, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.

SELECT
    ename ����̸� , job ���� , dname �μ��̸�, loc �μ���ġ
FROM
    emp
NATURAL JOIN
    dept
;

/*
    USING JOIN
        ==> �ݵ�� ���� ���ǽĿ� ����ϴ� �ʵ��� �̸��� ������ ���
            ���� �̸��� �ʵ尡 ������ �����ص� �����ϴ�.
        
        ���� ]
            SELECT
                ��ȸ�ʵ�, ...
            FROM
                ���̺�1  JOIN  ���̺�2
            USING
                (�������ǽĿ� ����� �ʵ��̸�)
            ;
*/

-- ����� ����̸�, ����, �μ���ȣ, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
SELECT
    e.ename ����̸�, job ����, deptno �μ���ȣ, dname �μ��̸�, loc �μ���ġ
FROM
    emp e JOIN dept d
USING 
    (deptno)
;



