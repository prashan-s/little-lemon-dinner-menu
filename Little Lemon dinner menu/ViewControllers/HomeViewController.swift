//
//  ViewController.swift
//  Little Lemon Dishes menu
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import UIKit

class HomeViewController: UIViewController {


    
    //MARK: TypeAlias
    
    
    //MARK: - Enum
    enum Segues:String{
        case ShowDetailView = "showDetail"
    }
    enum Sections:Int,CaseIterable{
        case Liked = -1
        case Rated = -2
        case Savoury = 1
        case Desert = 2
        case Dishes = 3
        
        var displayValue:String{
            switch self{
            case .Liked: return "Liked"
            case .Rated: return "Rated"
            case .Savoury: return "Savoury"
            case .Desert: return "Desert"
            case .Dishes: return "Dishes"
                
            }
        }
    }

    
    //MARK: - Classes
    
    
    
    //MARK: - Structs
    
    
    
    //MARK: - Constants
    
    
    
    //MARK: - Variables
    var menu:Menu = Menu(menuItems: [
        .init(id: 1, name: "Classic Margherita Pizza", description: "A traditional Italian pizza with tomato sauce, mozzarella cheese, and fresh basil leaves.", imageName: "menu-item-placeholder", price: 20.0, stars: .NoStars, liked: true, category: 1),
        .init(id: 2, name: "Decadent Chocolate Brownie", description: "Indulge in a rich and moist chocolate brownie topped with a scoop of vanilla ice cream.", imageName: "menu-item-placeholder", price: 25.0, stars: .Stars(1), liked: false, category: 2),
        .init(id: 3, name: "Savory Chicken Alfredo", description: "Tender grilled chicken served over fettuccine pasta with creamy Alfredo sauce.", imageName: "menu-item-placeholder", price: 15.0, stars: .Stars(2), liked: true, category: 1),
        .init(id: 4, name: "Chef's Special Risotto", description: "A delectable risotto prepared with seasonal vegetables and Parmesan cheese.", imageName: "menu-item-placeholder", price: 30.0, stars: .NoStars, liked: false, category: 3),
        .init(id: 5, name: "Refreshing Berry Sorbet", description: "Enjoy a refreshing sorbet made from a blend of seasonal berries.", imageName: "menu-item-placeholder", price: 18.0, stars: .NoStars, liked: true, category: 2),
        .init(id: 6, name: "Spicy Cajun Shrimp", description: "Succulent shrimp seasoned with Cajun spices served with rice and grilled vegetables.", imageName: "menu-item-placeholder", price: 22.0, stars: .Stars(3), liked: false, category: 1),
        .init(id: 7, name: "Grilled Mediterranean Platter", description: "A delightful platter featuring an assortment of grilled vegetables, hummus, and pita bread.", imageName: "menu-item-placeholder", price: 16.0, stars: .NoStars, liked: true, category: 3),
        .init(id: 8, name: "Tiramisu Delight", description: "An irresistible Italian dessert made with layers of coffee-soaked ladyfingers and mascarpone cheese.", imageName: "menu-item-placeholder", price: 28.0, stars: .Stars(5), liked: false, category: 2),
        .init(id: 9, name: "Mouthwatering Beef Burger", description: "Savor the juiciness of a perfectly grilled beef patty topped with cheese, lettuce, and pickles.", imageName: "menu-item-placeholder", price: 21.0, stars: .NoStars, liked: true, category: 1),
        .init(id: 10, name: "Lemon Garlic Roasted Chicken", description: "Tender roasted chicken infused with zesty lemon and garlic flavors.", imageName: "menu-item-placeholder", price: 17.0, stars: .NoStars, liked: false, category: 3)

    ])
    
    private var menuItems:[MenuItem] = []
    
    private var sections:[Sections]? = nil
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - VC Life Cycle

    override func viewDidLoad() {
        setupOnce()
    }
    
    private func setupOnce(){
        setupNavBar()
        registerTableViewCells()
        setupTableView()
        self.menuItems = menu.menuItems
        reload()
    }
    
    private func reload(){
        self.sections = nil
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ShowDetailView.rawValue{
            if let vc = segue.destination as? HomeDetailViewController{
                vc.menuItem = sender as! MenuItem
            }
        }
    }
    
    
    func addMenuItemAlert() {
        let alertController = UIAlertController(title: "Add New Menu Item", message: nil, preferredStyle: .alert)
        
        // Add text fields to the alert
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Description"
        }
     
        alertController.addTextField { textField in
            textField.placeholder = "Price"
            textField.keyboardType = .decimalPad // Set keyboard type to number with a decimal point
        }
        alertController.addTextField { textField in
            textField.placeholder = "Category"
            textField.keyboardType = .numberPad // Set keyboard type to number
        }
        
        // Create the "Add" action
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let nameTextField = alertController.textFields?[0],
                  let descriptionTextField = alertController.textFields?[1],
                  let priceTextField = alertController.textFields?[2],
                  let categoryTextField = alertController.textFields?[3],
                  let name = nameTextField.text,
                  let description = descriptionTextField.text,
                  let price = Double(priceTextField.text ?? ""),
                  let categoryInt = Int(categoryTextField.text ?? "") else {
                // Error handling if any of the required fields are empty or invalid
                return
            }
            
