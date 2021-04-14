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

// facade

protocol OnOffCommand {
    func on()
    func off()
}

protocol DimCommand {
    func dim(_ brightness : Int)
}

protocol UpDownCommand {
    func up()
    func down()
}

protocol ProjectorCommand {
    func widescreenMode()
}

protocol AmpCommand {
    func plug(_ player: PlayerCommand)
    func setSurroundSound()
}

protocol PlayerCommand {
    func play(_ name: String)
    func stop()
    func eject()
}

protocol PopperCommand {
    func pop()
}
    
protocol Amplifier : OnOffCommand, AmpCommand {}
protocol Tuner : OnOffCommand {}
protocol DVDPlayer : OnOffCommand, PlayerCommand {}
protocol CDPlayer : OnOffCommand, PlayerCommand {}
protocol Projector : OnOffCommand, ProjectorCommand{}
protocol TheaterLights : OnOffCommand, DimCommand{}
protocol Screen : OnOffCommand, UpDownCommand {}
protocol PopcornPopper : OnOffCommand, PopperCommand {}

class HomeTheaterFacade {
    var amp : Amplifier!
    var tuner : Tuner!
    var dvd : DVDPlayer!
    var cd : CDPlayer!
    var projector : Projector!
    var lights : TheaterLights!
    var screen : Screen!
    var popper : PopcornPopper!
    
    init(amp : Amplifier,
         tuner : Tuner,
         dvd : DVDPlayer,
         cd : CDPlayer,
         projector : Projector,
         lights : TheaterLights,
         screen : Screen,
         popper : PopcornPopper) {
        self.amp = amp
        self.tuner = tuner
        self.dvd = dvd
        self.cd = cd
        self.projector = projector
        self.lights = lights
        self.screen = screen
        self.popper
    }
    
    func watch(movie: String) {
        print("start to watch \(movie)")
        amp.on()
        amp.plug(dvd)
        tuner.on()
        dvd.on()
        cd.on()
        projector.on()
        lights.on()
        screen.on()
        popper.on()
        dvd.play(movie)
    }
    
    func endMovie() {
        print("shutting down all systems")
        amp.off()
        tuner.off()
        dvd.stop()
        dvd.eject()
        dvd.off()
        cd.off()
        projector.off()
        lights.off()
        screen.off()
        popper.off()
    }
}

// template method

protocol CaffeinBevarage {
    func prepareRecipe()
    func brew()
    func addCondiments()
    func boilWater()
    func pourInCup()
    func customerWantsCondiments() -> Bool
}

extension CaffeinBevarage {
    func prepareRecipe() {
        boilWater()
        brew()
        pourInCup()
        if customerWantsCondiments() {
            addCondiments()
        }
    }
    
    func boilWater() {
        print("물 끓이는 중")
    }
    func pourInCup() {
        print("컵에 따르는 중")
    }
    func customerWantsCondiments() -> Bool {
        return true
    }
}

class CoffeeWithHook : CaffeinBevarage {
    func brew() {
        print("필터를 통해서 커피를 우려내는 중")
    }

    func addCondiments() {
        print("설탕과 우유를 추가하는 중")
    }
    
    func customerWantsCondiments() -> Bool {
        let answer : String = getUserInput()
        
        if answer.lowercased().hasPrefix("y") {
            return true
        } else {
            return false
        }
    }
    
    func getUserInput() -> String {
        return "y"
    }
}

class Tea : CaffeinBevarage {
    func brew() {
        print("차를 우려내는 중")
    }
    
    func addCondiments() {
        print("레몬을 추가하는 중")
    }
}

let cafe : CoffeeWithHook = CoffeeWithHook()
cafe.prepareRecipe()

let tea : Tea = Tea()
tea.prepareRecipe()

// Iterator

struct FoodMenuItem : Component {
    typealias T = Self
    
    let name : String
    let description : String
    let vegetarian : Bool
    let price : Double
}

class DinerMenuIterator<FoodMenuItem> : IteratorProtocol {
    typealias T = FoodMenuItem
    private var position : Int = 0
    var items : [FoodMenuItem] = []
    
    init(_ items: [FoodMenuItem]) {
        self.items = items
    }
    
    func hasNext() -> Bool {
        if position >= items.count {
            return false
        } else {
            return true
        }
    }
    
