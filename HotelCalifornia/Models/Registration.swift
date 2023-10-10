//
//  Registration.swift
//  HotelCalifornia
//
//  Created by Emirhan Erdogan on 27.06.2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import Foundation

struct Registration {
    
    // MARK: - Properties
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
    
    // MARK: - Functions
    func fullName() -> String {
        return firstName + " " + lastName
    }
}
