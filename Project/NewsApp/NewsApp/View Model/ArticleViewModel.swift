//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Bao Long on 27/12/2022.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numbeOfRowInSection() -> Int {
        return articles.count
    }
    
    func articleAtIndex(at index: Int) -> ArticalViewModel {
        let article = articles[index]
        return ArticalViewModel(article)
        //return article ??? WTFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    }
}


struct ArticalViewModel {
    private var article: Article
}

extension ArticalViewModel {
    init(_ article: Article) {
        self.article = article
    }
    
    var title: String {
        return self.article.title
    }
    
    var description: String {
        return self.article.description
    }
    
}
