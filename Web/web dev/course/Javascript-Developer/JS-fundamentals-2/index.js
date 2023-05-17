'use strict';

// function calcAge (birthYear) {
//     return 2023 - birthYear;
// }

// console.log(calcAge(1991));

// Arrow Function
// const calcAge2 = birthYear => 2023 - birthYear;
// console.log(calcAge2(23));

// const yearsUntilRetirement = (firstName, birthYear) => {
//     const age = 2023 - birthYear;
//     const retirement = 65 - age;

//     return`${firstName} is going to retire in ${retirement} years.`;
// };

// console.log(yearsUntilRetirement(`Bob`, 2003));

//* coding challenge 1 *//

// const calcAverage = (num1, num2, num3) => (num1+num2+num3)/3;
// const Averaged = calcAverage(85, 54, 41);
// const Averagek = calcAverage(23, 34, 27);

// function checkWinner (Averaged, Averagek) {
//     if(Averaged >= (Averagek*2)){
//         console.log(`Dolphins win (${Averaged} vs ${Averagek})`);
//     } else if (Averaged === Averagek) {
//         console.log(`DRAW!! (${Averaged} vs ${Averagek})`);
//     } else if (Averagek >= (Averaged*2)){
//         console.log(`Koalas win (${Averaged} vs ${Averagek})`);
//     } else {
//         console.log(`No one wins (${Averaged} vs ${Averagek})`);
//     }
// }

// checkWinner(Averaged, Averagek);

//*coding challenge 2*//

// const bills = [125, 555, 44];
// const tips = [];
// const total = [];
// const calcTip = billValue => 
// (50 <= billValue <= 300) ? 
// 0.15 * billValue : 
// 0.2 * billValue;

// const tipsAdder = bills => {
//     bills.forEach(billValue => {
//         const tipvalue = calcTip(billValue);
//         tips.push(tipvalue);
//     });
// };

// const totalMaker = (bills, tips, i) => {
//     const tota = bills[i]+tips[i];
//     total.push(tota);
// }

// tipsAdder(bills);
// totalMaker(bills, tips, 0);
// totalMaker(bills, tips, 1);
// totalMaker(bills, tips, 2);
// console.log(bills);
// console.log(tips);
// console.log(total);

//* coding challenge 3 *//

// const markMiller = {
//     fullName: 'Mark Miller',
//     mass: 78,
//     height: 1.69,
//     bmiCalc: function()  {
//         return this.mass/this.height**2;
//     },

// }
// const johnSmith = {
//     fullName: 'John Smith',
//     mass: 92,
//     height: 1.95,
//     bmiCalc: function()  {
//         return this.mass/this.height**2;
//     },
// }


// const markBmi = markMiller.bmiCalc();
// const johnBmi = johnSmith.bmiCalc();

// markBmi > johnBmi ? 
// console.log(`Mark(${markBmi}) has higher BMI than John(${johnBmi})`) : 
// johnBmi > markBmi ? 
// console.log(`John(${johnBmi}) has higher BMI than Mark(${markBmi})`) :
// console.log(`Mark(${markBmi}) has equal BMI as John(${johnBmi})`);

//* coding challenge 4 *//

// const bills = [22, 295, 440, 37, 105, 10, 1100, 86, 52];
// const tips = [];
// const total = [];
// const calcTip = billValue => 
// (50 <= billValue <= 300) ? 
// 0.15 * billValue : 
// 0.2 * billValue;

// const tipsAdder = bills => {
//     for(let i = 0; i< bills.length; i++){
//         const tipValue = calcTip(bills[i]);
//         tips.push(tipValue);
//     };
// };

// const totalMaker = (bills, tips) => {
//     for(let i = 0; i< bills.length; i++){
//         const tota = bills[i]+tips[i];
//         total.push(tota);
//     };
// };

// const averageMaker = (arr) => {
//     var sum = 0;
//     for(let i = 0; i< arr.length; i++){
//         sum+=arr[i];
//     };
//     return sum / arr.length;
// }

// tipsAdder(bills);
// totalMaker(bills, tips);

// console.log(tips);
// console.log(total);
// console.log(averageMaker(total));
