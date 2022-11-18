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
+$  image  tape
+$  images  (list tape)
+$  price  @ud
+$  api-key  tape
::  Core Data Models
::
+$  product  [=id =title =description =images =price]
+$  catalog  ((mop id product) gth)
+$  store  [=id =title =description avatar=image =catalog =stewards =api-key]
::  Poke actions
::
+$  action
  $%  [%create-store =title]
      [%update-store =id =title =description avatar=image =api-key]
      [%delete-store =id]
      [%create-product store-id=id =title =description =images =price]
      [%update-product store-id=id product-id=id =title =description =images =price]
      [%delete-product store-id=id product-id=id]
  ==
::  Subscription Updates
::
+$  update
  $%  [%initial =stores]
      [%create-store =id =title =description avatar=image]
      [%update-store =id =title =description avatar=image =api-key]
      [%delete-store =id]
      [%create-product store-id=id product-id=id =title =description =images =price]
      [%update-product store-id=id product-id=id =title =description =images =price]
      [%delete-product store-id=id product-id=id]
  ==
::  Top-level Data Structures
::
+$  stores  (map id store)
--
