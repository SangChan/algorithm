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

var mvc : MVC_Controller = .init(model: .init(no: 1, name: "test"), view: .init())
mvc.update()
mvc.model = .init(no: 2, name: "testtest")
mvc.update()

// VIPER

class VIPER_View {
    var presenter : VIPER_Presenter?
    
    init() {
        presenter?.viewDidLoad()
    }
    
    func update(_ data: VIPER_Entity) {
        Swift.print("no = \(data.no)")
        Swift.print("name = \(data.name)")
    }
    
    
}

class VIPER_Interactor {
    var presenter : VIPER_Presenter?
    var entity : VIPER_Entity?
    
    func fetch() {
        entity = .init(no: 1, name: "viper test")
        didFetch(entity!)
    }
    
    func didFetch(_ data: VIPER_Entity) {
        presenter?.view?.update(data)
    }
}

class VIPER_Presenter {
    weak var view : VIPER_View?
    var interactor : VIPER_Interactor?
    var router : VIPER_Router?
    
    func viewDidLoad() {
        Swift.print("view did load")
    }
    
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

VIPER_Router.create(view: .init())

// MVVM

class MVVM_Model {
    
}

class MVVM_View {
    
}

class MVVM_ViewModel {
    
}
