const express = require("express");
const https = require("https");
const bodyParser = require("body-parser");
const app = express();
app.use(bodyParser.urlencoded({extended: true}));


app.get("/", function (req, res) {
    // res.send("hi");
    res.sendFile(__dirname + "/index.html");

});

app.post("/", function(req, res){
    
    const query = req.body.cityName;
    console.log(query)
const apiKey = "c303e4eee629334a33db69df2e4ae29d";
const url = `https://api.openweathermap.org/data/2.5/weather?q=${query}&APPID=${apiKey}&units=metric`;

https.get(url, function (response) { 


    response.on("data", function (data) { 
        const weatherData = JSON.parse(data);
        const description = weatherData.weather[0].description;
        const feels = weatherData.main.feels_like;
        const icon = weatherData.weather[0].icon;
        const imageUrl = `https://openweathermap.org/img/wn/${icon}@2x.png`
        console.log(icon);
        // res.send(`
        // <h1>The temperature in Neemrana is ${feels} C.</h1>
        // <em>The weather is currently ${description}</em>
        // `);
        //  or
        res.write(`<h1>The temperature in ${query} is ${feels} C.</h1>`);
        res.write(`<em>The weather is currently ${description}</em>`);
        res.write(`<hr width="0">`)
        res.write(`<img src="${imageUrl}" alt="">`)
        res.send();

     });
 });

})



app.listen(3000, function () { 
    console.log("Server Started at port 3000");
 });