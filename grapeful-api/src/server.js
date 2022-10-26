const express = require('express'); //express package is required and stored in const express
const app = express(); // we build the app using the express package
const mongoose = require('mongoose');
const bodyParser= require('body-parser');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:false}));

mongoose.connect("mongodb+srv://sarahabraham:gapp12345@cluster0.eue6xyc.mongodb.net/grapeful?retryWrites=true&w=majority").then(function(){
    app.get("/", function(req,res){
    res.send("Grapeful's Setup");
    }); // uses get to communicate with the server

    const userRoutes = require('./routes/user_routes');
    app.use("/api/user", userRoutes);
});



const PORT = 5000;
app.listen(PORT, function(){
    console.log(`Server started at PORT: $(PORT)`);
}); //server listens to port 5000