##Step 1:
drop table if exists t_sup_supplier_hist;
create table t_sup_supplier_hist(
	`sup_id` varchar(50) not null,
	`last_modified` date,
	primary key(`sup_id`));

##Step 2:
drop trigger if exists ins_date;
delimiter $$
create trigger ins_date after insert on t_sup_supplier
for each row 
begin
	insert into t_sup_supplier_hist values (new.sup_id, now()); end $$

drop trigger if exists update_date;
delimiter $$
create trigger update_date after update on t_sup_supplier
for each row
begin
		insert into t_sup_supplier_hist values (new.sup_id, now())
        on duplicate key update `last_modified` = now(); end $$

drop trigger if exists delete_date;
delimiter $$
create trigger delete_date before delete on t_sup_supplier
for each row
begin
	insert into t_sup_supplier_hist values (old.sup_id, now())
    on duplicate key update `last_modified` = now(); end $$
    
##Step 3:
insert into t_sup_supplier(sup_id)
values(2904474);

update t_sup_supplier
set status_code = 'ini'
where sup_id = 2904473; 

##Step 4:
select * from t_sup_supplier_hist;