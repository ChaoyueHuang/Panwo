import processing.sound.*;
SoundFile[] notes = new SoundFile[7]; // empty place for notes
int[] melodynotes = new int[8];
SoundFile noteC, noteD, noteE, noteF, noteG, noteA, noteB;
int option = -1; //note option from 1-7, for C-A
int cur=0;
int playPointer=0;

void setup(){
  size(800,1200);
  
//load sound files into array
  notes[0] = new SoundFile (this, "C.wav");
  notes[1] = new SoundFile (this,"D.wav");
  notes[2] = new SoundFile (this,"E.wav");
  notes[3] = new SoundFile (this,"F.wav");
  notes[4] = new SoundFile (this,"G.wav");
  notes[5] = new SoundFile (this,"A.wav");
  notes[6] = new SoundFile (this,"B.wav");
  
  //initialize the melody array
  for(int i=0; i<melodynotes.length; i++){
    melodynotes[i] = i%7; //for each melody note place, 7 note options are available
  }
}

void draw() {
  background(255, 204, 0);
  
  //if started
  //play note 1
  //keypressed (left/right) --> play the prev/next note
  //keypressed (enter) --> select, and append the note to the noteArray
  //play and loop all the note in noteArray
  //keypressed (enter for the second time) --> play all note options for selection 
  

}

void keyPressed(){
//browse all the note options
 if(keyCode == UP){
    option++;
  }
  if(keyCode == DOWN){
    option--;
  }
  
 if(option > 6 || option < 0){
    option = 0;
  }
  
  notes[option].play();
  
/*  if(option == 1){
    noteC.play();
  }
  if(option == 2){
    noteD.play();
  }
  if(option == 3){
    noteE.play();
  }
  if(option == 4){
    noteF.play();
  }
  if(option == 5){
    noteG.play();
  }
  if(option == 6){
    noteA.play();
  }
  if(option == 7){
    noteB.play();
  }*/

//confirm note selection
  if(keyCode == ENTER){
      melodynotes[cur] = option; //put selected notes into melodynotes array
      notes[melodynotes[cur]].play();
      cur++;
  }

if(keyCode == SHIFT){
  while(playPointer < cur){
    option = playPointer;
    notes[melodynotes[playPointer]].play();
    fill(0);
    ellipse(playPointer*50, option*50, 30, 30);
    println(playPointer);
    try{
      Thread.sleep(500);
    } catch (Exception e){
    }
    playPointer++;
  }
  playPointer = 0;
}

}
