//
//  NewsViewModel.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/13/23.
//

import Foundation

class NewsViewModel : ObservableObject {
    @Published var articles : [CustomizedArticle] = []
    @Published var favorites : [CustomizedArticle] = [] 
    private let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=//"

    func loadArticles() {
        fetchArticles(url: urlString)
    }

    func addFavorite(item: CustomizedArticle) {
        item.isFavorite = true
        self.favorites.append(item)
        let favArticles = self.favorites.map { $0.article.title ?? "" }
        WatchConnectivityManager.shared.send(favArticles)
    }
    
    func removeFavorite(item : CustomizedArticle) {
        let index = favorites.firstIndex{$0.article == item.article}
        if let index = index {
            self.favorites.remove(at: index)
        }
        let favArticles = self.favorites.map { $0.article.title ?? "" }
        WatchConnectivityManager.shared.send(favArticles)
    }
    
    private func fetchArticles(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            
            guard let data = data else { return }
            
            do {
                let item = try JSONDecoder().decode(NEWSAPI.self, from: data)
                DispatchQueue.main.async {
                    self.articles = item.articles.map { CustomizedArticle(article: $0, isFavorite: self.checkIsFavorite(item: $0))}
                }
            }catch {
                print("We got an error here")
                print(error)
                return
            }
        }.resume()
    }
    
    func checkIsFavorite(item: Article) -> Bool {
        return favorites.contains(where: { fav in
            fav.article == item
        })
    }
    
}

