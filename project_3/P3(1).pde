import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
}

void draw() {
  if (video.available()) {
    video.read();
    opencv.loadImage(video);
    opencv.flipHorizontal();
    image(video, 0, 0);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(2);
    Rectangle[] faces = opencv.detect();
    for (int i = 0; i < faces.length; i++) {
      Rectangle r = faces[i];
      rect(r.x, r.y, r.width, r.height);
      noFill();
      stroke(255, 0, 0);
      strokeWeight(1);
      Rectangle[] eyes = opencv.detect(OpenCV.CASCADE_EYE, r.x, r.y, r.width, r.height);
      for (int j = 0; j < eyes.length; j++) {
        rect(r.x + eyes[j].x, r.y + eyes[j].y, eyes[j].width, eyes[j].height);
      }
      Rectangle[] noses = opencv.detect(OpenCV.CASCADE_NOSE, r.x, r.y, r.width, r.height);
      for (int j = 0; j < noses.length; j++) {
        rect(r.x + noses[j].x, r.y + noses[j].y, noses[j].width, noses[j].height);
      }
      Rectangle[] mouths = opencv.detect(OpenCV.CASCADE_MOUTH, r.x, r.y, r.width, r.height);
      for (int j = 0; j < mouths.length; j++) {
        rect(r.x + mouths[j].x, r.y + mouths[j].y, mouths[j].width, mouths[j].height);
      }
    }
  }
}
