select * from APR.credentials;
select * from APR.users;
select * from APR.user_history;

select count(*) from APR.user_history where user_name="imishra";
select * from APR.user_history where user_name="imishra";
select * from APR.user_history where user_name="imishra" order by listen_count desc limit 5;
select * from APR.user_history where user_name="imishra";
select track_name from APR.user_history where user_name='imishra' order by listen_count desc limit 5;

select * from APR.credentials;
select * from APR.users;

