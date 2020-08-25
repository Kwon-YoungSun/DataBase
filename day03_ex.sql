/*
    1. 1���� 365�� �̶�� �����ϰ�
        ����� �ٹ��� �� �� �� ������ ǥ���ϰ�
        ��� �Ҽ����ϴ� ��������.
        
        ǥ������ ]
        
            ����̸�    �Ի���     �ٹ����
            SMITH       80/00/00    40 ��
*/
SELECT
    ename ����̸�,
    hiredate �Ի���,
--    FLOOR((SYSDATE - hiredate) / 365.0 + 1) || ' ��' �ٹ����
    FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate) / 12.0 + 1) || ' ��' �ٹ����
FROM
    emp
;

/*
    2. ����� �̸�, �Ի���, �ٹ����� ��ȸ�ϼ���.
        �� �ٹ����� ��, �� ������ ǥ���ϼ���.
*/
SELECT
    ename ����̸�,
    hiredate �Ի���,
    CONCAT(
        FLOOR((SYSDATE - hiredate) / 365.0 + 1) || '�� ', -- ��
        FLOOR(MOD(SYSDATE-hiredate, 365.0) / 12) || '����' -- ����
    ) �ٹ���
FROM
    emp
;

/*
    3. ����� ù�޿��� ���� �� ���� �ٹ��� ���� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, sal ����޿�, hiredate �Ի���, LAST_DAY(hiredate) ù���޳�,
    LAST_DAY(hiredate) - hiredate + 1 || ' ��' "ù�޿� D-DAY"
FROM
    emp
;

/*
    4. ����� �Ի��� �����ϴ� ù ������� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, hiredate �Ի���, NEXT_DAY(hiredate, '��') ù�����
FROM
    emp
;

/*
    5. �ٹ������ �Ի��� ���� 1���� �������� �����ؾ� �Ѵ�.
        ����� �ٹ���� �������� ��ȸ�ϼ���.
        ��, 15�� ���� �Ի��ڴ� �ش� ���� �����Ϸ� �ϰ�
        16�� ���� �Ի��ڴ� �ش� ���� �������� �������� �Ѵ�.
*/
SELECT
    ename ����̸�, hiredate �Ի���,
    ROUND(hiredate, 'MONTH') �ٹ����������
FROM
    emp
;
/*
    6. ����� �����Ͽ� �Ի��� ����� ����̸�, �Ի������ ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, hiredate �Ի���,
    TO_CHAR(hiredate, 'DAY') �Ի����
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'DAY') = '������'
;

/*
    7. ��� �޿� �߿��� ������� 0�� ����� ����̸�, �޿� �� ��ȸ�ϼ���.
    
    ��Ʈ ]
        ���ڿ��� ��ȯ�� ó���Ѵ�.
        
*/
SELECT
    ename ����̸�, sal �޿�
FROM
    emp
WHERE
    SUBSTR(TO_CHAR(sal), -3, 1) = '0'
;
    
/*
    8. ����� ����̸�, �޿�, Ŀ�̼��� ��ȸ�ϼ���.
        ��, Ŀ�̼��� ���� ����� NONE���� ǥ�õǰ� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, sal �޿�,
--    NVL(TO_CHAR(comm), 'NONE') Ŀ�̼�
--    NVL2(TO_CHAR(comm), TO_CHAR(comm), 'NONE') Ŀ�̼�
    COALESCE(TO_CHAR(comm), 'NONE') Ŀ�̼�
FROM
    emp
;

/*

*/