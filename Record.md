### adding package.json
 package.json is a file that record all the information about your project , such as its name, version, description, main file, scripts, author, license, and dependencies. The reason adding package.json so that is to simplified the command line to run nodemon server. Below are the code to add package.json.

- npm init -y

### Installing Express library
Express library will be used as the route for the API so that it can interact the data store in the database through url link. Below are the code to install Express.

- npm install express

### Installing JSON Web Token ( JWT ) library
JWT library will be used to generate API Authentication so that only someone with the auth can use the API. Below are the code to install Json Web token.

- npm install jsonwebtoken

### Installing dotenv library
dotenv can be used to store the Auth token as parameter. Below are the code to install dotenv.

- npm install dotenv 

after install dotenv library you can create file and named .env then write all the parameters you want to store in it.

### Installing nodemon library
Nodemon is used to run server the API and it will automatically refresh every time you change the code. Below are the code to install nodemon.

- npm install --save-dev nodemon