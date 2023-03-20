float sunRadius = 50;
float moonRadius = 20;
float earthRadius = 100;

float sunRotation = 0;
float moonRotation = 0;

float sunDistance = 200;
float moonDistance = 70;

float tideHeight = 0;

void setup() {
  size(500, 500);
  smooth();
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  
  // Draw Sun
  fill(255, 255, 0);
  ellipse(0, 0, 2*sunRadius, 2*sunRadius);
  
  // Draw Moon
  pushMatrix();
  rotate(moonRotation);
  translate(moonDistance, 0);
  fill(255);
  ellipse(0, 0, 2*moonRadius, 2*moonRadius);
  popMatrix();
  
  // Draw Earth
  pushMatrix();
  rotate(sunRotation);
  translate(sunDistance, 0);
  rotate(moonRotation);
  translate(moonDistance, 0);
  fill(0, 0, 255);
  ellipse(0, 0, 1.2*earthRadius, 1.2*earthRadius);
  
  // Draw tide
  tideHeight = sin(moonRotation + sunRotation) * earthRadius/2;
  fill(255, 255, 255, 150);
  ellipse(0, 0, 1.2*earthRadius + tideHeight, 1.2*earthRadius + tideHeight);
  
  popMatrix();
  
  sunRotation += 0.01;
  moonRotation += 0.05;
}
