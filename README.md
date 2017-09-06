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
1. Node(first argument) you passed to `insert` is Nil - non-existant.
In that case you just create a new leaf node with a passed value(second argument).

2. Node(first argument) have value associated with it greater or less then the one we trying to insert.
In that case `insert`, for that list of arguments, evaluates to another call to insert. With first argument being one of the child nodes. Right child, if value you trying to insert is greater then current node one. Left if less then current node one. Recursion in all it's glory!

3. If value you're trying to insert(second argument) equals to current node one - throw error. That's not allowed. There are other options. For example you can make values to be a list.
More on that [here](https://stackoverflow.com/questions/300935/are-duplicate-keys-allowed-in-the-definition-of-binary-search-trees).


## Lookup
*other names: search/find/contains*
This is the simplest one. Mainly because you don't need to reconstruct the data structure from the ground up.

```haskell
contains :: Ord a => Tree a -> a -> Bool
contains Nil _ = False
contains (Node l x r) v
      | v == x = True
      | v < x = contains l v
      | v > x = contains r v
```
**Here you also have 3 options**
1. The node you provided as a function first argument is Nil. So you return False. It fits in the functional paradigm very well. You will get false if you provide Nil in your first call. As well as inner function calls with leaf node child as arguments, which is Nil.

2. The provided in arguments node value is greater or less then value we searching for(second arg). In that case the function call evaluates to another same function call with new set of arguments and evaluation continues until it hits leaf node or finds value.

3. The value is found. Return true.


## Delete

```haskell
delete :: Ord a => Tree a -> a -> Tree a
delete Nil _ = Nil
delete (Node l x r) v
  | v < x = Node (delete l v) x r
  | v > x = Node l x (delete r v)
delete (Node Nil x Nil) v = Nil
delete (Node Nil x   r) v = r
delete (Node l   x Nil) v = l
delete (Node l   x   r) v = Node l rv nr
  where
    (Node _ rv _) = rightmost r
    nr = deleteRightest r
```
**Guess how much options you have?**
1. The node is Nil so we return Nil. If you're not calling `delete` with Nil as a root node would mean that function evaluation come to leaf node and that would imply that there is no node with value we want deleted.
2. 
