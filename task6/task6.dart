


class Meal {
  late String _description;

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

int _computeValue() {
  print('In _computeValue...');
  return 3;
}

class CachedValueProvider {
  late final _cache = _computeValue();
  int get value => _cache;
}




void main() {
 
  question1();
    

  
  question2();
  question3();
  question4();
  question5();
  question6();
  
  
  
  
  final myMeal = Meal();
  myMeal.description = 'Feijoada!';
  print(myMeal.description);
  
  print('Calling constructor...');
  var provider = CachedValueProvider();
  print('Getting value...');
  print('The value is ${provider.value}!');
  
  
}

question1()
{
     String? name;

    name="Mehdi";

    print('a is $name');
 }

question2()
{
  
  String? a;
  a = null;
  print('a is $a.');

}

question3()
{
  List<String> aListOfStrings = ['one', 'two', 'three'];
  List<String?> aNullableListOfStrings=[];
  List<String?> aListOfNullableStrings = ['one', null, 'three'];

  print('aListOfStrings is $aListOfStrings.');
  print('aNullableListOfStrings is $aNullableListOfStrings.');
  print('aListOfNullableStrings is $aListOfNullableStrings.');

}

question4()
{
  
  int? couldReturnNullButDoesnt() => -3;

  int? couldBeNullButIsnt = 1;
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt;
  int b = listThatCouldHoldNulls.first!; // first item in the list
  int c = couldReturnNullButDoesnt()!.abs(); // absolute value

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}

question5(){
  
  int getLength(String? str) {
  // Add null check here

  return str!.length;
  }
  
  print(getLength("This is a string!"));

}

question6(){
  
  int getLength(String? str) {

  return str!.length;
}
  
  print(getLength(null));


}

  


  


