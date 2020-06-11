//
//  UIApplication+Ex.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
