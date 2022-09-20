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
    var presenter : VIPER_Presenter
    
    func initUISet() {
        
    }
    func didAppearSet() {
        
    }
}

class VIPER_Interactor {
    var presenter : VIPER_Presenter
    func fetch() {
        
    }
}

class VIPER_Presenter {
    var view : VIPER_View
    var interactor : VIPER_Interactor
    var wireFrame : VIPER_Router
}

class VIPER_Entity {
    var name : String
    var no : Int
}

class VIPER_Router {
    
}

// MVVM

class MVVM_Model {
    
}

class MVVM_View {
    
}

class MVVM_ViewModel {
    
}
