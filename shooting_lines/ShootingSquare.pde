class ShootingSquare {
  ShootingLine leftLine, topLine, rightLine, bottomLine;

  // delay:delay between each line
  float delay;

  int startTime;

  int elapsed;

  ShootingSquare(float x, float y, float _length, float _distance, float _angle, int _duration, int _delay) {
    delay = _delay;
    
    PVector center = new PVector(x, y);
    PVector toCorner = new PVector(- _length / 2, - _length / 2).rotate(_angle);

    leftLine   = new ShootingLine(PVector.add(center, toCorner), _length, _distance, _angle - PI / 2, _duration + _delay * 6);
    topLine    = new ShootingLine(PVector.add(center, toCorner.rotate(PI / 2)), _length, _distance, _angle, _duration + _delay * 6);
    rightLine  = new ShootingLine(PVector.add(center, toCorner.rotate(PI / 2)), _length, _distance, _angle + PI / 2, _duration + _delay * 6);
    bottomLine = new ShootingLine(PVector.add(center, toCorner.rotate(PI / 2)), _length, _distance, _angle + PI, _duration + _delay * 6);

    startTime = millis();
  }

  boolean isFinished() {
    return bottomLine.isFinished();
  }

  void move() {
    elapsed = millis() - startTime;
    
    leftLine.move();
    
    if (elapsed > 3 * delay) {
      topLine.move();
    }
    
    if (elapsed > delay * 4) {
      rightLine.move();
    }
    
    if (elapsed > delay * 5) {
      bottomLine.move();
    }
  }

  void display() {
    leftLine.display();
    topLine.display();
    rightLine.display();
    bottomLine.display();
  }
}
