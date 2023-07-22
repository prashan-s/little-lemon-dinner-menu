//
//  ViewController.swift
//  Little Lemon dinner menu
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import UIKit

class HomeViewController: UIViewController {


    
    //MARK: TypeAlias
    
    
    //MARK: - Enum
    enum Segues:String{
        case showDetailView = "showDetail"
    }
    enum Sections:Int,CaseIterable{
        case Liked
        case Rated
        case Categories
        
        var displayValue:String{
            switch self{
            case .Liked: return "Liked"
            case .Rated: return "Rated"
            case .Categories: return "Categories"
            }
        }
    }
    
    
    //MARK: - Classes
    
    
    
    //MARK: - Structs
    
    
    
    //MARK: - Constants
    
    
    
    //MARK: - Variables
    var menu:Menu = Menu(menuItems: [
        .init(id: 1, name: "Test1", description: "TestDesc1", imageName: "menu-item-placeholder",liked: true),
        .init(id: 2, name: "Test2", description: "TestDesc2", imageName: "menu-item-placeholder"),
        .init(id: 3, name: "Test3", description: "TestDesc3", imageName: "menu-item-placeholder",stars: .Stars(1)),
        .init(id: 4, name: "Test4", description: "TestDesc4", imageName: "menu-item-placeholder"),
        
    ])
    
    private var sections:[Sections]? = nil
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - VC Life Cycle

    override func viewDidLoad() {
        setupOnce()
    }
    
    private func setupOnce(){
        registerTableViewCells()
        setupTableView()
        reload()
    }
    
    private func reload(){
        self.sections = nil
        self.tableView.reloadData()
    }
}
//MARK: - SetupOnce
extension HomeViewController{
    private func registerTableViewCells(){
        
    }
    
    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func getSectionCount(section:Int) -> Sections{
      getSections()[section]
    }
    
    private func getSections() -> [Sections]{
        var temp_sections:[Sections] = []
        
        if let sections{
            return sections
        }else{
            Sections.allCases.forEach { sec in
                if getItemCount(for: sec) > 0 {
                    temp_sections.append(sec)
                }
            }
            self.sections = temp_sections
        }
        return temp_sections
    }
    private func getItemCount(for section:Sections) -> Int{
        switch section{
        case .Liked:
            return menu.menuItems.filter({$0.liked == true}).count
        case .Rated:
            return menu.menuItems.filter({$0.stars != .NoStars}).count
        case .Categories:
            return 0
        }
    }
    
    private func getItemCount(for section:Sections, indexPath:IndexPath) -> MenuItem{
        switch section{
        case .Liked:
            return menu.menuItems.filter({$0.liked == true})[indexPath.row]
        case .Rated:
            return menu.menuItems.filter({$0.stars != .NoStars})[indexPath.row]
        case .Categories:
            return .init(id: 1, name: "", description: "", imageName: "")
        }
    }
    
}

//MARK: TableView
extension HomeViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getSections().count
    }
    
    //header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getSections()[section].displayValue
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let sec = getSections()[section]
        if  getItemCount(for: sec) == 0 {
            return "Empty"
        }else {
    
            return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = getSections()[section]
        return getItemCount(for: sec)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sec = getSections()[indexPath.section]
        let item = getItemCount(for: sec, indexPath: indexPath)
        
        let cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = item.name
        configuration.secondaryText = item.description
        configuration.image = .init(named: item.imageName)
        configuration.imageProperties.maximumSize = .init(width: 50, height: 100)
        configuration.imageToTextPadding = 5
        
        cell.contentConfiguration = configuration
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.showDetailView.rawValue, sender: nil)
    }
    
}

extension HomeViewController:UITableViewDelegate{
    
}
