import '../enums/process_state_enum.dart';

class Process {
  //Identificador de processo (PID)
  final int id;

  //Estado do Processo (EP)
  EnumProcessState state;

  //Tempo de processamento (TP)
  int cicleCount;

  //Contador de Programa (CP)
  int programCount;

  //número de vezes que realizou uma operação de Entrada/Saída (E/S)
  int entranceExitCount;

  //número de vezes que usou a CPU (nCPU)
  int cpuCount;

  Process? backup;
  final bool hasBackup;

  Process({
    required this.id,
    required this.state,
    required this.cicleCount,
    required this.programCount,
    required this.entranceExitCount,
    required this.cpuCount,
    required this.hasBackup,
  }) {
    if (hasBackup) {
      backup = Process(
        id: id,
        state: state,
        cicleCount: cicleCount,
        programCount: programCount,
        entranceExitCount: entranceExitCount,
        cpuCount: cpuCount,
        hasBackup: false,
      );
    }
  }

  void restore() {
    if (backup != null) {
      cicleCount = backup!.cicleCount;
      programCount = backup!.programCount;
      entranceExitCount = backup!.entranceExitCount;
      cpuCount = backup!.cpuCount;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'state': state.name,
      'cicleCount': cicleCount,
      'programCount': programCount,
      'entranceExitCount': entranceExitCount,
      'cpuCount': cpuCount,
    };
  }
}
