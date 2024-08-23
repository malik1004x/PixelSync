//
//  ListsView.swift
//  PixelSync
//
//  Created by Robert Malikowski on 6/8/24.
//

import SwiftUI
import PixeldrainSwift

struct ListsView: View {
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    @State private var lists: [PixeldrainListInfo]?
    
    var body: some View {
        if apiConnection == nil {
            LoginBanner(apiConnection: $apiConnection, transferManager: transferManager)
        } else {
            if lists == nil {
                ProgressView().onAppear() {
                    Task {
                        lists = try await apiConnection!.getUserLists()
                    }
                }
            } else {
                VStack {
                    HStack {
                        TextField("Search", text: $searchQuery).cornerRadius(15).padding(.horizontal, 15)
                    }.padding(.top, 15)
                    List (lists!.filter {list in
                        searchQuery.isEmpty || list.title.lowercased().contains(searchQuery.lowercased())
                    }, id: \.id) { list in
                        ListListItem(listInfo: list, transferManager: transferManager, apiConnection: $apiConnection).padding(.horizontal, 10)
                    }
                }
            }
        }
    }
}
