///  Задание – ООО "Травка - муравка":
///  Цель: Рассчитать средний возрост техники
///  Майка Алексей Николаевич

import 'start_data.dart';


List<AgriculturalMachinery> getAllMachine(Map mapBefore2010, Map mapAfter2010){
  /**Функция для извлечения списка техники из Словаря
   * Function to extract a list of equipment from the Dictionary*/

  List <AgriculturalMachinery> listMachinery = [];

  mapBefore2010.values.expand((i) => i).forEach((territory){
    territory.machineries.forEach((mechanism) {
      if (!listMachinery.contains(mechanism)) listMachinery.add(mechanism);
    });
  });

  mapAfter2010.values.expand((i) => i).forEach((territory){
    territory.machineries.forEach((mechanism) {
      if (!listMachinery.contains(mechanism)) listMachinery.add(mechanism);
    });
  });

  return listMachinery;
}

double getMeanAge(List <AgriculturalMachinery> listMachinery){
  /**Функция для вычисления среднего возраста всей техники
   * Function to calculate the average age of all equipment*/
  try {
    double sumAge = 0;
    listMachinery.forEach((machine) {sumAge += (DateTime.now().year - machine.releaseDate.year);});
    return double.parse((sumAge / listMachinery.length).toStringAsFixed(2));
  } catch (error) { return 0;}
}

double getMeanAgeOld(List <AgriculturalMachinery> listMachinery){
  /**Функция для вычисления среднего возраста 50% самой старой техники
   * Function to calculate the average age of the 50% oldest equipment*/
  try {
    double sumAge50 = 0;
    listMachinery.sort((data1, data2) =>
    data1.releaseDate.year - data2.releaseDate.year);
    listMachinery.getRange(0, listMachinery.length ~/ 2).forEach((machine) {
      sumAge50 += (DateTime
          .now()
          .year - machine.releaseDate.year);
    });
    return double.parse(
        (sumAge50 / (listMachinery.length ~/ 2)).toStringAsFixed(2));
  } catch (error) { return 0;}
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