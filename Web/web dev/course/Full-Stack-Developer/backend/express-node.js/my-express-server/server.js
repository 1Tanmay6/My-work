const express = require("express");
const app = express();

app.get("/", function(req, res) {
    res.send("<h1>Hello World</h1>");
});

app.get("/contact", function (req, res) {
    res.send("Contact me at something.com");
});

app.get("/about", function(req, res){
    res.send("This is me. The owner of this website.");
});

app.get("/hobbies", function (req, res) {
    res.send("<ul><li>Programming</li><li>Games</li></ul>")
})

app.listen(3000, function () {
    console.log('Server hosted at port 3000');
});