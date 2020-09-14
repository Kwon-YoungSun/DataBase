-- �������� rowtype�� �̿��ؼ� ó���ϼ���.
/*
    ���� 1 ]
        emp01 ���̺��� �̸��� Ư�� ���ڼ��� ������� �޿��� 20% �λ��ϴ� ���ν����� �ۼ��ؼ�
        �����ϼ���.
        ���ν��� �̸��� sal_up03
*/
CREATE OR REPLACE PROCEDURE sal_up03(
    len IN NUMBER
)
IS

BEGIN
    UPDATE
        emp01
    SET
        sal = sal * 1.2
    WHERE
        LENGTH(ename) = len
    ;

    
    DBMS_OUTPUT.PUT_LINE('�̸��� ' || len || ' ������ ������� �޿��� 20% �λ��Ͽ����ϴ�!' );
END;
/

/*
    ���� 2 ]
        �����ȣ�� �Է��ϸ� ����� �̸�, ����, �μ��̸�, �μ���ġ�� ������ִ� ���ν���(e_info02)�� �ۼ����ּ���.

*/

/*
    ���� 3 ] ����� �̸��� �Է��ϸ� �����ȣ, ����̸�, ����, �޿�, �޿������ ������ִ�
                   ���ν���(e_info031)�� �ۼ��ϰ� �����ϼ���.
*/
CREATE OR REPLACE PROCEDURE e_info031(
    name IN emp.ename%TYPE
)
IS
    iemp emp%ROWTYPE;
    igrade salgrade%ROWTYPE;
BEGIN
    SELECT
        empno, job, sal, grade
    INTO
        iemp.empno,  iemp.job, iemp.sal, igrade.grade
    FROM
        emp, salgrade
    WHERE
        name = ename
        AND sal BETWEEN losal AND hisal
    ;
    
    DBMS_OUTPUT.PUT_LINE('�Էµ� ����̸� : ' || name);
    DBMS_OUTPUT.PUT_LINE('�Էµ� �����ȣ : ' || iemp.empno);
    DBMS_OUTPUT.PUT_LINE('�Էµ� ������� : ' || iemp.job);
    DBMS_OUTPUT.PUT_LINE('�Էµ� ����޿� : ' || iemp.sal);
    DBMS_OUTPUT.PUT_LINE('�Էµ� �޿���� : ' || igrade.grade);
END;
/

exec e_info031('SMITH');

/*
    ���� 4 ]
        ����� ��ȣ�� �Է��ϸ�
        ����̸�, �������, ����̸�
        �� ������ִ� ���ν���(e_info04)�� �ۼ��ϰ� �����ϼ���.
        
        ��Ʈ ]
            OUTER JOIN ����ϼ���.
*/
CREATE OR REPLACE PROCEDURE e_info04(
    ino IN emp.empno%TYPE
)
IS
    iemp emp%ROWTYPE;
    semp emp%ROWTYPE;
    
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        e.ename,  e.job, s.ename
    INTO
        iemp.ename, iemp.job, semp.ename
    FROM
        emp e, emp s
    WHERE
        e.mgr = s.empno(+)
        AND ino = e.empno
    ;
    
    DBMS_OUTPUT.PUT_LINE('�Է��� �����ȣ : ' || ino);
    DBMS_OUTPUT.PUT_LINE('����̸�: ' || iemp.ename);
    DBMS_OUTPUT.PUT_LINE('�������: ' || iemp.job);
    DBMS_OUTPUT.PUT_LINE('����̸�: ' || semp.ename);
END;
/
exec e_info04(7839);