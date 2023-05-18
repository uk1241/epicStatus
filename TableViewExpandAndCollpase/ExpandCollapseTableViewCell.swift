//
//  ExpandCollapseTableViewCell.swift
//  TableViewExpandAndCollpase
//
//  Created by R.Unnikrishnan on 15/05/23.
//

import UIKit

class ExpandCollapseTableViewCell: UITableViewCell {
    
    let data = ["John","Emily","Unni"]
    @IBOutlet weak var statusaTableview: UITableView!
    
    @IBOutlet weak var bgLineView: UIView!
    @IBOutlet weak var bgView: UIView!
    var isExpanded = false
    var isCollapsed = false
    var expandAction: (() -> Void)?
    var expandedIndexPath: IndexPath? = nil
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toggleButtonOutlet: UIButton!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set shadow properties
        bgView.layer.shadowColor = UIColor(hex: "#0458AD26").cgColor
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgView.layer.shadowRadius = 4
        statusaTableview.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "StatusTableViewCell")
        // Set the contentInset property to adjust the spacing
        statusaTableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0)
        
    }

    
    override func layoutSubviews() {
           super.layoutSubviews()
           
           // Update shadow path to match cell's frame
           layer.shadowPath = UIBezierPath(rect: bounds).cgPath
 }
    

    @IBAction func toggleButtonAction(_ sender: UIButton) {

        isExpanded.toggle()
        expandAction?()
        
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//          super.setSelected(selected, animated: animated)
//
//          // Update background color based on selected state
////          let backgroundColor = isExpanded ? UIColor.white : UIColor.blue
////          contentView.backgroundColor = selected ? backgroundColor.withAlphaComponent(0.8) : backgroundColor
//      }
//
}

extension ExpandCollapseTableViewCell : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell", for: indexPath) as! StatusTableViewCell
        cell.nameLbl.text = data[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 0
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
