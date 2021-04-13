--select team_id ��, round(avg(height),1) ���Ű, round(avg(weight),1) ��ո�����
--from player
--group by team_id

--select job ����, count(*) ������, sum(sal*12+NVL2(comm,comm,0)) ��������,
--trunc(avg(sal*12+NVL2(comm,comm,0))) �������, trunc(stddev(sal*12+NVL2(comm,comm,0))) ����ǥ������
--from emp
--group by job
--having trunc(avg(sal*12+NVL2(comm,comm,0)))>=30000

--select job ����, ename �̸�, hiredate �Ի���, sal ���޿�
--from emp
--where job = 'CLERK' or job = 'MANAGER'
--order by job desc, hiredate desc, sal asc

select *
from (select team_id ��, count(team_id) ���
      from player
      where e_player_name is not null 
      group by team_id
      having count(team_id)>=20
      order by count(team_id) desc)
where rownum <=4
 
 
 
