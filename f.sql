create database tms;
use tms;
CREATE TABLE Users (
  userId INT PRIMARY KEY AUTO_INCREMENT,
  Username VARCHAR(50),
  Password VARCHAR(50),
  UserType VARCHAR(10) CHECK (UserType IN ('Admin', 'User')),
  Bio TEXT,
  PaymentInfo VARCHAR(50) UNIQUE
);
CREATE TABLE contactinfo (
    ContactId INT PRIMARY KEY AUTO_INCREMENT,
    Username varchar(50),
    Subject VARCHAR(50),
    Message TEXT,
    Time_Stamp TIME
);
CREATE TABLE RefundTable12 (
    RefundId INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    ReservationId INT,
    FOREIGN KEY (ReservationId) REFERENCES SeatReservationTable(ReservationId),
    isRefund INT
);
create table Movies(
MovieId int AUTO_INCREMENT primary key,
Title varchar(50),
Description text,
ReleaseDate date,
isPlaying int
);
CREATE TABLE reserved12 (
    ReservationId INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT,
    FOREIGN KEY(UserId) REFERENCES Users(UserId),
    ShowId INT,
    FOREIGN KEY(ShowId) REFERENCES Movies(movieid),
    SeatNumber VARCHAR(20),
    UNIQUE (ShowId, SeatNumber)
);
create table PromotionAndDiscountTable(
	PromoId int primary key,
	PromoCode varchar(50),
	DiscountAmount decimal,
	ValidFrom date,
	ValidTo date,
	Detail text
);


-- to display all tables
select * from users;
select * from reserved12;
select * from movies;
select * from contactinfo;
select * from PromotionAndDiscountTable;
select * from RefundTable1;



SET SQL_SAFE_UPDATES = 0;





-- inserting dummy data

INSERT INTO User (Username, Password, UserType, Bio, PaymentInfo)
VALUES
  ('AliKhan', 'password123', 'Admin', 'Mujhe khana banana aur cricket khelna pasand hai.', '1234-5678-9012-3456'),
  ('FatimaAhmed', 'pass456', 'User', 'Main kitabon ko parhna aur ghoomna phirna pasand karti hoon.', '9876-5432-1098-7654'),
  ('AhmedRaza', 'mikepass', 'User', 'Mujhe music sunna aur painting karna acha lagta hai.', '2468-1357-8024-6802'),
  ('AyeshaMalik', 'emily123', 'User', 'Main sehatmand rehna aur logon ki madad karna chahti hoon.', '5555-1234-5678-9999'),
  ('HassanAli', 'davidpass', 'Admin', 'Mujhe computer programming aur video games khelna pasand hai.', '1111-2222-3333-4444'),
  ('SanaKhan', 'sarahpass', 'User', 'Main films dekhna aur shopping karna pasand karti hoon.', '7777-8888-9999-0000'),
  ('UsmanKhan', 'michael456', 'User', 'Mujhe photography karna aur safar karna acha lagta hai.', '3333-4444-5555-6666'),
  ('ZainabAli', 'olivia123', 'Admin', 'Main khana pakana aur gardening karna pasand karti hoon.', '9999-8888-7777-6666'),
  ('SaimaKhan', 'danielpass', 'User', 'Mujhe poetry likhna aur ghazal sunna acha lagta hai.', '1234-5678-9012-3457'),
  ('BilalAhmed', 'sophia456', 'User', 'Main exercise karna aur movies dekhna pasand karta hoon.', '9876-5431-1098-7654');


insert into Movies (Title, Description, ReleaseDate, isPlaying)
values
    ('Inception', 'A mind-bending sci-fi thriller directed by Christopher Nolan.', '2010-07-16', 1),
    ('The Shawshank Redemption', 'A powerful drama based on Stephen Kings novella.', '1994-09-23', 1),
    ('Pulp Fiction', 'A nonlinear crime film directed by Quentin Tarantino.', '1994-10-14', 0),
    ('The Dark Knight', 'A superhero film featuring Batman, directed by Christopher Nolan.', '2008-07-18', 1),
    ('Fight Club', 'An intense psychological drama based on Chuck Palahniuks novel.', '1999-10-15', 0),
    ('The Godfather', 'A classic crime film directed by Francis Ford Coppola.', '1972-03-24', 0),
    ('The Matrix', 'A groundbreaking sci-fi action film directed by the Wachowskis.', '1999-03-31', 1),
    ('Goodfellas', 'A gripping crime film directed by Martin Scorsese.', '1990-09-19', 0),
    ('Interstellar', 'An epic space exploration film directed by Christopher Nolan.', '2014-11-07', 1),
    ('Schindlers List', 'A powerful historical drama based on true events during World War II.', '1993-12-15', 0);