    func next() -> FoodMenuItem {
        let item = items[position]
        position += 1
        return item
    }
    
    func remove() {
        print("no remove")
    }
    

}

// Composite

protocol Leaf {
    func operation()
}

protocol Composite {
    associatedtype T
    func add(_ t: T)
    func remove(_ t: T)
    func getChild(_ i: Int)
    func operation()
}

protocol Component : Leaf, Composite {}

extension Component {
    func add(_ t: T) { }
    func remove(_ t: T) { }
    func getChild(_ i: Int) { }
    func operation() { }
}

// State

enum Coin : Int {
    case SOLD_OUT = 0
    case NO_QUARTER = 1
    case HAS_QUATER = 2
    case SOLD = 3
    case WINNER = 4
}

class GumballMachine : CustomStringConvertible {
    var description: String {
        return "\n<주식회사 왕뽑기>\n2021 뽑기기계\n남은 갯수 : \(count)\n"
    }
    
    var soldOutState : MachineState!
    var noQuarterState : MachineState!
    var hasQuarterState : MachineState!
    var soldState : MachineState!
    var winnerState : MachineState!
    
    lazy var state : MachineState = soldOutState
    var count : Int = 0
    
    init(_ count : Int) {
        self.noQuarterState = NoQuarterState(gumballMachine: self)
        self.hasQuarterState = HasQuarterState(gumballMachine: self)
        self.soldState = SoldState(gumballMachine: self)
        self.soldOutState = SoldOutState(gumballMachine: self)
        self.winnerState = WinnerState(gumballMachine: self)
        self.count = count
        if count > 0 {
            state = noQuarterState
        }
    }
    
    func insertQuarter() {
        state.insertQuarter()
    }
    
    func ejectQuarter() {
        state.ejectQuarter()
    }
    
    func turnCrank() {
        state.turnCrank()
        state.dispense()
    }
    
    func releaseBall() {
        print("알맹이가 나가고 있습니다.")
        if count > 0 {
            count -= 1
        }
    }
    
    func setState(_ state: MachineState) {
        self.state = state
    }
    
    func getState(_ coin: Coin) -> MachineState {
        switch coin {
        case .SOLD_OUT: return soldOutState
        case .SOLD: return soldState
        case .HAS_QUATER: return hasQuarterState
        case .NO_QUARTER: return noQuarterState
        case .WINNER: return winnerState
        }
    }
}

let gumballMachine = GumballMachine(5)
print(gumballMachine.description)

gumballMachine.insertQuarter()
gumballMachine.turnCrank()
print(gumballMachine.description)

gumballMachine.insertQuarter()
gumballMachine.ejectQuarter()
gumballMachine.turnCrank()
print(gumballMachine.description)

gumballMachine.insertQuarter()
gumballMachine.turnCrank()
gumballMachine.insertQuarter()
gumballMachine.turnCrank()
gumballMachine.ejectQuarter()
print(gumballMachine.description)

gumballMachine.insertQuarter()
gumballMachine.insertQuarter()
gumballMachine.ejectQuarter()
gumballMachine.insertQuarter()
gumballMachine.turnCrank()
gumballMachine.insertQuarter()
gumballMachine.turnCrank()
print(gumballMachine.description)


protocol MachineState {
    func insertQuarter()
    func ejectQuarter()
    func turnCrank()
    func dispense()
}

class NoQuarterState : MachineState {
    let state : Coin = .NO_QUARTER
    var gumballMachine : GumballMachine!
    
    init(gumballMachine : GumballMachine) {
        self.gumballMachine = gumballMachine
    }
    
    func insertQuarter() {
        print("동전을 넣으셨습니다.")
        gumballMachine.setState(gumballMachine.getState(.HAS_QUATER))
    }
    
    func ejectQuarter() {
        print("동전을 넣어주세요")
    }
    
    func turnCrank() {
        print("동전을 넣어주세요")
    }
    
    func dispense() {
        print("동전을 넣어주세요")
    }
}

class HasQuarterState : MachineState {
    let state : Coin = .HAS_QUATER
    var gumballMachine : GumballMachine!
    
    init(gumballMachine : GumballMachine) {
        self.gumballMachine = gumballMachine
    }
    
    func insertQuarter() {
        print("동전은 한개만 넣어주세요")
    }
    
