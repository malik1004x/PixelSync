//
//  ProfileView.swift
//  PixelSync
//
//  Created by Robert Malikowski on 6/8/24.
//

import SwiftUI
import PixeldrainSwift

struct ProfileView: View {
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    @State var profileInfo: PixeldrainUserInfo?
    
    var body: some View {
        if apiConnection == nil {
            LoginBanner(apiConnection: $apiConnection, transferManager: transferManager)
        } else {
            if profileInfo == nil {
                ProgressView().onAppear {
                    Task {
                            self.profileInfo = try await apiConnection?.getUserInfo()

                    }
                }
            } else {
                VStack {
                    Spacer().frame(height: 30)
                    Text("Welcome home, \(profileInfo!.username)!").font(.title)
                    Text(profileInfo!.email)
                    Spacer()
                    Text("You are on the ") + Text(profileInfo!.subscription.name).bold() + Text(" plan")
                    if profileInfo!.subscription.id == "prepaid" {
                        Text("Your account balance is ") + Text(formatBalanceMicroEur(balanceMicroEur: profileInfo!.balanceMicroEur))
                    }
                    Spacer()
                    ProfileUtilityButtons(apiConnection: $apiConnection)
                    Spacer().frame(height: 30)
                }
            }
        }
    }
}
