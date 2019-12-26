PFont font;
int[][] cell = new int[10][10];
Stone stone = new Stone();
StateMachine stateMachine = new StateMachine();

void setup() {
  size(400, 450);
  background(255);
  font = createFont("Osaka", 20);
  frameRate(60);
  for (int i=0; i<10; i++) {
    for (int j=0; j<10; j++) {
      cell[i][j] = 99;
    }
  }
  for (int i=1; i<=8; i++) {
    for (int j=1; j<=8; j++) {
      cell[i][j] = 0;
      fill(#00AD2F);
      rect((i-1)*50, (j-1)*50, 50, 50);
    }
  }

  stateMachine.Add(new CalcEnablePaintPlaceState());
  stateMachine.Add(new InputStoneState());
  stateMachine.Add(new PaintStoneState());
  stateMachine.Add(new FlipStoneState());
  stateMachine.Add(new ResultState());

  stateMachine.Change();

  cell[5][5] = -1;
  cell[4][4] = -1;
  cell[5][4] = 1;
  cell[4][5] = 1;
}

void draw() {  
  stateMachine.Update();
  if (stone.GameSet() == false) {
    fill(255);
    rect(100, 410, 200, 30);
    fill(0);
    if (stone.getTurn()%2 == 0) {
      text("黒のターン", 170, 430);
    } else if (stone.getTurn()%2 == 1) {
      text("白のターン", 170, 430);
    }
  }
}
