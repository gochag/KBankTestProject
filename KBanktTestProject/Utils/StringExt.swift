//
//  StringExt.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 02.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

extension String{
    func formatCardNumber(shouldRemoveLastDigit: Bool) -> String {
        guard !self.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: self).range(of: self)
        var number = regex.stringByReplacingMatches(in: self, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 16 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 16)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        let end = number.index(number.startIndex, offsetBy: number.count)
        let range = number.startIndex..<end

        if number.count <= 8 {
            number = number.replacingOccurrences(of: "(\\d{4})(\\d+)", with: "$1 $2", options: .regularExpression, range: range)
            
        } else if number.count <= 12 {
            number = number.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: range)
        } else{
            number = number.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d+)", with: "$1 $2 $3 $4", options: .regularExpression, range: range)
        }
        return number
    }
    
    func formatDate(shouldRemoveLastDigit: Bool) -> String{
        guard !self.isEmpty else { return "" }
          guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
          let r = NSString(string: self).range(of: self)
          var result = regex.stringByReplacingMatches(in: self, options: .init(rawValue: 0), range: r, withTemplate: "")
          
          if result.count > 5 {
              let tenthDigitIndex = result.index(result.startIndex, offsetBy: 5)
              result = String(result[result.startIndex..<tenthDigitIndex])
          }
        
        if shouldRemoveLastDigit {
                   let end = result.index(result.startIndex, offsetBy: result.count-1)
                   result = String(result[result.startIndex..<end])
               }
               
               let end = result.index(result.startIndex, offsetBy: result.count)
               let range = result.startIndex..<end
        
         result = result.replacingOccurrences(of: "(\\d{2})(\\d+)", with: "$1/$2", options: .regularExpression, range: range)
        return result
    }
}
