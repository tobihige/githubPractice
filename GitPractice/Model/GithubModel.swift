//
//  GithubModel.swift
//  GitPractice
//
//  Created by tobihige on 2024/01/17.
//

import Foundation

struct GithubResponse: Codable {
    let items: [GithubModel]?
}

struct GithubModel: Codable {
    let id: Int
    let name: String
    private let fullName: String
    var urlStr: String { "https://github.com/\(fullName)"}
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
    }
}
