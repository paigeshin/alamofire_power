const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const expressSession= require('express-session');

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json()); //json 데이터로 받을 때 반드시 bodyParser.json()를 써줘야함.
app.use(
    expressSession({
        secret: "Demo Application",
        resave: false,
        saveUninitialized: false
    })
);

let message = {
    user: '',
    message: ''
};

app.get('/', (req, res) => {
    console.log('Get Request called');
    message.user = "user1";
    message.message = "Get response";
    res.json(message)
});

//Header base64 decoding
app.get('/header', (req, res) => {
    console.log(req.headers);
    console.log(req.headers.authorization);
    let encodedData =  req.headers.authorization.split(' ')[1];
    let buff = new Buffer.from(encodedData, 'base64');
    let base64data = buff.toString('ascii');
    console.log(base64data);

    message.user = "user1";
    message.message = "Post response with Header";
    res.json(message)
});

app.post('/auth', (req, res) => {
    console.log(req.body);
    console.log(req.headers);


    message.user = "user1";
    message.message = "Post response with post auth";
    res.json(message)
});

app.get('/credential', (req, res) => {
    console.log(req.headers);
    console.log(req.withCredentials);
    message.user = "user1";
    message.message = "Post response with post credential";
    res.json(message)
});

app.post('/credential', (req, res) => {
    console.log(req.headers);
    console.log(req.withCredentials);
    message.user = "user1";
    message.message = "Post response with post credential";
    res.json(message)
});

app.post('/', (req, res) => {
    console.log(req.body);
    console.log('Post Request Called');
    message.user = req.body.user;
    message.message = "Post response";
    res.json(message)
});

app.put('/', (req, res) => {
    console.log(req.body);
    console.log('Put Request Called');
    message.user = req.body.user;
    message.message = "Put response";
    res.json(message)
});

app.delete('/', (req, res) => {
   console.log(req.body);
   message.user = req.body.user;
   message.message = "Delete response";
   res.json(message)
});

app.listen(5544, () => {
   console.log(`Server Listening on 5544`)
});