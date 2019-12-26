interface IState {
  public void Update();
  public void OnEnter();
  public void OnExit();
}

public class EmptyState implements IState {
  public void Update() {
  }
  public void OnEnter() {
  }
  public void OnExit() {
  }
}

public class InputStoneState implements IState {
  public void Update() {
    stone.InputStone();
    stateMachine.Change();
  }
  public void OnEnter() {
    stone.IsPut(false);
    stone.IsTurnOn(true);
  }
  public void OnExit() {
  }
}

public class PaintStoneState implements IState {
  private int _countFrame = 0;
  public void Update() {
    _countFrame ++;
    stone.PaintStone();
    if (_countFrame > frameRate/2) {
      stateMachine.Change();
    }
  }
  public void OnEnter() {
  }
  public void OnExit() {
    _countFrame = 0;
  }
}

public class CalcEnablePaintPlaceState implements IState {
  private int _countFrame = 0;
  public void Update() {
    _countFrame++;
    stone.CalcEnablePaintPlace();
    if (_countFrame>frameRate/4) {
      stateMachine.Change();
    }
  }
  public void OnEnter() {
  }
  public void OnExit() {
    _countFrame = 0;
  }
}

public class FlipStoneState implements IState {
  public void Update() {
    stone.FlipStone();
    stateMachine.Change();
  }
  public void OnEnter() {
  }
  public void OnExit() {
  }
}

public class ResultState implements IState {
  public void Update() {
    stone.CalcResult();
    stateMachine.Change();
  }
  public void OnEnter() {
  }
  public void OnExit() {
  }
}
