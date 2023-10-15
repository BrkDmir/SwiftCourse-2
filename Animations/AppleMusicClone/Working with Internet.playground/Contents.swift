import UIKit

// http://
// https://appstore.apple.com/us/app/keynote/id43253425?mt=12

/* Network Request
 
 1- Type
 2- Headers
 3- Body
 
 */

// MARK: - Request Type

// HTTP Methods -> GET, POST

// GET -> Sunucudan bilgi almak için kullanılır
// POST -> Sunucuya bilgi göndermek için kullanılır

// MARK: - Headers
/*
 Aslında bir dictionary'dir (Key, Value)
 Body'de yer alan bilginin hangi formatta olduğunu belirtir (Örn: JSON, XML)
 Tarayıcınız hakkında bilgiler içerir
 */

// MARK: - Body

/* Sunucu ve sorgunun oluşturulduğu bilgisayar arasındaki veri
 alışverişi body üzeridnen yapılır.
 Body'de yer alan bilginin hangi formatta olduğunu ise header belirtir.
 
 Örn: Bir web sitesini yüklediğinizde, header'da veri tipi HTML olacaktır. Body'de ise bir HTML dosyası
 yer alacaktır.
 Bir iphone uygulamasının atacağı post request'in' body alanında ise muhtemelen bir JSON veya XML türünden
 data bulunacaktır.
 
 NOT: Body'de yer alan bilginin formatı sabit değildir. Sorguya ve sunucuya göre değişiklik gösterebilir.
 */

// MARK: - Bir URL Oluşturmak

let url = URL(string: "http://apple.com")!
url.scheme
url.host
url.query

// MARK: - Network Request'lerini Oluşturulması ve Çalıştırılıması

// Data Task

// Data Task ile Request Oluşsturmak

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data {
      if  let string = String(data: data, encoding: .utf8){
          //print(string)

        }
    }
}

// Oluşturulan request'in çalıştırılması;
task.resume()


// MARK: - API'lar ile Çalışmak
// Dictionary olarak alınan parametrelerin, URL'in sonuna eklenmesini sağlayacak bir fonksiyon yazalım.

extension URL{
    func withQueries(_ queries: [String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
    
    
}

let apodUrl = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
let apiTask = URLSession.shared.dataTask(with: apodUrl) { data, _, error in
    if let data = data {
        if let responseString = String(data: data, encoding: .utf8){
            print(responseString)
            
        }
    }
}
apiTask.resume()


// MARK: - Query Kullanımı ile API Sorguları

let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
let query: [String: String] = [
"api_key": "DEMO_KEY",
"date": "2023-07-07"
]
let queryUrl = baseUrl.withQueries(query)!
let queryTask = URLSession.shared.dataTask(with: queryUrl) {(data, _, error) in
    if let data = data{
        if let responseStr = String(data: data, encoding: .utf8){
            print(responseStr)
        }
    }
}
queryTask.resume()
