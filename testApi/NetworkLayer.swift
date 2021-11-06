//
//  NetworkLayer.swift
//  testApi
//
//  Created by Andrii Storcheus on 01.09.2021.
//

import Foundation

class NetworkLayer {
    static var shared = NetworkLayer()
    private init() { }
    func sendRequest(_ request: PRequest){
        
        guard let url = URL(string: request.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.type.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { request.onError?(error.localizedDescription); return }
            request.onSuccess?(data)
            
        }.resume()
    }
}

class GetGirlRequest: PRequest {
    
    var url: String = "https://randomuser.me/api/?gender=female"
    var type: HTTPType = .GET
    var onError: ((String) -> Void)?
    var onSuccess: ((Data?) -> Void)?
    init(onError: ((String) -> Void)?, onSuccess: ((Data?) -> Void)? ) {
        self.onError = onError
        self.onSuccess = onSuccess
    }
}

protocol PRequest {
    var url: String { get set }
    var type: HTTPType { get set }
    var onError: ((String) -> Void)? { get set }
    var onSuccess: ((Data?) -> Void)? { get set }
}
enum HTTPType: String {
    case POST
    case GET
}
