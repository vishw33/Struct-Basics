import UIKit
//: # Usage of Structs and their initilization
struct Employee
{
    var name:String?
    var age:Int?
    var salary:Double?
    
}

//: Initilization of struct can be done as below
let employee1 = Employee(name: "Jhon", age: 26, salary: 15000)

//: If any of the property needed to be changed it cant be done even when salary is of type var but Structs here declared as let
// employee1.salary = 18000 // Uncomment this line to see error

//: lets change let to var
var employee2 = Employee(name: "Smith", age: 29, salary: 18000)
employee2.salary = 20435;
print(employee2)
//: So here the salary is over written

//: ## Mutating function in Struct
//: ### from Apple Docs
//: Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.

struct Point
{
    var x:Int
    var y:Int
    
   mutating func setDefault(xValue:Int , yValue:Int)
    {
        x = xValue
        y = yValue
    }
}

var errImg:UIImageView = UIImageView.init(image: UIImage.init(named: "Mutating_Error.png"))

//: If mutating is removed from function setDefault the compiler gives you an error. Chect the errImage for the error detail

//: Setting some point value can be done as below
var viewPoints = Point(x: 10, y: 10)
print(viewPoints)
//: with help of mutationg function we can reset it back to original position
viewPoints.setDefault(xValue: 0, yValue: 0)
print(viewPoints)
//: ### here we are resetting it instead of destroying the object , this is done when there is a feature use for a object

//: ## Partial Initilization of the Struct

//: from the struct above of Employee, you need to create another employee but at this time you know only his name but have no idea about age and salary detail. Lets try the same
//let employeeX:Employee = Employee(name: "Tom") // uncomment this line to see error

var _errImg:UIImageView = UIImageView.init(image: UIImage.init(named: "Partial_init_Error.png"))
//: You can see error image in _errImg

//: In Order to avoid same we are going to write the extension

extension Employee
{
    init(name:String = "" , age:Int = 0 , salary:Double = 0)
    {
        self.name = name
        self.age = age
        self.salary = salary
        
    }
}

let employee = Employee()
let employee_name = Employee(name: "Paul")
let employee_name_age = Employee(name: "Harry",age:24)
let employee_alldetails = Employee(name: "Ron",age:24,salary:8000)
let employee_age = Employee(age:23)
let employee_age_salary = Employee(age:27,salary:12500)

//: ## Structs using Comparable
//: # Implementing Employee with Comparable Portable
struct Employee2:Comparable
{
    var name:String
    var age:Int
    var salary:Double
    
    init(name: String? = nil,
        age: Int? = nil,
        salary: Double? = 0) {
        
        self.name = name!
        self.age = age!
        self.salary = salary!
    }
    //: Below are the function which define comparators
    static func <(lhs: Employee2, rhs: Employee2) -> Bool {
        return lhs.salary < rhs.salary
    }
    
    static func ==(lhs: Employee2, rhs: Employee2) -> Bool {
        return  lhs.salary == rhs.salary
    }
    
    static func ===(lhs: Employee2, rhs: Employee2) -> Bool {
        return  (lhs.name == rhs.name) && (lhs.age == rhs.age)
    }
    
    static func age(lhs: Employee2, rhs: Employee2) -> Bool {
        return  lhs.age < rhs.age
    }
}

let emp:Employee2 = Employee2.init(name: "sh", age: 20)
print(emp)

let employee11:Employee2 = Employee2(name: "Jhon", age: 28, salary: 15000)
let employee21:Employee2 = Employee2(name: "Harry", age: 30, salary: 12500)
let employee31:Employee2 = Employee2(name: "Tom", age: 24, salary: 17500)
let employee41:Employee2 = Employee2(name: "Smith", age: 40, salary: 22750)
let employee51:Employee2 = Employee2(name: "Alex", age: 21
    , salary: 8300)

let employeeArrayWithComparableProtocal:[Employee2] = [employee11,employee21,employee31,employee41,employee51]

//: Here the employeeArrayWithComparableProtocal is sorted based on salary if you observe we have already sorthed based on age
//: So here what made difference is we no need to specify any property which needed to sort
let salaryOrdered_ = employeeArrayWithComparableProtocal.sorted { (a, b) -> Bool in
    return a > b
}

//: So now lets go back to search we were talking before
let employeeXC:Employee2 = Employee2(name: "Jhon", age: 28)
let searchedEmployee = employeeArrayWithComparableProtocal.filter{$0 === employeeXC}
print(searchedEmployee)

//: Here in above we created employee with name and age we got back his salary details

//: if employee has to be sorted by any other means or by property it can be assigned and used as below
let ageOrdered_ = employeeArrayWithComparableProtocal.sorted { (a, b) -> Bool in
    return Employee2.age(lhs: a, rhs: b)
}
ageOrdered_.flatMap{print("age: \($0.age), salary: \($0.salary)")}
