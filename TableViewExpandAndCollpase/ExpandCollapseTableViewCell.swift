//
//  ExpandCollapseTableViewCell.swift
//  TableViewExpandAndCollpase
//
//  Created by R.Unnikrishnan on 15/05/23.
//

import UIKit

class ExpandCollapseTableViewCell: UITableViewCell {
    
    
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
