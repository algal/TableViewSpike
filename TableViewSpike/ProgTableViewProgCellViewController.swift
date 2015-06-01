//
//  ProgTableViewProgCellViewController.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-18.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

protocol TextableLabel {
  func configureWithItem(#body:String) -> Void
}

class ProgTableViewViewController: UITableViewController
{
  let items = Model().dataArray
  
  let prototypeCellIdentifier:String = "PrototypeCellIdentifier"
  let nonPrototypeCellIdentifier:String = "CellIdentifier"

  var tableViewConfig:TableViewConfiguration = .Programmatic
  var cellConfig:CellConfiguration = .Programmatic
  
  override func viewDidLoad() {
    super.viewDidLoad()

    switch cellConfig {
    case .StoryboardDefined:
      NSLog("we are not registering a nib or a class in viewDidLoad, on the expectation that the UITableViewController superclass's machinery handles that for the case of a storybaord-defined VC")
      break
    case .Programmatic:
          tableView.registerClass(ProgCell.self, forCellReuseIdentifier: nonPrototypeCellIdentifier)
    case .ProgrammaticContainingNib:
      tableView.registerClass(NibContainingTableViewCell.self, forCellReuseIdentifier: nonPrototypeCellIdentifier)
    case .NibDefined:
      tableView.registerNib(UINib(nibName: "NibBasedTableViewCell", bundle: nil), forCellReuseIdentifier: nonPrototypeCellIdentifier)
    }

    // enable iOS8 automatic cell height
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = CGFloat(44)
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let identifier:String
    switch cellConfig {
    case .StoryboardDefined: identifier = prototypeCellIdentifier
    default: identifier = nonPrototypeCellIdentifier
    }
    
    if let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? UITableViewCell,
      cellx = cell as? TextableLabel
    {
      let item = items[indexPath.row]
      cellx.configureWithItem(body:item.body)
      return cell
    }
    
    assertionFailure("unrecognized cell type")
    return UITableViewCell()
  }
}




