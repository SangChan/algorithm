//: [Previous](@previous)

import Foundation

// oop

class Customer {
    func order(menuName: String, menu: Menu, barista: Barista) {
        if let menuItem: MenuItem = menu.choose(name: menuName) {
            let coffee : Coffee = barista.makeCoffee(menuItem: menuItem)
            print("drink \(coffee.name), and it costs \(coffee.price)")
        } else {
            print("sorry, we don't have \(menuName)")
        }
    }
}

struct MenuItem : Hashable {
    let name : String
    let price : Int
}

class Menu {
    var items : [MenuItem] = []
    
    init(items : [MenuItem]) {
        self.items = items
    }
    
    func choose(name: String) -> MenuItem? {
        return items.filter { $0.name == name }.first
    }
}

class Barista {
    func makeCoffee(menuItem: MenuItem) -> Coffee {
        return Coffee(menuItem: menuItem)
    }
}

struct Coffee {
    let name : String
    let price : Int
    
    init(menuItem: MenuItem) {
        self.name = menuItem.name
        self.price = menuItem.price
    }
}

let barista : Barista = Barista()
let menu : Menu = Menu(items: [
    MenuItem(name: "커피", price: 1000),
    MenuItem(name: "라떼", price: 1200),
    MenuItem(name: "에스프레소", price: 500),
    MenuItem(name: "콜드브루", price: 1500),
    MenuItem(name: "쌍화차", price: 2000)
])
let customer : Customer = Customer()
customer.order(menuName:"커피", menu: menu, barista: barista)
customer.order(menuName:"쌍화차", menu: menu, barista: barista)
customer.order(menuName:"라떼", menu: menu, barista: barista)
customer.order(menuName:"에스프레소", menu: menu, barista: barista)
customer.order(menuName:"콜드브루", menu: menu, barista: barista)
customer.order(menuName:"박카스", menu: menu, barista: barista)

// strategy

protocol FlyBehavior {
    func fly()
}

protocol QuackBehavior {
    func quack()
}

class FlyWithWings : FlyBehavior {
    func fly() {
        print("날개로 파닥파닥")
    }
}

class Quack: QuackBehavior {
    func quack() {
        print("꽉꽉")
    }
}

class Duck {
    private var flyBehavior : FlyBehavior?
    private var quackBehavior : QuackBehavior?
    
    func setFly(_ f: FlyBehavior) {
        self.flyBehavior = f
    }
    
    func setQuack(_ q: QuackBehavior) {
        self.quackBehavior = q
    }
    
    func performFly() {
        flyBehavior?.fly()
    }
    
    func performQuack() {
        quackBehavior?.quack()
    }
}

class MallardDuck : Duck {
    override init() {
        super.init()
        self.setFly(FlyWithWings())
        self.setQuack(Quack())
    }
}

let mallardDuck : MallardDuck = MallardDuck()
mallardDuck.performFly()
mallardDuck.performQuack()

// Observer

class WeatherData : Subject {
    private var observers : [Observer] = []
    private var weather : Weather?
    
    func registerObserver(_ o: Observer) {
        observers.append(o)
    }
    
    func removeObserver(_ o: Observer) {
        if let index = observers.firstIndex(where: { $0.id == o.id }) {
            observers.remove(at: index)
        }
    }
    
    func notifyObserver() {
        guard let w = weather else { return }
        observers.forEach { (o) in
            o.update(w)
        }
    }
    
    func measermentsChanged() {
        notifyObserver()
    }
    
    func setMeasurements(_ w: Weather) {
        self.weather = w
        measermentsChanged()
    }
}

struct Weather {
    let temp : Double
    let humidity : Double
    let pressure : Double
}

protocol Subject {
    func registerObserver(_ o: Observer)
    func removeObserver(_ o: Observer)
    func notifyObserver()
}

protocol Observer {
    var id: String { set get }
    func update(_ w: Weather)
}

protocol DisplayElement {
    func display()
}

class CurrentWeatherDisplay : Observer, DisplayElement {
    private var weather : Weather?
    private let weatherData : Subject
    var id: String
    
    init(_ weatherData: Subject, id: String) {
        self.weatherData = weatherData
        self.id = id
        weatherData.registerObserver(self)
    }
    
    func update(_ w: Weather) {
        self.weather = w
        display()
    }
    
    func display() {
        guard let weather = weather else { return }
        print("current weather = \(weather.humidity), \(weather.pressure), \(weather.temp)")
    }
    
    
}

let wd : WeatherData = WeatherData()
let currentDisplay : CurrentWeatherDisplay = CurrentWeatherDisplay(wd, id: "test")
wd.setMeasurements(.init(temp: 30, humidity: 20, pressure: 10))
wd.setMeasurements(.init(temp: 100, humidity: 100, pressure: 100))
wd.setMeasurements(.init(temp: 120, humidity: 1, pressure: 100000))

// decorator

protocol Beverage {
    var description : String { get set }
    func getDescription() -> String
    func cost() -> Double
}

extension Beverage {
    var description: String { return "이름없는 음료" }
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 0.0
    }
}

protocol CondimentDecorator : Beverage {
    var beverage : Beverage { get }
}

class Espresso : Beverage {
    var description: String = "에스프레소"
    
    func cost() -> Double {
        return 1.99
    }
}

class HouseBlend : Beverage {
    var description: String = "하우스 블렌드 커피"
    
    func cost() -> Double {
        return 0.89
    }
}

class Mocha: CondimentDecorator {
    var description: String = "모카 추가"
    
