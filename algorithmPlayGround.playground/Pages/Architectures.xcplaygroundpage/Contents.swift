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

// VIPER

class VIPER_View {
    
}

class VIPER_Interactor {
    
}

class VIPER_Presenter {
    
}

class VIPER_Entity {
    
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
