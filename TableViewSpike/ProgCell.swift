//
//  ProgCell.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-18.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

/**

This programatically created cell correctly sizes around its multi-line label
content within a view controller where the table view has set the
estimatedRowHeight.

Note well what was done:
1. contraints are configured against contentView, not agains the cell itself
2. UILabel.numberOfLines = 0, to enable line wrapping

Note also what was NOT done:
1. we did not install the constraints in UIView.updateConstraints. (We did it in init)
2. we did not set UILabel.preferredMaxLayoutWidth
3. we did not set any content-hugging or compression-resistance priorities
4. we did not add a combination of constraints, with a lower priority constraint
   driving the contentView to shrink locally, and a higher priority constraint
   stopping it from compressing its content

*/

class ProgCell : UITableViewCell
{
  var bodyLabel:UILabel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
    
    super.contentView.backgroundColor = UIColor.grayColor()
    
    self.bodyLabel = UILabel(frame: self.bounds)
    self.bodyLabel.numberOfLines = 0
    self.bodyLabel.backgroundColor = UIColor.yellowColor()
    self.contentView.addSubview(bodyLabel)
    
    // AL setup
    self.bodyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    let vfls = ["H:|-15-[bodyLabel]-15-|","V:|-15-[bodyLabel]-15-|"]
    for vfl in vfls {
      self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vfl, options:NSLayoutFormatOptions.allZeros , metrics: nil, views: ["bodyLabel":self.bodyLabel]))
    }

    /*
    Parenthetical Discussion of Constraint Errors 
    Due to the Notorious "UIView-Encapsulated-Layout-Height" Constraint

    The constraint below additionally requires a minimum height of 50, irrespective of the cell's
    content. As a result, if you activate this constraint, then the cell's constraints become 
    incompatible with any _additional_ constraint requiring the cell height to be smaller than 50, 
    such as for it to be 44.
    
    Why is this interesting? When a UITableView using auto-sizing logic first runs, it initializes
    the cell, calls `tableView(_:cellForRowAtIndexPath:)` in order to populate the cell with content, and
    then calls `systemLayoutSizeFittingSize(:withHorizontalFittingPriority:verticalFittingPriority:)`
    in order to allow the cell to express its desired height given the width of the table view.
    
    But at the start of this call, the UITableViewCell.contentView begins with constraints for its 
    default width (the screen width) and height (44 points!). This latter constraint is called
    `UIView-Encapsulated-Layout-Height`. If the constraints you have defined on the cell are
    incompaitble with this constraint requiring height==44, then the normal call to
    `systemLayoutSizeFittingSize(:withHorizontalFittingPriority:verticalFittingPriority:)` will emit 
    error messages into the console regarding unsatisfiable constraints.

    However, these errors are _transient_. On its own, the UITV will later use the value your cell's
    provides for its desired height (defined via its own Auto Layout constraints, and revealed via 
    the call to `systemLayoutSizeFittingSize(:withHorizontalFittingPriority:verticalFittingPriority:)`)
    in order to reset the `UIView-Encapsulated-Layout-Height` to a value that is compatible with
    your cell's constraints and contents.

    So what?
    
    To avoid seeing these spurious error messages, you have a few options:
    1. Configure your cell's constraints so that they are compatible with it having a required 
       height of 44. For instance, you could reduce to 999 the priority of the spacer constraint
       connecting the bottom of the contentView to your bottom-most subview within the contentView.
       This makes it "legitimate" for your contentView's subviews to poke out beyond the bottom of
       your subview, and makes a transient constraint that contentView.height==44 satisfiable.
    
    The part I don't understand:
    
    If the `UIView-Encapsulated-Layout-Height` constraint starts out on the contentView, then how
    does `systemLayoutSizeFittingSize(:withHorizontalFittingPriority:verticalFittingPriority:)` 
    determine what height the contentView would want to be in the absence of this constraint??
    
    */
    let minimumHeightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: 50)
    minimumHeightConstraint.active = false
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override func systemLayoutSizeFittingSize(targetSize: CGSize) -> CGSize {
    let result = super.systemLayoutSizeFittingSize(targetSize)
    return result
  }
  
  override func systemLayoutSizeFittingSize(targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    let result = super.systemLayoutSizeFittingSize(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    return result
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension ProgCell : TextableLabel {
  func configureWithItem(#body:String) -> Void {
    self.bodyLabel.text = body
  }
}