insert into  TicketInventoryTable (ShowId, TotalSeats, AvailableSeats)
values
    (1, 100, 80),
    (2, 150, 120),
    (3, 200, 180),
    (4, 120, 100),
    (5, 180, 150),
    (6, 100, 80),
    (7, 150, 120),
    (8, 200, 180),
    (9, 120, 100),
    (10, 180, 150);


INSERT INTO RefundTable (UserId, ReservationId, isRefund)
VALUES
    (1, 1, 1),
    (2, 2, 0),
    (3, 3, 1),
    (4, 4, 0),
    (5, 5, 1),
    (6, 6, 0),
    (7, 7, 1),
    (8, 8, 0),
    (9, 9, 1),
    (10, 10, 0);

INSERT INTO PromotionAndDiscountTable (PromoId, PromoCode, DiscountAmount, ValidFrom, ValidTo, Detail)
VALUES
    (1, 'WINTER2023', 0.15, '2023-06-01', '2023-08-31', 'winter ke mausam mein 15% tak ki chhoot sabhi ticket par.'),
    (2, 'KHANDANMAZA', 0.2, '2023-09-01', '2023-12-31', 'Khandan ke bookings ke liye 20% tak ki discount ka aanand uthaye.'),
    (3, 'PEHLESEBOOK', 0.1, '2023-11-01', '2024-01-31', 'Pehle se book karein aur apne ticket par 10% bachayein.'),
    (4, 'HAFTAKADEAL', 0.25, '2023-10-01', '2023-10-31', 'Khaas hafta ke offer: Chune gaye shows par 25% tak ki chhoot.'),
    (5, 'WAFADAR25', 0.25, '2023-01-01', '2023-12-31', 'Wafadar khidmatgaron ke liye khaas 25% ki discount.'),
    (6, 'HAPPY50', 0.5, '2023-01-01', '2023-12-31', 'happy bookings par 50% tak ki chhoot.'),
    (7, 'FESTIVESALE', 0.3, '2023-12-15', '2024-01-15', 'festives kay mausam mein sabhi ticket par 30% tak ki chhoot.'),
    (8, 'NOVEMBER03', 0.15, '2023-01-01', '2023-12-31', 'November 3rd ko booking ke liye 15% ki discount.'),
    (9, 'HAPPYBIRTHDAYGIFT', 0.1, '2023-01-01', '2023-12-31', 'Apni salgirah par 10% ki discount.'),
    (10, 'SENIORCITIZEN', 0.2, '2023-01-01', '2023-12-31', 'Senior citizens ke liye sabhi shows par 20% ki discount.'),
	(11,'DECEMBER', 0.2, '2023-12-01', '2024-01-01', 'December ka mahinay main pain 20% discount.');



CREATE TABLE cont (
    ContactId INT PRIMARY KEY,
    UserId INT,
    FOREIGN KEY (UserId) REFERENCES UserTable(UserId),
    Subject VARCHAR(50),
    Message TEXT,
    Time_Stamp TIME
);


