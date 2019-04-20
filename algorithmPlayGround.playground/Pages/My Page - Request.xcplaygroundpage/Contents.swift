//: [Previous](@previous)

import Foundation

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
