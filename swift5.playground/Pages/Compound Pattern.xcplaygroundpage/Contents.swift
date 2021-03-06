import Foundation

// Compound

protocol Quackable : QuackObservable {
    func quack()
}

protocol Observer {
    func update(duck: QuackObservable)
}

class Quackologist : Observer {
    func update(duck: QuackObservable) {
        print("Quackologist: \(duck) just quacked.")
    }
}

protocol QuackObservable {
    func register(observer: Observer)
    func notifyObservers()
}

class Observable : QuackObservable {
    var observers : [Observer] = []
    let duck : QuackObservable!
    
    init(_ duck: QuackObservable) {
        self.duck = duck
    }
    
    func register(observer: Observer) {
        observers.append(observer)
    }
    
    func notifyObservers() {
        observers.forEach { (observer) in
            observer.update(duck: duck)
        }
    }
    
}

class QuackDuck : Quackable {
    lazy var observable : Observable = Observable(self)
    
    func quack() {
        print("Quack")
        notifyObservers()
    }
    
    func register(observer: Observer) {
        observable.register(observer: observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class RedheadDuck : Quackable {
    lazy var observable : Observable = Observable(self)
    
    func quack() {
        print("Quack")
        notifyObservers()
    }
    
    func register(observer: Observer) {
        observable.register(observer: observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class DuckCall : Quackable {
    lazy var observable : Observable = Observable(self)
    func quack() {
        print("Kwak")
        notifyObservers()
    }
    
    func register(observer: Observer) {
        observable.register(observer: observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class RubberDuck : Quackable {
    lazy var observable : Observable = Observable(self)
    
    func quack() {
        print("Squeak")
        notifyObservers()
    }
    
    func register(observer: Observer) {
        observable.register(observer: observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class Goose {
    func honk() {
        print("Honk")
    }
}

class GooseAdapter : Quackable {
    lazy var observable : Observable = Observable(self)
    let goose : Goose!
    init(_ goose: Goose) {
        self.goose = goose
    }
    
    func quack() {
        goose.honk()
        notifyObservers()
    }
    
    func register(observer: Observer) {
        observable.register(observer: observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class QuackCounter : Quackable {
    let duck : Quackable!
    static var numberOfQuacks = 0
    
    init(_ duck : Quackable) {
        self.duck = duck
    }
    
    func quack() {
        duck.quack()
        Self.numberOfQuacks += 1
    }
    
    static func getQuacks() -> Int {
        return Self.numberOfQuacks
    }
    
    func register(observer: Observer) {
        duck.register(observer: observer)
    }
    
    func notifyObservers() {
        duck.notifyObservers()
    }
}

protocol AbstractDuckFactory {
    func createQuackDuck() -> Quackable
    func createRedheadDuck() -> Quackable
    func createDuckCall() -> Quackable
    func createRubberDuck() -> Quackable
}

extension AbstractDuckFactory {
    func createQuackDuck() -> Quackable {
        return QuackDuck()
    }
    func createRedheadDuck() -> Quackable {
        return RedheadDuck()
    }
    func createDuckCall() -> Quackable {
        return DuckCall()
    }
    func createRubberDuck() -> Quackable {
        return RubberDuck()
    }
}

class CountingDuckFactory: AbstractDuckFactory {
    func createQuackDuck() -> Quackable {
        return QuackCounter(QuackDuck())
    }
    func createRedheadDuck() -> Quackable {
        return QuackCounter(RedheadDuck())
    }
    func createDuckCall() -> Quackable {
        return QuackCounter(DuckCall())
    }
    func createRubberDuck() -> Quackable {
        return QuackCounter(RubberDuck())
    }
}

class Flock : Quackable {
    func notifyObservers() { }
    
    private var quackers : [Quackable] = []
    
    func add(_ quacker : Quackable) {
        quackers.append(quacker)
    }
    
    func quack() {
        quackers.forEach { (quacker) in
            quacker.quack()
        }
    }
    
    func register(observer: Observer) {
        quackers.forEach { (quacker) in
            quacker.register(observer: observer)
        }
    }
}

class DuckSimulator {
    static func main() {
        let simulator : DuckSimulator = DuckSimulator()
        let duckFactory : AbstractDuckFactory = CountingDuckFactory()
        simulator.simulate(duckFactory: duckFactory)
    }
    
    func simulate(duckFactory: AbstractDuckFactory) {
        let redhaedDuck : Quackable = duckFactory.createRedheadDuck()
        let duckCall : Quackable = duckFactory.createDuckCall()
        let rubberDuck : Quackable = duckFactory.createRubberDuck()
        let gooseDuck : Quackable = GooseAdapter(.init())
        
        let flockOfDucks : Flock = Flock()
        flockOfDucks.add(redhaedDuck)
        flockOfDucks.add(duckCall)
        flockOfDucks.add(rubberDuck)
        flockOfDucks.add(gooseDuck)
        
        let flockOfQuacks: Flock = Flock()
        let quackOne : Quackable = duckFactory.createQuackDuck()
        let quackTwo : Quackable = duckFactory.createQuackDuck()
        let quackThree : Quackable = duckFactory.createQuackDuck()
        let quackFour : Quackable = duckFactory.createQuackDuck()
        
        flockOfQuacks.add(quackOne)
        flockOfQuacks.add(quackTwo)
        flockOfQuacks.add(quackThree)
        flockOfQuacks.add(quackFour)
        
        flockOfDucks.add(flockOfQuacks)
        
        print("Duck Simulator: With Observer")
        let quackologist : Quackologist = Quackologist()
        flockOfDucks.register(observer: quackologist)
        
        print("Duck Simulator : Whole Flock Simulation")
        simulate(flockOfDucks)
        
        print("Duck Simulator : Quack Flock Simulation")
        simulate(flockOfQuacks)
        
        print("The ducks quacked \(QuackCounter.getQuacks()) times")
    }
    
    func simulate(_ duck: Quackable) {
        duck.quack()
    }
}

DuckSimulator.main()

// MVC

protocol BeatObserver {
    func updateBeat()
}
protocol BPMObserver {
    func updateBPM()
}

protocol BeatModelInterface {
    func initialize()
    func on()
    func off()
    func setBPM(bpm: Int)
    func getBPM() -> Int
    func register(beatObserver: BeatObserver)
    func remove(beatObserver: BeatObserver)
    func register(bpmObserver: BPMObserver)
    func remove(bpmObserver: BPMObserver)
}

protocol Sequencer {
    func start()
    func stop()
    func setTempoInBPM(_ bpm: Int)
}



class BeatModel : BeatModelInterface {
    var bpm : Int = 90
    let sequencer : Sequencer! = nil
    var beatObservers : [BeatObserver] = []
    var bpmObservers : [BPMObserver] = []
    
    func initialize() {
        
    }
    
    func on() {
        sequencer.start()
        setBPM(bpm: 90)
    }
    
    func off() {
        setBPM(bpm: 0)
        sequencer.stop()
    }
    
    func setBPM(bpm: Int) {
        self.bpm = bpm
        sequencer.setTempoInBPM(self.getBPM())
        notifyBPMObervers()
    }
    
    func getBPM() -> Int {
        return bpm
    }
    
    func beatEvent() {
        notifyBeatObervers()
    }
    
    func register(beatObserver: BeatObserver) {
        beatObservers.append(beatObserver)
    }
    
    func remove(beatObserver: BeatObserver) {
        beatObservers.popLast()
    }
    
    func register(bpmObserver: BPMObserver) {
        bpmObservers.append(bpmObserver)
    }
    
    func remove(bpmObserver: BPMObserver) {
        bpmObservers.popLast()
    }
    
    func notifyBPMObervers() {
        bpmObservers.forEach { (o) in
            o.updateBPM()
        }
    }
    
    func notifyBeatObervers() {
        beatObservers.forEach { (o) in
            o.updateBeat()
        }
    }
}

protocol ControllerInterface {
    func start()
    func stop()
    func increaseBPM()
    func decreaseBPM()
    func setBPM(_ bpm: Int)
}

protocol ActionEvent {
    func getSource() -> String
}

protocol ActionListener {
    func actionPerformed(_ event: ActionEvent)
}

class DJView : ActionListener, BeatObserver, BPMObserver {
    
    var model : BeatModelInterface!
    var controller : ControllerInterface!
    
    init(controller : ControllerInterface, model : BeatModelInterface) {
        self.controller = controller
        self.model = model
        model.register(bpmObserver: self)
        model.register(beatObserver: self)
    }
    
    func createView() {
        
    }
    
    func createControls() {
        
    }
    
    func enableStopMenuItem() {
        
    }
    
    func disableStopMenuItem() {
        
    }
    
    func enableStartMenuItem() {
        
    }
    
    func disableStartMenuItem() {
        
    }
    
    func updateBPM() {
        print(model.getBPM())
    }
    
    func updateBeat() {
        
    }
    
    func actionPerformed(_ event: ActionEvent) {
        print(event.getSource())
    }
    
}

class BeatController: ControllerInterface {
    let model : BeatModelInterface!
    var view : DJView!
    
    init(model : BeatModelInterface) {
        self.model = model
        self.view = DJView(controller: self, model: model)
        view.createView()
        view.createControls()
        view.disableStopMenuItem()
        view.enableStartMenuItem()
        model.initialize()
    }
    
    func start() {
        model.on()
        view.disableStartMenuItem()
        view.enableStopMenuItem()
    }
    
    func stop() {
        model.off()
        view.disableStopMenuItem()
        view.enableStartMenuItem()
    }
    
    func increaseBPM() {
        model.setBPM(bpm: model.getBPM() + 1)
    }
    
    func decreaseBPM() {
        model.setBPM(bpm: model.getBPM() - 1)
    }
    
    func setBPM(_ bpm: Int) {
        model.setBPM(bpm: bpm)
    }
    
    
}

let model : BeatModelInterface = BeatModel()
let controller : ControllerInterface = BeatController(model: model)

// Bridge

protocol Implementor {
    func on()
    func off()
    func tuneChannel()
}

protocol RemoteControl {
    var implementor : Implementor { get }
    func on()
    func off()
    func setChannel()
}

extension RemoteControl {
    func on() {
        implementor.on()
    }
    
    func off() {
        implementor.off()
    }
    
    func setChannel() {
        implementor.tuneChannel()
    }
}

class ConcreteRemote : RemoteControl {
    var implementor: Implementor
    
    init(_ implementor: Implementor) {
        self.implementor = implementor
    }
}

protocol TV : Implementor {
    func on()
    func off()
    func tuneChannel()
}

class RCA : TV {
    func on() {
        print("on")
    }
    
    func off() {
        print("off")
    }
    
    func tuneChannel() {
        print("tune channel")
    }
    
}
let rcatv : RCA = RCA()
let remocon : ConcreteRemote = ConcreteRemote(rcatv)
remocon.on()
remocon.off()
remocon.setChannel()
