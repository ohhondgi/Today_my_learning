--select
--    decode(grouping(team_id), 1,
--    'all team', team_id) "��ID",
--    decode(grouping(position), 1,
--    'all position', position) "������",
--    count(*) "��"
--from player
--where position is not null
--group by grouping sets (team_id, position)
--order by team_id

-- player ���̺� ���� position�� team_id�� ���� �� �ִ� ��� ����� ����
-- subtotal�� �����ض� (position�� null�� �����ʹ� �����ϰ� ����Ͽ���)
--
--select
--    case grouping(position)
--    when 1 then 'all position'
--    else position end "������",
--    case grouping(team_id)
--    when 1 then 'all team_id'
--    else team_id end "��ID",
--    count(*) "�� ����"
--from player
--where position is not null
--group by cube (position, team_id)

--select team_id "��ID", count(*) "�ҼӼ��� ��",
--    rank() over (order by count(*) desc) rank,
--    DENSE_RANK() over (order by  count(*) desc) dense_rank
--from player
--group by team_id

--select team_id ��ID, player_name ������, height ����Ű,
--    max(height) over (partition by team_id) as "����� ���� Ű",
--    min(height) over (partition by team_id) as "�ִܽ� ���� Ű"
--from player

--select player_name ������, join_yyyy �Դܳ⵵, weight ü��,
--    trunc (avg(weight) over (PARTITION by join_yyyy), 1) ��ո�����
--from player;

--select position, player_name, join_yyyy,
--    first_value(player_name) over
--    (partition by position order by join_yyyy asc,
--    player_name asc rows unbounded preceding) "�Դܿ����� ���� ��������",
--    last_value(player_name) over
--    (partition by position order by join_yyyy asc,
--    player_name asc rows between current row
--    and unbounded following) "�Դܿ����� ���� ��������"
--from player
--where join_yyyy is not null

select player_name, weight,
    ntile(50) over (order by weight desc) "50����"
from player
where weight is not null
and weight >= 70










