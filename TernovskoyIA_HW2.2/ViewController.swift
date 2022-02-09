//
//  ViewController.swift
//  TernovskoyIA_HW2.2
//
//  Created by Илья Терновской on 26.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var viewField: UIView!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    var delegate: ViewControllerDelegate!
    var viewColors: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewField.layer.cornerRadius = 13
        doneButton.layer.cornerRadius = 13
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        viewField.backgroundColor = viewColors
        
        setValuesFromColor()
        setValueForLabel(for: redLabel, greenLabel, blueLabel)
        setValueForTextField(for: redTextField, greenTextField, blueTextField)
        
        
        
    }
 
    @IBAction func colorSliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValueForLabel(for: redLabel)
            setValueForTextField(for: redTextField)
        case greenSlider:
            setValueForLabel(for: greenLabel)
            setValueForTextField(for: greenTextField)
        default:
            setValueForLabel(for: blueLabel)
            setValueForTextField(for: blueTextField)
        }
        changeColor()
        
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(from: viewField.backgroundColor ?? .black)
        dismiss(animated: true)
    }
    
}
// - MARK: Private methods
extension ViewController {
   
    private func changeColor() {
        viewField.backgroundColor = UIColor(
            displayP3Red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValueForLabel (for labels: UILabel...) {
        for label in labels {
            switch label {
            case redLabel: label.text = String(format: "%.2f", redSlider.value)
            case greenLabel: label.text = String(format: "%.2f", greenSlider.value)
            default: label.text = String(format: "%.2f", blueSlider.value)
                
         
            }
        }
    }
    
    private func setValueForTextField (for textFields: UITextField...) {
        for textField in textFields {
            switch textField {
            case redTextField: textField.text = String(format: "%.2f", redSlider.value)
            case greenTextField: textField.text = String(format: "%.2f", greenSlider.value)
            default: textField.text = String(format: "%.2f", blueSlider.value)
            }
        }
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setValuesFromColor() {
        let ciColor = CIColor(color: viewColors)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    
}
// MARK: TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
      func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            if currentValue <= 1.0 {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValueForLabel(for: redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValueForLabel(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValueForLabel(for: blueLabel)
            }
            changeColor()
            return
            } else {
                showAlert(title: "Sorry", message: "please enter a valid value")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneClicked)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
}
