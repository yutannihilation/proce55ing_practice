
class ShootingLine {  
  // destination
  PVector dst;

  // duration time until the rotation finishes in milliseconds
  int duration;

  // lstart starts to move after some delay
  int durationOffset;

  float angle;
  float distance;

  // when the object is created in milliseconds
  int startTime = 0;
  int elapsed;

  // current locations (0-1)
  float lstart, lend;

  // line length
  float length;

  ShootingLine(PVector _dst, float _length, float _distance, float _angle, int _duration) {
    length = _length;

    distance = _distance;

    duration = _duration;

    angle = _angle;

    dst = _dst;

    lstart = 0;
    lend = 0;
  }

  void move() {
    if (startTime == 0) {
      startTime = millis();
    } else if (isFinished()) {
      lstart = 1;
      lend = 1;
    } else {
      elapsed = millis() - startTime;

      lend = 1 + pow(2, -10 * elapsed / duration) * sin( (elapsed / duration * 10 - 10.001) * PI / 4);

      if (distance * (lend - lstart) > length && durationOffset == 0) {
        durationOffset = elapsed;
      }

      // exponential
      lstart = 1 - pow(2, -10 * max(0, (elapsed - durationOffset)) / (duration - durationOffset));
    }
  }

  boolean isFinished() {
    return startTime != 0 && millis() - startTime >= duration;
  }

  void display() {
    PVector lstartVec = PVector.sub(dst, PVector.fromAngle(angle).mult(length + (distance - length) * (1 - lstart)));
    PVector lendVec = PVector.sub(dst, PVector.fromAngle(angle).mult(distance * (1 - lend)));
    line(lstartVec.x, lstartVec.y, lendVec.x, lendVec.y);
  }
}
