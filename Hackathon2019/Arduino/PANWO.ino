
int state_01 = 12;
int state_02 = 3;
int state_03 = 30;
boolean buttonUp_01 = true;
boolean buttonUp_02 = true;
boolean buttonUp_03 = true;

char val;

int switchPin_01 = 10; 
int switchPin_02 = 11;
int switchPin_03 = 12;

void setup() {

  //set initial status
  pinMode(9, OUTPUT);
  digitalWrite(9, LOW);
  pinMode(8, OUTPUT);
  digitalWrite(8, LOW);
  pinMode(7, OUTPUT);
  digitalWrite(7, LOW);
  pinMode(5, OUTPUT);
  digitalWrite(5, LOW);
  pinMode(4, OUTPUT);
  digitalWrite(4, LOW);
  pinMode(3, OUTPUT);
  digitalWrite(3, LOW);
  pinMode(2, OUTPUT);
  digitalWrite(2, LOW);

  //set button status
  pinMode(switchPin_01, INPUT);
  digitalWrite(switchPin_01, HIGH);
  pinMode(switchPin_02, INPUT);
  digitalWrite(switchPin_02, HIGH);

  Serial.begin (9600); 
}

void loop() {
  if (Serial.available()) {        
    val = Serial.read();    
  }
   
  //C moter vibrates
  if (val == 5) {
    digitalWrite(9, HIGH);
    digitalWrite(8, LOW);
    digitalWrite(7, LOW);
    digitalWrite(5, LOW);
    digitalWrite(4, LOW);
    digitalWrite(3, LOW);
    digitalWrite(2, LOW);
  }
  
  //D moter vibrates
    if (val == 6) {
    digitalWrite(8, HIGH);
    digitalWrite(9, LOW);
    digitalWrite(7, LOW);
    digitalWrite(5, LOW);
    digitalWrite(4, LOW);
    digitalWrite(3, LOW);
    digitalWrite(2, LOW);
  }
  
  //E moter vibrates
    if (val == 7) {
    digitalWrite(7, HIGH);
    digitalWrite(8, LOW);
    digitalWrite(9, LOW);
    digitalWrite(5, LOW);
    digitalWrite(4, LOW);
    digitalWrite(3, LOW);
    digitalWrite(2, LOW);
  }
  
  //F moter vibrates
    if (val == 8) {
    digitalWrite(5, HIGH);
    digitalWrite(8, LOW);
    digitalWrite(7, LOW);
    digitalWrite(9, LOW);
    digitalWrite(4, LOW);
    digitalWrite(3, LOW);
    digitalWrite(2, LOW);
  }
  
  //G moter vibrates
    if (val == 9) {
    digitalWrite(4, HIGH);
    digitalWrite(8, LOW);
    digitalWrite(7, LOW);
    digitalWrite(5, LOW);
    digitalWrite(9, LOW);
    digitalWrite(3, LOW);
    digitalWrite(2, LOW);
  }
  
  //A moter vibrates
    if (val == 10) {
    digitalWrite(3, HIGH);
    digitalWrite(8, LOW);
    digitalWrite(7, LOW);
    digitalWrite(5, LOW);
    digitalWrite(4, LOW);
    digitalWrite(9, LOW);
    digitalWrite(2, LOW);
  }
  
  //B moter vibrates
    if (val == 11) {
    digitalWrite(2, HIGH);
    digitalWrite(8, LOW);
    digitalWrite(7, LOW);
    digitalWrite(5, LOW);
    digitalWrite(4, LOW);
    digitalWrite(3, LOW);
    digitalWrite(9, LOW);
  }

// set A button to a switch
  if(digitalRead(switchPin_01) == HIGH && buttonUp_01 == true) {
    state_01 = 25 - state_01;
    buttonUp_01 = false;
  }
  else if(digitalRead(switchPin_01) != HIGH && buttonUp_01 != true) {
    buttonUp_01 = true; 
    state_01 =25 - state_01;
    Serial.write(state_01); 

  }
 Serial.print(state_01);

//set B button to a switch
  if(digitalRead(switchPin_02) == HIGH && buttonUp_02 == true) {
    state_02 = 7 - state_02;
    buttonUp_02 = false;
  }
  else if(digitalRead(switchPin_02) != HIGH && buttonUp_02 != true) {
    buttonUp_02 = true; 
    state_02 =7 - state_02;
    Serial.write(state_02);

  }
 Serial.print(state_02);

 //set C button to a switch
  if(digitalRead(switchPin_03) == HIGH && buttonUp_03 == true) {
    state_03 = 61 - state_03;
    buttonUp_03 = false;
  }
  else if(digitalRead(switchPin_03) != HIGH && buttonUp_03 != true) {
    buttonUp_03 = true; 
    state_03 =61 - state_03;
    Serial.write(state_03);

  }
 Serial.print(state_03);
 
  delay(100); // Delay
}
