//: Playground - noun: a place where people can play

//ENUMS

import UIKit

enum Values: Int {
    case one
    case two
    case three
}

enum Planets: String {
    case sun = "sun"
    case mars = "mars"
}

let planetObject = Planets.mars
let number = Values.one

//let resultOfComparison = number.rawValue == 0

number.rawValue


enum Color {
    case RGB(Int, Int, Int)
    case RGBA(Int, Int, Int, Int)
    case DumbColor
    case CMYC
}

//let someColor:Color = .RGBA(255, 255,255,1)
//someColor

//@objc(ColorTypeSpecial)
indirect enum ColorType {
    case RGB(Color)
    case CMYK(Int, Int, Int, Int)
}

let someColor = ColorType.RGB(Color.RGB(10, 10, 10))

// Apple sample indirect
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))


let rgbColor = Color.RGB(10, 10, 10)
let rgbaColor = Color.RGBA(10, 10, 10, 10)

switch rgbColor {
    case .RGBA(let red, let green, let blue, let alpha):
        print("\(red) - \(green) - \(blue)- \(alpha)")
    case .RGB(let red, let green, let blue):
        print("\(red) - \(green) - \(blue)")
        default:
    break
}

let someValue = 5
let someOptional: Int? = 12

switch someOptional {
    case .some(someValue):
        print("the value is \(someValue)")
    case .some(let val):
        print("the value is \(val)")
    default:
        print("not exist")
}

//STRUCT

struct SimpleDate {
    var day: Int
    var month: Int
    var year: Int? = nil
}

var someDate = SimpleDate(day: 12, month: 12, year: nil)
let another = someDate //copy by value

someDate.day = 15
print("Another day value - \(another.day)")


//properties
struct Date {
    var day: Int
    var month: Int
    var year: Int

    var currentDayDescription :String {
        get {
            return "Current day of month - \(day)"
        }
    }

    static var description:String = "amsndkasd"

    //failable
    init?(day:Int, month: Int, year: Int) {
        if day > 31 {
            return nil
        }

        self.day = day
        self.month = month
        self.year = year
    }
}


let date = Date(day: 34, month: 12, year: 2018)
print(date)
print(Date.description)
Date.description = "someValue"
print(Date.description)

//struct Constants {
//
//    struct Intervals {
//        static let timeout: TimeInterval = 0.7
//        static let requestTimeout: TimeInterval = 0.3
//    }
//
//    static let timeoutInterval:TimeInterval = 0.7
//}
//
//Constants.Intervals.timeout

enum ATSwitchMode: Int {

    typealias RawValue = Int

    case on = 1
    case off = 0

    static var allOperation:[ATSwitchMode] {
        get {
            return [
                .on,
                .off
            ]
        }
    }
}

let allOperation = ATSwitchMode.allOperation

//methods

struct Rectangle {
    var width = 1
    var height = 1

    func area() -> Int {
        return width * height
    }

    //mutable
    mutating func scaleBy(value: Int) {
        width *= value
        height *= value
    }
}

var rect = Rectangle(width: 10, height: 15)
rect.scaleBy(value: 5)


// subscript

struct something {
    let someProperty: Int
    subscript(index: Int) -> Int {
        return someProperty / index
    }
}
let valueResult = something(someProperty: 100)

print("The number is divisible by \(valueResult[9]) times")
print("The number is divisible by \(valueResult[2]) times")


//extension

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

extension Matrix {
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
}


var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 1] = 3.2

let somematrixInValue = matrix[1, 1]