    func ejectQuarter() {
        print("동전이 반환됩니다.")
        gumballMachine.setState(gumballMachine.getState(.NO_QUARTER))
    }
    
    func turnCrank() {
        print("손잡이를 돌리셨습니다.")
        let winner : Int = Int.random(in: 0 ..< 10)
        if winner == 0 && gumballMachine.count > 1 {
            gumballMachine.setState(gumballMachine.getState(.WINNER))
        } else {
            gumballMachine.setState(gumballMachine.getState(.SOLD))
        }
    }
    
    func dispense() {
        print("알맹이가 나갈 수 없습니다.")
    }
}

class SoldState : MachineState {
    let state : Coin = .SOLD
    var gumballMachine : GumballMachine!
    
    init(gumballMachine : GumballMachine) {
        self.gumballMachine = gumballMachine
    }
    
    func insertQuarter() {
        print("잠깐만 기다려 주세요. 알맹이가 나가고 있습니다.")
    }
    
    func ejectQuarter() {
        print("동전을 넣지 않으셨습니다. 동전이 반환되지 않습니다.")
    }
    
    func turnCrank() {
        print("손잡이는 한번만 돌려주세요.")
    }
    
    func dispense() {
        gumballMachine.releaseBall()
        if gumballMachine.count == 0 {
            print("더이상 알맹이가 없습니다.")
            gumballMachine.setState(gumballMachine.getState(.SOLD_OUT))
        } else {
            gumballMachine.setState(gumballMachine.getState(.NO_QUARTER))
        }
    }
}

class SoldOutState : MachineState {
    let state : Coin = .SOLD_OUT
    var gumballMachine : GumballMachine!
    
    init(gumballMachine : GumballMachine) {
        self.gumballMachine = gumballMachine
    }
    
    func insertQuarter() {
        print("매진되었습니다. 다음 기회에 이용해주세요")
    }
    
    func ejectQuarter() {
        print("이미 알맹이를 뽑으셨습니다.")
    }
    
    func turnCrank() {
        print("매진되었습니다.")
    }
    
    func dispense() {
        print("매진입니다")
    }
}

class WinnerState : MachineState {
    let state : Coin = .WINNER
    var gumballMachine : GumballMachine!
    
    init(gumballMachine : GumballMachine) {
        self.gumballMachine = gumballMachine
    }
    
    func insertQuarter() {
        print("잠깐만 기다려 주세요. 알맹이가 나가고 있습니다.")
    }
    
    func ejectQuarter() {
        print("동전을 넣지 않으셨습니다. 동전이 반환되지 않습니다.")
    }
    
    func turnCrank() {
        print("손잡이는 한번만 돌려주세요.")
    }
    
    func dispense() {
        print("축하드립니다! 알맹이를 하나 더 받으실 수 있습니다.")
        gumballMachine.releaseBall()
        if gumballMachine.count == 0 {
            gumballMachine.setState(gumballMachine.getState(.SOLD_OUT))
        } else {
            gumballMachine.releaseBall()
            if gumballMachine.count > 0 {
                gumballMachine.setState(gumballMachine.getState(.NO_QUARTER))
            } else {
                print("더 이상 알맹이가 없습니다")
                gumballMachine.setState(gumballMachine.getState(.SOLD_OUT))
            }
        }
    }
}

// Proxy

protocol Remote {}

protocol MyRemote : Remote {
    func sayHello() throws -> String
}

class MyRemoteImpl : MyRemote {
    func sayHello() throws -> String {
        return "Server says, \"hey\""
    }
}

protocol Icon {
    func getIconWidth() -> Int
    func getIconHeight() -> Int
    func paintIcon()
}

struct ImageIcon : Icon {
    func getIconWidth() -> Int {
        return 800
    }
    
    func getIconHeight() -> Int {
        return 600
    }
    
    func paintIcon() {
        print("draw")
    }
}

class ImageProxy : Icon {
    let imageIcon : ImageIcon = ImageIcon()
    var url : URL!
    
    init(_ url : URL) {
        self.url = url
    }
    
    func getIconWidth() -> Int {
        return imageIcon.getIconWidth()
    }
    
    func getIconHeight() -> Int {
        return imageIcon.getIconHeight()
    }
    
    func paintIcon() {
        imageIcon.paintIcon()
    }
}

// Compound