            // Ensure the category is limited to a maximum of 3
            let category = max(min(categoryInt, 3), 1)
            
            // Create a new MenuItem using the user input
            let newMenuItem = MenuItem(id: self.menu.menuItems.count + 1, // Use menuItemCounter for ID
                                       name: name,
                                       description: description,
                                       imageName: "menu-item-placeholder",
                                       price: price,
                                       stars: .NoStars, // Using a switch for boolean values
                                       liked: false, // Using a switch for boolean values
                                       category: category)
            
            
            // Add the new MenuItem to the Menu object
            do {
                try self.menu.addMenuItem(newMenuItem)
                self.reload()
            } catch {
                // Handle error if the item already exists in the menu
                print("Error: \(error)")
            }
        }
        
        // Create the "Cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to the alert controller
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        // Assuming you have a reference to your view controller, let's call it "viewController"
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func presentFilterActionSheet() {
        self.menuItems = menu.menuItems
        let actionSheet = UIAlertController(title: "Filter Options", message: nil, preferredStyle: .actionSheet)
        
        // Filter by liked status
        let likedAction = UIAlertAction(title: "Liked", style: .default) { [weak self] _ in
            self?.filterMenuItems(byLiked: true)
        }
        actionSheet.addAction(likedAction)
        
        let notLikedAction = UIAlertAction(title: "Not Liked", style: .default) { [weak self] _ in
            self?.filterMenuItems(byLiked: false)
        }
        actionSheet.addAction(notLikedAction)
        
        // Filter by category
        let category1Action = UIAlertAction(title: "Savoury", style: .default) { [weak self] _ in
            self?.filterMenuItems(byCategory: 1)
        }
        actionSheet.addAction(category1Action)
        
        let category2Action = UIAlertAction(title: "Desert", style: .default) { [weak self] _ in
            self?.filterMenuItems(byCategory: 2)
        }
        actionSheet.addAction(category2Action)
        
        let category3Action = UIAlertAction(title: "Dishes", style: .default) { [weak self] _ in
            self?.filterMenuItems(byCategory: 3)
        }
        actionSheet.addAction(category3Action)
        
        // Filter by price
        let priceAscendingAction = UIAlertAction(title: "Price - Low to High", style: .default) { [weak self] _ in
            self?.sortMenuItems(byPriceAscending: true)
        }
        actionSheet.addAction(priceAscendingAction)
        
        let priceDescendingAction = UIAlertAction(title: "Price - High to Low", style: .default) { [weak self] _ in
            self?.sortMenuItems(byPriceAscending: false)
        }
        actionSheet.addAction(priceDescendingAction)
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        // Present the action sheet
        present(actionSheet, animated: true, completion: nil)
    }
    
    // Function to filter menu items by liked status
    func filterMenuItems(byLiked liked: Bool) {
        let filteredItems = menuItems.filter { $0.liked == liked }
        self.menuItems = filteredItems
        self.reload()
    }
    
    // Function to filter menu items by category
    func filterMenuItems(byCategory category: Int) {
        let filteredItems = menuItems.filter { $0.category == category }
        // Use the filteredItems array as needed, e.g., update the UI with the filtered data.
        self.menuItems = filteredItems
        self.reload()
    }
    
    // Function to sort menu items by price
    func sortMenuItems(byPriceAscending ascending: Bool) {
        let sortedItems = menuItems.sorted { ascending ? $0.price < $1.price : $0.price > $1.price }
        self.menuItems = sortedItems
        self.reload()
        
    }
    
}
//MARK: - SetupOnce
extension HomeViewController{
    private func registerTableViewCells(){
        
    }
    
    private func setupNavBar(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        let filterButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(filterButtonTapped))
        navigationItem.setRightBarButtonItems([addButton,filterButton], animated: true)
        
    }
    
    @objc private func addButtonTapped() {
        addMenuItemAlert()
    }
    
    @objc private func filterButtonTapped() {
        presentFilterActionSheet()
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
            return menuItems.filter({$0.liked == true}).count
        case .Rated:
            return menuItems.filter({$0.stars != .NoStars}).count
        default:
            return menuItems.filter({$0.category == section.rawValue}).count
        }
    }
    
    private func getItemCount(for section:Sections, indexPath:IndexPath) -> MenuItem{
        switch section{
        case .Liked:
            return menuItems.filter({$0.liked == true})[indexPath.row]
        case .Rated:
            return menuItems.filter({$0.stars != .NoStars})[indexPath.row]
        default:
            return menuItems.filter({$0.category == section.rawValue})[indexPath.row]
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
        cell.selectionStyle = .none
        cell.separatorInset.left = 20
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sec = getSections()[indexPath.section]
        let item = getItemCount(for: sec, indexPath: indexPath)
        
        performSegue(withIdentifier: Segues.ShowDetailView.rawValue, sender: item)
    }
    
}

extension HomeViewController:UITableViewDelegate{
    
}
