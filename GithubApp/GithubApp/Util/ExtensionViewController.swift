//
//  ExtensionViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/26.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
