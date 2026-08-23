class Employee{
    Employee ({required String this.Name,required this.BaseSalary });
    final String Name;
    final int BaseSalary;

    /// Class con sẽ khi đè cái này
    int MonthSalary()=>BaseSalary;

    
    String get Role=>'Nhân Viên';

}