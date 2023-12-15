const mysql = require("mysql2");
const express = require("express");
const bodyParser = require("body-parser");
const path = require('path');

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "12345678",
  database: "tms",
});

const app = express();

db.connect((err) => {
  if (err) {
    console.error("Database connection failed:", err.stack);
    return;
  }
  console.log("Connected to the database");
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: true }));

  var globalSelectedSeats = [];
  let globalMovieName = '';
  let globalMovieId = null; 

  //--------------------------------------D-O-N-E--------------------------------------
  //Rahim' Code
  //GETTER METHODS
  app.get("/search", (req, res) => {
    res.sendFile(__dirname + "/search.html");
  });

  app.get("/mainpage", (req, res) => {
    res.sendFile(__dirname + "/MainPage.html");
  });
  
  app.get("/seat0", (req, res) => {
    res.sendFile(__dirname + "/seat0.html");
  });

  app.get("/seat", (req, res) => 
  {
          res.sendFile(__dirname + "/seat.html")
  });

  app.get("/seat2", (req, res) => {
      res.sendFile(__dirname + "/seat2.html");
  });

  app.get("/seat3", (req, res) => {
    res.sendFile(__dirname + "/seat3.html");
  });

  app.get("/seat4", (req, res) => {
    res.sendFile(__dirname + "/seat4.html");
  });

  //POST METHODS
  app.post('/seat0', (req, res) => {
    const { movieTitle } = req.body;
    
    const query = `SELECT title, movieid FROM movies WHERE title = ? AND isPlaying = 1`;
    db.query(query, [movieTitle], (err, results) => {
        if (err) {
            console.error('Error executing the query:', err);
            res.status(500).send('Error searching for the movie');
            return;
        }

        if (results.length > 0) {
            globalMovieName = results[0].title;
            globalMovieId = results[0].movieid; 
            res.status(200).send('Movie exists and is playing.');
        } else {
            res.status(404).send('Movie does not exist in the database or is not playing.');
        }
    });
  });

  app.post("/seat", (req, res) => {
    const { selectedSeats } = req.body;
    if (selectedSeats && Array.isArray(selectedSeats)) {
        globalSelectedSeats.push(...selectedSeats);
        res.status(200).send("Seat selection received and stored.");
    } else {
        res.status(400).send("No valid seat selection received.");
    }
  });

  app.post("/seat2", (req, res) => {
    console.log(globalMovieName);
    console.log("Inside seat 2");
  
    const firstName = req.body.first_name;
    const lastName = req.body.last_name;
    const username = firstName + lastName;
    console.log(username);
  
    const query = "SELECT userId FROM Users WHERE Username = ?";
    db.query(query, [username], (err, results) => {
      if (err) {
        console.error("Error searching in database:", err);
        res.status(500).send("Internal Server Error");
        return;
      }
      if (results.length > 0) {
        const userId = results[0].userId;
        console.log("User ID found:", userId);
  
        globalSelectedSeats.forEach(seatNumber => {
          const insertQuery = "INSERT INTO reserved12 (UserId, ShowId, SeatNumber) VALUES (?, ?, ?)";
          db.query(insertQuery, [userId, globalMovieId, seatNumber], (insertErr, insertResult) => {
            if (insertErr) {
              console.error("Error inserting into Reservation table:", insertErr);
              res.redirect("/seat4");
            } else {
              console.log("Reservation added for user:", userId, "Seat:", seatNumber);
              if (seatNumber === globalSelectedSeats[globalSelectedSeats.length - 1]) {
                res.redirect("/seat3");
              }
            }
          });
        });
      } else {
        console.log("User not found");
        res.send("User not found in the database.");
      }
    });
  });
  

  app.post("/mainpage", (req, res) => {
    const query = `SELECT mt.title, st.showtime FROM MovieTable mt JOIN ShowSheduleTable st ON mt.movieid = st.movieid`;
    db.query(query, (err, results) => {
      if (err) {
        console.error("Error executing the query:", err);
        res.status(500).send("Error searching for the movie");
        return;
      }


      const movieRows = results
        .map((movie) => {
          return `<tr><td><a href="/seat0">${movie.title}</a></td><td>${movie.showtime}</td></tr>`;
        })
        .join("");

      const htmlResponse = `
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <!-- Your styles and other meta tags -->
            </head>
            <body>
                <header>
                    <!-- Your header content -->
                </header>
                <br>
                <div class="mainDiv">
                    <div class="Recently-Added">
                        <h1>Now Showing</h1>
                        <table>
                            <thead>
                                <tr>
                                    <th>Movie Name</th>
                                    <th>Movie Timing</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${movieRows}
                            </tbody>
                        </table>
                    </div>
                    <!-- Rest of your HTML content -->
                </div>
                <!-- Rest of your HTML content -->
            </body>
            </html>
        `;
      res.send(htmlResponse);
    });
  });

  app.post("/search", (req, res) => {
    const searchTerm = req.body.movieName;

    const query = `SELECT * FROM Movies WHERE Title LIKE '%${searchTerm}%'`;
    db.query(query, (err, results) => {
      if (err) {
        console.error("Error executing the query:", err);
        res.status(500).send("Error searching for the movie");
        return;
      }
      res.send(generateMovieList(results));
    });
  });

  function generateMovieList(results) {
    let movieList = '<h2>Search Results:</h2>';

    if (results.length === 0) {
        movieList += '<p>No movies found</p>';
    } else {
        movieList += '<ul>';
        results.forEach(movie => {
            movieList += `<li>${movie.Title} (${new Date(movie.ReleaseDate).getFullYear()}) - ${movie.Description}</li>`;
        });
        movieList += '</ul>';
    }

    return movieList;
}

  //-------------------------------------------------------------------------
  //MAHAM'S CODE
  //Global Variables
  let globalUs , globalps;
  //Getter Functions
  app.get("/addMovie", (req, res) => {
    res.sendFile(__dirname + "/addMovie.html");
  });

  // edit movie
  app.get("/editMovie", (req, res) => {
    res.sendFile(__dirname + "/editMovie.html");
  });
  
  //delete movie
  app.get("/deleteMovie", (req, res) => {
    res.sendFile(__dirname + "/deleteMovie.html");
  });

  app.get("/sam" , (req , res) =>{
    res.sendFile(__dirname + "/sam.html");
  })

  app.get("/sdm" , (req , res) => {
    res.sendFile(__dirname + "/sdm.html");
  });
  
  app.get("/sem" , (req , res) => {
    res.sendFile(__dirname + "/sem.html");
  });

  app.get('/register', (req, res) => {
    res.sendFile(__dirname + '/register.html');
  });

  app.get('/Profile', (req, res) => {
    const username = globalUs; 
    console.log(username);
    db.query('SELECT * FROM Users WHERE Username = ?', [username], (err, results) => {
      if (err) {
        console.error('Error fetching user profile:', err);
        return res.status(500).json({ status: 'Internal Server Error' });
      }

      if (results.length === 0) {
        return res.status(404).json({ status: 'User not found' });
      }

      const userProfile = results[0];
      res.json({ status: 'Success', userProfile });
    });
  });

  app.get('/login', (req, res) => {
    res.sendFile(__dirname + '/login.html');
  });

  app.get('/main' , (req , res) =>{
    res.sendFile(__dirname + '/main.html');
  })

  app.get('/admin' , (req, res) =>{
    res.sendFile(__dirname + '/admin.html');
  })

  app.get('/loginAdmin', (req, res) => {
    res.sendFile(__dirname + '/loginAdmin.html');
  });

  //POST functions
  app.post("/addMovie", (req, res) => {
    const { title, description, releaseDate, isPlaying } = req.body;

    db.query(
        "INSERT INTO Movies (Title, Description, ReleaseDate, isPlaying) VALUES (?, ?, ?, ?)",
        [title, description, releaseDate, isPlaying],
        (err, results) => {
            if (err) {
                console.error("Error executing add movie query:", err);
                return res.status(500).json({ status: "Internal Server Error" });
            }

            // Assuming successful insertion, send a success message to the client
            res.json({ status: "Movie added successfully" });
        }
    );
  });

  app.post("/deleteMovie", (req, res) => {
    const { title } = req.body;

    if (!title) {
        return res.status(400).json({ message: "Movie title is required." });
    }

    db.query("DELETE FROM Movies WHERE Title = ?", [title], (err, results) => {
        if (err) {
            console.error("Error executing delete movie query:", err);
            return res.status(500).json({ message: "Internal Server Error" });
        }
        if (results.affectedRows > 0) {
            res.json({ status: "Movie deleted successfully" });
        } else {
            res.status(404).json({ message: "Movie not found" });
        }
    });
  });


  app.post("/editMovie", (req, res) => {
  
  const { movieId , title, description, releaseDate, isPlaying } = req.body;

  if (!movieId || !title || !description || !releaseDate || !isPlaying) {
    return res.status(400).json({ message: "All fields are required." });
  }

  db.query(
    "UPDATE Movies SET Title = ?, Description = ?, ReleaseDate = ?, isPlaying = ? WHERE MovieId = ?",
    [title, description, releaseDate, isPlaying, movieId],
    (err, results) => {
      if (err) {
        console.error("Error executing edit movie query:", err);
        return res.status(500).json({ status: "Internal Server Error" });
      }
      console.log("Query Executed" + ", Movie ID: " + movieId);
      console.log("Rows affected:", results.affectedRows);

      if (results.affectedRows > 0) {
        console.log("Inside if block - Movie edited successfully");
        res.json({ status: "Movie edited successfully" });
      } else {
        console.log("Inside else block - Movie not found or no changes made");
        res.status(404).json({ message: "Movie not found or no changes made" });
      }
    }
  );
  });
  
  app.post('/updateUserProfile', (req, res) => {
    const username = req.user; 
    const { fullName, password, contact, bio, paymentInfo } = req.body;

    db.query(
      'UPDATE UserTable SET FullName = ?, Password = ?, Contact = ?, Bio = ?, PaymentInfo = ? WHERE Username = ?',
      [fullName, password, contact, bio, paymentInfo, username],
      (err, results) => {
        if (err) {
          console.error('Error updating user profile:', err);
          return res.status(500).json({ status: 'Internal Server Error' });
        }

        if (results.affectedRows > 0) {
          res.json({ status: 'User profile updated successfully' });
        } else {
          res.status(404).json({ status: 'User not found' });
        }
      }
    );
  });

  app.post('/register', (req, res) => {
    const { username, password, 'confirm-password': confirmPassword, 'user-type': userType, bio, 'payment-info': paymentInfo } = req.body;
  
    if (password !== confirmPassword) {
      return res.status(400).json({ status: 'Passwords do not match' });
    }
  
    const insertQuery = 'INSERT INTO Users (Username, Password, UserType, Bio, PaymentInfo) VALUES (?, ?, ?, ?, ?)';
    const values = [username, password, userType, bio, paymentInfo];
  
    db.query(insertQuery, values, (err, results) => {
      if (err) {
        console.error('Error executing registration query:', err);
        return res.status(500).json({ status: 'Internal Server Error' });
      }
      res.redirect('/login'); 
    });
  });
  
  app.post('/login', (req, res) => {
    const { username, password } = req.body;
    globalUs = username;
    globalps = password

    db.query('SELECT * FROM Users WHERE Username = ? AND Password = ? AND usertype = ?', [globalUs, globalps , 'User'], (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        return res.status(500).json({ status: 'Internal Server Error' });
      }

      if (results.length > 0) {
        res.json({ status: 'Login successful' });
      } else {
        res.status(401).json({ status: 'Login failed' });
      }
    });
  });

  app.post('/loginAdmin', (req, res) => {
    const { username, password } = req.body;
    globalUs = username;
    globalps = password;

    db.query('SELECT * FROM Users WHERE Username = ? AND Password = ? AND UserType = ?', [globalUs, globalps, 'admin'], (err, results) => {
        if (err) {
            console.error('Error executing query:', err);
            return res.status(500).json({ status: 'Internal Server Error' });
        }

        if (results.length > 0) {
            res.json({ status: 'Login successful' });
        } else {
            res.status(401).json({ status: 'Login failed' });
        }
    });
  });

  //Mariyam's Code
  //GETTER FUNCTIONS
  app.get('/contact', (req, res) => {
    res.sendFile(__dirname + '/Contactus.html');
  });

  app.get('/promo', (req, res) => {
    res.sendFile(__dirname + '/Promo.html');
  });

  app.post('/promo', async (req, res) => {
    const promoId = req.body.promoId;
  
    try {
      const pool = await mssql.connect(config);
      const currentDate = new Date().toISOString().split('T')[0]; // Get current date in 'YYYY-MM-DD' format
  
      const promo = await pool.request()
        .input('promoId', mssql.Int, promoId)
        .query('SELECT * FROM PromotionAndDiscountTable WHERE id = @promoId');
      if (promo.recordset.length === 0) {
        res.status(404).json({ status: 'Promo not found' });
      } else {
        const validFrom = new Date(promo.recordset[0].validFrom).getTime();
        const validTo = new Date(promo.recordset[0].validTo).getTime();
        const currentDateTimestamp = new Date(currentDate).getTime();
  
        console.log('currentDateTimestamp:', currentDateTimestamp);
        console.log('validFrom:', validFrom);
        console.log('validTo:', validTo);
  
        if (currentDateTimestamp >= validFrom && currentDateTimestamp <= validTo) {
          const result = await pool.request()
            .input('promoId', mssql.Int, promoId)
            .query('INSERT INTO AvailedPromotions (promoId, availedDate) VALUES (@promoId, GETDATE())');
  
          console.log('Promo availed:', result);
          res.json({ status: 'Promo availed successfully' });
        } else {
          res.status(400).json({ status: 'Promo not available at the moment' });
        }
      }
    } catch (error) {
      console.error('Error availing promo:', error);
      res.status(500).json({ status: 'Internal Server Error' });
    }
  });
  
  app.post('/contact', (req, res) => {
    console.log('Received form submission request:', req.body);
  
    const { contactId, username, subject, message} = req.body;

    if (!contactId || !username || !subject || !message){
      res.status(400).json({ status: 'All fields are required' });
      return;
    }

    const query = `
        INSERT INTO contactinfo (ContactId, Username, Subject, Message, Time_Stamp)
        VALUES (?, ?, ?, ?, NOW())
    `;
  
    const values = [parseInt(contactId), username, subject, message];
  
    console.log('Executing query:', query);
    console.log('Parameters:', values);
  
    db.query(query, values, (err, result) => {
        if (err) {
            console.error('Error executing form submission query:', err);
            res.status(500).json({ status: 'Internal Server Error' });
        } 
        else {
            console.log(username);
            console.log('Form submitted successfully');
            res.json({ status: 'Form submitted successfully' });
        }
      });
  });

  //FAIQ'S CODE
  //GETTERS
  app.get('/ticketrefund' , (req , res) => {
    res.sendFile(__dirname + '/ticketrefund.html');
  });

  app.get('/inventory' , (req , res) => {
    res.sendFile(__dirname + '/inventory.html');
  });

  app.get('/applyForRefund' , (req , res) => {
    res.sendFile(__dirname + '/applyForRefund.html');
  });
  

  app.post('/checkRefundStatus', (req, res) => {
    const { refundId } = req.body;
  
    // Perform database operations to check the refund status
    const query = 'SELECT isRefund FROM RefundTable12 WHERE RefundId = ?';
    db.query(query, [refundId], (err, results) => {
      if (err) {
        console.error('Error checking refund status:', err);
        res.status(500).json({ isRefunded: -1 }); // -1 indicates an error
      } else if (results.length === 1) {
        const isRefunded = results[0].isRefund;
        res.status(200).json({ isRefunded });
      } else {
        res.status(404).json({ isRefunded: -1 }); // Refund ID not found
      }
    });
  });
  

  app.post('/applyForRefund', (req, res) => {
    const { applyReservationId, applyUserId } = req.body;
  
    // Ensure that applyReservationId and applyUserId are valid numbers
    if (isNaN(applyReservationId) || isNaN(applyUserId)) {
      res.status(400).send('Invalid input. ReservationId and UserId must be numbers.');
      return;
    }
    
    const randomNumber = Math.floor(Math.random() * 101);

    // Determine if the random number is even or odd
    const refundChoice = randomNumber % 2 === 0 ? 1 : 0;

    // Perform database operations to insert the refund application
    const insertQuery = 'INSERT INTO RefundTable12 (UserId, ReservationId, isRefund) VALUES (?, ?, ?)';
    db.query(insertQuery, [applyUserId, applyReservationId, refundChoice], (insertErr, result) => {
      if (insertErr) {
        console.error('Error inserting refund application:', insertErr);
        res.status(500).send('Error submitting for refund. Please try again.');
      } else {
        // Get the refund ID from the inserted row
        const refundId = result.insertId;
  
        // Send the refundId in the response
        res.status(200).json({ refundId });
      }
    });
  });

});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});