INSERT INTO cont (ContactId, UserId, Subject, Message, Time_Stamp)
VALUES
    (1, 1, 'Query about ticket booking', 'Hello, I have a question regarding the ticket booking process. Can you please provide some information?', '10:30:00'),
    (2, 2, 'Issue with payment', 'Hi, I encountered an error while making a payment. Can you assist me in resolving this issue?', '11:45:00'),
    (3, 3, 'Feedback on recent show', 'I recently watched a movie at your theater and wanted to share my feedback. The sound quality was excellent, but the seating arrangement could be improved.', '14:20:00'),
    (4, 4, 'Lost and found', 'I lost my wallet at your theater yesterday. Is there a lost and found department where I can inquire about it?', '16:10:00'),
    (5, 5, 'Complaint about staff behavior', 'I had a disappointing experience with one of your staff members. Their behavior was rude and unprofessional. I would like to bring this to your attention.', '18:05:00'),
    (6, 6, 'Request for movie recommendation', 'Can you suggest a good movie to watch this weekend? I enjoy action and thriller genres.', '20:30:00'),
    (7, 7, 'Issue with online ticket booking', 'I tried booking tickets online, but the website kept giving me an error. Is there an alternative way to purchase tickets?', '09:15:00'),
    (8, 8, 'Inquiry about upcoming shows', 'I would like to know the schedule for upcoming shows in the next week. Can you provide me with the details?', '12:40:00'),
    (9, 9, 'Request for group booking', 'We are planning a group outing to your theater. Is it possible to make a group booking for around 20 people?', '15:55:00'),
    (10, 10, 'Issue with seating allocation', 'I booked tickets for a specific seat, but when I arrived, someone else was already sitting there. How can this be resolved?', '17:25:00');
	
    INSERT INTO cont (ContactId, UserId, Subject, Message, Time_Stamp)
VALUES
(11,11,'not interested' , 'dont want to see the movie' , '17:25:00');
select * from cont;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    -- ----Insert Stored procedure for Promotion and discounts table ---
CREATE PROCEDURE InsertPromotionAndDiscounttable
(
    @PromoId INT,
    @PromoCode VARCHAR(50),
    @DiscountAmount DECIMAL,
    @ValidFrom DATE,
    @ValidTo DATE,
    @Detail TEXT
)
AS
BEGIN
    BEGIN TRY
        IF @ValidFrom > @ValidTo
        BEGIN
            THROW 51000, 'ValidFrom date cannot be greater than ValidTo date', 1;
        END

        IF EXISTS (SELECT 1 FROM PromotionAndDiscountTable WHERE PromoId = @PromoId)
        BEGIN
            THROW 51001, 'PromoId already exists', 1;
        END

        INSERT INTO PromotionAndDiscountTable (PromoId, PromoCode, DiscountAmount, ValidFrom, ValidTo, Detail)
        VALUES (@PromoId, @PromoCode, @DiscountAmount, @ValidFrom, @ValidTo, @Detail)
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

--Exec statement to insert in table -----
EXEC InsertPromotionAndDiscounttable
    @PromoId = 123,
    @PromoCode = 'SUMMER25',
    @DiscountAmount = 25.00,
    @ValidFrom = '2023-06-01',
    @ValidTo = '2023-08-31',
    @Detail = 'Summer promotion - 25% off on all items';

----To getdata------ 
CREATE PROCEDURE GetPromotion
(
    @PromoId INT
)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM PromotionAndDiscountTable WHERE PromoId = @PromoId)
        BEGIN
            THROW 51002, 'PromoId does not exist', 1;
        END
        ELSE
        BEGIN
            SELECT * FROM PromotionAndDiscountTable
            WHERE PromoId = @PromoId;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

--Exec statment -----
EXEC GetPromotion 
    @PromoId = 123;

---Delete stored procedure ----
	CREATE PROCEDURE DeletePromotionAndDiscounttable
(
    @PromoId INT
)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM PromotionAndDiscountTable WHERE PromoId = @PromoId)
        BEGIN
            THROW 51003, 'PromoId does not exist', 1;
        END
        ELSE
        BEGIN
            DELETE FROM PromotionAndDiscountTable
            WHERE PromoId = @PromoId;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

---Exec statement----
EXEC DeletePromotionAndDiscounttable
    @PromoId = 123;
----Update stored procedure----
CREATE PROCEDURE UpdatePromotionAndDiscounttable
(
    @PromoId INT,
    @PromoCode VARCHAR(50),
    @DiscountAmount DECIMAL,
    @ValidFrom DATE,
    @ValidTo DATE,
    @Detail TEXT
)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM PromotionAndDiscountTable WHERE PromoId = @PromoId)
        BEGIN
            THROW 51004, 'PromoId does not exist', 1;
        END
        ELSE
        BEGIN
            UPDATE PromotionAndDiscountTable
            SET 
                PromoCode = @PromoCode,
                DiscountAmount = @DiscountAmount,
                ValidFrom = @ValidFrom,
                ValidTo = @ValidTo,
                Detail = @Detail
            WHERE PromoId = @PromoId;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

