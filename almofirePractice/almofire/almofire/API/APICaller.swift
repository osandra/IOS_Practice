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

    enum APIError: Error {
        case failedToGetJsonData
        case failedToGetData
    }
    
    public func signUserIn(email: String, password: String, completion: @escaping (Bool)->Void){
        
        let param: [String:String] = [
            "email": email,
            "password": password
         ]
    
        let dataRequest = AF.request(SecretKey.serverURL+"login/",
                 method: .get,
                 parameters: param,
                 encoding: URLEncoding.queryString
        )
    
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                print(response)
                guard let statusCode = response.response?.statusCode else {return}
                if statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }

            case .failure:
                completion(false)
            }
        }
    }
    
    public func join(username: String, email: String, password: String, completion: @escaping (Bool)->Void){
        let param: [String:String] = [
            "username": username,
            "email": email,
            "password": password
         ]
    
        let dataRequest = AF.request(SecretKey.serverURL+"join/",
                 method: .post,
                 parameters: param,
                 encoding: URLEncoding.queryString
        )
    
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                if statusCode == 200 {
                    //분기시키기 그리고 원래는 유저 객체를 돌려주는데..
                    print("success")
                    completion(true)
                } else {
                    print("failure")
                    completion(false)
                }

            case .failure:
                completion(false)
            }
        }
    }
    
    let baseURL = "https://api.unsplash.com/search/photos/"
    public func getPhotoData(term: String, completion: @escaping (Result<PhotoAPI, Error>)->Void){

        let param:[String:String] = [
            "query": term,
            "client_id": SecretKey.client_id
         ]
        
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
