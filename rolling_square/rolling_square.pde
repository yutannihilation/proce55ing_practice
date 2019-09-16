int restAtBegin = 200;
int restAtEnd = 400;

color bgColor;

MovingObject obj;

// when the scene started in milliseconds
int startTime = -1;

void chooseBackgroundAndObject() {
  startTime = -1;
  bgColor = color(random(255), random(255), random(255));

  switch(ceil(random(6))) {
  case 0:
  case 1:
    obj = new RollingSquare(300, 300, 100, PI/8, 500);
    break;
  case 2:
    obj = new RollingSquare(300, 300, 100, -PI/8, 500);
    break;
  case 3:
  case 4:
    obj = new ShrinkingTriangle(300, 300, sqrt(2) * 100, 0.1, 500);
    break;
  case 5:
    obj = new PoppingCircle(300, 300, 100, 20, 500);
    break;
  case 6:
    obj = new PoppingCircle(300, 300, 100, -20, 500);
    break;
  }
}

void setup() {
  size(600, 600, P2D);
  chooseBackgroundAndObject();
}

void draw() {
  background(bgColor);
  obj.display();

  if (startTime < 0) {
    startTime = millis();
    delay(restAtBegin);
    return;
  }

  obj.move();

  if (obj.isFinished()) {
    delay(restAtEnd);
    chooseBackgroundAndObject();
  }
}
