public class StateMachine {
  ArrayList<IState> _states = new ArrayList<IState>();
  IState _currentState = new EmptyState();
  private int _stateNumber = -1;

  public void Update() {
    _currentState.Update();
  }

  public void Change() {
    _stateNumber ++;
    if (_stateNumber >= _states.size()) {
      _stateNumber = 0;
    }
    _currentState.OnExit();
    _currentState = _states.get(_stateNumber);
    _currentState.OnEnter();
  }

  public void Add(IState state) {
    _states.add(state);
  }
}
