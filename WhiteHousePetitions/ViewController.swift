//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Petruț Vinca on 15.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    var unfilteredPetitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "White House Petitions"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadPetitions))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPetitions))
        
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
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredPetitions[indexPath.row].title
        cell.detailTextLabel?.text = filteredPetitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailedPetition = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func parseJSON(_ json: Data) {
        let decoder = JSONDecoder()
        if let input = try? decoder.decode(Petitions.self, from: json) {
            unfilteredPetitions = input.results
            filteredPetitions = unfilteredPetitions
            tableView.reloadData()
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Error :(", message: "There is a problem with the URL or Data", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default))
        present(alertController, animated: true)
    }
    
    @objc func searchPetitions() {
        let alertController = UIAlertController(title: "Hello :)", message: "What word are you looking for?", preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Search", style: .default) {[weak alertController, weak view] action in
            if let answer = alertController?.textFields?[0].text {
                self.filterPetitions(by: answer.lowercased())
            }
            
        })
        present(alertController, animated: true)
    }
    
    @objc func reloadPetitions() {
        if filteredPetitions != unfilteredPetitions {
            filteredPetitions = unfilteredPetitions
            tableView.reloadSections([0], with: .automatic)
        }
    }
    
    func filterPetitions(by answer: String) {
        var temporaryPetitions = [Petition]()
        for petition in unfilteredPetitions {
            if petition.title.lowercased().contains(answer) || petition.body.lowercased().contains(answer) {
                temporaryPetitions.append(petition)
            }
        }
        
        if !temporaryPetitions.isEmpty {
            filteredPetitions.removeAll()
            filteredPetitions = temporaryPetitions
            tableView.reloadSections([0], with: .automatic)
        }
    }
}
