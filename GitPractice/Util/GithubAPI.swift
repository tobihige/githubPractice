//
//  GithubAPI.swift
//  GitPractice
//
//  Created by tobihige on 2024/01/17.
//

import Foundation

enum GithubError: Error {
    case error
}

protocol GithubAPIProtocol: AnyObject {
    func get(searchWord: String, isDesc: Bool, result:
    ((Result<[GithubModel], GithubError>) -> Void)?)
}

final class GithubAPI: GithubAPIProtocol {
    static let shared = GithubAPI()
    
    private init() {}
    
    func get(searchWord: String, isDesc: Bool = true, result: ((Result<[GithubModel], GithubError>) -> Void)? = nil) {
        guard !searchWord.isEmpty else {
            result?(.failure(.error))
            return
        }
        let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars&order=\(isDesc ? "desc" : "asc")")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data,
                  let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
                  let models = githubResponse.items
            else {
                result?(.failure(.error))
                return
            }
            result?(.success(models))
        })
        task.resume()
    }
}