---exec statement---
EXEC UpdatePromotionAndDiscounttable
    @PromoId = 123,
    @PromoCode = 'NEWCODE',
    @DiscountAmount = 15.00,
    @ValidFrom = '2023-12-01',
    @ValidTo = '2023-12-31',
    @Detail = 'Updated promotion details';

---Insert stored procedure for Contact table------
	CREATE PROCEDURE InsertContact_Table
    @ContactId int,
    @UserId int,
    @Subject varchar(50),
    @Message text,
    @Time_Stamp time
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM ContactTable WHERE ContactId = @ContactId)
        BEGIN
            THROW 51005, 'ContactId already exists', 1;
        END
        ELSE IF NOT EXISTS (SELECT 1 FROM UserTable WHERE UserId = @UserId)
        BEGIN
            THROW 51006, 'UserId does not exist in UserTable', 1;
        END
        ELSE
        BEGIN
            INSERT INTO ContactTable (ContactId, UserId, Subject, Message, Time_Stamp)
            VALUES (@ContactId, @UserId, @Subject, @Message, @Time_Stamp)
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
--Exec statement---
EXEC InsertContact_Table @ContactId=11 ,@UserId = 1, @Subject = 'Example Subject', @Message = 'Example Message', @Time_Stamp = '12:00:00'
---To getdata-----
CREATE PROCEDURE RetrieveContacttable
AS
BEGIN
    BEGIN TRY
        IF (SELECT COUNT(*) FROM ContactTable) = 0
        BEGIN
            THROW 51007, 'ContactTable is empty', 1;
        END
        ELSE
        BEGIN
            SELECT * FROM ContactTable;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

---Exec statement----
EXEC RetrieveContacttable
--Delete stored procedure----
CREATE PROCEDURE DeleteContacttable
    @ContactId int
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM ContactTable WHERE ContactId = @ContactId)
        BEGIN
            THROW 51008, 'ContactId does not exist', 1;
        END
        ELSE
        BEGIN
            DELETE FROM ContactTable
            WHERE ContactId = @ContactId;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
---Exec statement-----
EXEC DeleteContacttable @ContactId = 11
--Update stored procedure----

CREATE PROCEDURE UpdateContacttable
    @ContactId int,
    @UserId int,
    @Subject varchar(50),
    @Message text,
    @Time_Stamp time
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM ContactTable WHERE ContactId = @ContactId)
        BEGIN
            THROW 51009, 'ContactId does not exist', 1;
        END
        ELSE
        BEGIN
            UPDATE ContactTable
            SET UserId = @UserId, Subject = @Subject, Message = @Message, Time_Stamp = @Time_Stamp
            WHERE ContactId = @ContactId;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


--Exec statement----
EXEC UpdateContacttable @ContactId = 1, @UserId = 2, @Subject = 'Updated Subject', @Message = 'Updated Message', @Time_Stamp = '13:00:00'
---stored procedure for ticket refund table ---
	--1. for inserting new value into table--
CREATE PROCEDURE InsertTicketRefund
    @p_UserId INT,
    @p_ReservationId INT,
    @p_isRefund INT,
    @p_ResultMessage NVARCHAR(100) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO TicketRefundTable (UserId, ReservationId, isRefund)
        VALUES (@p_UserId, @p_ReservationId, @p_isRefund);

        SET @p_ResultMessage = 'Data successfully added.';
    END TRY
    BEGIN CATCH
        SET @p_ResultMessage = 'Error adding data: ' + ERROR_MESSAGE();
    END CATCH;
END;

DECLARE @ResultMessage NVARCHAR(100);

EXEC InsertTicketRefund 
    @p_UserId = 11, 
    @p_ReservationId = 11, 
    @p_isRefund = 1,
    @p_ResultMessage = @ResultMessage OUTPUT;

PRINT @ResultMessage;

--2. delete a record for refund table--
CREATE PROCEDURE DeleteTicketRefundRecord
    @RefundIdToDelete INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM TicketRefundTable WHERE RefundId = @RefundIdToDelete)
    BEGIN
        DELETE FROM TicketRefundTable WHERE RefundId = @RefundIdToDelete;
        PRINT 'Record deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Record not found. Deletion failed.';
    END
