//
//  Location.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 21/03/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
