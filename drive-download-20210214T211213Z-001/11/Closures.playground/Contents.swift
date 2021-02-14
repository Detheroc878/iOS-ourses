//: Playground - noun: a place where people can play

import UIKit

//simple closure

var closure:(String) -> ()

func printText(text:String) -> () {
    print(text)
}

closure = printText
closure("Test string")

var anotherClosure = { (text:String) -> String in
    return text
}

print(anotherClosure("Test string 2"))

//typealias

typealias SomeClosure = (String) -> ()

func doSomething(_ text:String, closure:SomeClosure) {
    let newText = text + text
    closure(newText)
}

doSomething("test") { (text) in
    print(text)
}

// return closure

var something:SomeClosure = { (text:String) -> () in
    print(text)
}

func someOperation() -> SomeClosure {
    return something
}

someOperation()("Print text")

// function argument

func printValue(values:(Int, Int), swapFunction:((Int, Int)) -> (Int, Int)) {
    print(swapFunction(values))
}

let value = (0,1)

printValue(values: value) { (a, b) -> (Int, Int) in
    return (b, a)
}

printValue(values: value) { (a, b)  in
    return (b, a)
}

printValue(values: value) {
    return ($0.1, $0.0)
}

printValue(values: value) { ($0.1, $0.0) }


// escaping

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"


//autoclosure

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

/* some samples from Apple tutorial and used only for ref */

