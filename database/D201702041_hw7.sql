--�μ���ȣ�� 20 �� ������� ���հ� �μ���ȣ�� 30�� ������� ������ ������
--select *
--from emp
--where deptno = 30
--union
--select *
--from emp
--where deptno = 20

--select *
--from emp
--where sal >= 1000
--minus
--select *
--from emp
--where job = 'CLERK'

-- family ���̺��� ����(composition)�� �����Ҿƹ���(greatgrandfather)�� 
-- ������� �Ƶ�(son)���� �θ� ����(parent_node)�� ������ ������ ��Ÿ���ÿ�.
--select level, lpad(' ', 4 * (level-1)) || composition,person_name, parent_node,
--    CONNECT_BY_ISLEAF
--from family
--start with parent_node is null
--connect by prior composition = parent_node

-- �����ȣ(empno)�� 7876���κ��� ���� ������(mgr)�� ã�� ������ ������ ���Ͻÿ�
--select level, lpad(' ', 4 * (level -1)) || job, empno, mgr, connect_by_isleaf
--isleaf
--from emp
--start with empno = 7876
--connect by prior mgr = empno;

-- �����������ڰ� ���� ���(����,�Ŵ���)�� �����ϰ� �ڽ��� ���Ӱ����ڸ�
-- �������� �Ͽ� �����������ڸ� ���������� �̿��Ͽ� ���ϰ�, ��� ��ȣ
-- ���Ӱ����� ��ȣ, ������������ ��ȣ�� ���Ͻÿ�.
--select e1.empno ���, e1.mgr, e2.mgr ������������
--from emp e1, emp e2
--where e1.mgr = e2.empno
--and e2.mgr is not null
--order by e1.empno

select e1.empno ���, e1.mgr, e2.mgr ������������
from emp e1 left outer join emp e2
 on (e1.mgr = e2.empno)
order by e1.empno








