public class Stone {
  //cellState(cell[x][y]) … 0:null, 1:black, -1:white
  private int _turn = 1; //奇数:黒, 偶数:白
  private color[] _col = {#000000, #FFFFFF}; //黒, 白
  private color cellColor = #00AD2F;
  public boolean _isPut = false;
  public boolean _isTurnOn = true;
  public boolean _checkColor = true;
  private boolean _canPut = true;
  private boolean _gameSet = false;
  private int _cx = 100;
  private int _cy = 100;
  private int _inputX = 0;
  private int _inputY = 0;
  private int _countB;
  private int _countW;

  public int getTurn() {
    return this._turn;
  }

  public boolean GameSet() {
    return this._gameSet;
  }

  public boolean IsPut(boolean value) {
    _isPut = value;
    return this._isPut;
  }

  public boolean IsTurnOn(boolean value) {
    _isTurnOn = value;
    return this._isTurnOn;
  }

  public boolean CheckColor(boolean value) {
    _checkColor = value;
    return this._checkColor;
  }

  public boolean CountColor() {
    for (int i=1; i<=8; i++) {
      for (int j=1; j<=8; j++) {
        if (cell[i][j] == 0) break;
        if (i==8 && j==8) {
          return true;
        }
      }
    }
    return false;
  }

  public void CalcResult() {
    for (int i=1; i<=8; i++) {
      for (int j=1; j<=8; j++) {
        if (cell[i][j] == 1 && _gameSet == false) _countB++;
        if (cell[i][j] == -1 && _gameSet == false) _countW++;
      }
    }
    println("B:", _countB, " ", "W:", _countW);
    fill(255);
    rect(310, 405, 80, 40);
    fill(0);
    text("白："+_countW, 335, 420);
    text("黒："+_countB, 335, 440);
    if (_countB+_countW <64) {
      _countB = 0;
      _countW = 0;
    }

    if (_countB + _countW >= 64) {
      _gameSet = true;
      fill(255);
      rect(100, 410, 200, 30);
      fill(0);
      if (_countB>_countW) {
        text("黒の勝ち", 180, 430);
      } else if (_countB<_countW) {
        text("白の勝ち", 180, 430);
      } else if (_countB == _countW) {
        text("引き分け", 180, 430);
      }
    }
  }

  public void PaintStone() {
    for (int i=1; i<=8; i++) {
      for (int j=1; j<=8; j++) {
        fill(#00AD2F);
        rect((i-1)*50, (j-1)*50, 50, 50);
        int x = -25 + 50*i;
        int y = -25 + 50*j;
        if (cell[i][j] == 1) {
          //print("b");
          fill(_col[0]);
          ellipse(x, y, 40, 40);
        } else if (cell[i][j] == -1) {
          //print("w");
          fill(_col[1]);
          ellipse(x, y, 40, 40);
        }
      }
    }
  }

  public void CalcEnablePaintPlace() {
    for (int i=1; i<=8; i++) {
      for (int j=1; j<=8; j++) {
        if (EnablePut(i, j, 1, 0) || EnablePut(i, j, 1, -1) || EnablePut(i, j, 1, 1) || EnablePut(i, j, 0, -1) || EnablePut(i, j, 0, 1) || EnablePut(i, j, -1, -1) || EnablePut(i, j, -1, 0) || EnablePut(i, j, -1, 1)) {
          cellColor = #118E31;
          fill(cellColor);
          rect((i-1)*50, (j-1)*50, 50, 50);
        }
      }
    }
  }

  public void InputStone() {

    for (int i=1; i<=8; i++) {
      for (int j=1; j<=8; j++) {
        if (EnablePut(i, j, 1, 0) || EnablePut(i, j, 1, -1) || EnablePut(i, j, 1, 1) || EnablePut(i, j, 0, -1) || EnablePut(i, j, 0, 1) || EnablePut(i, j, -1, -1) || EnablePut(i, j, -1, 0) || EnablePut(i, j, -1, 1)) {
          _canPut = true;
        }
      }
    }
    if (mousePressed && mouseX>0 && mouseX<400 && mouseY>0 && mouseY<400 && _isPut == false && _isTurnOn == true) {
      _isTurnOn = false;
      _isPut = true;
      _inputX = int(mouseX);
      _inputY = int(mouseY);
    }
    _cx = int(_inputX/50)+1;
    _cy = int(_inputY/50)+1;
    if (EnablePut(_cx, _cy, 1, 0) || EnablePut(_cx, _cy, 1, -1) || EnablePut(_cx, _cy, 1, 1) || EnablePut(_cx, _cy, 0, -1) || EnablePut(_cx, _cy, 0, 1) || EnablePut(_cx, _cy, -1, -1) || EnablePut(_cx, _cy, -1, 0) || EnablePut(_cx, _cy, -1, 1)) {
      _turn++; 
      if (cell[_cx][_cy] !=1 && cell[_cx][_cy] != -1) {
        if (_turn%2 == 1) {
          cell[_cx][_cy] = 1;
        } else if (_turn%2 == 0) {
          cell[_cx][_cy] = -1;
        }
      }
    }
  outside:
    for (int i=1; i<=8; i++) {
      for (int j=1; j<=8; j++) {
        if (EnablePut(i, j, 1, 0) || EnablePut(i, j, 1, -1) || EnablePut(i, j, 1, 1) || EnablePut(i, j, 0, -1) || EnablePut(i, j, 0, 1) || EnablePut(i, j, -1, -1) || EnablePut(i, j, -1, 0) || EnablePut(i, j, -1, 1)) {
          break outside;
        }
        if (i == 8 && j== 8) {
          _turn++;
        }
      }
    }
  }

  public void FlipStone() {
    //上,下,左,右,左上,左下,右上,右下
    int countUP = CheckFlipColor(0, -1);
    int countDown = CheckFlipColor(0, 1);
    int countLeft = CheckFlipColor(-1, 0);
    int countRight = CheckFlipColor(1, 0);
    int countUPLeft = CheckFlipColor(-1, -1);
    int countDownLeft = CheckFlipColor(-1, 1);
    int countUPRight = CheckFlipColor(1, -1);
    int countDownRight = CheckFlipColor(1, 1);

    for (int i=1; i<countUP; i++) {
      cell[_cx][_cy-i] *= -1;
    }
    for (int i=1; i<countDown; i++) {
      cell[_cx][_cy+i] *= -1;
    }
    for (int i=1; i<countLeft; i++) {
      cell[_cx-i][_cy] *= -1;
    }
    for (int i=1; i<countRight; i++) {
      cell[_cx+i][_cy] *= -1;
    }
    for (int i=1; i<countUPLeft; i++) {
      cell[_cx-i][_cy-i] *= -1;
    }
    for (int i=1; i<countDownLeft; i++) {
      cell[_cx-i][_cy+i] *= -1;
    }
    for (int i=1; i<countUPRight; i++) {
      cell[_cx+i][_cy-i] *= -1;
    }
    for (int i=1; i<countDownRight; i++) {
      cell[_cx+i][_cy+i] *= -1;
    }
  }

  public int CheckFlipColor(int dirX, int dirY) {
    int distance = 1;
    while (cell[_cx][_cy] != cell[_cx+distance*dirX][_cy+distance*dirY] && cell[_cx+distance*dirX][_cy+distance*dirY] != 0 && _cx+distance*dirX<=8 && _cx+distance*dirX>=1 && _cy+distance*dirY<=8 && _cy+distance*dirY>=1) {
      if (cell[_cx][_cy] == cell[_cx+distance*dirX][_cy+distance*dirY]) break;
      distance++;
    }
    if (cell[_cx+distance*dirX][_cy+distance*dirY] == 0 || cell[_cx+distance*dirX][_cy+distance*dirY] == 99) distance = 0;
    return distance;
  }

  public boolean EnablePut(int x, int y, int dirX, int dirY) {
    int stoneColor;
    if (_turn%2 == 1) {
      stoneColor = -1;
    } else {
      stoneColor = 1;
    }
    if (cell[x][y] != 0) return false;
    x+=dirX;
    y+=dirY;
    if (x>8 || x<1 || y>8 || y<1) return false;
    if (cell[x][y] == stoneColor) return false;
    if (cell[x][y] == 0) return false;
    x+=dirX;
    y+=dirY;
    while (x>=1 && x<=8 && y>=1 && y<=8) {
      if (cell[x][y] == 0) return false;
      if (cell[x][y] == stoneColor) return true;
      x+=dirX;
      y+=dirY;
    }
    return false;
  }
}
