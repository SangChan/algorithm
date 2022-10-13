//: [Previous](@previous)

import Foundation

// MVC

class MVC_Model {
    var no : Int
    var name : String
    
    init(no : Int, name :  String) {
        self.no = no
        self.name = name
    }
}

class MVC_View {
    func print(no : Int, name : String) {
        Swift.print("no = \(no)")
        Swift.print("name = \(name)")
    }
}

class MVC_Controller {
    var model : MVC_Model
    var view : MVC_View
    
    init(model : MVC_Model, view : MVC_View) {
        self.model = model
        self.view = view
    }
    
    func update() {
        view.print(no: model.no, name: model.name)
    }
}

print("MVC TEST - start")
var mvc : MVC_Controller = .init(model: .init(no: 1, name: "test"), view: .init())
mvc.update()
mvc.model = .init(no: 2, name: "testtest")
mvc.update()
print("MVC TEST - end")

// VIPER

class VIPER_View {
    var presenter : VIPER_Presenter?
   
    // presenter -> view
    func update(_ data: VIPER_Entity) {
        Swift.print("no = \(data.no)")
        Swift.print("name = \(data.name)")
    }
    
    
}

class VIPER_Interactor {
    var presenter : VIPER_Presenter?
    var entity : VIPER_Entity?
    private var count : Int = 0
    // presenter -> interactor
    func fetch() {
        count += 1
        entity = .init(no: count, name: "viper test \(count)")
        didFetch(entity!)
    }
    
    // interactor -> presenter
    func didFetch(_ data: VIPER_Entity) {
        presenter?.show(with: data)
    }
}

class VIPER_Presenter {
    weak var view : VIPER_View?
    var interactor : VIPER_Interactor?
    var router : VIPER_Router?
    
    // view -> presenter
    func viewDidLoad() {
        Swift.print("view did load")
        self.fetch()
    }
    
    // presenter -> interactor
    func fetch() {
        interactor?.fetch()
    }
    
    // view -> presenter
    func show(with data : VIPER_Entity) {
        view?.update(data)
    }
}

class VIPER_Entity {
    var name : String
    var no : Int
    
    init(no : Int, name :  String) {
        self.no = no
        self.name = name
    }
}

class VIPER_Router {
    // presemter -> router
    static func create(view: VIPER_View) {
        let presenter : VIPER_Presenter = VIPER_Presenter()
        
        view.presenter = presenter
        view.presenter?.router = VIPER_Router()
        view.presenter?.view = view
        view.presenter?.interactor = VIPER_Interactor()
        view.presenter?.interactor?.presenter = presenter
    }
    
    func pushTo(view: VIPER_View, with: VIPER_Entity) {
        
    }
}

print("VIPER TEST - start")
var viperView : VIPER_View = .init()
VIPER_Router.create(view: viperView)
viperView.presenter?.viewDidLoad()
viperView.presenter?.fetch()
viperView.presenter?.fetch()
viperView.presenter?.fetch()
print("VIPER TEST - end")
// MVVM - Clean

/// Domain Layer
// Entities
struct MVVM_Entity {
    let no : Int
    let name : String
}

// Use cases
class MVVM_UseCase {
    private let repository : MVVM_Interface = MVVM_Repository()
    
    func fetch() -> MVVM_Entity? {
        return repository.get()
    }
}

protocol MVVM_Interface {
    func set(_ data: MVVM_Entity)
    func get() -> MVVM_Entity?
}

/// Presentation Layer
// Presenter
class MVVM_ViewModel : NSObject {
    private let useCase : MVVM_UseCase = .init()
    @objc dynamic var text : String?
    
    func viewDidLoad() {
        Swift.print("view did load")
        fetch()
    }
    
    func fetch() {
        if let entity = useCase.fetch() {
            update(entity)
        }
    }
    
    func update(_ entity : MVVM_Entity) {
        text = "no = \(entity.no) name = \(entity.name)"
    }
}

class MVVM_Coordinator {
    func push(to view : MVVM_View) {
        view.viewDidLoad()
    }
}

class MVVM_View {
    private var vm : MVVM_ViewModel = .init()
    func viewDidLoad() {
        self.bind()
        vm.viewDidLoad()
    }
    
    func bind() {
        //observe vm
        vm.observe(\.text) { vm, change in
            Swift.print(change.newValue)
        }
    }
}

/// Data Layer
// Data
class MVVM_Network {
    func initialize() {
        
    }
}

class MVVM_Storage {
    func initialize() {
        
    }
}

class MVVM_Repository : MVVM_Interface {
    private var count : Int = 0
    private var data: MVVM_Entity?
    
    func set(_ data: MVVM_Entity) {
        self.data = data
    }
    
    func get() -> MVVM_Entity? {
        count += 1
        let data = MVVM_Entity(no: count, name: "MVVM \(count)")
        self.data = data
        return self.data
    }
}

print("MVVM TEST - start")
let coordinator = MVVM_Coordinator.init()
coordinator.push(to: .init())
print("MVVM TEST - end")
