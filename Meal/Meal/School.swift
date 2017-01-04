//
//  School.swift
//  Meal
//
//  Created by sunrin software10 on 2017. 1. 2..
//  Copyright © 2017년 sunrin software10. All rights reserved.
//

struct School {
    var code: String
    var type: String
    var name: String
    
    init?(dictuionary: [String: Any]) {
        guard let code = dictuionary["code"] as? String,
        let name = dictuionary["name"] as? String,
        let type = dictuionary["type"] as? String
            else {return nil }
        self.code = code
        self.type = type
        self.name = name
    }
}
