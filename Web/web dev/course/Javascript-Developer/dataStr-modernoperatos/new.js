// const array1 = [2,4,[5,6]];

// const [x, ,z] = array1;
// // console.log(x);
// // console.log(z);

// const [a,b] = z;
// // console.log(a);
// // console.log(b);

// const onject = {
//     name: "Tanmay Patil",
//     courses: ["C", "C++", "HTML", "CSS"],
//     iq: 10,
//     workable: false,
// }

// const {name, iq} = onject
// console.log(name);

//! changing the name
// const {name: myName, iq: myiq} = onject;
// console.log('myName:',myName ,'\nmyiq:', myiq);

//! default values

// const {menu = [], iq: mwiq = 0} = onject;
// console.log(menu);
// console.log(mwiq);

//! mutating variables
// let num1 = 111;
// let num2 = 999;
// const obj = {a: 23, b: 7, c:14};
//  Use prenthesis for mutation as curly braces denotes a code block so add parenthesis to remove the error()
// ({num1,num2} = obj);
// console.log(a, b);

//! spread operator
// const arr = [1,2,3];
// console.log(...arr);

//! // SPREAD operator is always on the right side of the =
// const arr1 = [23,241,121, ...arr];

//! // REST operator because it is on left side of the = as it is used to pack elements in an array which is the opposite of the spread operator
// const [a, c, ...others] = [1, 2,3,4,5];

// console.log(a, c, others);

//! Operators
//! operators can USE ANY DATATYPE and can return any value

// console.log(34 && 0);
// console.log(true && false);
// console.log('' && 'Tanmay');
// console.log('Tanmay' && 0);

//! Nullish operator

// const guestCorrector = null ?? 10;
// console.log(guestCorrector);

//! Assignment operator

const rest1 = {
  name: "hi",
  numberofguests: 0,
};

const rest2 = {
  name: "hu",
  numberofguests: 0,
};
rest1.numberofguests &&= 10;
rest1.numberofguests ||= 10;
rest2.numberofguests ??= 10;

console.log(rest1.numberofguests);
console.log(rest2.numberofguests);
