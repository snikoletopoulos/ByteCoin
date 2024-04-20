import Foundation

protocol CoinManagerDelegate {
  func didFailWithError(_ coinManager: CoinManager, error: Error)
  func didUpdateCoinData(_ coinManager: CoinManager, coin: CoinData)
}

struct CoinManager {
  let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
  let apiKey = "YOUR_API_KEY_HERE"

  let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

  var delegate: CoinManagerDelegate?

  func getCoinPrice(for currency: String) {
    let urlString = "\(baseURL)/\(currency)/apikey-\(apiKey)"
    performRequest(with: urlString)
  }

  func performRequest(with urlString: String) {
    guard let url = URL(string: urlString) else { return }

    let session = URLSession(configuration: .default)

    let task = session.dataTask(with: url) { data, _, error in
      if error != nil {
        self.delegate?.didFailWithError(self, error: error!)
      }

      guard let data = data else { return }
      guard let coinData = self.parseJson(data) else { return }
      self.delegate?.didUpdateCoinData(self, coin: coinData)
    }

    task.resume()
  }

  func parseJson(_ data: Data) -> CoinData? {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(CoinData.self, from: data)
    } catch {
      delegate?.didFailWithError(self, error: error)
      return nil
    }
  }
}
