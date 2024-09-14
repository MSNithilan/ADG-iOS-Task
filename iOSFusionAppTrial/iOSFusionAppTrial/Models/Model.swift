import SwiftUI

// Models for the historical data API
struct CryptoDataResponse: Codable {
    let Data: DataResponse
}

struct DataResponse: Codable {
    let Data: [HistoricalData]
}

struct HistoricalData: Codable {
    let time: Int
    let close: CGFloat
}

struct GraphData: Identifiable {
    let id = UUID()
    var value: CGFloat
}

// Models for the market cap API
struct MarketCapResponse: Codable {
    let Data: [MarketCapData]
}

struct MarketCapData: Codable {
    let CoinInfo: CoinInfo  // Include CoinInfo for coin metadata
    let RAW: [String: RawDetails]  // RAW holds the price data
}

struct CoinInfo: Codable {  // Model for coin metadata
    let Name: String
    let FullName: String
}

struct RawDetails: Codable {  // Model for price details
    let FROMSYMBOL: String
    let TOSYMBOL: String
    let PRICE: Double
    let TOPTIERVOLUME24HOUR: Double
    let OPENHOUR: Double
    let OPEN24HOUR: Double
}

// Models for the crypto calculation API (percentage change)
struct CryptoCalcResponse: Codable {
    let Data: TimeSeriesData
}

struct TimeSeriesData: Codable {
    let Data: [ClosePrice]
}

struct ClosePrice: Codable {
    let time: Int
    let close: Double
}

