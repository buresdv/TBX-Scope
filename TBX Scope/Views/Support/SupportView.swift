//
//  SupportWindow.swift
//  TBX Scope
//
//  Created by David Bureš on 15.10.2022.
//

import SwiftUI
import StoreKit
import ConfettiSwiftUI

struct SupportView: View {
    
    @ObservedObject var appState: AppState
    
    @Binding var isShowingSheet: Bool
    
    @StateObject var storeManager = StoreManager()
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                Image("Avatar")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .mask(Circle())
                    .shadow(radius: 10)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("Hey! I'm David")
                                .font(.largeTitle)
                            Text("I'm the developer of this app.")
                                .font(.subheadline)
                        }
                        
                        Text("This app is completely free and open source.\nIf you enjoy using it and would like to support it, you can drop a few pennies into the tip jar.")
                        
                        VStack {
                            if appState.isShowingThanks {
                                Text("Thank you so much for your support!\nThanks to you, I can keep my apps free and open source.")
                            } else {
                                Text("Who knows, there might even be a little surprise for you :)")
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    
                    if let product = storeManager.products.first {
                        Button {
                            Task {
                                await storeManager.purchase()
                            }
                        } label: {
                            Text("Tip \(String(product.displayPrice))")
                        }
                    } else {
                        Button {
                        } label: {
                            Text("Fetching...")
                        }
                        .disabled(true)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            Text("Close")
                        }

                    }
                }
            }
        }
        .frame(width: 450, height: 200)
        .padding()
        .onAppear {
            Task {
                await storeManager.fetchProducts()
            }
        }
        .onChange(of: storeManager.timesTipped, perform: { newValue in
            if newValue > 0 {
                withAnimation {
                    appState.isShowingThanks = true
                }
            }
        })
        .confettiCannon(counter: $storeManager.timesTipped, num: 30, repetitions: 2)
    }
}
