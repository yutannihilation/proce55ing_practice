class ShrinkingTriangle extends MovingObject {

  // PShape object
  PShape s1;

  // length of each side
  float size;

  // Current and initial bloat
  float bloat, initialBloat;
  
  // center of gravity and the vector to the top corner
  PVector center, v1;

  // when the object is created in milliseconds
  float startTime = -1;

  // duration time until the rotation finishes in milliseconds
  int duration;

  ShrinkingTriangle(float _size, float _bloat, int _duration) {
    size = _size * sqrt(2); // to make the area same as the square, multiply by sqrt(2)
    initialBloat = _bloat;
    bloat = initialBloat;
    duration = _duration;

    center = new PVector(size / 2, size / sqrt(3));
    v1 = new PVector(0, -center.y);
    // left corner
    v1.rotate(-2 * PI / 3);

    noFill();

    //s1 = createShape(TRIANGLE, -center.x, center.y / 2, 0, -center.y, center.x, center.y / 2);
    s1 = createShape();
    s1.beginShape();
    s1.vertex(-center.x, center.y / 2);
    s1.vertex(0, -center.y);
    s1.vertex(center.x, center.y / 2);
    s1.endShape(CLOSE);
    
    s1.setStroke(color(255));
    s1.setStrokeWeight(ceil(_size / 20));
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

    PVector v = PVector.mult(v1, 1 + bloat);
    s1.setVertex(0, v);
    v.rotate(2 * PI / 3);
    s1.setVertex(1, v);
    v.rotate(2 * PI / 3);
    s1.setVertex(2, v);
    
    //rotate at the center of the shape
    translate(width / 2, height / 2);
    
    shape(s1);

    popMatrix();
  }
}
