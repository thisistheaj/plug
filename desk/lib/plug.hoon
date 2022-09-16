/-  *plug
|%
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action
  %.  jon
  %-  of
  :~  [%create-store (ot ~[title+sa])]
      [%update-store (ot ~[id+ni title+sa description+sa avatar+sa])]
      [%delete-store (ot ~[id+ni])]
      [%create-product (ot ~[store-id+ni title+sa description+sa images+(ar sa) price+ni])]
      [%update-product (ot ~[store-id+ni product-id+ni title+sa description+sa images+(ar sa) price+ni])]
      [%delete-product (ot ~[store-id+ni product-id+ni])]
  ==
::  encodes: stores, tuples, store
::
++  enc-stores
  |=  =stores
  ^-  json
  a+(turn ~(tap by stores) enc-store-tuple)
++  enc-store-tuple
  =,  enjs:format
  |=  t=[=id =store]
  ^=  json
  %-  pairs
  :~  ['id' (numb id.t)]
      ['store' (enc-store store.t)]
  ==
++  enc-store
  =,  enjs:format
  |=  s=store
  %-  pairs
  :~  ['id' (numb id.s)]
      ['title' (tape title.s)]
      ['description' (tape description.s)]
      ['avatar' (tape avatar.s)]
  ==
::  encodes: catalog, tuples, product
::
++  enc-catalog
  |=  c=catalog
  ^-  json
  a+(turn ~(tap by c) enc-product-tuple)
++  enc-product-tuple
  =,  enjs:format
  |=  t=[=id =product]
  ^=  json
  %-  pairs
  :~  ['id' (numb id.t)]
      ['product' (enc-product product.t)]
  ==
++  enc-product
  =,  enjs:format
  |=  p=product
  %-  pairs
  :~  ['id' (numb id.p)]
      ['title' (tape title.p)]
      ['description' (tape description.p)]
      ['images' a+(turn images.p tape)]
      ['price' (numb price.p)]
  ==
--


