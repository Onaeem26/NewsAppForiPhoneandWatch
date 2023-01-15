//
//  FavoritesView.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/13/23.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var newsVM : NewsViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(newsVM.favorites, id: \.id) { item in
                    NewsArticleBar(newsVM: newsVM, item: item)
                }
            }
            .padding()
        }.navigationTitle("Favorites")
    }
}


