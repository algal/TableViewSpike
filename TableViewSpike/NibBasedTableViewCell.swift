//
//  NibBasedTableViewCell.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-18.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

/**

This is a nib-defined table view cell ("NibBasedTableViewCell").

The main thing to note: just like the purely programatically defined view, and the nib-loading
view, this nib-defined view does not need to take special steps for its layout to work with AL.

From this we can conclude that the need for these special steps is not due to 
defining table view cells in nibs!

*/


class NibBasedTableViewCell: UITableViewCell
{
  @IBOutlet weak var bodyLabel: UILabel!
}

extension NibBasedTableViewCell : TextableLabel {
  func configureWithItem(body:String) -> Void {
    self.bodyLabel.text = body
  }
}
