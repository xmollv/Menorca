//
//  Webservice.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation
import UIKit

final class Webservice: NSObject {
    
    private var numberOfCallsToSetVisible = 0
    private let activityIndicatorQueue = DispatchQueue(label: "com.xmollv.Menorca.networkIndicator")
    
    private func load(url: String, httpMethod: HTTPMethod = .get, headers: [String:String] = [:], completion: @escaping CompletionType<Data?>) {
        
        activityIndicatorQueue.sync {
            self.setNetworkActivityVisible(true)
        }
        
        guard let endpoint = URL(string: url) else {
            completion(Result.isFailure(.malformedUrl))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            self.activityIndicatorQueue.sync {
                self.setNetworkActivityVisible(false)
            }
            
            if let _ = error {
                completion(Result.isFailure(.unknown))
                return
            }
            
            completion(self.parseHTTPCode(response: response, data: data))
        }
        
        task.resume()
    }
    
    //MARK:- Network activity indicator visibility
    private func setNetworkActivityVisible(_ visible: Bool) {
        if visible {
            numberOfCallsToSetVisible += 1
        } else {
            numberOfCallsToSetVisible -= 1
        }

        let shouldBeVisible = numberOfCallsToSetVisible > 0
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = shouldBeVisible
        }
    }
    
    //MARK:- Default HTTP code parser
    private func parseHTTPCode(response: URLResponse?, data: Data?) -> Result<Data?> {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200...299:
                return Result.isSuccess(data)
            default:
                return Result.isFailure(.not200Status)
            }
        } else {
            return Result.isFailure(.unknown)
        }
    }
    
    func request(httpMethod: HTTPMethod, endpoint: Endpoint, completion: @escaping CompletionType<Data>) {
        load(url: endpoint.path, httpMethod: httpMethod) { networkResult in
            switch networkResult {
            case .isSuccess(let data):
                guard let data = data, !data.isEmpty else { completion(Result.isFailure(.noData)); return }
                completion(Result.isSuccess(data))
            case .isFailure(let error):
                completion(Result.isFailure(error))
            }
        }
    }
}

enum NetworkError {
    case unknown
    case malformedUrl
    case not200Status
    case malformedJson
    case noData
}

enum Result<T> {
    case isSuccess(T)
    case isFailure(NetworkError)
}

typealias CompletionType<T> = (Result<T>) -> ()
typealias JSONDictionary = Dictionary<String,Any>
typealias JSONArray = Array<JSONDictionary>

enum HTTPMethod: String {
    case get = "GET"
}

enum Endpoint {
    case fiestas
    
    var path: String {
        let baseUrl = "http://localhost:8000"
        switch self {
        case .fiestas:
            return "\(baseUrl)/fiestas.json"
        }
    }
}
