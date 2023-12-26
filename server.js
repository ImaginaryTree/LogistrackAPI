require('dotenv').config()
const express = require('express');
const app = express();
const jwt = require('jsonwebtoken')
const mysql = require('mysql');

const connection = mysql.createConnection({
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    password: '',
    database: 'logistrack'
})

connection.connect(function(err) {
    if (err) {
        console.log(err)
    } else {
        console.log('database connection successful')
    }
})




const posts = [
    {
        username: 'muna',
        title: 'post 1'
    },
    {
        username: 'moon',
        title: 'post 2'
    },
    {
        username: 'mina',
        title: 'post 3'
    }
]

// 
// Express and JWT Configuration
//


// let token = jwt.sign(posts[0], 'iguessthisisthetoken', {expiresIn: '15s' })
// console.log(token.split(' '))


app.get('/token', (req, res) => {
    let token = jwt.sign({'username':'admin', 'role': 'admin'}, process.env.ACCESS_TOKEN, {expiresIn: '60s' })

    return res.json({'token' : token})
})



/*
----------------------------------------------------------------
                !This is User API Configuration
----------------------------------------------------------------
*/

app.post('/testing', (req, res) => {
    res.json([req.body, req.headers, req.method, req.query])
})

app.get('/posts', (req, res) =>{
    
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    // console.log(req.headers.authorization.split(' ')[1])
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        console.log(verif)
        connection.query('SELECT * FROM user', function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
    
})

app.get('/createUser', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Name = req.headers.name
        let Email = req.headers.email
        let Password = req.headers.password
        let nomorInduk = req.headers.nomor_induk
        let Status = req.headers.status
        let Verif = req.headers.verif
        const query = "INSERT INTO `user` (`nama`, `email`, `password`, `nomor_induk`, `status`, `verif`) VALUES (?, ?, ?, ?, ?, ?)"
        console.log(req.headers)
        connection.query(query,  [Name, Email, Password, nomorInduk, Status, Verif], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
})
  
/*
----------------------------------------------------------------
                !This is equipment API Configuration
----------------------------------------------------------------
*/

app.get('/equipment', (req, res) =>{
    
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    // console.log(req.headers.authorization.split(' ')[1])
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        console.log(verif)
        connection.query('SELECT * FROM equipment', function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
    
})

app.get('/equipment/add', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Name = req.headers.name
        let Description = req.headers.description
        let Quantity = req.headers.quantity
        let Image = req.headers.image
        const query = "INSERT INTO `equipment` (`name`, `description`, `quantity`, `image`) VALUES (?, ?, ?, ?)"
        console.log(req.headers)
        connection.query(query,  [Name, Description, Quantity, Image], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
})

app.get('/equipment/update', (req, res) =>{
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Id = req.headers.id
        let Name = req.headers.name
        let Description = req.headers.description
        let Quantity = req.headers.quantity
        let Image = req.headers.image

        let query = "UPDATE `equipment` SET"
        let queryParam = []

        if(Name.length > 0){
            query += " `name` = ?"
            queryParam.push(Name)
        }
        if(Description.length > 0){
            const regex = /name/;
            if(regex.test(query)){
                query += ","
            }
            query += " `description` = ?"
            queryParam.push(Description)
        }
        if(Quantity.length > 0){
            const regex = /name|description/;
            if(regex.test(query)){
                query += ","
            }
            query += " `quantity` = ?"
            queryParam.push(Quantity)
        }
        if(Image.length > 0){
            const regex = /name|description|quantity/;
            if(regex.test(query)){
                query += ","
            }
            query += " `image` = ?"
            queryParam.push(Image)
        }

        query +=  " WHERE `id` = ?;"
        queryParam.push(Id)

        // res.json([query, queryParam])
        connection.query(query,  queryParam, function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        console.log(err)
        res.sendStatus(403)
    }


})

app.get('/equipment/delete', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Id = req.headers.id
        const query = "DELETE FROM `equipment` WHERE `id`= ?;"
        // DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
        console.log(req.headers)
        connection.query(query,  [Id], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
})

/*
----------------------------------------------------------------
                !This is room API Configuration
----------------------------------------------------------------
*/

app.get('/room', (req, res) =>{
    
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    // console.log(req.headers.authorization.split(' ')[1])
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        console.log(verif)
        connection.query('SELECT * FROM room', function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
    
})

app.get('/room/add', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Name = req.headers.name
        let Description = req.headers.description
        let Capacity = req.headers.capacity
        const query = "INSERT INTO `room` (`nama`, `description`, `capacity`) VALUES (?, ?, ?)"
        console.log(req.headers)
        connection.query(query,  [Name, Description, Capacity], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
})

app.get('/room/update', (req, res) =>{
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Id = req.headers.id
        let Name = req.headers.name
        let Description = req.headers.description
        let Capacity = req.headers.capacity

        let query = "UPDATE `room` SET"
        let queryParam = []

        if(Name.length > 0){
            query += " `name` = ?"
            queryParam.push(Name)
        }
        if(Description.length > 0){
            const regex = /name/;
            if(regex.test(query)){
                query += ","
            }
            query += " `description` = ?"
            queryParam.push(Description)
        }
        if(Capacity.length > 0){
            const regex = /name|description/;
            if(regex.test(query)){
                query += ","
            }
            query += " `capacity` = ?"
            queryParam.push(Capacity)
        }

        query +=  " WHERE `id` = ?;"
        queryParam.push(Id)

        // res.json([query, queryParam])
        connection.query(query,  queryParam, function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }


})

app.get('/room/delete', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Id = req.headers.id
        const query = "DELETE FROM `room` WHERE `id`= ?;"
        // DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
        console.log(req.headers)
        connection.query(query,  [Id], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
})

/*
----------------------------------------------------------------
            !This is Loan Request API Configuration
----------------------------------------------------------------
*/

app.get('/loanReq', (req, res) =>{
    
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    // console.log(req.headers.authorization.split(' ')[1])
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        console.log(verif)
        connection.query('SELECT * FROM loanrequest', function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
    
})

app.get('/loanReq/add', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let UserName = req.headers.username
        let EventName = req.headers.eventname
        let EquipmentName = req.headers.equipmentname
        let Quantity = req.headers.quantity
        let Room = req.headers.room
        let StartDate = req.headers.startdate
        let EndDate = req.headers.enddate
        let Status = req.headers.status
        let Reason = req.headers.reason
        const query = "INSERT INTO `loanrequest` (`user_name`, `event_name`, `equipment_name`, `quantity`, `room`, `start_date`, `end_date`, `status`, `reason`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        // res.json([UserName, EventName, EquipmentName, Quantity, Room, StartDate, EndDate, Status, Reason])
        connection.query(query,  [UserName, EventName, EquipmentName, Quantity, Room, StartDate, EndDate, Status, Reason], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        console.log(err)
        res.sendStatus(403)
    }
})

app.get('/loanReq/update', (req, res) =>{
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Id = req.headers.id
        let Status = req.headers.status

        let query = "UPDATE `loanrequest` SET"
        let queryParam = []

        if(Status.length > 0){
            query += " `status` = ?"
            queryParam.push(Status)
        }

        query +=  " WHERE `id` = ?;"
        queryParam.push(Id)

        // res.json([query, queryParam])
        connection.query(query,  queryParam, function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }


})

app.get('/loanReq/delete', (req, res) =>{
    console.log(req.headers.name)
    if(req.headers.authorization == undefined){
        console.log('endi token mu')
        return res.sendStatus(401)
    }
    try{
        let verif = jwt.verify(req.headers.authorization.split(' ')[1], process.env.ACCESS_TOKEN)
        let Id = req.headers.id
        const query = "DELETE FROM `loanrequest` WHERE `id`= ?;"
        // DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
        console.log(req.headers)
        connection.query(query,  [Id], function (err, Table_data, fields) {
            if (err) throw err
            console.log(Table_data)
            res.json(Table_data)
        });
        
    }catch(err){
        res.sendStatus(403)
    }
})

app.listen(3000, "192.168.1.2")
