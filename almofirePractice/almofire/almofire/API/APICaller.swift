//
//  APICaller.swift
//  almofire
//
//  Created by heawon on 2021/03/25.
//

import Foundation
import Alamofire
final class APICaller {
    
    static let shared = APICaller()
    
    let baseURL = "https://api.unsplash.com/search/photos/"
    
    let param:[String:String] = [
        "query": "cat",
        "client_id": SecretKey.client_id
     ]
    
    enum APIError: Error {
        case failedToGetJsonData
        case failedToGetData
    }
    
    public func getPhotoData(completion: @escaping (Result<PhotoAPI, Error>)->Void){
       let dataRequest = AF.request(baseURL,
                 method: .get,
                 parameters: param,
                 encoding: URLEncoding.default
        )
        
        dataRequest.responseJSON { (response) in
            switch response.result {
            case .success(let data):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                guard let getRealData = try? JSONDecoder().decode(PhotoAPI.self, from: jsonData) else {return}
                completion(.success(getRealData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedToGetJsonData))
            }
            case .failure(let error):
                print(error,"fail")
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
}
