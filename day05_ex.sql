-- ANSI ������ �̿��Ͽ� �ذ��ϼ���.

/*
    ���� 1 ]
        ������ 'MANAGER'�� �����
        �̸�, ����, �Ի���, �޿�, �μ��̸��� ��ȸ�ϼ���.
*/
-- NATURAL JOIN
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, dname �μ��̸�
FROM
    emp NATURAL JOIN dept
WHERE
    job = 'MANAGER'
;

-- INNER JOIN(equi join)
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, dname �μ��̸�
FROM
    emp INNER JOIN dept
ON
    emp.deptno = dept.deptno
WHERE
    job = 'MANAGER'
;


/*
    ���� 2 ]
        �޿��� ���� ���� �����
        �̸�, ����, �Ի���, �޿�, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
*/
-- 1. NATURAL JOIN
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, dname �μ��̸�, loc �μ���ġ
FROM
    emp NATURAL JOIN dept
WHERE
    sal = (
            SELECT
                MIN(sal)
            FROM
                emp
          )
;

-- 2. INNER JOIN(equi join)
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, dname �μ��̸�, loc �μ���ġ
FROM
    emp INNER JOIN dept
ON
    emp.deptno = dept.deptno
WHERE
    sal = (
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
-- INNER JOIN(Non Equi Join)
SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, grade �޿����
FROM
    emp INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
WHERE
    LENGTH(ename) = 5
;

/*
    ���� 4 ]
        �Ի����� 81���̸鼭 ������ CLERK �� �����
        �̸�, ����, �Ի���, �޿�, �޿����, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
*/

SELECT
    ename �̸�, job ����, hiredate �Ի���, sal �޿�, grade �޿����, dname �μ��̸�, loc �μ���ġ
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
WHERE
    TO_CHAR(hiredate, 'YY') = '81'
    AND job = 'CLERK'
;

/*
    ���� 5 ]
        ����� �̸�, ����, �޿�, ����̸�, �޿������ ��ȸ�ϼ���.
*/  
SELECT
    e.ename �̸�, e.job ����, e.sal �޿�, s.ename ����̸�, grade �޿����
FROM
-- emp ���̺�� salgrade ���̺� INNER JOIN(Non Equi Join)
    emp e INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
-- emp ���̺�� emp ���̺� OUTER JOIN
LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
;

/*
    ���� 6 ]
        �����
        �̸�, ����, �޿�, ����̸�, �μ��̸�, �μ���ġ, �޿������ ��ȸ�ϼ���.
*/
SELECT
    e.ename �̸�, e.job ����, e.sal �޿�, s.ename ����̸�, dname �μ��̸�, loc �μ���ġ, grade �޿����
FROM
-- ������̺�� �μ����̺� INNER JOIN(Equi Join)
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
-- ��� ���̺�� �޿�������̺� INNER JOIN(Non Equi Join)
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
-- ������̺�� ������̺� OUTER JOIN
LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno

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
-- ������̺�� �μ����̺� INNER JOIN(Equi Join)
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
-- ��� ���̺�� �޿�������̺� INNER JOIN(Non Equi Join)
INNER JOIN salgrade
ON
    sal BETWEEN losal AND hisal
-- ������̺�� ������̺� OUTER JOIN
LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
WHERE
-- ȸ�� ��ձ޿����� �޿��� ���� ����� ��ȸ
    e.sal > (
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
    ename ����̸�, job ����, sal �޿�, d.deptno �μ���ȣ, dname �μ��̸�, loc �μ���ġ
FROM
-- ������̺�� �μ����̺� OUTER JOIN
    emp e RIGHT OUTER JOIN dept d
ON
    e.deptno = d.deptno
;

--------------------------------------------------------------------------------

-- ������� ���� ���� �μ��� ����� �μ���ձ޿����� ���� �޴� �������
-- ����̸�, ����, �޿�, �μ���ȣ, �μ���ձ޿�, �μ������� ��ȸ�ϼ���.

--------------------------------------------------------------------------------
-- 1. �ζ��� �並 ������� �ʴ� ���
SELECT
    ename ����̸�, job ����, sal �޿�, deptno �μ���ȣ,
    (
        SELECT
            ROUND(AVG(sal), 2)
        FROM
            emp
        WHERE
            deptno = e.deptno
        GROUP BY
            deptno
    ) �μ���ձ޿�,
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
-- ������� ���� ���� �μ��� ��� ��
    deptno = (
                SELECT
                    deptno
                FROM
                    emp
                GROUP BY
                    deptno
                HAVING
                    COUNT(*) = (
                     SELECT
                        MAX(COUNT(*))
                     FROM
                        emp
                     GROUP BY
                        deptno
                )
             )
-- �μ���ձ޿����� ���� �޴� �������
    AND sal > (
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