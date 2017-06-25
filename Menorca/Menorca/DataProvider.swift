//
//  DataProvider.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import Foundation

protocol JSONInitiable {
    init?(dict: JSONDictionary)
}

final class DataProvider {
    
    //MARK:- Private managers to access the network
    private let webservice = Webservice()

    func requestMultiple<T: JSONInitiable>(_ httpMethod: HTTPMethod, _ endpoint: Endpoint, completion: @escaping CompletionType<[T]>) {
        webservice.request(httpMethod: httpMethod, endpoint: endpoint) { result in
            switch result {
            case .isSuccess(let json):
                guard let json = json as? JSONArray else { completion(Result.isFailure(.malformedJson)); return }
                let results = json.flatMap{ T(dict: $0) }
                DispatchQueue.main.async {
                    completion(Result.isSuccess(results))
                }
            case .isFailure(let error):
                DispatchQueue.main.async {
                    completion(Result.isFailure(error))
                }
            }
        }
    }
    
}

