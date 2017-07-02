//
//  DataProvider.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation

final class DataProvider {
    
    //MARK:- Private managers to access the network
    private let webservice = Webservice()

    func requestMultiple<T: Codable>(_ httpMethod: HTTPMethod, _ endpoint: Endpoint, completion: @escaping CompletionType<[T]>) {
        webservice.request(httpMethod: httpMethod, endpoint: endpoint) { result in
            switch result {
            case .isSuccess(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    let results = try jsonDecoder.decode([T].self, from: data)
                    DispatchQueue.main.async {
                        completion(Result.isSuccess(results))
                    }
                } catch  {
                    DispatchQueue.main.async {
                        dump(error)
                        completion(Result.isFailure(.malformedJson))
                    }
                }
                
            case .isFailure(let error):
                DispatchQueue.main.async {
                    completion(Result.isFailure(error))
                }
            }
        }
    }
    
}

