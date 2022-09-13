/-  *plug
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =stores]
+$  card  card:agent:gall
++  catalog-orm  ((on id product) gth)
++  next-product-id
  |=  [c=catalog]
  ^-  @
  ::  return the increment of: the greatest (aka leftmost) index, or 0
  ::
  .+  -:(fall (pry:catalog-orm c) [id=0 ~])
++  next-store-id
  |=  [=stores]
  ^-  @
  ::  return the increment of: the greatest index, or 0
  ::
  .+  (roll ~(tap in ~(key by stores)) max)
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  :-  ~
  %=  this
    stores  (molt ~[[1 [id=1 title="Default Store" catalog=~ stewards=~]]])
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ::  todo: update for more nuanced check when writing permissioning
  ::
  ?>  =(src.bowl our.bowl)
  ?+  mark  (on-poke:def mark vase)
    %plug-action
    =^  cards  state
      (handle-poke !<(action vase))
    [cards this]
  ==
  ++  handle-poke
    |=  =action
    ^-  (quip card _state)
    ?-    -.action
        %create-store
      =/  n  (next-store-id stores)
      `state(stores (~(put by stores) n [id=n title=title.action catalog=~ stewards=~]))
    ::
        %delete-store
      ?>  (~(has by stores) id.action)
      `state(stores (~(del by stores) id.action))
    ::
        %create-product
      ?>  (~(has by stores) store-id.action)
      =/  s  `store`(~(got by stores) store-id.action)
      =/  n  (next-product-id catalog.s)
      :-  ~
      %=  state
        stores
        %+  ~(put by stores)  id.s
        :*  id=id.s
            title=title.s
            %^  put:catalog-orm  catalog.s  n
            %-  product
            :*  id=n
                title=title.action
                description=description.action
                images=images.action
                price=price.action
            ==
            stewards=stewards.s
        ==
      ==
    ::
        %update-product
      ?>  (~(has by stores) store-id.action)
      =/  s  `store`(~(got by stores) store-id.action)
      :-  ~
      %=  state
        stores
        %+  ~(put by stores)  id.s
        :*  id=id.s
            title=title.s
            %^  put:catalog-orm  catalog.s  product-id.action
            %-  product
            :*  id=product-id.action
                title=title.action
                description=description.action
                images=images.action
                price=price.action
            ==
            stewards=stewards.s
        ==
      ==
    ::
        %delete-product
      ?>  (~(has by stores) store-id.action)
      =/  s  `store`(~(got by stores) store-id.action)
      ?>  (has:catalog-orm catalog.s product-id.action)
      :-  ~
      %=  state
        stores
        %+  ~(put by stores)  id.s
        :*  id=id.s
            title=title.s
            +:(del:catalog-orm catalog.s product-id.action)
            stewards=stewards.s
        ==
      ==
    ::
  ==
--
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?>  (~(has by stores) 1)
  =/  s  `store`(~(got by stores) 1)
  ?+  path  (on-peek:def path)
    [%x %all ~]  ``plug-catalog+!>(catalog.s)
  ==
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--