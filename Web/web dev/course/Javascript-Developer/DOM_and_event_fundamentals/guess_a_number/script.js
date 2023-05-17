'use strict';

// console.log(document.querySelector('.message').textContent);
// document.querySelector('.message').textContent = 'Correct Answer';

//! console.log(document.querySelector('.guess').value);

let score = 20;
let highScore = 0;
let secretNumber = Math.floor(Math.random() * 20 + 1);

function scoreIfAndElse(message) {
  if (score > 1) {
    score--;
    document.querySelector('.score').textContent = score;
    document.querySelector('.message').textContent = message;
  } else {
    document.querySelector('.score').textContent = 0;
    document.querySelector('.message').textContent = 'You lost the game.';
  }
}

document.querySelector('.check').addEventListener('click', function () {
  const guess = Number(document.querySelector('.guess').value);

  if (!guess) {
    document.querySelector('.message').textContent = 'No Number';
  } else if (guess === secretNumber) {
    document.querySelector('.message').textContent = 'Correct Guess!!';
    document.querySelector('.number').textContent = secretNumber;
    document.querySelector('body').style.backgroundColor = '#4BB543';
    document.querySelector('.number').style.width = '30rem';
    if (score > highScore) {
      highScore = score;
    }
    document.querySelector('.highscore').textContent = highScore;
  } else if (guess !== secretNumber) {
    guess > secretNumber && guess !== secretNumber
      ? scoreIfAndElse('Your guess is Higher')
      : scoreIfAndElse('your guess is Lower');
  }
});

document.querySelector('.again').addEventListener('click', function () {
  score = 20;
  document.querySelector('.score').textContent = score;
  document.querySelector('.message').textContent = 'Start guessing...';
  document.querySelector('.number').textContent = '?';
  document.querySelector('body').style.backgroundColor = '#222';
  document.querySelector('.number').style.width = '15rem';
  secretNumber = Math.floor(Math.random() * 20 + 1);
});
