import UIKit

// Klasik Fonksiyon Tanımlaması

func sum( numbers: [Int]) -> Int {
    return 100
}

// Closure Tanımlaması

let sumClosure = { (numbers: [Int]) -> Int in
    
    return 100
}

// Closure Kullanımı

let sum = sumClosure([1,2,3,4,5])
print(sum)

// Swiftte tüm değerlerin bir tipi vardır;
// Örn: Int, Bool etc.

// Closure ların tipleri aldıkları parametreler ve dönüş tiplerinin birleşimi ile ifade edilir
// Örn: Yukarıda tanımladığımız sumClosure adlı closure ın tipi: "[Int] -> Int" dir.

// Fonksyonlarda olduğu gibi closure ların da çeşitleri vardır

// MARK: - Parametresiz ve Dönüşsüz Closure

// Void: dönüş tipinin olmaması anlamına gelir

let printClosure = { () -> Void in
    print("Print Closure Executed")
}
printClosure()

// MARK: - Parametreli ve Dönüşsüz Closure

let complexPrintClosure = { (text: String) -> Void in
    print(text)
}
complexPrintClosure("Hello World!")

// MARK: - Parametresiz ve Dönüşlü Closure

let randomNumberClosure = {() -> Int in
    return Int.random(in: 1...100)
}
print(randomNumberClosure())

// MARK: - Parametreli ve Dönüşlü Closure

let complexRandomNumberClosure = { (min: Int, max: Int) -> Int in
    return Int.random(in: min...max)
}

print(complexRandomNumberClosure(1,1000))


// Closure ların argüman olarak kullanılması

let playlist = ["Tracks 3","Track 1","Track 2"]

let sortedPlaylist = playlist.sorted { (left, right) -> Bool in
    return left < right
}

print(sortedPlaylist)

// Closure ların kısa kullanımı
// Closure ların parametre isimleri olarak '$' işareti kullanılabilir.
// ("str1", "str2") $0 -> "str1", $1 -> "str2" yi ifade eder

let sortedPlaylist2 = playlist.sorted { return $0 < $1 }
print(sortedPlaylist2)

// Koleksiyonlar üzerinde tanımlı olan diğer Closure örnekleri

// MARK: - Map
// Arrayler üzerinde tanımlı olan bir metoddur.
// Arrayde bulunan her bir elemanın ne şekilde değişeceğini belirtir

let names = ["Mehmet", "Alp", "Mustafa","Serkan"]

// Closure olmadan...

// Boş bir array oluşturulur
// Bu array ad ve soyad bilgilerini tutar

var fullNames = [String]()

for name in names {
    let fullName = name + " " + "DEMİR"
    fullNames.append(fullName)
}
print(fullNames)

// Bu işlemi closure kullanarak yapalım

let fullNames2 = names.map { (name) -> String in
    return name + " " + "DEMİR"
}
print(fullNames2)

// Sadeleştirilmiş Closure

let fullNames3 = names.map { $0 + " " + "DEMİR"}
print(fullNames3)

// MARK: - Filter
// Bu fonksiyon, belirtilen bir kritere göre yeni bir array oluşturur

// Closure Olmadan...

let numbers = [4,23,51,97,34,1]
var numbersLessThan50 = [Int]()

for num in numbers {
    if num < 50 {
        numbersLessThan50.append(num)
    }
}
print(numbersLessThan50)

// Closure ile yapalım

let lessThan50 = numbers.filter { (num) -> Bool in
    // num, Arrayin o anki elemanı
    // return edilmesi gerekn bilgi ise, o elemanın yeni oluşturulacak Arrayde olup olmaması bilgisidir
   return num < 50
}
print(lessThan50)

// Sadeleştirilmiş hali

let lessThanFifty = numbers.filter {$0 < 50}
print(lessThanFifty)


// MARK: - Reduce
// Arrayde bulunan tüm elemanları kullanarak tek bir eleman oluşturur


let numbers2 = [1,6,3,5,4,8,2]

// Closure olmadan...

var total = 0

for i in numbers2 {
    total += i
}
print(total)

// Closure ile yapalım

let total2 = numbers2.reduce(0) { (currentTotal, newValue)-> Int in
    return currentTotal + newValue
}
print(total2)

// Sadeleştirilmiş hali

let total3 = numbers2.reduce(0, {$0 + $1})
print(total3)
