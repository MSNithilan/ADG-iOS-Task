import Foundation
import Combine

class DataFetcher: ObservableObject {
    @Published var data: [GraphData] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var fromSymbol: String = "Coin Symbol..."
    @Published var toSymbol: String = "Currency..."
    @Published var price: String = "0.00"
    @Published var topTierVolume24hour: String = "0.00k"
    @Published var openHour: String = "0.00k"
    @Published var open24hour: String = "0.00k"
    @Published var coinFullName: String = "Coin Name..."

    private var cancellables = Set<AnyCancellable>()

    func fetchData() {
        fetchHistoricalData()
        fetchMarketCapData()
    }

    private func fetchHistoricalData() {
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=7&api_key=f27de5e65280900bced06ffd4681a99ee9a55c795d4a1a0eb5ea19c898e32184") else {
            error = "Invalid URL"
            return
        }

        isLoading = true
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self?.error = "Error fetching data: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self?.error = "No data received"
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CryptoDataResponse.self, from: data)
                let graphData = response.Data.Data.map { GraphData(value: $0.close) }
                DispatchQueue.main.async {
                    self?.data = graphData
                }
            } catch {
                DispatchQueue.main.async {
                    self?.error = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func fetchMarketCapData() {
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=1&tsym=USD&api_key=f27de5e65280900bced06ffd4681a99ee9a55c795d4a1a0eb5ea19c898e32184") else {
            error = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.error = "Error fetching market cap data: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self?.error = "No market cap data received"
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MarketCapResponse.self, from: data)
                
                if let firstData = response.Data.first {
                    let rawDetails = firstData.RAW["USD"] // Access RAW data safely
                    let fromSymbol = rawDetails?.FROMSYMBOL ?? ""
                    let toSymbol = rawDetails?.TOSYMBOL ?? ""
                    let price = rawDetails?.PRICE ?? 0.0
                    let topTierVolume24hour = rawDetails?.TOPTIERVOLUME24HOUR ?? 0.0
                    let openHour = rawDetails?.OPENHOUR ?? 0.0
                    let open24hour = rawDetails?.OPEN24HOUR ?? 0.0
                    let integerPart = Int(price)
                    let integerPartVol = Int(topTierVolume24hour)
                    let integerPartOpen = Int(openHour)
                    let integerPartOpen24h = Int(open24hour)
                    let decimalPart = String(format: "%.2f", price - Double(integerPart))

                    DispatchQueue.main.async {
                        self?.fromSymbol = fromSymbol
                        self?.toSymbol = toSymbol
                        self?.price = "\(integerPart).\(decimalPart.dropFirst(2))" // Removes the "0." part
                        self?.topTierVolume24hour = "\(integerPartVol)"
                        self?.openHour = "\(integerPartOpen)"
                        self?.open24hour = "\(integerPartOpen24h)"
                        self?.coinFullName = firstData.CoinInfo.FullName // Set fullName here
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.error = "Error decoding market cap data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }


}

class CryptoViewModel: ObservableObject {
    @Published var percentageChange: Double = 0.0

    func fetchDataAndCalculateChange() {
        let urlString = "https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=10&api_key=f27de5e65280900bced06ffd4681a99ee9a55c795d4a1a0eb5ea19c898e32184"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let apiResponse = try JSONDecoder().decode(CryptoDataResponse.self, from: data)
                let closePrices = apiResponse.Data.Data.map { $0.close }
                
                if let firstClose = closePrices.first, let lastClose = closePrices.last {
                    let change = ((lastClose - firstClose) / lastClose) * 100
                    
                    DispatchQueue.main.async {
                        self.percentageChange = change
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}

