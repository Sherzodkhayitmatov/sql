drop table if exists photos
CREATE TABLE photos
(
    id INT IDENTITY(1,1),
    img_data VARBINARY(MAX)
);

INSERT INTO photos
SELECT * FROM OPENROWSET(
    BULK N'D:\sql\lesson-2\new-zealand-1882703_640.jpg',
    SINGLE_BLOB
) AS img;
select * from photos
