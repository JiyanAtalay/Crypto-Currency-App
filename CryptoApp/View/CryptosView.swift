//
//  ContentView.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 5.04.2024.
//

import SwiftUI
import SwiftData

struct CryptosView: View {
    @ObservedObject var cryptoViewModel : CryptoViewModel
    
    @Environment(\.modelContext) private var context
    
    private var urlx = URL(string: "")!
    
    @State private var showCurrenciesView = false
    
    init() {
        self.cryptoViewModel = CryptoViewModel()
    }
    
    var body: some View {
        NavigationStack {
            List(cryptoViewModel.cryptoList,id: \.id) { crypto in
                VStack {
                    HStack {
                        Text(crypto.name)
                            .font(.title3)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Image(systemName: "plus")
                            .onTapGesture {
                                /*
                                let namex = saveData(datax: crypto)
                                context.insert(namex)
                                
                                do {
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }*/
                            }
                        
                    }
                    HStack {
                        Text(String(format:"%.6f", crypto.quote.usd.price))
                            .font(.title3)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Text(String(format: "%.2f%%", crypto.quote.usd.percentchange24H))
                            .foregroundStyle(crypto.quote.usd.percentchange24H.description.first == "-" ? .red : .green)
                    }
                }
            }
            .toolbar(content: {
                Button {
                    showCurrenciesView = true // Değişiklik butonuna basıldığıCurrenciesView'i göster
                } label: {
                    Text("Degis")
                }
                .font(.title3)


                
                Button {
                    Task.init {
                        await cryptoViewModel.downloadCryptos(url: urlx)
                    }
                } label : {
                    Text("Refresh")
                }
            })
            .navigationTitle("Crypto List")
            .fullScreenCover(isPresented: $showCurrenciesView, content: {
                CurrenciesView()
            })
        }.task {
            await cryptoViewModel.downloadCryptos(url: urlx)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                Task.init {
                    await cryptoViewModel.downloadCryptos(url: urlx)
                }
            }
        }
    }
}

@Model
class saveData {
    let datax : Datum
    
    var name : String {
        datax.name
    }
    
    init(datax: Datum) {
        self.datax = datax
    }
}

#Preview {
    CryptosView()
}
