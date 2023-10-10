//
//  AddRegistrationTableViewController.swift
//  HotelCalifornia
//
//  Created by Emirhan Erdogan on 27.06.2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    // MARK: - UI Elements
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    // MARK: - Properties
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            // isHidden: Bir arayüz elemanının görünürlük bilgisi.
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            // isHidden: Bir arayüz elemanının görünürlük bilgisi.
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomType?
    
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        // Burada oluşturacağımız Registration objesinin içerisinde olması gereken özelliklerini tanımlıyoruz.
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CheckIn tarihini, bugünün gecesi olarak ayarlar.
        // NOT: Date() -> O anın tarihini verir. (Saat bilgisi dahil)
        let midnightToday = Calendar.current.startOfDay(for: Date())
        
        // Seçilebilecek en küçük tarihi ayarlar.
        checkInDatePicker.minimumDate = midnightToday
        
        // Seçili olan tarihi ayarlar.
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        
        // Storyboard'da ayarladğımız geçici değerleri, on anki Stepper değeri ile günceller.
        updateNumberOfGuests()
        
        updateRoomType()
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.selectedRoomType = roomType
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                return 216
            }else {
                return 0
            }
            
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                return 216
            }else {
                return 0
            }
            
        default:
            // Picker hücreleri dışında kalan tüm hücrelerin yükseliği.
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Seçili olan hücrenin, seçili olma durumunu sonlandırır.
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            }else if isCheckInDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            }else {
                isCheckInDatePickerShown = true
            }
            
            // Değişkenlerdeki değişim ile, heightForRow fonksiyonu tekrardan çalıştırılır.
            // Fakat yğkseklik değişimleri animasyon ile sağlanır.
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            }else if isCheckInDatePickerShown {
                isCheckOutDatePickerShown = true
                isCheckInDatePickerShown = false
            }else {
                isCheckOutDatePickerShown = true
            }
            
            // Değişkenlerdeki değişim ile, heightForRow fonksiyonu tekrardan çalıştırılır.
            // Fakat yğkseklik değişimleri animasyon ile sağlanır.
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    func updateDateViews() {
        // 21/03/1996 -> .short -> 3:30 PM
        // 21/03/1996 -> .medium -> March 21, 1996
        
        // Otelimizde minimum 1 gece konaklama yapılacağı için;
        // checkOutDatePicker'ın minimumDate'i, o an seçili olan checkIn
        // tarihinden 24 saat sonrası olarak ayarlanmalıdır.
        
        // addingTimeInterval: Var olan bir Date nesnesinin üzerine, belirtilen miktarda saniye ekler.
        let oneDay: Double = 24 * 60 * 60 // 24 saatin saniye karşılığını belirtir.
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    // MARK: - Actions
    @IBAction func datePickerValueChanged(_ picker: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
    }
    
    @IBAction func cancelBarButtonTapped(_ button: UIBarButtonItem) {
        
        // Bu butona basıldığında uygulamamızın geri gitmesi için bu fonksiyonu çalıştırıyoruz.
        dismiss(animated: true, completion: nil)
    }
}
