

class MonthlyExpenseModel{
  String id;
  String name;

  MonthlyExpenseModel({required this.id , required this.name});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
    };
  }

  factory MonthlyExpenseModel.fromJson(Map<String, dynamic> json){
    return MonthlyExpenseModel(
    id: json['id'],
      name: json['name']
    );
  }

  @override
  String toString() {
    return 'MonthlyExpenseModel{id: $id, name: $name}';
  }
}