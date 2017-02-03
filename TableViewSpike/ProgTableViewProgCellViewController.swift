//
//  ProgTableViewProgCellViewController.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-18.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

protocol TextableLabel {
  func configureWithItem(body:String) -> Void
}

class ProgTableViewViewController: UITableViewController
{
  let items = Model().dataArray
  
  let prototypeCellIdentifier:String = "PrototypeCellIdentifier"
  let nonPrototypeCellIdentifier:String = "CellIdentifier"

  var tableViewConfig:TableViewConfiguration = .programmatic
  var cellConfig:CellConfiguration = .programmatic
  
  override func viewDidLoad() {
    super.viewDidLoad()

    switch cellConfig {
    case .storyboardDefined:
      NSLog("we are not registering a nib or a class in viewDidLoad, on the expectation that the UITableViewController superclass's machinery handles that for the case of a storybaord-defined VC")
      break
    case .programmatic:
          tableView.register(ProgCell.self, forCellReuseIdentifier: nonPrototypeCellIdentifier)
    case .programmaticContainingNib:
      tableView.register(NibContainingTableViewCell.self, forCellReuseIdentifier: nonPrototypeCellIdentifier)
    case .nibDefined:
      tableView.register(UINib(nibName: "NibBasedTableViewCell", bundle: nil), forCellReuseIdentifier: nonPrototypeCellIdentifier)
    }

    // enable iOS8 automatic cell height
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = CGFloat(44)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let identifier:String
    switch cellConfig {
    case .storyboardDefined: identifier = prototypeCellIdentifier
    default: identifier = nonPrototypeCellIdentifier
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    if let cellx = cell as? TextableLabel
    {
      let item = items[indexPath.row]
      cellx.configureWithItem(body:item.body)
      return cell
    }
    
    assertionFailure("unrecognized cell type")
    return UITableViewCell()
  }
}




