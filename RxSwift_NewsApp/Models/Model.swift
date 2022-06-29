//
//  Model.swift
//  RxSwift_NewsApp
//
//  Created by max on 29.06.2022.
//

import Foundation

struct ArticleList: Codable {
    
    let articles: [Article]
    
}

extension ArticleList {
    
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=5b857b468411402e93e521c8ccfe22e0")!
        return Resource(url: url)
    }()
}

struct Article: Codable {
    
    let title: String
    let description: String?
    
}
