Seven Ways to Look at an Auto Layout Self-sizing TableView Cell
=====================================================================

### Hello, what is this?

This repo shows seven examples of implementing a `UITableView` with
self-sizing cells, where the row heights are calculated automatically
by using Auto Layout constraints. With these constraints, the cell
defines how tall it wants to be in order to contain its content, which
is text wrapped over multiple lines in a single `UILabel`. 

This repo shows _seven_ ways to do this, by looking at different ways
of instantiating the two table view controller and the cell:

- table view controller
  - programmatically
  - or from a storyboard,

- defining the cell 
  - purely programatically,
  - programmatically but loading a contained view deined with a nib,
  - entirely via a nib
  - via a prototype cell within a storyboard

### Why is this interesting?

First, all these working examples show the two crucical steps for
self-sizing cells: setting up the constraints against the
`contentView` not the cell, and setting the table view's `rowHeight`
and `estimatedRowHeight` appropriately to trigger the self-sizing
mechanism.

Second, it shows that many commonly-recommended special measures are
_not_ necessary, at least in the simple case of single word-wrapping
`UILabel` in a cell. In particular, none of the examples do any of the
following:

1. set the `preferredmaxLayoutWidth` of a `UILabel`
2. override `layoutSubviews`
3. set content-hugging or compression-resistance priorities
4. install multiple competing constraints to balance shrinking the
   cell without over-shrinking it

If you google around trying to figure out how to get your self-sizing
cells to work, you'll find a lot of advice recommending these
steps. These steps are sometimes necessary, but not always, and not
for the reason that is often implied.

For instance, if you are working with a collection view as opposed to
a table view, then the collection view does not constrain the width,
so then you may need to use two layout passes, one pass to measure the
desired width, before setting `preferredMaxLayoutWidth` based on that,
and then another pass to perform real layout once
`preferredMaxLayoutWidth` has been set correctly. But this necessity
is a problem with auto layout and wrapping in the general case, which
collection views represent, not self-sizing table view cells.

Or, if you are laying out a cell with multiple labels stacked on top
of each other vertically, then you _may_ need to tweak
compression-resistance priorities so that Auto Layout knows which
label should to take the hit when there's not enough space for both of
them to assume their `intrinsicContentSize`. I am not sure. But again,
this seems like a generic issue with specifying auto layout behavior
when there are multiple views at play, not a problem with self-sizing
table view cells.

### Other Resources

Here are some good resources:

- This is a
  [great article](http://devetc.org/code/2014/07/07/auto-layout-and-views-that-wrap.html)
  proving why at the most fundamental level it is impossible for the
  auto layout algorithm alone to handle normal word-wrapping with one
  layout pass. It is because of this, I believe, that one does need to
  override `layoutSubviews` and manually set `preferredMaxLayoutWidth`
  when working with collection views, as opposed to table views. With
  table views, the UITableView object defines the width so the cell
  only needs to determine its height.

- The section _Intrinsic Content Size of Multi-Line Text_ in this
  [objc.io article on Auto Layout](http://www.objc.io/issue-3/advanced-auto-layout-toolbox.html)
  is a great resource for understanding why and how to adjust `preferredMaxLayoutWidth`.

- The leading Stack Overflow answer on
  [this question](http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights),
  and the accompanying
  [github repo](https://github.com/smileyborg/TableViewCellWithAutoLayoutiOS8),
  providing a working example of a more complex cell layout, also
  taking various the "special measures" to make it work.

- This is a
  [github repo](https://github.com/algal/SelfSizingCellsDemo) showing
  that, for collection views, self-sizing cells simply do not work. Yet?

