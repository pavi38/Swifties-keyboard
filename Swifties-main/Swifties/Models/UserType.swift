//
//  UserType.swift
//  Swifties
//
//  Created by Pavneet Cheema on 3/25/24.
//

import Foundation
class UserType: ObservableObject {
@Published var type: String

    init(type: String) {
        self.type = type
    }
}
