//
//  Float+Extension.swift
//  ComprasPublicas
//
//  Created by Ana Finotti on 5/6/18.
//  Copyright © 2018 Finotti. All rights reserved.
//

import UIKit

extension Float {
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    
    func floatToCurrency(isSymbolAvailable: Bool? = true) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        if !isSymbolAvailable! {
            formatter.currencySymbol = ""
        }
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return "\(formattedTipAmount)"
        }
        return nil
    }
}
extension String {
    func stringToDouble() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_Br")
        formatter.numberStyle = .currency
        return (formatter.number(from: self)?.doubleValue)!
    }
}
