//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ciaran Murphy on 2/1/24.
//

import Foundation

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _addSprinkles = "addSprinkles"
        case _extraFrosting = "extraFrosting"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    //Save the below data to UserDefaults
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    //Save the above data to UserDefaults
    
    var hasValidAddress: Bool {
        var trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedStreet = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedName.isEmpty || trimmedStreet.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            return false
        }
            return true
    }
    
    var cost: Decimal {
        
        //$2 per cake
        var cost = Decimal(quantity) * 2
        
        //Make more expensive cakes:
        cost += Decimal(type) / 2
        
        //$1 for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        //50¢ for sprinkles
        
        if addSprinkles {
            cost += Decimal(quantity)/2
        }
        
        return cost
    }
}
