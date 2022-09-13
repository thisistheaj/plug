/-  *plug
|%
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action
  %.  jon
  %-  of
  :~  [%create-store ~[title+sa]]
      [%delete-store (ot ~[id+ni])]
      ::[%foo ~[title+sa]]
      [%create-product (ot ~[store-id+ni title+sa description+sa images+(ar sa) price+ni])]
      [%update-product (ot ~[store-id+ni product-id+ni title+sa description+sa images+(ar sa) price+ni])]
      [%delete-product (ot ~[store-id+ni product-id+ni])]
  ==
++  state-to-json
  |=  c=catalog
  ^-  json
  a+(turn ~(tap by c) enc-product-tuple)
++  enc-product-tuple
  =,  enjs:format
  |=  t=[id=id product=product]
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


