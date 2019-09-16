class ShrinkingTriangle extends MovingObject {

  // PShape object
  PShape s1;

  // location of the center of the shape
  float x, y;

  // length of each side
  float size;

  // Current and initial bloat
  float bloat, initialBloat;

  // when the object is created in milliseconds
  float startTime = -1;

  // duration time until the rotation finishes in milliseconds
  int duration;

  ShrinkingTriangle(float _x, float _y, float _size, float _bloat, int _duration) {
    x = _x;
    y = _y;
    size = _size;
    bloat = _bloat;
    initialBloat = _bloat;
    duration = _duration;

    noFill();

    s1 = createShape(TRIANGLE, 0, size, sqrt(2) * size / 2, 0, sqrt(2) * size, size);
    s1.setStroke(color(255));
    s1.setStrokeWeight(ceil(size / 20));
  }

  void move() {
    if (startTime < 0) {
      startTime = millis();
    } else if (isFinished()) {
      bloat = 0;
    } else {
      // cubic
      // bloat = initialBloat * (1 - pow((millis() - startTime) / duration, 3));

      // exponential
      bloat = initialBloat * pow(2, -10 * (millis() - startTime) / duration);
    }
  }

  boolean isFinished() {
    return millis() - startTime >= duration;
  }

  void display() {
    pushMatrix();

    //rotate at the center of the shape
    translate(x, y);
    scale(1 + bloat);

    // move back to the top-left corner of the shape
    translate(-sqrt(2) * size / 2, -size / 2);
    shape(s1);

    popMatrix();
  }
}
