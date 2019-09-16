int restAtBegin = 50;
int movingDuration = 300;
int restAtEnd = 100;

int baseSize = 150;

color bgColor;

MovingObject obj;

// when the scene started in milliseconds
int startTime = -1;

PShader blur;

void chooseBackgroundAndObject() {
  startTime = -1;
  bgColor = color(random(10, 200), random(10, 200), random(10, 200));

  switch(ceil(random(6))) {
  case 0:
  case 1:
    obj = new RollingSquare(300, 300, baseSize, PI/8, movingDuration);
    break;
  case 2:
    obj = new RollingSquare(300, 300, baseSize, -PI/8, movingDuration);
    break;
  case 3:
  case 4:
    obj = new ShrinkingTriangle(300, 300, baseSize, 0.1, movingDuration);
    break;
  case 5:
    obj = new PoppingCircle(300, 300, baseSize, 20, movingDuration);
    break;
  case 6:
    obj = new PoppingCircle(300, 300, baseSize, -20, movingDuration);
    break;
  }
}

void setup() {
  size(600, 600, P2D);
  // blur = loadShader("blur.glsl"); 

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
  
  // blur twice
  // filter(blur);
  // filter(blur);

  if (obj.isFinished()) {
    delay(restAtEnd);
    chooseBackgroundAndObject();
  }
}
