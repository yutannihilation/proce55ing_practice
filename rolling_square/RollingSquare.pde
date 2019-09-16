// ratio of inner square to outer square
float innerSquareScale = 0.6;

class RollingSquare extends MovingObject {

  // PShape object
  PShape s1, s2;

  // location of the center of the shape
  float x, y;

  // length of each side
  float size;

  // Current and initial rotation
  float angle, initialAngle;

  // when the object is created in milliseconds
  float startTime = -1;

  // duration time until the rotation finishes in milliseconds
  int duration;

  RollingSquare(float _x, float _y, float _size, float _angle, int _duration) {
    x = _x;
    y = _y;
    size = _size;
    angle = _angle;
    initialAngle = _angle;
    duration = _duration;

    noFill();

    // outer square
    s1 = createShape(RECT, 0, 0, size, size);
    s1.setStroke(color(255));
    s1.setStrokeWeight(ceil(size / 20));

    // inner square
    s2 = createShape(RECT, 0, 0, size * innerSquareScale, size * innerSquareScale);
    s2.setStroke(color(255));
    s2.setStrokeWeight(ceil(size / 20));
  }

  void move() {
    if (startTime < 0) {
      startTime = millis();
    } else if (isFinished()) {
      angle = 0;
    } else {
      // cubic
      // angle = initialAngle * (1 - pow((millis() - startTime) / duration, 3));

      // exponential
      angle = initialAngle * pow(2, -10 * (millis() - startTime) / duration);
    }
  }

  boolean isFinished() {
    return millis() - startTime >= duration;
  }

  void display() {
    pushMatrix();

    //rotate at the center of the shape
    translate(x, y);
    rotate(angle);

    // move back to the top-left corner of the shape
    translate(-size/2, -size/2);
    shape(s1);

    // go back to the center and rotate to the opposite direction
    translate(size/2, size/2);
    rotate(-2 * angle);

    // draw smaller square
    translate(-size * innerSquareScale/2, -size*innerSquareScale/2);
    shape(s2);

    popMatrix();
  }
}
