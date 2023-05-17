'use strict';

const measurement = {
  type: 'temp',
  unit: 'Celsius',
};

const td1 = [17, 21, 23];
const td2 = [12, 5, -5, 0, 4];

//! console.table(measurement);

const printForecast = function (arr) {
  var string = '';
  for (let i = 0; i < arr.length; i++) {
    var subStr = `...${arr[i]}C in ${i + 1} days`;
    string += subStr;
  }
  string += '...';
  return string;
};

console.log(printForecast(td1));
console.log(printForecast(td2));
