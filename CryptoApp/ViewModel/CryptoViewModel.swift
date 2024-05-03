//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 5.04.2024.
//

import Foundation

@MainActor
class CryptoViewModel : ObservableObject {
    @Published var cryptoList = [Datum]()
    
    let webservice = WebService()
    
    func downloadCryptos(url : URL) async {
        do {
            let cryptos = try await webservice.downloadCryptoCurrencies(url: url)
            
            self.cryptoList = cryptos
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
