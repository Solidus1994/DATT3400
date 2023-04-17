let handpose;
let video;
let predictions = [];
let score = 0;
let life = 3;
let enemyImage;
let smiley; 
let enemies = [];
let bulletSpeed = 5;
let bullets = [];
let lastBulletTime = 0;
let bulletCooldown = 500;

function preload() {
  enemyImage = loadImage("Enemy.png");
  smiley = loadImage("Smiley.png");
}

function setup() {
  createCanvas(640, 480);
  imageMode(CENTER);
  video = createCapture(VIDEO);
  video.size(width, height);

  handpose = ml5.handpose(video, modelReady);

  // This sets up an event that fills the global variable "predictions"
  // with an array every time new hand poses are detected
  handpose.on("predict", (results) => {
    predictions = results;
  });

  // Hide the video element, and just show the canvas
  video.hide();
}

function modelReady() {
  console.log("Model ready!");
}

function draw() {
  
  image(video, width/2, height/2, width, height);


  drawKeypoints();

  for (let i = 0; i < bullets.length; i++) {
    bullets[i].move();
    bullets[i].show();
  }
  
  if (random(1) < 0.01) {
    let enemy = new Enemy(width, random(height), enemyImage);
    enemies.push(enemy);
  }
  
  for (let i = bullets.length - 1; i >= 0; i--) {
  bullets[i].move();
  bullets[i].show();

  for (let j = enemies.length - 1; j >= 0; j--) {
    if (bullets[i].hits(enemies[j])) {
      bullets.splice(i, 1);
      enemies.splice(j, 1);
      break;
      }
    }
  }

for (let i = enemies.length - 1; i >= 0; i--) {
  enemies[i].move();
  enemies[i].show();

  if (enemies[i].x < -enemies[i].r) {
    enemies.splice(i, 1);
    }
  }
  
  for (let i = enemies.length - 1; i >= 0; i--) {
  enemies[i].move();
  enemies[i].show();

  if (enemies[i].x < -enemies[i].r) {
    enemies.splice(i, 1);
    life -= 1;
    break;
    }
    
    if (life <= 0) {
    gameOver();
    }

    
  }
  textSize(32);
  fill(255);
  text(`Score: ${score}`, 20, 40);
  
  textSize(32);
  fill(255);
  text(`Life: ${life}`, 20, 80);
}

function gameOver() {
  noLoop();
  textSize(64);
  fill(255, 0, 0);
  text("Game Over", width/4, height/2);
}


function drawKeypoints() {
  if (predictions.length > 0) {
    let thumb = predictions[0].landmarks[4];
    let pinky = predictions[0].landmarks[8];

    let d = dist(thumb[0], thumb[1], pinky[0], pinky[1]);
    

    let r = atan2(((thumb[0] + pinky[0]) / 2)-pinky[0],((thumb[1] + pinky[1]) / 2)-pinky[1]);
    

    push();
    translate((thumb[0] + pinky[0]) / 2, (thumb[1] + pinky[1]) / 2);
    rotate(-r);
    //ellipse(0,0, d);
    //ellipse(d/4,d/4, 10);
    image(smiley,0,0,50,50);
    pop();


  if (d < 30 && millis() - lastBulletTime > bulletCooldown) {
    let x = (thumb[0] + pinky[0]) / 2;
    let y = (thumb[1] + pinky[1]) / 2;
    let bullet = new Bullet(x, y, r);
    bullets.push(bullet);
    lastBulletTime = millis();
  }
}
  
}


class Bullet {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.r = 8;
    this.speed = 5;
    this.dir = 1;
  }

  move() {
    this.x += this.speed * this.dir;
  }

  show() {
    noStroke();
    fill(255, 0, 0);
    ellipse(this.x, this.y, this.r * 2);
  }

  hits(enemy) {
    let d = dist(this.x, this.y, enemy.x, enemy.y);
    if (d < this.r + enemy.r) {
      score++;
      return true;
    } else {
      return false;
    }
  }
}

class Enemy {
  constructor(x, y, img) {
    this.x = x;
    this.y = y;
    this.r = 20;
    this.speed = random(1, 3);
    this.img = img;
  }

  move() {
    this.x -= this.speed;
  }

  show() {
    image(this.img, this.x, this.y, this.r * 2, this.r * 2);
  }

  hits(bullet) {
    let d = dist(this.x, this.y, bullet.x, bullet.y);
    return d < this.r + bullet.r;
  }
}