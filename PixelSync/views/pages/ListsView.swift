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
                ScrollView {
                    ForEach(lists!, id: \.id) { list in
                        ListListItem(listInfo: list, transferManager: transferManager, apiConnection: $apiConnection)
                        Divider()
                    }
                }
            }
        }
    }
}
