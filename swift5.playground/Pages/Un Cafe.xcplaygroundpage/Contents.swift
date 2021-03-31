//: [Previous](@previous)

import Foundation

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

class WeatherData : Subject {
    private var observers : [Observer] = []
    private var weather : Weather?
    
    func registerObserver(_ o: Observer) {
        observers.append(o)
    }
    
    func removeObserver(_ o: Observer) {
        
    }
    
    func notifyObserver() {
        
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
    func update(_ w: Weather)
}

protocol DisplayElement {
    func display()
}
