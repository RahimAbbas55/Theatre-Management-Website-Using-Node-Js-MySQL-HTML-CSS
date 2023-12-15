# Theatre-Management-Website-Using-Node-Js-MySQL-HTML-CSS
Hello everyone,
This website is based on theatre/cinema management system using HTML + CSS + Javascript for Front-End and Node JS framework for backend development.
The database used in this project is "MySQL".
To run the project, follow the following steps:
1)Downloadd Visual Studio Code for your system.(Windows,Mac or Ubuntu etc)
2)Downloa the Javascript bundle extension.
3)Download the "live Server" extension.
4)Download "Node JS" framewrok from google or any other preferred browser.
5)Download "MySQL" and "MySQL Workbench".
6)Run the "f.sql" script in you workbenh soo that all tables in the database are created in your system.
7)Open the project file and make sure that "backend.js" exists in the same folder as your html files.
8)Open terminal, type "npm -y init" to initiat the node js project.
9)Then, type the following in your terminal to download the required dependencies/packages: "npm install mysql2 express nodemon".
10)Now navigate in the backend.js file where the database connection is made.Add your credentials of mysql in the required fiels, for example:
  "
    const db = mysql.createConnection({
      host: "localhost",
      user: "your_username",
      password: "your_SQL_password",
      database: "your_database_name",
    });
11)Once installed, clear your terminal and type: "nodemon backend.js".
  10.1)If you have errors installing nodemon in your system, type "node backend.js" in your terminal to start the service.
12)Once the server starts running, open your browser and type the following:
  ->"localhost:3000/main" to access the user side of the project.
  ->"localhost:3000/loginAdmin" to access the admin side of the project.

Note:
If you face any errors in setting up the project, feel free to contact me on the provided contact info in my profile description.
Happy Coding😊
