import UIKit

// Codable protokolü hem encodable hem de decodable protokollerini beraberinde getirir

/* Not: Codable protokolünü destekleyen modelinizde bulunan tüm değişkenlerin veri tiplerinin
 codable protokolünü desteklemesi gerekir */

struct Note: Codable {
    var title: String
    var text: String
    var timestamp: Date // Notun ne zaman oluşturulduğu bilgisi
    
}
// Bir not nesnesi oluşturma
// Date() -> o an
let newNote = Note(title: "Alışveriş Listesi", text: "yoğurt, çay, süt, makarna", timestamp: Date())

// MARK: - Oluşturulan not nesnesinin "plist" (propertyList) formatına encode edilmesi

/* Encode etmemizin sebebi bu nesneyi hafızada tutmak istememizdir.
 Hafızada tutulmak istenen veriler encode edilerek makine diline yani hafızaya
 yazılmaya uygun olan dile çevrilmelidir.*/

// Encode ederken farklı dosya formatlarında verilerimizi encode edebiliriz örn: JSON, Plist, MP3, MP4...

// Encodable protokolünü destekleyen herhangi bir veriyi propertyList formatına encode eder
let propertyListEncoder = PropertyListEncoder()

// Bu fonksiyon bir "throwingFunction" yani bu fonksiyon çalışırken error fırlatabilir
// Bu tür fonksiyonlar do catch yapısı ile kullanılmalıdır

// YÖNTEM 1: Fonkisyon çalışırken meydana gelen hataları yakalamak istersek
do {
    let encodedNote = try propertyListEncoder.encode(newNote)
    
}catch {
    // catch bloğu error adında bir değişken verir
    // Bu error, do bloğu içinde meydana gelen hatayı verir
    print(error)
}

//YÖNTEM 2: Hatanın bir önemi yok, sadece nil olmadığı durumu arıyorum

if let encodedNote = try? propertyListEncoder.encode(newNote){
  print(encodedNote)
}


// MARK: - DECODING

if let encodedNote = try? propertyListEncoder.encode(newNote){
    let propertyListDecoder = PropertyListDecoder()
    
    // type: hangi tür modele decpde edilecek
    // from: hangi datayı kullanarak bu işlem yapılacak
    // Note.self demek sınıfın type ını belirtmek demektir
    if let decodedNote = try? propertyListDecoder.decode(Note.self, from: encodedNote){
        print(decodedNote)
    }

}

// MARK: - File manager ile Documents directory kullanımı

/*Her uygulama kendi documents directory' sine sahiptir.
 Uygulamalar, yalnızca kendi klasörlerine veri yazabilir veya okuyabilirler.
 Uygulama kendi klasörü dışındaki bir veriye erişmek isterse kullanıcıdan iizn almak zorundadır */

/* Bir projenin birden fazla document directory' si olabilir fakat varsayılan olarak
 sadece 1 tane oluşturulur. Bu nedenle "documentDirectory bir arraydir ve biz ilk elemanına erişmek isteriz (.first) */

let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
print(documentsDirectory)

// Yukarıda tanımladığımız "documentsDirectory" isimli değişken bize bir klasör verir
// Bu klasör içerisinde yeni bir dosya uzantısı oluşturmamız gerekiyor

let notesURL = documentsDirectory.appendingPathComponent("notes").appendingPathExtension("plist")
print(notesURL)

// MARK: - Encode edilmiş bir datanın hafızaya kaydedilme işlemi

if let encodedNote = try? propertyListEncoder.encode(newNote){
    // noFileProtection: Var olan dosyanın üzerine yazılmasını engellemez
    try? encodedNote.write(to: notesURL, options: .noFileProtection)
    
}

// MARK: - Veriyi okumak

// Data' nın özel bir init' i vardır
// Data(contentsOf: ) -> parametre olarak vereceğiniz URL' de bulunan datayı kulanarak initialize edilmesini sağlar

let propertListDecoder = PropertyListDecoder()

// ADIM 1: Dosyayı Data formatında okumak

if let retrievedNoteData = try? Data(contentsOf: notesURL){
    print(retrievedNoteData)
    
    // ADIM 2: propertyListDecoder kullanarak Data' dan Note objesi oluşturmak
    
    if let decodedNote = try? propertListDecoder.decode(Note.self, from: retrievedNoteData){
        print(decodedNote)
    }
}

