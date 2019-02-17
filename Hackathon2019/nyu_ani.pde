/**
 * shows how to create a sequence of animations (timeline)
 *    
 * KEYS
 * space           : toggle, pause and resume sequence
 * s               : start or restart sequence
 */

import de.looksgood.ani.*;

float x_, y_, diameter_;
AniSequence seq_;

void nyu(){
    smooth();
    noStroke();

    x_ = 50;
    y_ = 300;
    diameter_ = 3;

  // Ani.init() must be called always first!
    Ani.init(this);

  // create a sequence
  // dont forget to call beginSequence() and endSequence()
    seq_ = new AniSequence(this);
    seq_.beginSequence();
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

  
  // step 4
  seq_.beginStep();
  //seq.add(Ani.to(this, 1, "x:50,y:300"));
  //seq.add(Ani.to(this, 2, "diameter", 3));
  seq_.endStep();

  seq_.endSequence();

  // start the whole sequence
  seq_.start();
  
  //call the display and point functions
  // display();

}
  
    void display() {
    
    fill(255,5);
    rect(0,0,width,height);
    
        fill(0);
    ellipse(x_,y_,diameter_,diameter_);
    
    //println(seq.isFinished());
  

    }


// pause and resume animation by pressing SPACE
// or press "s" to start the sequence
//void keyPressed() {
//  if (key == 's' || key == 'S') seq_.start();
//  if (key == ' ') {
//    if (seq_.isPlaying()) seq_.pause();
//    else seq_.resume();
//  }


  void point(int n[][]){
    String coo1;
    for(int[] t: n){
       int x=t[0], y=t[1]; 
       coo1 = "x_:"+x+",y_:"+y;
       seq_.add(Ani.to(this, 1, coo1));
    }
  }
