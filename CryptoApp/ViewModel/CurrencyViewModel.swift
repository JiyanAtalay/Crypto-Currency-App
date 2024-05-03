//
//  CurrencyViewModel.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 6.04.2024.
//

import Foundation

@MainActor
class CurrencyViewModel : ObservableObject {
    @Published var currenciesList = [String : Double]()
    @Published var symbolsList = [String : String]()
    
    var webservice = WebService()
    
    func downloadCurrencies(url : URL) async {
        do {
            let currencies = try await webservice.downloadCurrencies(url: url)
            
            self.currenciesList = currencies
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func downloadSymbols(url : URL) async {
        do {
            let symbols = try await webservice.downloadSymbols(url: url)
            
            self.symbolsList = symbols
        } catch {
            print(error.localizedDescription)
        }
    }
}
