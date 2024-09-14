import SwiftUI

struct ExtendedCoinView: View {
    @ObservedObject var dataFetcher: DataFetcher
    @ObservedObject var viewModel: CryptoViewModel
    @Binding var showExtendedView: Bool
    let bgc1 = #colorLiteral(red: 0.8352325559, green: 0.9164586663, blue: 0.9087759852, alpha: 1)
    let bgc2 = #colorLiteral(red: 0.9139035344, green: 0.9585645795, blue: 0.9594748616, alpha: 1)

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.orange)
                        .padding(5)
                    VStack(alignment: .leading) {
                        HStack {
                            Text(dataFetcher.fromSymbol)
                                .font(.title2)
                            
                            Text(dataFetcher.toSymbol)
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        Text(dataFetcher.coinFullName)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    
                    Image(systemName: "arrow.left.arrow.right.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(5)
                        .foregroundStyle(.black)
                }
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Price")
                            .foregroundStyle(.gray)
                            .font(.title3)
                        HStack(spacing: 0) {
                            Text(dataFetcher.price.components(separatedBy: ".").first ?? "0")
                                .font(.title)
                            Text(".")
                                .font(.title)
                                .foregroundColor(.gray)
                            Text(dataFetcher.price.components(separatedBy: ".").dropFirst().first ?? "00")
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding(.top, 9)
                        }
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: viewModel.percentageChange >= 0 ? "arrow.up.right" : "arrow.down.right")
                            .foregroundColor(viewModel.percentageChange >= 0 ? .green : .red)
                            .font(.caption)
                            .bold()
                        Text(String(format: "%.2f%%", viewModel.percentageChange))
                            .foregroundColor(viewModel.percentageChange >= 0 ? .green : .red)
                            .font(.caption)
                            .bold()
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
                VStack {
                    LineGraph(data: dataFetcher.data, projection: viewModel.percentageChange)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(height: 75)
                        .padding(.horizontal, 25)
                }
                HStack(spacing: 15) {
                    HStack(spacing: 4) {
                        Text("Volume")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text(formatNumber(from: dataFetcher.topTierVolume24hour))
                            .font(.footnote)
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    HStack(spacing: 4) {
                        Text("Prev")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text(formatNumber(from: dataFetcher.openHour))
                            .font(.footnote)
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    HStack(spacing: 4) {
                        Text("Open")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text(formatNumber(from: dataFetcher.open24hour))
                            .font(.footnote)
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .padding(.top, 15)
            }
            .padding()
            .background(Color(bgc1))
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .padding()
        .onTapGesture {
            showExtendedView.toggle()
        }
        .onAppear {
            dataFetcher.fetchData()
            viewModel.fetchDataAndCalculateChange()
        }
    }
}

func formatNumber(from string: String) -> String {
    if let number = Int(string) {
        if number >= 1000 {
            let formattedNumber = Double(number) / 1000
            return String(format: "%.2fk", formattedNumber)
        } else {
            return String(number)
        }
    } else {
        return "..."
    }
}

struct ExtendedCoinView_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedCoinView(dataFetcher: DataFetcher(), viewModel: CryptoViewModel(), showExtendedView: .constant(true))
    }
}

