
These rambling words are Work-In-Progress.

### Questions to ask when defining a self-sizing view or cell

1. Is it a _self-satisfied_ view? That is, do its internal constraints
   suffice to define what size it would want to be if external
   constraints only positioned it on screen? 

   This question _may_ be equivalent to the following questions:

   - If external constraints only set its `center`, then would it
     return a valid value to the call
     `systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)`?

   - If external constraints only set its `center`, then would it
     return a valid value to the call `sizeThatFits`?

   - Does it return a valid value to `intrinsicContentSize`? Or is
     this method only supposed to be defined for leaf views? Does it
     by default return a sensible value for composite views? (Maybe:
     implementing `intrinsicContentSize` is how to make a leaf view
     self-satisifed, and implementing an axial chain of constraints is
     what suffices to make a composite view self-satisfied.)

   - For both the vertical and horizontal axis, does the view have a
     chain of constraints that bind one edge to its opposite edge?

2. If external constraints squeezed the view to be smaller than its
   preferred size, or stretched it to be bigger than its preferred
   size, then something in the view has got to give. That is, some
   constraint has got to give. Do the priorities of the view's
   internal constraints clearly defines which ones take precedence in
   these situations? If not, then the view's constraints are ambiguous
   in combination with _certain_ external constraints.

## preferred content size, self-satisfied views, and priorities

Let us try to define some terms unambiguously.

A view's _preferred content size_ is the size it would take if you set
only its position, and allowed AL to size it further. 

The key question for self-sizing cells, or for views in general, is _is
the preferred content size_ well-defined?

How do we define it? A leaf view defines its preferred size by
implementing `intrinsicContentSize`, which computes a size based on
the view's content. Here "content" does not mean subviews, but some
kind of raw material that is not managed by AL, like an image or a
string. A non-leaf view has a preferred content size if it is
_self-satified_, that is, if it implements a chain of constraints for
both the horizontal and the vertical axis.

A view is self-satisfied if it establishes a preferred size _in the
absence of external constraints_. This is binary: a view either is or
is not self-satisfied.

However, it is also important for a view to specify it's preferred
size and layout _in the presence of external constraints on its
size_. But this is not a binary question. Rather, the question is if
the view defines a preferred size _for a given set of external
constraints on its size_. So a view may establish a preferred layout
given external constraints confining the view within a certain range
of possible fitting sizes, but fail to define a preferred size and
internal layout if external constraints squeeze it or stretch it
beyond a certain degree.


