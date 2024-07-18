/*consulta 1*/
SELECT TOP 200 DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation desc;

/*consulta 2*/
select Posts.Title, Users.DisplayName
from Posts
JOIN Users on Posts.OwnerUserId = Users.Id

/*consulta 3*/
select top 200 avg(Score) as averageScore, Users.DisplayName
from Posts
join Users ON Posts.OwnerUserId = Users.Id
GROUP BY Users.DisplayName 
    
/*consulta 4*/
SELECT top 200 DisplayName
FROM  Users
WHERE Users.Id IN (
        SELECT Comments.UserId
        FROM Comments
        GROUP BY Comments.UserId
        HAVING COUNT(Comments.Id) > 100
    );

/*consulta 5*/
Update Users
set Location = 'Desconocido'  
where Location is NULL OR Location = ' ';
Print 'se ha actualizado la columna';

/*consulta 6*/
delete from Comments 
where UserId IN (select UserId from Users where Reputation < 100);
DECLARE @DeletedCommentsCount INT; DELETE FROM Comments WHERE UserId IN (SELECT UserId FROM Users WHERE Reputation < 100) SET @DeletedCommentsCount = @@ROWCOUNT; PRINT CAST(@DeletedCommentsCount AS VARCHAR(10)) + ' comentarios fueron eliminados.';

/*consulta 7*/
SELECT 
    Users.DisplayName,
    COALESCE(PostCounts.TotalPosts, 0) AS TotalPosts,
    COALESCE(CommentCounts.TotalComments, 0) AS TotalComments,
    COALESCE(BadgeCounts.TotalBadges, 0) AS TotalBadges
FROM 
    Users
LEFT JOIN 
    (SELECT OwnerUserId, COUNT(*) AS TotalPosts FROM Posts GROUP BY OwnerUserId) AS PostCounts
    ON Users.Id = PostCounts.OwnerUserId
LEFT JOIN 
    (SELECT UserId, COUNT(*) AS TotalComments FROM Comments GROUP BY UserId) AS CommentCounts
    ON Users.Id = CommentCounts.UserId
LEFT JOIN 
    (SELECT UserId, COUNT(*) AS TotalBadges FROM Badges GROUP BY UserId) AS BadgeCounts
    ON Users.Id = BadgeCounts.UserId;

/*consulta 8*/
SELECT TOP 10 Title, Score
from Posts
where Title IS NOT NULL
order by Score DESC

/*consulta 9*/
SELECT TOP 5 Text, CreationDate
  FROM Comments
  ORDER BY 
    CreationDate DESC
