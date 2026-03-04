SELECT
    s.StudentID,
    s.Name        AS StudentName,
    c.ClubName,
    m.JoinDate
FROM Membership_3NF m
JOIN Student_3NF s ON m.StudentID = s.StudentID
JOIN Club_3NF    c ON m.ClubID    = c.ClubID
ORDER BY m.JoinDate;

### How the JOIN Works

The diagram below shows how the three tables are linked:
```
Student_3NF          Membership_3NF          Club_3NF
-----------          --------------          --------
StudentID ◄──────── StudentID               ClubID ◄──────── ClubID
Name                 ClubID ────────────────►ClubName
Email                JoinDate                ClubRoom
                                             ClubMentor