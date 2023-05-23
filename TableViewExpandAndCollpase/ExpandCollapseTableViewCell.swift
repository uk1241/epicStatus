//
//  ExpandCollapseTableViewCell.swift
//  TableViewExpandAndCollpase
//
//  Created by R.Unnikrishnan on 15/05/23.
//

import UIKit

class ExpandCollapseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageButton: UIButton!
    let data = ["John","Emily","Unni","Emily"]
    var selectedCells: [Bool] = []
    var selectedIndexPaths = Set<IndexPath>()
    var lastSelectedIndexPath: IndexPath?
    @IBOutlet weak var statusaTableview: UITableView!
    @IBOutlet weak var bgView: UIView!
    var isExpanded = false
    var isCollapsed = false
    var expandAction: (() -> Void)?
    var expandedIndexPath: IndexPath? = nil
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toggleButtonOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set shadow properties
        bgView.layer.shadowColor = UIColor(hex: "#13ACF3").cgColor
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgView.layer.shadowRadius = 4
        statusaTableview.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "StatusTableViewCell")
        // Set the contentInset property to adjust the spacing
        statusaTableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0)
        // Remove space between cells
        statusaTableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -1, right: 0)
        // Initialize selectedCells array
        selectedCells = Array(repeating: false, count: data.count)
    }
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // Update shadow path to match cell's frame
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    @IBAction func toggleButtonAction(_ sender: UIButton)
    {
        isExpanded.toggle()
        expandAction?()
        
    }
    
}
extension ExpandCollapseTableViewCell: UITableViewDelegate, UITableViewDataSource {
    // Returns the number of rows in the table view section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    // Configures and returns a table view cell for the corresponding index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell", for: indexPath) as! StatusTableViewCell
        cell.nameLbl.text = data[indexPath.row]
        
        //Hides the status path image of last cell
        if indexPath.row == data.count-1
        {
            cell.statusPath.isHidden = true
        }
            // Check if the current cell is in the selectedIndexPaths set
            if selectedIndexPaths.contains(indexPath) {
                cell.statusImageOne.image = UIImage(named: "Group 2142")
                cell.statusPath.image = UIImage(named: "Path 1343")
                cell.approveLabel.text = "Approved"
                cell.sizeToFit()
            }
            else
            {
                cell.statusImageOne.image = UIImage(named: "Group 2142 (1)")
                cell.statusPath.image = UIImage(named: "Path 1343 (1)")
                cell.sizeToFit()            }
        
        return cell
    }
    
    // Handles the selection of a table view cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StatusTableViewCell else {
            return
        }
        // Add the selected index path to the selectedIndexPaths set
        selectedIndexPaths.insert(indexPath)
        // Update the cell's images to indicate selection
        cell.statusImageOne.image = UIImage(named: "Group 2142")
        cell.statusPath.image = UIImage(named: "Path 1343")
        cell.approveLabel.text = "Approved"
        print("Tapped")
    }
    
    // Handles the deselection of a table view cell
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StatusTableViewCell else {
            return
        }
        // Remove the deselected index path from the selectedIndexPaths set
        selectedIndexPaths.remove(indexPath)
        // Update the cell's images to indicate deselection if it's not selected anymore
        if selectedIndexPaths.contains(indexPath) {
            cell.statusImageOne.image = UIImage(named: "Group 2142 (1)")
            cell.statusPath.image = UIImage(named: "Path 1343 (1)")
        }
        else
        {
            cell.statusImageOne.image = UIImage(named: "Group 2142")
            cell.statusPath.image = UIImage(named: "Path 1343")
            cell.approveLabel.text = "Approved"
        }
        
        print("Deselected")
    }
}

