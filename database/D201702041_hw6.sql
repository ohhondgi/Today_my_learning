--select e.empno , e.ename, d.deptno, d.dname
--from dept d, emp e
--where e.deptno = d.deptno

select sc.sche_date �����, st.stadium_name �����,
    ht.team_name as Ȩ���̸�, at.team_name as �������̸�    
from stadium st, schedule sc, team ht, team at
where sc.stadium_id = st.stadium_id
and sc.hometeam_id = ht.team_id
and sc.awayteam_id = at.team_id
order by sc.sche_date, st.stadium_name

-- �� id�� ���� �̸�, ���̸�, �������� ã�ƺ���.
--select team_id, player_name, team_name, position
--from player natural join team;

-- Ȩ�� ������ ������ ������ null�� �ƴ� ���鿡 ���� schedule�� stadium��
-- stadium_id�� join �Ͽ� ����ϰ� �����, Ȩ�� ���� �� ������ ������ ����϶�.
--select s.sche_date �����, d.stadium_name �����,
--    s.home_score, s.away_score
--from schedule s join stadium d
--on s.stadium_id = d.stadium_id
--where s.home_score is not null
--and s.away_score is not null

--select *
--from stadium s cross join team t
-- 300

--select *
--from stadium st right join team t
--on st.stadium_id = t.stadium_id
-- 15

--select stadium_name, stadium.stadium_id, seat_count,
--    hometeam_id, team_name
--from stadium left outer join team
--on stadium.hometeam_id = team.team_id
--order by hometeam_id
















