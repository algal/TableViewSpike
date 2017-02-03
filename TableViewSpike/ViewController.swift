//
//  ViewController.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-16.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

enum TableViewConfiguration {
  case programmatic, storyboard
}

enum CellConfiguration {
  case programmatic, programmaticContainingNib, nibDefined, storyboardDefined
}

private typealias Selection = (String,TableViewConfiguration,CellConfiguration)

private let selections:[Selection] = [
  // programmatically defined table views
  ("Programmatic TableView, \nProgrammatic Cell",.programmatic,.programmatic),
  ("Programmatic TableView, \nProgrammatic Cell Containing a Nib",.programmatic,.programmaticContainingNib),
  ("Programmatic TableView, \nNib-defined Cell",.programmatic,.nibDefined),

  // storyboard-defined tableviews
  ("Storyboard TableView, \nProgrammatic Cell",.storyboard,.programmatic),
  ("Storyboard TableView, \nProgrammatic Cell Containing a Nib",.storyboard,.programmaticContainingNib),
  ("Storyboard TableView, \nNib-defined Cell",.storyboard,.nibDefined),
  ("Storyboard TableView, \nStoryboard dynamic prototype Cell",.storyboard,.storyboardDefined),
]

class ExampleSelectingViewController: UITableViewController
{
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selections.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let c: AnyObject = tableView.dequeueReusableCell(withIdentifier: "selectionCellIdentifier", for: indexPath)
    if let cell = c as? UITableViewCell
    {
      cell.textLabel?.text = selections[indexPath.row].0
      return cell
    }
    assertionFailure("failed to dequeue recognized table view cell")
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let (_,tableViewConfig,cellConfig) = selections[indexPath.row]

    let destVC:ProgTableViewViewController
    switch tableViewConfig {
    case .storyboard:
      destVC = UIStoryboard(name:"TableViewStoryboard",bundle:nil).instantiateInitialViewController() as! ProgTableViewViewController
    case .programmatic:
      destVC = ProgTableViewViewController()
    }
    
    destVC.cellConfig = cellConfig
    
    self.navigationController?.pushViewController(destVC, animated: true)
  }
 
 }

