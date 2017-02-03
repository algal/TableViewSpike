//
//  NibContainingTableViewCell.swift
//  TableViewSpike
//
//  Created by Alexis Gallagher on 2015-05-18.
//  Copyright (c) 2015 Bloom Filter. All rights reserved.
//

import UIKit

/**

This is a programmatically defined table view cell ("NibContainingTableViewCell"), which loads all
its content from a plain vanilla UIView defined by a nib ("NibContentView").

The main thing to note: just like the purely programatically defined view, this nib-loading
view does not need to take special steps for its layout to work with AL.

From this we can conclude that the need for these special steps is not due to requirements
that affect how nibs for ordinary UIViews are defined.

Interface builder sometimes shouts at you with about conflicts or
ambiguities in the constraints. But they may be happening, not because
a view's constraints are problematic _in isolation_, but because they
are problematic _in the context that interface builder imposes_. For
instance, if IB is externally constraining the view to a certain size,
and the view's own constraints are problematic _in combination with
being constraints to that that size_, then you will see complaints.

*/

class NibContainingTableViewCell: UITableViewCell
{
  override class var requiresConstraintBasedLayout : Bool { return true }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
    
    if let containedNibBasedView = UINib(nibName: "NibContentView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? NibContentView {
      self.contentView.addSubview(containedNibBasedView)

      containedNibBasedView.translatesAutoresizingMaskIntoConstraints = false
      let _ = ["V:|[v]|","H:|[v]|"].map({
        (vfl:String) -> (String) in
        let cs = NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: ["v":containedNibBasedView])
        self.contentView.addConstraints(cs)
        return vfl
        }
      )
    }
    else {
      assertionFailure("error instantiating nib")
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NibContainingTableViewCell : TextableLabel {
  func configureWithItem(body:String) -> Void {
    if let nibContentView:NibContentView = self.contentView.subviews.first as? NibContentView {
      nibContentView.bodyLabel.text = body
    }
  }
}
