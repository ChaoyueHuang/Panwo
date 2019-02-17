/**
 * shows how to create a sequence of animations (timeline)
 *    
 * KEYS
 * space           : toggle, pause and resume sequence
 * s               : start or restart sequence
 */

import de.looksgood.ani.*;

float x, y, diameter;
AniSequence seq;

void setup() {
  size(960,560);
  smooth();
  noStroke();
  textAlign(CENTER);
  background(255);

  x = 50;
  y = 300;
  diameter = 3;

  // Ani.init() must be called always first!
  Ani.init(this);

  // create a sequence
  // dont forget to call beginSequence() and endSequence()
  seq = new AniSequence(this);
  seq.beginSequence();
 // int N[][] = new int[4][2];
  int N[][]={
    {50,300},
    {50,50},
    {150,300},
    {150,50}
  };
  int Y[][]={
    {230,170},
    {310,50},
    {230,170},
    {230,300},
    {230,170},
    {310,50}
  };
  int U[][]={
     {310,225},
     {360,300},
     {410,300},
     {460, 225},
     {460,50}
  };
  
  point(N);
  point(Y);
  point(U);
  // step 0
  //seq.add(Ani.to(this, 1, "diameter", 3));
  //seq.add(Ani.to(this, 1, "x:50,y:300"));
  //seq.add(Ani.to(this, 1, "x:50,y:50"));
  //seq.add(Ani.to(this, 1, "x:150,y:300"));
  //seq.add(Ani.to(this, 1, "x:150,y:50"));
  //seq.add(Ani.to(this,1, "x:225,y:170"));
  //seq.add(Ani.to(this,1, "x:225,y:170"));
  
  
  // step 4
  seq.beginStep();
  //seq.add(Ani.to(this, 1, "x:50,y:300"));
  //seq.add(Ani.to(this, 2, "diameter", 3));
  seq.endStep();

  seq.endSequence();

  // start the whole sequence
  seq.start();

}

void draw() {
  fill(255,5);
  rect(0,0,width,height);
  
  //println(seq.isFinished());

  fill(0);
  ellipse(x,y,diameter,diameter);
}

// pause and resume animation by pressing SPACE
// or press "s" to start the sequence
void keyPressed() {
  if (key == 's' || key == 'S') seq.start();
  if (key == ' ') {
    if (seq.isPlaying()) seq.pause();
    else seq.resume();
  }
}

void point(int n[][]){
  String coo1;
  for(int[] t: n){
     int x=t[0], y=t[1]; 
     coo1 = "x:"+x+",y:"+y;
     seq.add(Ani.to(this, 1, coo1));
  }
}
