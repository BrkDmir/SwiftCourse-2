//
//  RegistrationsTableViewController.swift
//  HotelCalifornia
//
//  Created by Emirhan Erdogan on 27.06.2020.
//  Copyright © 2020 TurkishKit. All rights reserved.
//

import UIKit

class RegistrationsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var registrations = [Registration]()
    
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
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Burada, TableViewCell elemanımızı tanımlıyoruz.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell")!
        
        // Liste elemanımızın içerisinde hangi hücrenin olduğuna göre hangi değeri kullanmamız gerektiğini burada tanımlanan değer ile ayarlıyoruz.
        let registration = registrations[indexPath.row]
        
        // Tarihi düzgün bir şekilde göstermek için bir DateFormatter objesi oluşturuyoruz.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.fullName()
        
        let checkInString = dateFormatter.string(from: registration.checkInDate)
        let checkOutString = dateFormatter.string(from: registration.checkOutDate)
        let roomName = registration.roomType.name
        
        cell.detailTextLabel?.text = "\(checkInString) - \(checkOutString): \(roomName)"
        
        return cell
    }
    
    // MARK: - Actions
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? AddRegistrationTableViewController, let registraion = source.registration else { return }
        
        registrations.append(registraion)
        tableView.reloadData()
    }
}
