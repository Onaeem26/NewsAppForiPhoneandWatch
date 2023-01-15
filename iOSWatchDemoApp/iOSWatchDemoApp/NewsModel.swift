//
//  NewsModel.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/13/23.
//

import Foundation


struct NEWSAPI : Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]
}

struct Article : Codable, Equatable {
    var title : String?
    var description : String?
    var url : URL?
    var urlToImage : URL?
}

class CustomizedArticle {
    var id = UUID()
    var article : Article
    var isFavorite : Bool
    
    init(id: UUID = UUID(), article: Article, isFavorite: Bool) {
        self.id = id
        self.article = article
        self.isFavorite = isFavorite
    }
}
