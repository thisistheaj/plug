|%
::  Permissioning
::
+$  ship  @p
+$  permission-level  tape
+$  steward  [=ship =permission-level]
+$  stewards  (map ship steward)
::  Basic Data Types
::
+$  id  @
+$  title  tape
+$  description  tape
+$  images  (list tape)
+$  price  @ud
::  Core Data Models
::
+$  product  [=id =title =description =images =price]
+$  catalog  ((mop id product) gth)
+$  store  [=id =title =catalog =stewards]
::  Poke actions
::
+$  action
  $%  [%create-store =title]
      [%delete-store =id]
      [%create-product store-id=id =title =description =images =price]
      [%update-product store-id=id product-id=id =title =description =images =price]
      [%delete-product store-id=id product-id=id]
  ==
::  Top-level Data Structures
::
+$  stores  (map id store)
--
