import processing.serial.*;
import processing.sound.*;

SoundFile[] notes = new SoundFile[7]; // empty place for notes
int[] melodynotes = new int[8];
SoundFile noteC, noteD, noteE, noteF, noteG, noteA, noteB;
int option = -1; //note option from 1-7, for C-A
int cur=0;
int playPointer=0;

Serial port;

void setup(){
  size(800,1200);
  
  //viberation
 // String portName = Serial.list()[3]; // replace this number with the port you are using
 // port = new Serial(this, portName, 9600);
  
//load sound files into array
  notes[0] = new SoundFile (this, "C.wav");
  notes[1] = new SoundFile (this,"D.wav");
  notes[2] = new SoundFile (this,"E.wav");
  notes[3] = new SoundFile (this,"F.wav");
  notes[4] = new SoundFile (this,"G.wav");
  notes[5] = new SoundFile (this,"A.wav");
  notes[6] = new SoundFile (this,"B.wav");
  
  background(255, 204, 0);
}

void draw() {
    fill(0);
    ellipse(playPointer*50, playPointer*50, 30, 30);
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
 //   port.write("option");
  }
  if(keyCode == DOWN){
    option--;
  }
  
 if(option > 6 || option < 0){
    option = 0;
  }
  
  notes[option].play();
  

//confirm note selection
  if(keyCode == ENTER){
      melodynotes[cur] = option; //put selected notes into melodynotes array
      notes[melodynotes[cur]].play();
      cur++;
  }

  if(keyCode == SHIFT){
    new Thread(new Runnable(){
      public void run(){
        while(playPointer < cur) {
          notes[melodynotes[playPointer]].play();
          playPointer++;
          
          try{
            Thread.sleep(500);
          } catch (Exception e){
          }
        }

      }
    }).start();
    
    playPointer = 0;
   
  }

}