async function addRefundDetails(newRefundId, applyUserId, applyReservationId, isRefund) {
  try {
    const insertRefundQuery = `
      INSERT INTO TicketRefundTable (RefundId, UserId, ReservationId, isRefund)
      VALUES (?, ?, ?, ?)
    `;
    await db.promise().query(insertRefundQuery, [newRefundId, applyUserId, applyReservationId, isRefund]);
    return { success: true, message: 'Refund details added successfully' };
  } catch (error) {
    console.error('Error adding refund details:', error);
    throw new Error('Error adding refund details');
  }
}

async function getReservationId(userId) {
  try {
    const selectQuery = 'SELECT ReservationId FROM RefundTable WHERE UserId = ?';
    const [rows, fields] = await db.promise().query(selectQuery, [userId]);

    if (rows.length > 0) {
      return rows[0].ReservationId;
    } else {
      return null;
    }
  } catch (error) {
    console.error('Error fetching Reservation ID:', error);
    throw new Error('Error fetching Reservation ID');
  }
}

async function getUserId(reservationId) {
  try {
    const selectQuery = 'SELECT UserId FROM RefundTable WHERE ReservationId = ?';
    const [rows, fields] = await db.promise().query(selectQuery, [reservationId]);

    if (rows.length > 0) {
      return rows[0].UserId;
    } else {
      return null; 
    }
  } catch (error) {
    console.error('Error fetching User ID:', error);
    throw new Error('Error fetching User ID');
  }
}

