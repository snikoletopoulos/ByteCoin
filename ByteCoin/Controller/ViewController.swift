import UIKit

class ViewController: UIViewController {
  @IBOutlet var bitcoinLabel: UILabel!
  @IBOutlet var currencyLabel: UILabel!
  @IBOutlet var currencyPicker: UIPickerView!

  var coinManager = CoinManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    currencyPicker.dataSource = self
    currencyPicker.delegate = self

    coinManager.delegate = self

    let currencyIndex = currencyPicker.selectedRow(inComponent: 0)
    coinManager.getCoinPrice(for: coinManager.currencyArray[currencyIndex])
  }
}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return coinManager.currencyArray.count
  }
}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return coinManager.currencyArray[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let currency = coinManager.currencyArray[row]
    coinManager.getCoinPrice(for: currency)
  }
}

// MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
  func didFailWithError(_ coinManager: CoinManager, error: Error) {
    print(error)
  }

  func didUpdateCoinData(_ coinManager: CoinManager, coin: CoinData) {
    DispatchQueue.main.async {
      self.bitcoinLabel.text = String(format: "%.1f", coin.rate)
      self.currencyLabel.text = coin.asset_id_quote
    }
  }
}