    var beverage : Beverage
    init(_ beverage: Beverage) {
        self.beverage = beverage
    }
    
    func getDescription() -> String {
        return "\(beverage.getDescription()) , 모카"
    }
    
    func cost() -> Double {
        return 0.20 + beverage.cost()
    }
}

let beverage : Beverage = Espresso()
print("\(beverage.getDescription()) = $\(beverage.cost())")
var beverage2 : Beverage = HouseBlend()
print("\(beverage2.getDescription()) = $\(beverage2.cost())")
beverage2 = Mocha(beverage2)
print("\(beverage2.getDescription()) = $\(beverage2.cost())")

// Factory Method

struct Pizza {
    let name : String
}

class SimplePizzaFactory {
    func create(type: String) -> Pizza {
        switch type {
        case "cheese":
            return Pizza(name: "cheese")
        case "pepperoni":
            return Pizza(name: "pepperoni")
        default:
            return Pizza(name: "new")
        }
    }
}

class PizzaStore {
    let factory : SimplePizzaFactory = SimplePizzaFactory()
    
    func order(type: String) -> Pizza {
        let pizza = factory.create(type: type)
        
        return pizza
    }
}

// Abstract Factory

protocol PizzaIngredientFactory {
    func createDough()
    func createSauce()
    func createCheese()
    func createVeggies()
    func createPepperoni()
    func createClam()
}

class NYPizzaIngredientFactory : PizzaIngredientFactory {
    func createDough() {
        print("ny : create dough")
    }
    
    func createSauce() {
        print("ny : create sauce")
    }
    
    func createCheese() {
        print("ny : create cheese")
    }
    
    func createVeggies() {
        print("ny : create veggies")
    }
    
    func createPepperoni() {
        print("ny : create pepperoni")
    }
    
    func createClam() {
        print("ny : create clam")
    }
    
}

class ChicagoPizzaIngredientFactory : PizzaIngredientFactory {
    func createDough() {
        print("chicago : create dough")
    }
    
    func createSauce() {
        print("chicago : create sauce")
    }
    
    func createCheese() {
        print("chicago : create cheese")
    }
    
    func createVeggies() {
        print("chicago : create veggies")
    }
    
    func createPepperoni() {
        print("chicago : create pepperoni")
    }
    
    func createClam() {
        print("chicago : create clam")
    }
}

// Singleton

class Singleton {
    static let shared : Singleton = Singleton()
    
    private var number : Int = 0 {
        didSet { print(number) }
    }
    private init() {}
    
    func setNumber(_ x : Int) {
        number = x
    }
    
    func add(_ x : Int) {
        number += x
    }
    
    func multiple(_ x : Int) {
        number *= x
    }
}

Singleton.shared.add(10)
Singleton.shared.add(12)
Singleton.shared.add(1)
Singleton.shared.multiple(2)
Singleton.shared.setNumber(0)


//DispatchQueue.global(qos: .background).async {
//    for i in 1 ... 100 {
//        Singleton.shared.setNumber(i)
//    }
//}
//
//DispatchQueue.global(qos: .userInteractive).async {
//    for i in 1000 ... 1100 {
//        Singleton.shared.setNumber(i)
//    }
//}

// Command

struct Light {
    var isOn : Bool = false
    
    mutating func on() {
        self.isOn = true
        print("light is on")
    }
}

protocol Command {
    func execute()
}

class LightOnCommand : Command {
    var light : Light
    
    init(_ light : Light) {
        self.light = light
    }
    
    func execute() {
        light.on()
    }
}

class SimpleRemoteControl {
    var slot : Command?
    
    func setCommand(_ command : Command) {
        slot = command
    }
    
    func buttonPressed() {
        slot?.execute()
    }
}

var simpleRemoteControl : SimpleRemoteControl = SimpleRemoteControl()
var light : Light = Light()
var lightOn : LightOnCommand = LightOnCommand(light)
simpleRemoteControl.setCommand(lightOn)
simpleRemoteControl.buttonPressed()

// Adaptor

protocol EnumerationProtocolBase : class {}

protocol EnumerationProtocol : EnumerationProtocolBase {
    associatedtype T
    func hasMoreElements() -> Bool
    func nextElement() -> T
}

class Enumeration<A> : EnumerationProtocol {
    typealias T = A
    private var data : Array<T>
    
    init(_ data: Array<T>) {
        self.data = data
    }
    func hasMoreElements() -> Bool {
        return !data.isEmpty
    }
    
    func nextElement() -> T {
        return data.last!
    }
}

protocol IteratorProtocolBase : class {}

protocol IteratorProtocol : IteratorProtocolBase {
    associatedtype T
    func hasNext() -> Bool
    func next() -> T
    func remove()
}

class Iterator<A> : IteratorProtocol {
    typealias T = A
    private var data : Array<T>
    
    init(_ data: Array<T>) {
        self.data = data
    }
    func hasNext() -> Bool {
        return !data.isEmpty
    }
    func next() -> T {
        return data.last!
    }
    func remove() {
        data.removeLast()
    }
}


class EnumerationIterator<A> : IteratorProtocol {
    typealias T = A
    
    var enumeration : EnumerationProtocolBase?
    
    init(_ enumeration: EnumerationProtocolBase) {
        self.enumeration = enumeration
    }
    
    func hasNext() -> Bool {
        let enumeration = self.enumeration as! Enumeration<A>
        return enumeration.hasMoreElements()
    }
    
    func next() -> T {
        let enumeration = self.enumeration as! Enumeration<A>
        return enumeration.nextElement()
    }
    
    func remove() {
        print("error")
    }
}
