//
//  StoryboardTableViewCell.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-18.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

class StoryboardTableViewCell: UITableViewCell
{
  @IBOutlet weak var bodyLabel: UILabel!

}

extension StoryboardTableViewCell : TextableLabel
{
  func configureWithItem(#body: String) {
    self.bodyLabel.text = body
  }
}