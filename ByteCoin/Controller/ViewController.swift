//
//  ViewController.swift
//  ByteCoin
//
//  Created by sukhjeet on 07/02/21.
//

import UIKit

class ViewController: UIViewController, CoinManagerDelegate {
    
    @IBOutlet weak var bitcoinAmount: UILabel!
    @IBOutlet weak var exchangeTo: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
        exchangeTo.text = coinManager.currencyArray[0]
        coinManager.getCoinPrice(for: coinManager.currencyArray[0])
    }
    
    func didUpdateCoin(_ coinManager: CoinManager, _ rate: Double) {
        DispatchQueue.main.async {
            self.bitcoinAmount.text = String(format: "%0.4f", rate)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
        return
    }
    
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
          
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        exchangeTo.text = currency
        coinManager.getCoinPrice(for: currency)
    }
    
}
