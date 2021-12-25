//
//  NeworkManager.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import Foundation
import RxSwift




public enum RequestType: String {
    case GET, POST, PUT,DELETE
}


class APIRequest {
    let baseURL = URL(string: "http://api.tvmaze.com/search/shows?q=Future")!
    var method = RequestType.GET
    var parameters = [String: String]()
    
    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}


class APICalling {
    // create a method for calling api which is return a Observable
    func getShows() -> Observable<[WelcomeElement]> {
        return Observable<[WelcomeElement]>.create { observer in
            let apiRequest =  APIRequest()
            let request = apiRequest.request(with: apiRequest.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {observer.onError(error)}
                do {
                    let model: [WelcomeElement] = try JSONDecoder().decode([WelcomeElement].self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