END;
EXEC DeleteTicketRefundRecord @RefundIdToDelete = 3;

--3. update a record for refund table--
CREATE PROCEDURE UpdateTicketRefundRecord
    @RefundIdToUpdate INT,
    @NewUserId INT,
    @NewReservationId INT,
    @NewIsRefund INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM TicketRefundTable WHERE RefundId = @RefundIdToUpdate)
    BEGIN
        UPDATE TicketRefundTable
        SET UserId = @NewUserId,
            ReservationId = @NewReservationId,
            isRefund = @NewIsRefund
        WHERE RefundId = @RefundIdToUpdate;

        PRINT 'Record updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Record not found. Update failed.';
    END
END;

EXEC UpdateTicketRefundRecord @RefundIdToUpdate = 5, @NewUserId = 55, @NewReservationId = 55, @NewIsRefund = 0;

--4. retrieve a record for refund table--

CREATE PROCEDURE GetTicketRefundRecord
    @RefundId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM TicketRefundTable WHERE RefundId = @RefundId)
    BEGIN
        SELECT * FROM TicketRefundTable WHERE RefundId = @RefundId;
    END
    ELSE
    BEGIN
        PRINT 'Record not found.';
    END
END;

EXEC GetTicketRefundRecord @RefundId = 2;


---stored procedure for show schedule table ---
--1. to insert new record--

CREATE PROCEDURE InsertIntoShowShedule
    @ShowId INT,
    @MovieId INT,
    @ShowTime TIME,
    @WeekDay VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM ShowSheduleTable WHERE ShowId = @ShowId)
    BEGIN
        INSERT INTO ShowSheduleTable (ShowId, MovieId, ShowTime, Week_day)
        VALUES (@ShowId, @MovieId, @ShowTime, @WeekDay);
        PRINT 'Record inserted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Duplicate ShowId. Insertion failed.';
    END
END;

EXEC InsertIntoShowShedule @ShowId = 11, @MovieId = 11, @ShowTime = '14:30:00', @WeekDay = 'Thursday';

--2. delete a record for refund table--
CREATE PROCEDURE DeleteFromShowShedule
    @ShowIdToDelete INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM ShowSheduleTable WHERE ShowId = @ShowIdToDelete)
    BEGIN
        DELETE FROM ShowSheduleTable WHERE ShowId = @ShowIdToDelete;
        PRINT 'Record deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Record not found. Deletion failed.';
    END
END;

EXEC DeleteFromShowShedule @ShowIdToDelete = 3;

--3. update a record for refund table--
CREATE PROCEDURE UpdateShowShedule
    @ShowIdToUpdate INT,
    @NewMovieId INT,
    @NewShowTime TIME,
    @NewWeekDay VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM ShowSheduleTable WHERE ShowId = @ShowIdToUpdate)
    BEGIN
        UPDATE ShowSheduleTable
        SET MovieId = @NewMovieId,
            ShowTime = @NewShowTime,
            Week_day = @NewWeekDay
        WHERE ShowId = @ShowIdToUpdate;

        PRINT 'Record updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Record not found. Update failed.';
    END
END;

EXEC UpdateShowShedule @ShowIdToUpdate = 5, @NewMovieId = 55, @NewShowTime = '20:00:00', @NewWeekDay = 'Friday';

--4. retrieve a record for refund table--
CREATE PROCEDURE GetShowSheduleRecord
    @ShowId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM ShowSheduleTable WHERE ShowId = @ShowId)
    BEGIN
        SELECT * FROM ShowSheduleTable WHERE ShowId = @ShowId;
    END
    ELSE
    BEGIN
        PRINT 'Record not found.';
    END
END;

EXEC GetShowSheduleRecord @ShowId = 8;

-- Search movie procedure 

Create Procedure searchMovie 
@movieName varchar(50)
AS 
BEGIN
	IF @movieName = Title
		select * from MovieTable
	ELSE
		PRINT 'Movie not found'
END;

EXEC searchMovie @movieName = 'Shawshank Redemption';

-- display now showing movies procedure

create procedure displayMovie
as
begin
	select * from MovieTable
end

exec displayMovie

