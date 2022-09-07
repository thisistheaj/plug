|%
:: Permissioning
::
+$  ship  @p
+$  permission-level  tape
+$  steward  [=ship =permission-level]
+$  stewards  (map ship steward)
:: Basic Data Types
::
+$  id  @
+$  title  tape
+$  description  tape
+$  images  (list tape)
+$  price  @ud
:: Product Data
::
+$  product  [=id =title =description =images =price store-ids=(list id)]
:: Product Sortation Data Types
::
+$  products-by-id  ((mop id product) gth)
+$  products-by-price  ((mop price product) gth)
+$  products-by-title  ((mop title product) gth)
:: Store Data
::
+$  catalog  [store-id=id =products-by-id =products-by-price =products-by-title]
+$  store  [=id =title =catalog =stewards]
:: Poke actions
::
+$  action
  $%  [%create-store =title]
      [%delete-store =id]
      [%add-product store-id=id =title =description =images =price store-ids=(list id)]
      [%update-product store-id=id product-id=id =title =description =images =price store-ids=(list id)]
      [%remove-product store-id=id product-id=id]
      [%delete-product product-id=id]
  ==
::  Top-level Data Structures
::
+$  stores  (map id store)
+$  products  products-by-id
+$  default-store  id
+$  current-store  id
--
