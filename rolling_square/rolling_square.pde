// A Star object
RollingSquare s1, s2;

// time after the move
float extend = 1;

void setup() {
  size(600, 600, P2D);

  // Outer square
  s1 = new RollingSquare(300, 300, 100, PI/8, 0.5);

  // Inner square
  s2 = new RollingSquare(300, 300, 50, -PI/8, 0.5);
}

void draw() {
  background(51);
 
  s1.display();
  s1.move();
  
  s2.display();
  s2.move();
}