-- register procedure
CREATE PROCEDURE RegisterUser
    @InputUsername VARCHAR(50),
    @InputPassword VARCHAR(50),
    @ConfirmPassword VARCHAR(50),
    @InputUserType VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM UserTable WHERE Username = @InputUsername)
    BEGIN
        IF @InputPassword = @ConfirmPassword
        BEGIN
            INSERT INTO UserTable (Username, Password, UserType)
            VALUES (@InputUsername, @InputPassword, @InputUserType);
            SELECT 'Registration Successful' AS Status;
        END
        ELSE
        BEGIN
            SELECT 'Password and Confirm Password do not match' AS Status;
        END
    END
    ELSE
    BEGIN
        SELECT 'Username Already Exists' AS Status;
    END
END;

EXEC RegisterUser
    @InputUsername = 'user123',
    @InputPassword = 'password123',
    @ConfirmPassword = 'password123',
    @InputUserType = 'User'; --

SELECT * FROM UserTable;

-- login procedure
CREATE PROCEDURE ValidateUserLogin
    @InputUsername VARCHAR(50),
    @InputPassword VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StoredPassword VARCHAR(50);
    DECLARE @UserType VARCHAR(10);

    IF EXISTS (SELECT 1 FROM UserTable WHERE Username = @InputUsername)
    BEGIN
        
        SELECT @StoredPassword = Password, @UserType = UserType
        FROM UserTable
        WHERE Username = @InputUsername;

        IF @StoredPassword = @InputPassword
        BEGIN
            SELECT 'Login Successful' AS Status, @UserType AS UserType;
        END
        ELSE
        BEGIN
            SELECT 'Incorrect Password' AS Status;
        END
    END
    ELSE
    BEGIN
        SELECT 'Username Not Found' AS Status;
    END
END;

EXEC ValidateUserLogin
    @InputUsername = 'user123', 
    @InputPassword = 'password123';

-- add movie procedure
CREATE PROCEDURE addMovie
    @InputMovieId INT,
    @InputTitle VARCHAR(50),
    @InputDescription TEXT,
    @InputReleaseDate DATE,
    @InputIsPlaying INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM MovieTable WHERE MovieId = @InputMovieId)
    BEGIN
        INSERT INTO MovieTable (MovieId, Title, Description, ReleaseDate, IsPlaying)
        VALUES (@InputMovieId, @InputTitle, @InputDescription, @InputReleaseDate, @InputIsPlaying);
        SELECT 'Movie Inserted Successfully' AS Status;
    END
    ELSE
    BEGIN
        SELECT 'MovieId Already Exists' AS Status;
    END
END;

EXEC addMovie 
    @InputMovieId = 1,
    @InputTitle = 'New Movie',
    @InputDescription = 'A fantastic new movie',
    @InputReleaseDate = '2023-12-01',
    @InputIsPlaying = 1;  --(1 for yes, 0 for no)

SELECT * FROM MovieTable;

-- update movie procedure
CREATE PROCEDURE UpdateMovie
    @InputMovieId INT,
    @NewTitle VARCHAR(50),
    @NewDescription TEXT,
    @NewReleaseDate DATE,
    @IsPlaying INT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM MovieTable WHERE MovieId = @InputMovieId)
    BEGIN
        UPDATE MovieTable
        SET
            Title = @NewTitle,
            Description = @NewDescription,
            ReleaseDate = @NewReleaseDate,
            IsPlaying = @IsPlaying
        WHERE MovieId = @InputMovieId;

        SELECT 'Movie Updated Successfully' AS Status;
    END
    ELSE
    BEGIN
        SELECT 'MovieId Not Found' AS Status;
    END
END;

EXEC UpdateMovie 
    @InputMovieId = 1,
    @NewTitle = 'New Movie Title',
    @NewDescription = 'New Movie Description',
    @NewReleaseDate = '2023-01-01',
    @IsPlaying = 1; -- (1 for yes, 0 for no)

-- delete movie procedure
CREATE PROCEDURE DeleteMovie
    @InputMovieId INT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM MovieTable WHERE MovieId = @InputMovieId)
    BEGIN
        DELETE FROM MovieTable WHERE MovieId = @InputMovieId;
        SELECT 'Movie Deleted Successfully' AS Status;
    END
    ELSE
    BEGIN
        SELECT 'MovieId Not Found' AS Status;
    END
END;

EXEC DeleteMovie @InputMovieId = 1; 




