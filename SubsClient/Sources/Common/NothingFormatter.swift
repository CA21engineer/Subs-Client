//
//  NothingFormatter.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import Foundation

class NothingFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        guard let str = obj as? String else { return nil }
        return str as String
    }

    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as NSString
        return true
    }

    override func isPartialStringValid(_ partialStringPtr: AutoreleasingUnsafeMutablePointer<NSString>, proposedSelectedRange proposedSelRangePtr: NSRangePointer?, originalString origString: String, originalSelectedRange origSelRange: NSRange, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        true
    }
}
