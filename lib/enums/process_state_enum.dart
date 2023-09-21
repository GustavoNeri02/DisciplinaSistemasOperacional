enum EnumProcessState {
  blocked,
  running,
  ready,
  finished,
}

extension EnumProcessStateUtils on EnumProcessState {
  bool get isBlocked => this == EnumProcessState.blocked;
  bool get isRunning => this == EnumProcessState.running;
  bool get isReady => this == EnumProcessState.ready;
  bool get isFinished => this == EnumProcessState.ready;

  bool get isNotBlocked => this != EnumProcessState.blocked;
  bool get isNotRunning => this != EnumProcessState.running;
  bool get isNotReady => this != EnumProcessState.ready;
  bool get isNotFinished => this != EnumProcessState.finished;
}
