SELECT ID AS ���, dept_name '�Ҽ� �а�', name as �̸�, salary �޿�
FROM instructor

SELECT ALL DEPT_NAME
FROM instructor

SELECT DISTINCT DEPT_NAME
FROM instructor

SELECT NAME AS �̸�, ROUND(salary/12, 2) AS ���޿�
FROM INSTRUCTOR

-- ���ڿ��� ���ڿ� ���ϱ� (VARCHAR�� NUMERIC���� ��ȯ�ϴ� �� ����)
SELECT dept_name + '�а� ' + '�л��� ��� ������ ' + tot_cred AS �л�����
FROM student

-- ������ ���ڿ��� ���ڷ� ��ȯ�ϴ��� �������� ���ڸ� ���������� ��ȯ�ϸ� ����X
SELECT dept_name + '�а� ' + '�л��� ��� ������ ' + CONVERT(VARCHAR, tot_cred) AS �л�����
FROM student