///  Задание – ООО "Травка - муравка":
///  Цель: Рассчитать средний возрост техники
///  Майка Алексей Николаевич

import 'start_data.dart';


List<AgriculturalMachinery> getAllMachine(Map mapBefore2010, Map mapAfter2010){
  /**Функция для извлечения списка техники из Словаря
   * Function to extract a list of equipment from the Dictionary*/

  List <AgriculturalMachinery> listMachinery = [];

  for(var territory in mapBefore2010.values.expand((i) => i)){
    for(var mechanism in territory.machineries){
      if (!listMachinery.contains(mechanism)) listMachinery.add(mechanism);
    }
  }

  for(var territory in mapAfter2010.values.expand((i) => i)){
    for(var mechanism in territory.machineries){
      if (!listMachinery.contains(mechanism)) listMachinery.add(mechanism);
    }
  }

  return listMachinery;
}

double getMeanAge(List <AgriculturalMachinery> listMachinery){
  /**Функция для вычисления среднего возраста всей техники
   * Function to calculate the average age of all equipment*/

  if(listMachinery.isEmpty) return 0;
  int sumAge = listMachinery.map((machine) => DateTime.now().year - machine.releaseDate.year).reduce((a, b) => a + b);
  return double.parse((sumAge / listMachinery.length).toStringAsFixed(2));
}

double getMeanAgeOld(List <AgriculturalMachinery> listMachinery){
  /**Функция для вычисления среднего возраста 50% самой старой техники
   * Function to calculate the average age of the 50% oldest equipment*/
  
  if(listMachinery.isEmpty) return 0;
  listMachinery.sort((data1, data2) => data1.releaseDate.year - data2.releaseDate.year);

  var oldestMachines = listMachinery.sublist(0, listMachinery.length ~/ 2);
  var sumAge = oldestMachines.map((machine) => DateTime.now().year - machine.releaseDate.year).reduce((a, b) => a + b);

  return double.parse((sumAge / oldestMachines.length).toStringAsFixed(2));
}

void main(){
  try {

    var (mapAfter2010, mapBefore2010) = getInputData();
    if (mapAfter2010.isEmpty && mapBefore2010.isEmpty){
      print("Данные о технике отсутствуют");
      return;
    }

    List <AgriculturalMachinery> listMachinery = getAllMachine(mapBefore2010, mapAfter2010);

    double sumAge = getMeanAge(listMachinery);
    double sumAge50 = getMeanAgeOld(listMachinery);

    print("Средний возраст всей техники: $sumAge");
    print("Средний возраст 50% самой старой техники: $sumAge50");

  } catch (error) { print("Ошибка при работе скрипта: $error"); }
}