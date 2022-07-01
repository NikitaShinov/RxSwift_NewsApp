//
//  NewsViewModel.swift
//  RxSwift_NewsApp
//
//  Created by max on 30.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

struct NewsListViewModel {
    
    let newsVM: [NewsViewModel]
    
}

extension NewsListViewModel {
    
    init(_ news: [Article]) {
        self.newsVM = news.compactMap(NewsViewModel.init)
    }
    
}

extension NewsListViewModel {
    
    func newsAt(_ index: Int) -> NewsViewModel {
        return self.newsVM[index]
    }
    
}

struct NewsViewModel {
    
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension NewsViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
    
}
