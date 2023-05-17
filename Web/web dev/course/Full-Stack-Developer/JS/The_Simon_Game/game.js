let buttonColors = ["red", "green", "blue", "yellow"];
var gamePattern = [];
var userClickPattern = [];
var level = 0;
var startOverBool = false;

function playSound(name) {
    var audio = new Audio("./sounds/" + name+".mp3");
    audio.play();
}

function animatePress(currentColor) {
    $("#"+currentColor).addClass('pressed');
    setTimeout(() => {
        $("#"+currentColor).removeClass('pressed');
    }, 100);
}

function handler(id) {
    var userChosenColor = id;
    userClickPattern.push(userChosenColor);
    checkAnswer(level-1);
    console.log('userClickPattern: ' + userClickPattern);
}

function nextSequence() {
    userClickPattern = [];
    var randomNumber = Math.floor((Math.random() * 4));
    var randomChosenColor = buttonColors[randomNumber];
    gamePattern.push(randomChosenColor);

    $("#"+randomChosenColor).fadeOut(100).fadeIn(100);
    playSound(randomChosenColor);
    
    level++;
    $("h1").text("level " + level);
    console.log('gamePattern: ' + gamePattern);
}

function checkAnswer(currentLevel) {
        if(gamePattern[currentLevel] == userClickPattern[currentLevel]){
            console.log("success");
            setTimeout(() => {
                userClickPattern = [];
                nextSequence();
            }, 1000);
        }else{
            console.log("failed");
            wrong();
        }   
}

function wrong() {
    var istrue = false;
    for (let i = 0; i<userClickPattern.length;i++){
        if(userClickPattern[i] == gamePattern[i]){
            istrue = true;
        }else{
            istrue = false;
        }
    }
    if(!istrue){
        startOverBool = true;
        playSound('wrong');
        $("h1").text("Game Over, Press Any Key to Restart");
        $("body").addClass('game-over');
    setTimeout(() => {
        $("body").removeClass('game-over');
    }, 200);
        
    }
}


function startOver() {
    gamePattern = [];
    level = 0;
    userClickPattern = [];
    startOverBool = false;
}

$(".btn").click(function (event) {
    playSound(event.target.id);
    animatePress(event.target.id);
   handler(event.target.id);
});

$(document).keypress(function (event) {
    if(startOverBool){
        startOver();
    }else{
        $("h1").text("level " + level);
        userClickPattern = [];
        nextSequence(); 
    }

});