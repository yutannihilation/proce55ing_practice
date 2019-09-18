PImage img;
float angle;

PShader sobelShader, blurShader;

void setup() {
  size(660, 600, P2D);
  PImage initialImg = loadImage("icon_20190903.png");

  sobelShader = loadShader("sobel_operator.glsl");

  blurShader = loadShader("blur.glsl");

  angle = 0;

  // first, draw the image on black background and detect the edges
  background(0);
  shader(sobelShader);
  image(initialImg, 0, 0);
  resetShader();

  // use ARGB. This needs alpha channel
  img = createImage(width, height, ARGB);
  
  // load the drawn pixels into img so that we can play with it
  loadPixelToImage();

  // draw the image 
  background(232, 100, 87);
  image(img, 0, 0);
  
  // if I want to capture the movie, add some delay
  // delay(5000);
}

void draw() {
  // resample the edge; this should be done before blur
  if (frameCount % 10 == 0 && random(1) > 0.95 - 0.25 * pow(min(frameCount / 1000, 1), 3)) {
    // load the current drawn canvas
    loadPixelToImage();

    // detect the edges
    shader(sobelShader);
    image(img, 0, 0);
    resetShader();

    // load the edges into img
    loadPixelToImage();
    background(232, 100, 87);
    
    // zoom randomly to add fun
    randomZoom();
  }

  // rotate at the center
  translate(width / 2, height / 2);
  rotate(angle++/300);
  translate(-width / 2, -height / 2);

  // draw image with blur
  image(img, 0, 0);
  filter(blurShader);

  // resample the blured image; this should be done after blur
  if (frameCount % 10 == 0 && random(1) > 0.95 - 0.25 * pow(min(frameCount / 1000, 1), 3)) {
    loadPixelToImage();
    randomZoom();
  }
}

void loadPixelToImage() {
  // load the current canvas
  loadPixels();

  // copy the pixel one by one
  for (int i = 0; i < width * height; i++) {
    if (brightness(pixels[i]) == 0) {
      // if the color is pure black, make the pixel transparent.
      img.pixels[i] = color(0, 0, 0, 0);
    } else {
      img.pixels[i] = pixels[i];
    }
  }
  // reflect the change to the image
  img.updatePixels();
}

void randomZoom() {
  // zoom randomly
  translate(width * (0.5 * random(-0.3, 0.3)), height * (0.5 * random(-0.3, 0.3)));
  scale(1 + pow(random(0.7), 3));
  translate(-width * (0.5 * random(-0.3, 0.3)), -height * (0.5 * random(-0.3, 0.3)));
  
  // rotate randomly
  angle += pow(random(-30, 30), 3);
}
