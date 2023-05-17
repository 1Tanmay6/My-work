var randomNumber1 = Math.floor(Math.random()*6 + 1);
var randomNumber2 = Math.floor(Math.random()*6 + 1);

imageChanger(".img1", randomNumber1)
imageChanger(".img2", randomNumber2)
setWinner(randomNumber1, randomNumber2)

function imageChanger(cla, randomNumber){
    document.querySelector(cla).setAttribute("src", 'images/dice' +randomNumber +'.png')
}

function setWinner(randomNumber1, randomNumber2){
    if(randomNumber1>randomNumber2){
        document.querySelector("h1").innerHTML="Player 1 wins"
    }else if(randomNumber1 === randomNumber2){
        document.querySelector("h1").innerHTML="Draw"
    }else{
        document.querySelector("h1").innerHTML="Player 2 wins"
    }
}