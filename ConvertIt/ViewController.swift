//
//  ViewController.swift
//  ConvertIt
//
//  Created by William Farley on 2/2/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var conversionLabel: UILabel!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    
    var formulasArray = ["miles to kilometers",
                         "kilometers to miles",
                         "feet to meters",
                         "meters to feet",
                         "yards to meters",
                         "meters to yards"]
    
    var toUnits = ""
    var fromUnits = ""
    var conversionString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formulaPicker.dataSource = self
        formulaPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Entry Error", message: "Please enter a valid number. Not an empty string. No commas, symbols, or non-numeric characters.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func calculateConversion() {
        
        var inputValue = 0.0
        var outputValue = 0.0
        var outputString = ""
        
        if let inputValue = Double(userInput.text!) {
        
        switch conversionString {
        case "miles to kilometers":
            outputValue = inputValue / 0.62137
        case "kilometers to miles":
            outputValue = inputValue * 0.62137
        case "feet to meters":
            outputValue = inputValue / 3.2808
        case "meters to feet":
            outputValue = inputValue * 3.2808
        case "yards to meters":
            outputValue = inputValue / 1.0936
        case "meters to yards":
            outputValue = inputValue * 1.0936
        default:
            showAlert()
            }
        
        } else {
            showAlert()
        }
        
        if decimalSegment.selectedSegmentIndex < 3 {
            outputString = String(format: "%." + String(decimalSegment.selectedSegmentIndex+1) + "f", outputValue)
        } else {
            outputString = String(outputValue)
        }
        
        conversionLabel.text! = "\(userInput.text!) \(fromUnits) = \(outputValue) \(toUnits)"
    }
    
    //MARK:- Delegates and DataSources, Required for UIPickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return formulasArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return formulasArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        conversionString = formulasArray[row]
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        conversionLabel.text = toUnits
        fromUnitsLabel.text = fromUnits
        calculateConversion()
    }
    
    //MARK:- Actions
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        calculateConversion()
    }
    
    @IBAction func decimalSelected(_ sender: UISegmentedControl) {
        calculateConversion()
    }
    
    
}

