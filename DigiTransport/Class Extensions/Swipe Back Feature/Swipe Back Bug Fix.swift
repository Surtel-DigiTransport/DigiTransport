//
//  Bug Fix.swift
//  DigiTransport
//
//  Created by Shamit Surana on 8/4/20.
//  Copyright © 2020 RS Infocon. All rights reserved.
//
import UIKit

extension UINavigationController:UINavigationControllerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if responds(to: #selector(getter: self.interactivePopGestureRecognizer)) {
            if viewControllers.count > 1 {
                interactivePopGestureRecognizer?.isEnabled = true
            } else {
                interactivePopGestureRecognizer?.isEnabled = false
            }
        }
    }
}
