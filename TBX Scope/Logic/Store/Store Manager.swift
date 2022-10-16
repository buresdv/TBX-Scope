//
//  Store Manager.swift
//  TBX Scope
//
//  Created by David Bureš on 16.10.2022.
//

import Foundation
import StoreKit

class StoreManager: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var timesTipped: Int = UserDefaults.standard.integer(forKey: "timesTipped")
    
    func fetchProducts() async -> Void {
        do {
            let products = try await Product.products(for: ["tip"])
            print(products)
            
            DispatchQueue.main.async {
                self.products = products
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func purchase() async -> Void {
        do {
            guard let product = products.first else { return }
            let purchaseResult = try await product.purchase()
            
            switch purchaseResult {
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verificationResult):
                    print(verificationResult.errorDescription)
                    print(signedType.productID)
                case .verified(let signedType):
                    
                    // HOLY SHIT
                    await signedType.finish()
                    
                    print("Bought \(signedType.productID) (\(signedType.id))")
                    DispatchQueue.main.async { [self] in
                        if self.timesTipped == 0 {
                            self.timesTipped = 1
                        } else {
                            self.timesTipped += 1
                        }
                    }
                    print("Tipped \(timesTipped) times")
                    
                }
            case .userCancelled:
                print("User cancelled the purchase")
            case .pending:
                print("Purchase is pending")
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
}
