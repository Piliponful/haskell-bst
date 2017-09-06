# Learning binary trees haskell
---

Who would write readme if not me:deciduous_tree:?

**quick terminology:**
- root node - the node that doesn't have a parent
- leaf node - the node that doesn't have any children


## Insert

```haskell
insert :: Ord a => Tree a -> a -> Tree a
insert Nil v = Node Nil v Nil
insert (Node l x r) v
      | v == x = error "Duplicate key"
      | v < x = Node (insert l v) x r
      | v > x = Node l x (insert r v)
```
**If you want to insert an element you have 3 options:**
1. The node you provided to the function is Nil - non-existant.
In that case you just create a new leaf node with a provided value.

2. The node you provided as a function first argument have value associated with it greater or less then the one we trying to insert.
In that case the function `insert`, for that list of arguments, evaluates to another call to insert. With first argument being one of the child nodes. The right child if value you trying to insert is greater then current node one. And left if less then current node one... and that's recursion in all it's glory!

3. If value you're trying to insert is equals to current node one then throw error. That's not allowed. There are other options. For example you can make values to be a list.
More on that [here](https://stackoverflow.com/questions/300935/are-duplicate-keys-allowed-in-the-definition-of-binary-search-trees).


## Lookup
other names: search/find/contains
```haskell
contains :: Ord a => Tree a -> a -> Bool
contains Nil _ = False
contains (Node l x r) v
      | v == x = True
      | v < x = contains l v
      | v > x = contains r v
```
This is the simplest one. Mainly because you don't need to reconstruct the data structure.
**Here you also have 3 options**
1. The node you provided as a function first argument is Nil. Then you return False. It fits in the functional paradigm very well. Because you will get false if you provide a
