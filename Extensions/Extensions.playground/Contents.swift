import UIKit

// EXTENSIONS

// extension SomeType {  }

// Extension ile Computed Property Eklemek

extension UIColor {
    
    static var favoriteColor: UIColor {
        return UIColor(red: 0.23, green: 0.12, blue: 0.8, alpha: 1.0)
    }
}

// Instance veya Type methodları eklemek

// Use Case: Tekil kelimeleri çoğul hale getirmek istiyoruz
// Fakat String üzerinde bu iişi yapabilecek bir fonksiyon bulunmuyor


extension String {
    
    mutating func pluralized() -> String {
        // Kompleks bir fonksiyon. Yaptığı iş ise var olan String değerini çoğul hale getirmek
        return ""
        
    }
    
}

var elma = "elma"
var masa = "masa"
var sandalye = "sandalye"

elma.pluralized()
masa.pluralized()
sandalye.pluralized()


// Kodları organize etmek için extension kullanımı

class Restaurant {
    
    // var name: String
    // var menuItem: [String]
    // var servers: [Emplyoyee]
    // var cookingStaff: [Employee]
    // var customers: [Customer]
}

// MARK: - Restaurant Methods

extension Restaurant {
    
    // func add(menuItem: MenuItem)
    // func remove(menuItem: MenuItem)
    // func welcome(guest: Customer)
    // func serve(item: MenuItem, to guest: Guest)
}


struct Employee {
    
    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
}

extension Employee: Equatable {
    
    static func ==(lhs: Employee, rhs: Employee) -> Bool {
        
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.jobTitle == rhs.jobTitle && lhs.phoneNumber == rhs.phoneNumber
        
    }
    
}
