import 'dart:math';

import 'entities/processo.dart';
import 'enums/process_state_enum.dart';

void main() {
  final ciclos = [10000, 5000, 7000, 3000, 3000, 800000, 20, 5000, 4000, 1000];
  final List<Process> processos = List.generate(
    10,
    (index) => Process(
      id: index,
      state: EnumProcessState.ready,
      cicleCount: ciclos[index],
      programCount: 0,
      entranceExitCount: 0,
      cpuCount: 0,
      hasBackup: true,
    ),
  );

  while (processos.any((processo) => processo.state.isNotFinished)) {
    for (Process processo in processos) {
      // Um único processo executando por vez
      if (processo.state == EnumProcessState.ready) {
        executeProcess(processo);
      }
    }
  }
}

void executeProcess(Process process) {
  final random = Random();
  const int quantum = 1000;
  process.state = EnumProcessState.running;

  while (process.cicleCount > 0) {
    process.programCount = process.cicleCount + 1;
    process.cpuCount++;

    // Quando bloqueado, possui 30% de chance de sair de bloqueado para pronto
    // Acima por ser na proxima vez
    if (process.state.isBlocked && random.nextDouble() < 0.3) {
      print(
          'O Processo de ID "${process.id}" está trocando seu status de "BLOQUEADO" para "PRONTO"');
      process.state = EnumProcessState.ready;
    }

    //Quando executando, possui 5% de chance de entrada/saida, ficando bloqueado
    if (process.state.isRunning && random.nextDouble() < 0.05) {
      print(
          'O Processo de ID "${process.id}" está trocando seu status de "EXECUTANDO" para "BLOQUEADO"');
      process.state = EnumProcessState.blocked;
      process.entranceExitCount++;
    }

    process.cicleCount--;

    // Realização da Troca de Contexto
    if (process.programCount == quantum && process.entranceExitCount == 0) {
      // Restauração dos dados
      process.restore();
      process.state = EnumProcessState.ready;
      print(
          'O Processo de ID "${process.id}" está trocando seu status de "EXECUTANDO" para "PRONTO"');
      return;
    }
  }

  // Finalização do Processo
  process.state = EnumProcessState.finished;
  // Impressão dos dados do processo finalizado
  print('\nO Processo de ID "${process.id}" foi finalizado:');
  print(process.toString());
  print('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n');

  // Salvar dados do processo em um arquivo ou tabela de processos - todo
}
