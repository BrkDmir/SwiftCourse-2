//
//  SelectRoomTypeTableViewController.swift
//  HotelCalifornia
//
//  Created by Emirhan Erdogan on 27.06.2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

protocol SelectRoomTypeTableViewControllerDelegate: class {
    // class: Protokolün yalnızca Class'lar tarafından
    // desteklenebileceğini belirtmek için kullanılır.
    func didSelect(roomType: RoomType)
}

class SelectRoomTypeTableViewController: UITableViewController {
    
    // MARK: - Properties
    var selectedRoomType: RoomType?
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // Burada, liste elemanının kaç tane bölüme (section) sahip olması gerektiğini belirtiyoruz.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Burada, liste elemanının içerisinde kaç tane hücre olması gerektiğini belirtiyoruz.
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Burada, TableViewCell elemanımızı tanımlıyoruz.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell")!
        
        // Liste elemanımızın içerisinde hangi hücrenin olduğuna göre hangi değeri kullanmamız gerektiğini burada tanımlanan değer ile ayarlıyoruz.
        let roomType = RoomType.all[indexPath.row]
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "₺ \(roomType.price)"
        
        // O an çizilmekte olan oda türü, önceden seçilen oda türü mü?
        if roomType == selectedRoomType {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Burada, diğer ViewController elemanının içerisindeki değerlerle etkileşimde bulunuluyor.
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: selectedRoomType!)
        
        tableView.reloadData()
    }
}
