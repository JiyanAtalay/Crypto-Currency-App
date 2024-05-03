//
//  CurrenciesView.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 6.04.2024.
//

import SwiftUI

struct CurrenciesView: View {
    
    @ObservedObject var currencyViewModel : CurrencyViewModel
    
    private var urlCurrencies = URL(string: "")!
    private var urlSymbols = URL(string: "")!
    
    @State private var showCryptosView = false
    
    init() {
        currencyViewModel = CurrencyViewModel()
    }
    
    var body: some View {
        let tryx = currencyViewModel.currenciesList["TRY"] ?? 0
        NavigationStack {
            List {
                ForEach(currencyViewModel.symbolsList.sorted(by: <),id: \.key) { (key,value) in
                    VStack(alignment : .leading) {
                        HStack {
                            Text(value)
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "plus")
                                .onTapGesture {
                                    //
                                }
                        }
                        HStack {
                            Text(key)
                            Spacer()
                            Text((tryx/currencyViewModel.currenciesList[key]!).description)
                        }
                    }
                }
            }
            .toolbar(content: {
                Button {
                    showCryptosView = true
                } label : {
                    Text("Degis")
                }
                .font(.title3)
                
                Button {
                    Task.init {
                        await currencyViewModel.downloadCurrencies(url: urlCurrencies)
                        await currencyViewModel.downloadSymbols(url: urlSymbols)
                    }
                } label : {
                    Text("Refresh")
                }
            })
            .navigationTitle("Currency")
            .fullScreenCover(isPresented: $showCryptosView, content: {
                CryptosView()
            })
        }
        .task {
            await currencyViewModel.downloadCurrencies(url: urlCurrencies)
            await currencyViewModel.downloadSymbols(url: urlSymbols)
        }
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                Task.init {
                    await currencyViewModel.downloadCurrencies(url: urlCurrencies)
                    await currencyViewModel.downloadSymbols(url: urlSymbols)
                }
            }
        })
    }
}

#Preview {
    CurrenciesView()
}
