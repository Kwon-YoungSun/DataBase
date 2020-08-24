-- 1. emp ���̺� �ִ� ����̸��� �μ���ȣ�� ��ȸ�ϼ���.
    SELECT 
        ename, deptno
    FROM
        emp
    ;
    
-- 2. emp ���̺� �ִ� �μ���ȣ�� ��ȸ�ϼ���.
--      ��, �ߺ��� �μ��� �ѹ��� ��ȸ�ǰ� �ϼ���.
    SELECT
        DISTINCT deptno
    FROM
        emp
    ;

-- 3. emp ���̺� �ִ� ��� �̸��� ����(�޿� * 12)�� ��ȸ�ϼ���.
--      ��, ����� ��Ī���� ��µǰ� �ϼ���.
    SELECT
        ename ����̸�, sal*12 ����
    FROM
        emp
    ;
    
-- 4. ����̸�, ���� �׸��� ������(���� + Ŀ�̼�)�� ��ȸ�ϼ���.
--      Ŀ�̼��� ���� ����� Ŀ�̼��� 0���� �ؼ� ����ϼ���.
    SELECT
        ename ����̸�, job ����, sal*12+NVL(comm,0) ������
    FROM
        emp
    ;
    
-- 5. ����� �̸�, ����, �Ի����� ��ȸ�ϼ���.
--      ��, ����� ��Ī�� ��µǰ� �ϼ���.
    SELECT
        ename �̸�, job ����, hiredate �Ի���
    FROM
        emp
    ;

-- 6. ����̸�, ����, �޿��� ��ȸ�ϼ���.
--      ��, �޿��� ���� �޿��� 10% �λ�� �޿��� ��ȸ�ϼ���.
    SELECT
        ename �̸�, job ����, sal*1.1 �޿�
    FROM
        emp
    ;
    
-- 7. �����ȣ, ����̸��� ��ȸ�ϼ���.
--      ��, ����̸��� �̸� �տ� 'Mr.' �� �ٿ����� ��ȸ�ǰ� �ϼ���.
    SELECT
        empno �����ȣ, 'Mr. ' || ename ����̸�
    FROM
        emp
    ;
-- 8. ����, �μ���ȣ�� ��ȸ�ϴµ� �ߺ������ʹ� �� ���� ��ȸ�ǰ� �ϼ���.
    SELECT
        DISTINCT job ����, deptno �μ���ȣ
    FROM
        emp
    ;
-- 9. ����̸�, ����, �Ի���, Ŀ�̼��� ��ȸ�ϼ���.
--      ��, Ŀ�̼��� ���� Ŀ�̼ǿ� 200�� ���� ����� ��ȸ�ϰ�
--      Ŀ�̼��� ���� ����� 300�� ��ȸ�ǰ� �ϼ���.
    SELECT
        ename ����̸�, job ����, hiredate �Ի���, NVL(comm+200, 300) Ŀ�̼�
    FROM
        emp
    ;
-- 10. ����̸��� 'SMITH'�� ����� ����̸�, ����, �Ի����� ��ȸ�ϼ���.
    SELECT
        ename ����̸�, job ����, hiredate �Ի���
    FROM
        emp
    WHERE
        ename = 'SMITH'
    ;
    
-- 11. ������ MANAGER�� ����� �̸�, ����, �޿��� ��ȸ�ϼ���.
    SELECT
        ename ����̸�, job ����, sal �޿�
    FROM
        emp
    WHERE
        job = 'MANAGER'
    ;
-- 12. �Ի����� 81�� 11�� 17���� ����� �̸�, ����, �Ի����� ��ȸ�ϼ���.
    SELECT
        ename ����̸�, job ����, hiredate �Ի���
    FROM
        emp
    WHERE
        hiredate = to_date('1981/11/17', 'yyyy/mm/dd')
    ;
-- 13. ������ MANAGER �̰ų� SALESMAN �� ����� �̸�, ����, �μ���ȣ�� ��ȸ�ϼ���.
    SELECT
        ename ����̸�, job ����, deptno �μ���ȣ
    FROM
        emp
    WHERE
        job = 'MANAGER' OR job = 'SALESMAN'
    ;
-- 14. �޿��� 1000�̻� 3000 �̸��� ����� �̸�, ����, �޿��� ��ȸ�ϼ���.
    SELECT
        ename ����̸�, job ����, sal �޿�
    FROM
        emp
    WHERE
        sal >= 1000 AND sal < 3000
    ;
-- 15. ������ MANAGER�̰� �޿��� 1000 �̻��� ����� �̸�, ��å, �޿�, �Ի����� ��ȸ�ϼ���.
    SELECT
        ename ����̸�, job ��å, sal �޿�, hiredate �Ի���
    FROM
        emp
    WHERE
        job = 'MANAGER' AND sal >= 1000
    ;
-- 16. 