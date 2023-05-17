const express = require("express");
const bodyParser= require("body-parser");
const request = require("request");
const https = require("https");

const app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static("public"));

app.get("/", function (req, res) { 
    res.sendFile(__dirname + "/signup.html");
 });

app.post("/failure", function (req, res) { 
    res.redirect("/");
 })

app.post("/", function (req, res) { 
    const firstName = req.body.fname;
    const lastName = req.body.lname;
    const email = req.body.email;

    const data = {
       members: [
        {
            email_address: email,
            status: 'subscribed',
            merge_fields: {
                FNAME: firstName,
                LNAME: lastName
            }
        }
       ] 
    };

    const jsonData = JSON.stringify(data);

    const url = "https://us17.api.mailchimp.com/3.0/lists/daff7143d8"
    const options = {
        method: "POST",
        auth: "Tanmay1:fbe64895e515f8bf5333abe689c4676f-us17"
    }

    const request = https.request(url, options, function(response) {

        response.statusCode === 200 ?
          res.sendFile(__dirname + "/success.html") 
        : res.sendFile(__dirname + "/failure.html");

        response.on("data", function(data){
            // console.log(JSON.parse(data));
        })
    })
    request.write(jsonData);
    request.end();
    console.log(firstName, lastName, email);
 })

app.listen(3000, function (req, res) { 
    console.log("Server Started!");
 });

// fbe64895e515f8bf5333abe689c4676f-us17
// daff7143d8
// https://us17.api.mailchimp.com/3.0/