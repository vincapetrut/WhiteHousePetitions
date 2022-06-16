//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Petruț Vinca on 15.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "White House Petitions"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let address: String
        if tabBarController?.tabBar.tag == 0 {
            address = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            address = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: address) {
            if let data = try? Data(contentsOf: url) {
                parseJSON(data)
                return
            }
        }
        
        showError()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailedPetition = petitions[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func parseJSON(_ json: Data) {
        let decoder = JSONDecoder()
        if let input = try? decoder.decode(Petitions.self, from: json) {
            petitions = input.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Error :(", message: "There is a problem with the URL or Data", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default))
        present(alertController, animated: true)
    }
}
