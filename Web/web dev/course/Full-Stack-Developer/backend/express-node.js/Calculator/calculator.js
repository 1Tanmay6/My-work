const express = require("express");
var bodyParser = require("body-parser");

const app = express();


app.use(bodyParser.urlencoded({extended: true}));

app.get("/", function(req, res){
    res.sendFile(__dirname + "/index.html");
});

app.get("/bmiCalculator", function(req, res){
    res.sendFile(__dirname + "/bmiCalculator.html")
});

app.post("/bmiCalculator", function (req, res) {
    var weight = Number(req.body.weight);
    var height = Number(req.body.height);
    var hsq = height*height;

    var bmi = weight/hsq;

    res.send("Your BMI: " + bmi );
    
})

app.post("/", function(req, res){
    
    var num1 = Number(req.body.num1);
    var num2 = Number(req.body.num2);

    var result = num1 + num2;
    res.send("Result is: " + result);
})

app.listen(3000, function () {
    console.log("The server started at port 3000.");
});