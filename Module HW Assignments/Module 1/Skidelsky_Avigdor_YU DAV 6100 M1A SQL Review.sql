show databases;
use dav6100_db;

##Q1:
select distinct status_code as 'Status', count(*) as 'Count of Suppliers'
from t_ctr_amt
group by status_code;

##Q2:
select c.country_label_en as 'Country Label', b.orig_max_am as 'Total Contract Dollars'
from t_sup_supplier as a
join t_ctr_amt as b
on a.sup_id = b.sup_id
join r_ctry as c
on a.country_code = c.country_code
where a.country_code='US'
group by c.country_label_en;

##Q3:
select a.country_code, sum(if (b.doc_bfy=2015, b.orig_max_am, null)) as '2015', sum(if(b.doc_bfy=2016,b.orig_max_am,null)) as '2016',
sum(if(b.doc_bfy=2017,b.orig_max_am,null)) as '2017', sum(if(b.doc_bfy=2018,b.orig_max_am,null)) as '2018',sum(if(b.doc_bfy=2019,b.orig_max_am,null)) as '2019',
sum(if(b.doc_bfy=2020,b.orig_max_am,null))as '2020',sum(if(b.doc_bfy=9999,b.orig_max_am,null)) as '9999'
from t_sup_supplier as a
join t_ctr_amt as b
on a.sup_id = b.sup_id
where b.doc_bfy >= 2015
group by a.country_code
order by a.country_code;