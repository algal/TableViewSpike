//
//  ViewController.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-16.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

enum TableViewConfiguration {
  case Programmatic, Storyboard
}

enum CellConfiguration {
  case Programmatic, ProgrammaticContainingNib, NibDefined, StoryboardDefined
}

private typealias Selection = (String,TableViewConfiguration,CellConfiguration)

private let selections:[Selection] = [
  // programmatically defined table views
  ("Programmatic TableView, \nProgrammatic Cell",.Programmatic,.Programmatic),
  ("Programmatic TableView, \nProgrammatic Cell Containing a Nib",.Programmatic,.ProgrammaticContainingNib),
  ("Programmatic TableView, \nNib-defined Cell",.Programmatic,.NibDefined),

  // storyboard-defined tableviews
  ("Storyboard TableView, \nProgrammatic Cell",.Storyboard,.Programmatic),
  ("Storyboard TableView, \nProgrammatic Cell Containing a Nib",.Storyboard,.ProgrammaticContainingNib),
  ("Storyboard TableView, \nNib-defined Cell",.Storyboard,.NibDefined),
  ("Storyboard TableView, \nStoryboard dynamic prototype Cell",.Storyboard,.StoryboardDefined),
]

class ExampleSelectingViewController: UITableViewController
{
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selections.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let c: AnyObject = tableView.dequeueReusableCellWithIdentifier("selectionCellIdentifier", forIndexPath: indexPath)
    if let cell = c as? UITableViewCell
    {
      cell.textLabel?.text = selections[indexPath.row].0
      return cell
    }
    assertionFailure("failed to dequeue recognized table view cell")
    return UITableViewCell()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let (_,tableViewConfig,cellConfig) = selections[indexPath.row]

    let destVC:ProgTableViewViewController
    switch tableViewConfig {
    case .Storyboard:
      destVC = UIStoryboard(name:"TableViewStoryboard",bundle:nil).instantiateInitialViewController() as! ProgTableViewViewController
    case .Programmatic:
      destVC = ProgTableViewViewController()
    }
    
    destVC.cellConfig = cellConfig
    
    self.navigationController?.pushViewController(destVC, animated: true)
  }
 
 }

