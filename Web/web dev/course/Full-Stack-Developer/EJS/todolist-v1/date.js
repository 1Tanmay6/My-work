'use strict';

module.exports = {getDay: getDay, getDate: getDate};

function getDate(){
    let today = new Date();
    const options = { weekday: "long", day: "numeric", month: "long" };
    let day = today.toLocaleDateString("en-US", options);
    return day;
}
function getDay(){
    let today = new Date();
    const options = { weekday: "long" };
    let day = today.toLocaleDateString("en-US", options);
    return day;
}

//* There is one more way of exporting and it has been shown in date2.js 