with
usercomments AS
(select a.id as id , a.display_name as display_name,b.text, b.creation_date
  from (select * from {{ref('stackoverflow_users')}} x where x.id is not null) a
left outer join (select * from {{ref('stackoverflow_comments')}} y where y.id is not null) b
on a.id = b.user_id)


select * from usercomments