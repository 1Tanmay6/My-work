"use strict";

const express = require("express");
const bodyParser = require("body-parser");
const date = require(__dirname + '/date.js');



const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));
app.set("view engine", "ejs");

const days = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
];

let items = [`Buy Food`, `Cook Food`, `Eat Food`];
let workItems = [];

app.get("/", function (req, res) {
  let day = date.getDate();
  
  items.forEach((element) => {
    let bol = element === "" ? false : true;
    if (!bol) {
      items.pop(element);
    }
  });
  res.render("list", { listTitle: day, newItems: items });
});

app.get("/work", (req, res) => {
  res.render("list", { listTitle: "Work List", newItems: workItems });
});

app.post("/work", (req, res) => {
  let item = req.body.newItem;
  workItems.push(item);
});

app.post("/", (req, res) => {
  let text = req.body.newItem;
  if (req.body.list === "Work") {
    workItems.push(text);
    res.redirect("/work");
  } else {
    items.push(text);
    res.redirect("/");
  }
  
});

app.listen(3000, function (req, res) {
  console.log("Server started at port 3000");
});
