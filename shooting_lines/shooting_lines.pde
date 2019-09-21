ShootingSquare s;

PShader blur;

float length = 200;

void resetLine() {
  float x = random(length, width - length);
  float y = random(length, height - length);
  s = new ShootingSquare(x, y, length, width, random(2 * PI), 50, 50);
}

void setup() {
  size(600, 600, P2D);
  stroke(255);
  strokeWeight(4);

  blur = loadShader("blur.glsl");

  resetLine();
}

void draw() {
  background(23, 122, 65);
  filter(blur);

  s.move();
  s.display();

  if (s.isFinished()){
    delay(100);
    resetLine();
  }
}
