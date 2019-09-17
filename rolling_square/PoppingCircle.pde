class PoppingCircle extends MovingObject {

  // PShape object
  PShape s1;

  // height and width of the circle
  float size;

  // Current and initial offset
  float offset, initialOffset;

  // when the object is created in milliseconds
  float startTime = -1;

  // duration time until the rotation finishes in milliseconds
  int duration;

  PoppingCircle(float _size, float _offset, int _duration) {
    size = _size;
    initialOffset = _offset * _size;
    offset = initialOffset;
    duration = _duration;

    noFill();

    s1 = createShape(ELLIPSE, 0, 0, size, size);
    s1.setStroke(color(255));
    s1.setStrokeWeight(ceil(_size / 20));
  }

  void move() {
    if (startTime < 0) {
      startTime = millis();
    } else if (isFinished()) {
      offset = 0;
    } else {
      // cubic
      // offset = initialOffset * (1 - pow((millis() - startTime) / duration, 3));

      // exponential
      offset = initialOffset * pow(2, -10 * (millis() - startTime) / duration);
    }
  }

  boolean isFinished() {
    return millis() - startTime >= duration;
  }

  void display() {
    pushMatrix();

    //rotate at the center of the shape
    translate(width / 2, height / 2 + offset);
    shape(s1);

    popMatrix();
  }
}
