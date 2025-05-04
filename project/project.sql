
CREATE TABLE Team (
    TeamID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Coach VARCHAR(100),
    HomeCity VARCHAR(100),
    RankingPoints INT CHECK (RankingPoints >= 0)
);


CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age > 10),
    Position VARCHAR(50),
    Nationality VARCHAR(50),
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

CREATE TABLE Match (
    MatchID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Location VARCHAR(100),
    HomeTeamID INT,
    AwayTeamID INT,
    HomeScore INT DEFAULT 0,
    AwayScore INT DEFAULT 0,
    FOREIGN KEY (HomeTeamID) REFERENCES Team(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Team(TeamID)
);

CREATE TABLE Official (
    OfficialID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    ExperienceYears INT CHECK (ExperienceYears >= 0)
);


CREATE TABLE MatchOfficial (
    MatchID INT,
    OfficialID INT,
    PRIMARY KEY (MatchID, OfficialID),
    FOREIGN KEY (MatchID) REFERENCES Match(MatchID),
    FOREIGN KEY (OfficialID) REFERENCES Official(OfficialID)
);

CREATE TABLE Statistic (
    StatID INT PRIMARY KEY,
    MatchID INT,
    PlayerID INT,
    Goals INT DEFAULT 0,
    Assists INT DEFAULT 0,
    YellowCards INT DEFAULT 0,
    RedCards INT DEFAULT 0,
    FOREIGN KEY (MatchID) REFERENCES Match(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);

INSERT INTO Team VALUES
(1, 'Dragons', 'John Smith', 'New York', 15),
(2, 'Wolves', 'Sarah Johnson', 'Chicago', 12),
(3, 'Falcons', 'James Lee', 'Houston', 18);

INSERT INTO Player VALUES
(1, 'Tom Brown', 22, 'Forward', 'USA', 1),
(2, 'Mike Green', 24, 'Midfielder', 'USA', 1),
(3, 'Sam White', 21, 'Defender', 'Canada', 2),
(4, 'David Black', 23, 'Goalkeeper', 'UK', 2),
(5, 'Chris Grey', 25, 'Forward', 'Mexico', 3);

INSERT INTO Match VALUES
(1, '2025-05-01', '18:00:00', 'Stadium A', 1, 2, 2, 1),
(2, '2025-05-05', '20:00:00', 'Stadium B', 2, 3, 0, 3),
(3, '2025-05-10', '19:00:00', 'Stadium C', 3, 1, 1, 1);

INSERT INTO Official VALUES
(1, 'Karen Hill', 'Referee', 5),
(2, 'Ron Clark', 'Line Judge', 3),
(3, 'Laura Adams', 'Referee', 7);

INSERT INTO MatchOfficial VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2);

INSERT INTO Statistic VALUES
(1, 1, 1, 2, 0, 1, 0),
(2, 1, 2, 0, 1, 0, 0),
(3, 2, 3, 0, 0, 1, 0),
(4, 2, 5, 2, 1, 0, 0),
(5, 3, 5, 1, 0, 0, 0);
SELECT Name, RankingPoints
FROM Team;

SELECT P.Name
FROM Player P
JOIN Team T ON P.TeamID = T.TeamID
WHERE T.Name = 'Dragons';

SELECT M.MatchID, T1.Name AS HomeTeam, T2.Name AS AwayTeam, M.HomeScore, M.AwayScore
FROM Match M
JOIN Team T1 ON M.HomeTeamID = T1.TeamID
JOIN Team T2 ON M.AwayTeamID = T2.TeamID;

SELECT P.Name, SUM(S.Goals) AS TotalGoals
FROM Player P
JOIN Statistic S ON P.PlayerID = S.PlayerID
GROUP BY P.Name
ORDER BY TotalGoals DESC
LIMIT 1;

SELECT M.MatchID, M.Date
FROM Match M
JOIN MatchOfficial MO ON M.MatchID = MO.MatchID
JOIN Official O ON MO.OfficialID = O.OfficialID
WHERE O.Name = 'Karen Hill';

SELECT AVG(HomeScore + AwayScore) AS AvgGoals
FROM Match;

SELECT P.Name, SUM(S.Assists) AS TotalAssists
FROM Player P
JOIN Statistic S ON P.PlayerID = S.PlayerID
GROUP BY P.Name
HAVING SUM(S.Assists) > 1;

SELECT M.MatchID, M.Date
FROM Match M
JOIN Team T1 ON M.HomeTeamID = T1.TeamID
JOIN Team T2 ON M.AwayTeamID = T2.TeamID
WHERE T1.Name = 'Falcons' OR T2.Name = 'Falcons';

SELECT DISTINCT T.Name
FROM Team T
WHERE T.TeamID IN (
    SELECT P.TeamID
    FROM Player P
    WHERE P.Age > 23
);

SELECT T.Name, COUNT(P.PlayerID) AS PlayerCount
FROM Team T
LEFT JOIN Player P ON T.TeamID = P.TeamID
GROUP BY T.Name;

CREATE INDEX idx_player_teamid ON Player(TeamID);
CREATE INDEX idx_statistic_playerid ON Statistic(PlayerID);
CREATE INDEX idx_match_homeid ON Match(HomeTeamID);

