//
//  FirstViewController.swift
//  TernovskoyIA_HW2.2
//
//  Created by Илья Терновской on 07.02.2022.
//

import UIKit

protocol ViewControllerDelegate {
    func setColor(from color: UIColor)
}

class FirstViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ViewController else { return }
        viewController.delegate = self
        viewController.viewColors = view.backgroundColor
    }

}

extension FirstViewController: ViewControllerDelegate {
    func setColor(from color: UIColor) {
        view.backgroundColor = color
    }
}
