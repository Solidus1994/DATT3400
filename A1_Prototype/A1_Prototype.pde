float angle = 0;
float radius = 200;
float smallRadius = 50;

void setup() {
  size(500, 500);
  smooth();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  noFill();
  strokeWeight(2);
  stroke(0);
  ellipse(0, 0, radius*2, radius*2); 
  float x = cos(angle) * radius;
  float y = sin(angle) * radius;
  ellipse(x, y, smallRadius*2, smallRadius*2);
  angle += 0.05; 
}
