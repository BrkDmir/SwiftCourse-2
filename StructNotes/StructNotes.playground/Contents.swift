import UIKit

struct KilometreSayaci{
    
    var deger: Int = 0 // Varsayılan değer
    
    /* Eğer bir struct içindeki metod o struct'a ait bir
     propertynin değerini değiştirecek ise o metodu taanımlarken başına
     "mutating" anahtar kelimesi yazılır */
    
    mutating func arttır(){
        deger += 1
    }
    mutating func azalt(){
        deger -= 1
    }
    mutating func reset(){
        deger = 0
    }
}

/* Ayrıca struct içinde tanımlanan metodlar halihazırda o struct içindeki
propertylere direkt olarak erişebildiği için metodları tanımlarken propertyleri
ayrıca parantez
içinde değer olarak yazmamız gerekmez */

// Computed Properties

struct Sicaklik{
    
    var celcius: Double
    var fahrenheit: Double {
        return celcius * 1.8 + 32
    }
    var kelvin: Double {
        return celcius + 273.15
    }
    
}

// Property Observers

// willSet (değer değişmek üzere iken)
// didSet (değer değiştiğinde)

struct AdimSayar{
    var adimSayisi: Int = 0{
        willSet{
            // newValue -> Yeni gelecek olan değer
            print("Adım sayısı birazdan \(newValue) olacak")
            
        }
        didSet{
            // oldValue -> Yeni değer gelmeden önceki değer
            if adimSayisi > oldValue{
                print("\(adimSayisi - oldValue) adım atıldı")
            }
        }
    }
}
var adimSayar1 = AdimSayar()
adimSayar1.adimSayisi = 5


