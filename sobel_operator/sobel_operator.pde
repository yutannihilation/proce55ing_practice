PImage img;
float angle;

PShader sobelShader, blurShader;

void setup() {
  size(660, 600, P2D);
  PImage initialImg = loadImage("icon_20190903.png");

  sobelShader = loadShader("sobel_operator.glsl");

  blurShader = loadShader("blur.glsl");

  angle = 0;

  background(0);

  shader(sobelShader);
  image(initialImg, 0, 0);
  resetShader();

  img = createImage(width, height, ARGB);
  loadPixelToImage();

  background(232, 100, 87);
  image(img, 0, 0);

  loadPixelToImage();
  delay(3000);
}

void draw() {
  if (frameCount % 50 == 10) {
    loadPixelToImage();

    shader(sobelShader);
    image(img, 0, 0);
    resetShader();

    loadPixelToImage();
    background(232, 100, 87);
    image(img, 0, 0);
  }

  translate(width / 2, height / 2);
  rotate(angle++/2000);
  translate(-width / 2, -height / 2);

  image(img, -width * 0.0005, -height * 0.0005, width * 1.001, height * 1.001);
  filter(blurShader);
  
  if (frameCount % 32 == 25) {
    loadPixelToImage();
  }
}

void loadPixelToImage() {
  loadPixels();
  img.loadPixels();
  for (int i = 0; i < width * height; i++) {
    if (brightness(pixels[i]) == 0) {
      img.pixels[i] = color(0, 0, 0, 0);
    } else {
      img.pixels[i] = pixels[i];
    }
  }
  img.updatePixels();
}
