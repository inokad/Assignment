//
//  Fetcher.swift
//  SPHAssignment
//
//  Reusable class for fetching data.
//
//  Created by Inoka Dissanayaka on 12/18/18.
//  Copyright © 2018 Inoka Dissanayaka. All rights reserved.

import Foundation

class Fetcher {
    static let sharedInstance = Fetcher()
    
    fileprivate let HOST_API_URL = "data.gov.sg"
    fileprivate let HTTP_SCHEME = "https"
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    enum APIEndpoint: String {
        case DataStoreSearch = "/api/action/datastore_search"
    }

    let defaultSession = URLSession(configuration: .default)
    
    /**
     * Get search data for a given resource id.
     */
    func getSearchedData(resourceId: String, completion: ((Result<[Record]>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = HTTP_SCHEME
        urlComponents.host = HOST_API_URL
        urlComponents.path = APIEndpoint.DataStoreSearch.rawValue
        
        let resourceId = URLQueryItem(name: Constants.QUERY_PARAM_RESOURCE_ID , value: resourceId)
        let offset = URLQueryItem(name: Constants.QUERY_PARAM_OFFSET, value: Constants.QUERY_OFFSET_VALUE)
        urlComponents.queryItems = [resourceId, offset]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = defaultSession.dataTask(with: request) { responseData, response, responseError in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                    
                } else if let jsonData = responseData,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == Constants.HTTP_SUCCESS_CODE {
                    
                    let decoder = JSONDecoder()
                    do {
                        #if DEBUG
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        debugPrint(jsonObject)
                        #endif
                        let rawResponse = try decoder.decode(RawServerResponse.self, from: jsonData)
                        debugPrint(rawResponse)
                        completion?(.success(rawResponse.result.records))
                        
                    } catch {
                        completion?(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
}
