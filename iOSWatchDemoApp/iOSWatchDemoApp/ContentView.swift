//
//  ContentView.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(newsViewModel.articles, id: \.id) { item in
                        NewsArticleBar(newsVM: newsViewModel, item: item)
                    }
                }
                .padding()
            }.navigationTitle("Articles")
            .onAppear {
                newsViewModel.loadArticles()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoritesView(newsVM: newsViewModel)) {
                        Text("Favs")
                    }
                  }
              }
        }
    }
}

struct NewsArticleBar : View {
    @ObservedObject var newsVM : NewsViewModel
    var item : CustomizedArticle
    @State var isFavorite : Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            
            AsyncImage(url: item.article.urlToImage) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 120, maxHeight: 120)
            
            VStack(alignment: .leading) {
                Text(item.article.title ?? "")
                    .font(.system(.headline))
                    .frame(maxWidth: .infinity)
            }
            
            Button {
                if !isFavorite {
                    isFavorite = true
                    newsVM.addFavorite(item: item)
                }else {
                    isFavorite = false
                    newsVM.removeFavorite(item: item)
                }
                
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }.onAppear {
            isFavorite = item.isFavorite
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
