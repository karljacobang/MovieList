//
//  NetworkProcess.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import Foundation
import Moya
import Alamofire

// MARK: - Provider setup

enum Environment {
    case development
}

// ENVIRONMENT - REPLACE FOR NEW TESTING ENVIRONMENT

let environment = Environment.development

// ROOT URL - REPLACE FOR NEW TESTING ENVIRONMENT

let serviceURL: String = {
    switch environment {
    case .development:
        return "itunes.apple.com/"
    }
}()


let manager: Manager = {
    
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
        serviceURL: .disableEvaluation
    ]
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 240
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    
    return Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
}()

let endpointClosure = { (target: MovieList) -> Endpoint in
    let endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    
    return endpoint
}

var MovieListProvider: MoyaProvider<MovieList> = {
    let networkLogger = NetworkLoggerPlugin(verbose: false, responseDataFormatter: nil)
    return MoyaProvider<MovieList>(endpointClosure: endpointClosure, manager: manager, plugins:[networkLogger])
}()


// MARK: - Provider support

extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum MovieList {
    case search(String)
}


extension MovieList: TargetType {
    public var baseURL: URL { return URL(string: "https://" + serviceURL)! }
    public var path: String {
        switch self {
        case .search(let term):
            return "search?term=" + term + "&entity=movie"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
        
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding!
}
