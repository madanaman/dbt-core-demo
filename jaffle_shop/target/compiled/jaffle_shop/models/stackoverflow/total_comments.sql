

with total_comments AS (select id,display_name,count(text) as totalcomments
from `genuine-display-356209`.`dbt_amadan`.`usercomments`
a where date(creation_date) between '2010-01-01' and '2012-12-31'
group by a.id,a.display_name)

select * from total_comments