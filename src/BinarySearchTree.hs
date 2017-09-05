module BinarySearchTree
      ( insert
      , contains
      , delete
      , Tree(Nil, Node)
      ) where


data Tree a = Nil
            | Node (Tree a) a (Tree a)
              deriving (Eq, Show)



insert :: Ord a => Tree a -> a -> Tree a
insert Nil v = Node Nil v Nil
insert (Node l x r) v
      | v == x = error "Duplicate key"
      | v < x = Node (insert l v) x r
      | v > x = Node l x (insert r v)

contains :: Ord a => Tree a -> a -> Bool
contains Nil _ = False
contains (Node l x r) v
      | v == x = True
      | v < x = contains l v
      | v > x = contains r v

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


rightmost :: Tree a -> Tree a
rightmost t@(Node l x Nil) = t
rightmost (Node _ _ r) = rightmost r


deleteRightest :: Tree a -> Tree a
deleteRightest (Node l _ Nil) = l
deleteRightest (Node l x r) = Node l x $ deleteRightest r

{-
the first thing to do is to add tree balancing
add tests and hight level overview of how each function works with few diagrams
add new functions like inverse, same, fromList, toList and others
add new, more interesting trees like patrika, kd, avl, red/black, BSP and quadtrees, octree. Maybe eventually even try again making dynamic occlusion culling alg-_-
-}