function getShowOptions(callback) {
  const selectQuery = 'SELECT DISTINCT ShowId FROM ShowSheduleTable';
  db.query(selectQuery, (err, result) => {
    if (err) {
      console.error('Error fetching data:', err);
      callback([]);
    } else {
      const shows = result.map((row) => row.ShowId);
      callback(shows);
    }
  });
}

function getMovieOptions(callback) {
  const selectQuery = 'SELECT DISTINCT MovieId FROM ShowSheduleTable';
  db.query(selectQuery, (err, result) => {
    if (err) {
      console.error('Error fetching data:', err);
      callback([]);
    } else {
      const movies = result.map((row) => row.MovieId);
      callback(movies);
    }
  });
}

function getUserOptions(callback) {
  const selectQuery = 'SELECT DISTINCT UserId FROM UserTable';
  db.query(selectQuery, (err, result) => {
    if (err) {
      console.error('Error fetching data:', err);
      callback([]);
    } else {
      const users = result.map((row) => row.UserId);
      callback(users);
    }
  });
}

function getReservationOptions(callback) {
  const selectQuery = 'SELECT DISTINCT ReservationId FROM SeatReservationTable';
  db.query(selectQuery, (err, result) => {
    if (err) {
      console.error('Error fetching data:', err);
      callback([]);
    } else {
      const reservations = result.map((row) => row.ReservationId);
      callback(reservations);
    }
  });
}