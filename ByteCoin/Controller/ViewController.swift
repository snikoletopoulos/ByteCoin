import UIKit

class ViewController: UIViewController {
  @IBOutlet var bitcoinLabel: UILabel!
  @IBOutlet var currencyLabel: UILabel!
  @IBOutlet var currencyPicker: UIPickerView!

  let coinManager = CoinManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    currencyPicker.dataSource = self
    currencyPicker.delegate = self
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
