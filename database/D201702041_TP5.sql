-- ������ ���� ����� �ִ� å�鿡 ���ؼ� ���� ����� �й�, �̸�,
-- å ������ȣ, å �̸��� ����ϴ� sql���� �ۼ��Ͻÿ�.
--select c.cno �й�, c.name �̸�, p.e_isbn as "å ������ȣ", e.title å�̸�
--from ebook e, previousrental p join customer c
--on p.c_cno = c.cno
--where p.e_isbn = e.isbn

-- previousrental ���̺��� å���� ���� �����
-- �й��� ���� ��� ���� ���� �����Ͽ� ���Ͻÿ�.
--select p.e_isbn, p.c_cno, count(*)
--from previousrental p
--group by rollup (p.e_isbn, p.c_cno)
--order by p.e_isbn

-- previousrental ���̺��� å�� ���� rank
-- �� �����Ͻÿ�
--select distinct p.e_isbn, 
--    count(*) over(partition by p.e_isbn) as "����Ƚ��"
--from previousrental p
--order by count(*) over(partition by p.e_isbn) desc

-- previousrental ���̺��� å���� ������ Ƚ���� ����ϰ�,
-- Ƚ���� ���� ������ ����Ͻÿ�.
--select DISTINCT e_isbn, all_rented,
--   dense_rank() over (order by all_rented DESC) as rank
--from (select e_isbn, count(*) over(partition by e_isbn) as all_rented
--        from previousrental)
--order by rank
