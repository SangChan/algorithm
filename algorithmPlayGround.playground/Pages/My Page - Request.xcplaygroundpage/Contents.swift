//: [Previous](@previous)

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

protocol LocalResponse {
    static func documentsURL() -> URL?
    static func save(_ response : Self)
    static func load() -> Self?
}

protocol WebServiceProtocol {
    static var domain : String { get }
    static var endpoint : String { get }
    var session : URLSession { get }
    
    func execute(_ request: AnyObject, onComplete: @escaping ((Result<AnyObject>) -> Void))
}

protocol RequestBuilderProtocol {
    static func post(_ url: URL) -> URLRequest
    static func post(_ url: URL, token: String, sessionid: String) -> URLRequest
    static func get(_ url: URL) -> URLRequest
    static func get(_ url: URL, token: String, sessionid: String) -> URLRequest
}

class RequestBuilder : RequestBuilderProtocol {
    static var model: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    
    static var idiom: String = {
        return "Phone"
    }()
    
    static var version : String = {
        return "iOS 12.2"
    }()
    
    static var identification: String = {
        return "\(RequestBuilder.model)\(RequestBuilder.version)/\(RequestBuilder.idiom)"
    }()
    
    static func post(_ url: URL) -> URLRequest {
        var r = URLRequest(url: url)
        r.httpMethod = "POST"
        r.addValue("application/json", forHTTPHeaderField: "Content-Type")
        r.addValue("application/json", forHTTPHeaderField: "Accept")
        return r
    }
    
    static func get(_ url: URL) -> URLRequest {
        var r = URLRequest(url: url)
        r.httpMethod = "GET"
        r.addValue("application/json", forHTTPHeaderField: "Accept")
        return r
    }
    
}

struct LoginRequest : Codable {
    let userName    : String
    let password    : String
}

struct LoginResponse : Codable, LocalResponse {
    var token: String
    var sessionId: String
    var memberId: Int
    var dataStore: String
    var errorCode : Int
    
    static func documentsURL() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    static func save(_ loginResponse : LoginResponse) {
        guard let docsUrl = LoginResponse.documentsURL() else { return }
        let url = docsUrl.appendingPathComponent("\(LoginResponse.self)")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(loginResponse)
            try data.write(to: url, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func load() -> LoginResponse? {
        guard let docsUrl = LoginResponse.documentsURL() else { return .none }
        let url = docsUrl.appendingPathComponent("\(LoginResponse.self)")
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url, options: [])
            let loginResponse = try decoder.decode(LoginResponse.self, from: data)
            return loginResponse
        } catch {
            return .none
        }
    }
}
