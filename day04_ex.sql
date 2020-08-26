-- day04 ����

/*
    1. �̸��� SMITH ����� ������ ������ ���� ����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    job = (
            SELECT
                job
            FROM
                emp    
            WHERE
                ename = 'SMITH'
          )
;

/*
    2. ������� ��ձ޿����� ���� �޴� ����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    sal < (
            SELECT
                AVG(sal)
            FROM
                emp
          )
;
/*
    3. �ְ�޿����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    sal = (
            SELECT
                MAX(sal)
            FROM
                emp
          )
;
/*
    4. KING ������� �ʰ� �Ի��� ����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    hiredate > (
                    SELECT
                        hiredate
                    FROM
                        emp
                    WHERE
                        ename = 'KING'
               )
;
/*
    5. �� ����� �޿��� ��ձ޿��� ���̸� ��ȸ�ϼ���. 
*/
SELECT
    ename ����̸�, sal �޿�,
    ROUND( 
        sal - (
                SELECT
                    AVG(sal)
                FROM
                    emp
              )
    , 2) "�޿�-��ձ޿�"
        
FROM
    emp group by ename, sal
;

/*
    6. �μ��� �޿��հ谡 ���� ���� �μ��� ������� ������ ��ȸ�ϼ���. 
*/
SELECT
    *
FROM
    emp
WHERE
    deptno = (
                SELECT
                    deptno
                FROM 
                    emp
                WHERE
                    sal = (SELECT MAX(sal) FROM emp GROUP BY deptno)
                
            )
;

SELECT
    deptno, SUM(sal)
FROM
    emp
GROUP BY
    deptno
;


/*
    7. Ŀ�̼��� �޴� ������ �ѻ���̶� �ִ� �μ��� �Ҽ� ������� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    deptno = ( -- Ŀ�̼��� �޴� ������ �� ����̶� �ִ� �μ���ȣ ��ȸ
                SELECT
                    DISTINCT deptno
                FROM
                    emp
                WHERE
                    comm IS NOT NULL
                    AND
                    comm <> 0
                
             )
;

/*
    8. ��ձ޿����� �޿��� ���� �̸��� 4���� �Ǵ� 5������ ����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
-- ��ձ޿����� �޿��� ����
    sal > (
                SELECT
                    AVG(sal)
                FROM
                    emp
            )
    AND
-- �̸��� 4���� �Ǵ� 5������
    LENGTH(ename) IN (4, 5)
;

/*
    9. ����� �̸��� 4���ڷε� ����� ���� ������ ������� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    job IN (
                SELECT
                    job -- ������
                FROM
                    emp
                WHERE
                    LENGTH(ename) = 4 -- ����� �̸��� 4���ڷε� ����� ����(SALESMAN, PRESIDENT, ANALYST)
          )
;

/*
    10. �Ի�⵵�� 81���� �ƴ� ����� ���� �μ��� �ִ� ����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    deptno IN (
                SELECT
                    deptno -- ���� �μ��� �ִ�
                FROM
                    emp
                WHERE
                    TO_CHAR(hiredate, 'YYYY') <> '1981' -- �Ի�⵵�� 81���� �ƴ� �����
             )
;
/*
    11. ���޺� ��ձ޿����� �����̶� ���� �޴� ����� ������ ��ȸ�ϼ���.(ANY)
*/
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
                SELECT
                    AVG(sal) -- MIN : 1037.5
                FROM
                    emp
                GROUP BY
                    job
            )
;

/*
    12. �Ի�⵵�� ��ձ޿����� ���� �޴� ����� ������ ��ȸ�ϼ���.
*/
SELECT
    *
FROM
    emp
WHERE
    sal > ALL (
            SELECT
                AVG(sal) -- 2050(1987), 800(1980), 1300(1982), 2282.5(1981)
            FROM
                emp
            GROUP BY
                TO_CHAR(hiredate, 'YYYY')
          )
;

/*
    13. �ְ� �޿����� �̸����̿� ���� �̸����̸� ���� ����� �����ϸ�
        ��� ����� ������ ��ȸ�ϰ�
        �ƴϸ� ��ȸ���� ������.(EXISTS)
*/
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
                SELECT
                    LENGTH(ename) -- KING
                FROM
                    emp
                WHERE
                    sal = (
                            SELECT
                                MAX(sal)
                            FROM
                                emp
                        )
                    
            )
;