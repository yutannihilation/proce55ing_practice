int restAtBegin = 500;
int restAtEnd = 500;

color bgColor;

MovingObject obj;

// when the scene started in milliseconds
int startTime = -1;

void chooseBackgroundAndObject() {
  startTime = -1;
  bgColor = color(random(255), random(255), random(255));
  obj = new RollingSquare(300, 300, 100, PI/8, 500);
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
