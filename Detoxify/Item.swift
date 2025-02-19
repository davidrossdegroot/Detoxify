//
//  Item.swift
//  Detoxify
//
//  Created by David De Groot on 2/19/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
