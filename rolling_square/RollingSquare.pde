class RollingSquare {

  // PShape object
  PShape s;

  // location of the center of the shape
  float x, y;

  // length of each side
  float size;
  
  // Current and initial rotation
  float angle, initialAngle;
  
  // when the object is created in milliseconds
  float startTime = -1;
  
  // duration time until the rotation finishes
  float duration;
  
  RollingSquare(float _x, float _y, float _size, float _angle, float _duration) {
    x = _x;
    y = _y;
    size = _size;
    angle = _angle;
    initialAngle = _angle;
    duration = _duration;

    noFill();
    s = createShape(RECT, 0, 0, size, size);
    s.setStroke(color(255));
    s.setStrokeWeight(4);
  }

  void move() {
    if (startTime < 0) {
      startTime = millis();
    } else if (isFinished()) {
      angle = 0;
    } else {
      // cubic
      // angle = initialAngle * (1 - pow((millis() - startTime) / duration / 1000, 3));
      
      // exponential
      angle = initialAngle * pow(2, -10 * (millis() - startTime) / duration / 1000);
    }
  }
  
  boolean isFinished() {
    return millis() - startTime >= duration * 1000;
  }

  void display() {
    pushMatrix();

    //rotate at the center of the shape
    translate(x, y);
    rotate(angle);

    // move back to the top-left corner of the shape
    translate(-size/2, -size/2);
    shape(s);
    popMatrix();
  }
}
