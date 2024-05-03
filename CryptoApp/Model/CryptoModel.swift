//
//  CryptoModel.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 5.04.2024.
//

import Foundation

struct Welcome: Codable, Identifiable{
    let id = UUID()
    let status: Status
    let data: [Datum]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name : String
    let lastUpdated: String
    let quote: Quote

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case lastUpdated = "last_updated"
        case quote = "quote"
    }
}

// MARK: - Quote
struct Quote: Codable {
    let usd: Usd

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct Usd: Codable {
    let price, volumeChange24H, percentchange24H : Double

    enum CodingKeys: String, CodingKey {
        case price = "price"
        case volumeChange24H = "volume_change_24h"
        case percentchange24H = "percent_change_24h"
    }
}

// MARK: - Status
struct Status: Codable {
    let errorCode: Int

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
    }
}
