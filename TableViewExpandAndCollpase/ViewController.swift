//
//  ViewController.swift
//  TableViewExpandAndCollpase
//
//  Created by R.Unnikrishnan on 15/05/23.
//

import UIKit

class ViewController: UIViewController {
    let data = ["John", "Emily", "Michael", "Sophia", "William"]
    var isExpanded = false
    var isCollapsed = false
    var expandAction: (() -> Void)?
    var toggleAction: (() -> Void)?
    var expandedIndexPath: IndexPath? = nil
    var collapsedIndexPaths: Set<IndexPath> = []
    var initiallyCollapsedIndexPaths: Set<IndexPath> = [IndexPath(row: 0, section: 0)] // Set the initially collapsed cells here
    @IBOutlet weak var statusHistoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        statusHistoryTableView.register(UINib(nibName: "ExpandCollapseTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCellIdentifier")
        toggleAction?()
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellIdentifier", for: indexPath) as! ExpandCollapseTableViewCell
        cell.nameLabel.text = data[indexPath.row]
        // Set the expand action closure
        cell.expandAction = { [weak self] in
        self?.toggleCellHeight(indexPath: indexPath)
        // cell.statusaTableview.isHidden = true
        tableView.reloadRows(at: [indexPath], with: .automatic) // Reload the specific cell to update the button image
        }
        // Update the button image based on expand/collapse state
        let isExpanded = expandedIndexPath == indexPath
        let buttonImageName = isExpanded ? "next (1) (1)" : "next (1)"
        cell.toggleButtonOutlet.setImage(UIImage(named: buttonImageName), for: .normal)
        // Set the cell's selected state based on expandedIndexPath
        cell.setSelected(expandedIndexPath == indexPath, animated: false)
        // Set the cell's selected state based on collapsed state
        cell.setSelected(collapsedIndexPaths.contains(indexPath), animated: false)
        return cell
    }
    
    func toggleCellHeight(indexPath: IndexPath) {
        let previouslyExpandedIndexPath = expandedIndexPath
        
        if expandedIndexPath == indexPath {
            // Tapped on the expanded cell, collapse it
            expandedIndexPath = nil
            collapsedIndexPaths.insert(indexPath)
        } else
        {
            // Tapped on a different cell or no previously expanded cell, update the expandedIndexPath
            expandedIndexPath = indexPath
            collapsedIndexPaths.remove(indexPath)
        }
        var indexPathsToReload: [IndexPath] = []
        if let previousIndexPath = previouslyExpandedIndexPath
        {
            // Collapse the previously expanded cell
            indexPathsToReload.append(previousIndexPath)
        }
        if let expandedIndexPath = expandedIndexPath
        {
            // Expand the newly tapped cell
            indexPathsToReload.append(expandedIndexPath)
        }
        if !indexPathsToReload.isEmpty
        {
            statusHistoryTableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
        
        statusHistoryTableView.beginUpdates()
        statusHistoryTableView.endUpdates()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if let expandedIndexPath = expandedIndexPath, expandedIndexPath == indexPath {
                return 70*5+70
            }
            // Check if the cell is in the collapsedIndexPaths set
            if collapsedIndexPaths.contains(indexPath) {
                return 85
            }
            return 70*5+70
        }
}
// Extension to create a UIColor instance from a hexadecimal color code.
extension UIColor {
    convenience init(hex: String) {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if formattedHex.hasPrefix("#")
        {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
