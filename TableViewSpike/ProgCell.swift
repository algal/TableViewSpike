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

