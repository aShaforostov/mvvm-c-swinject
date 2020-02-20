//
//  APIService.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import Foundation
import RxSwift

struct APIService {
    private let decoder = JSONDecoder()

    private var session: URLSession

    private var baseURL: URL

    init(session: URLSession, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }

    enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }

    enum Endpoint {
           case feed
           case post(postID: Int)

           func path() -> String {
               switch self {
               case .feed:
                   return "files/api201910/posts.json"
               case let .post(postID):
                   return "files/api201910/\(postID).json"
               }
           }
       }

    func GET<T: Codable>(endpoint: Endpoint, params: [String: String]? = [:]) -> Single<T> {
        let queryURL = URL(string: "\(baseURL)\(endpoint.path())")!
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }

        // swiftlint:disable force_unwrapping
        var request = URLRequest(url: components.url!)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return Single.create { single in

            let task = self.session.dataTask(with: request) { (data, _, error) in
                guard let data = data else {
                    DispatchQueue.main.async {
                        single(.error(APIError.noResponse))
                    }
                    return
                }
                guard error == nil else {
                    DispatchQueue.main.async {
                        // swiftlint:disable force_unwrapping
                        single(.error(APIError.networkError(error: error!)))
                    }
                    return
                }
                do {
                    let object = try self.decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        single(.success(object))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        #if DEBUG
                        print("JSON Decoding Error: \(error)")
                        #endif
                        single(.error(APIError.jsonDecodingError(error: error)))
                    }
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
