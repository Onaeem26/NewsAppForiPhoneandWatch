//
//  ContentView.swift
//  iOSWatchDemoApp Watch App
//
//  Created by Muhammad Osama Naeem on 1/13/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var connectivityManager = WatchConnectivityManager.shared
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Articles")
            if connectivityManager.notificationMessage?.favoriteArticles.count ?? 0 > 0 {
                ScrollView {
                    ForEach(connectivityManager.notificationMessage?.favoriteArticles ?? [], id: \.self) { item in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item)
                                        .font(.system(.headline))
                                }
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                
                            }.padding(.horizontal, 4)
                            Divider()
                        }
                    }
                }
            }else {
                Text("Favorite Articles will appear here")
                    .foregroundColor(Color.secondary)
            }
        }
    }
    
    func removeFavorite(item : String, arr: inout [String]) {
        let index = arr.firstIndex{$0 == item}
        if let index = index {
            arr.remove(at: index)
        }
        WatchConnectivityManager.shared.send(arr)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
