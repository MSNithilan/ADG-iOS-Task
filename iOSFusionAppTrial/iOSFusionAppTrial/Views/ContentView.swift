import SwiftUI

struct ContentView: View {
    @ObservedObject var dataFetcher = DataFetcher()
    @ObservedObject var viewModel = CryptoViewModel()
    
    @State private var showExtendedView = false
    
    var body: some View {
        ZStack {
            if showExtendedView {
                ExtendedCoinView(dataFetcher: dataFetcher, viewModel: viewModel, showExtendedView: $showExtendedView)
            } else {
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.orange)
                                .padding(5)
                            
                            Text(dataFetcher.fromSymbol)
                                .font(.title2)
                                .foregroundColor(.white)
                            
                            Text(dataFetcher.toSymbol)
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            VStack {
                                HStack(spacing: 0) {
                                    Text(dataFetcher.price.components(separatedBy: ".").first ?? "0")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text(".")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                    Text(dataFetcher.price.components(separatedBy: ".").dropFirst().first ?? "00")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                        .padding(.top, 9)
                                }
                            }
                        }
                        HStack {
                            HStack(spacing: 4){
                                Image(systemName: viewModel.percentageChange >= 0 ? "arrow.up.right" : "arrow.down.right")
                                    .foregroundColor(viewModel.percentageChange >= 0 ? .green : .red)
                                    .font(.caption)
                                Text(String(format: "%.2f%%", viewModel.percentageChange))
                                    .foregroundColor(viewModel.percentageChange >= 0 ? .green : .red)
                                    .font(.caption)
                            }
                            LineGraph(data: dataFetcher.data)
                                .stroke(Color.white, lineWidth: 2)
                                .frame(height: 40)
                                .padding(.horizontal,5)
                            
                            Image(systemName: "arrow.up.right.circle")
                                .foregroundStyle(.gray)
                                .font(.largeTitle)
                        }
                    }
                    .padding()
                    .background(Color.black)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

