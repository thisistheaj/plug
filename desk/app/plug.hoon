/-  *plug
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =stores]
+$  card  card:agent:gall
++  catalog-orm  ((on id product) gth)
++  next-index
  |=  [c=catalog]
  ^-  @
  ::  return the increment of: the greatest (aka leftmost) index, or 0
  ::
  .+  -:(fall (pry:catalog-orm c) [id=0 ~])
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
        %add-product
      ?>  (~(has by stores) store-id.action)
      =/  s  `store`(~(got by stores) store-id.action)
      =/  n  (next-index catalog.s)
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
    ::    %delete-product
    ::  ?>  (has:product-orm products id.action)
    ::  `state(products +:(del:product-orm products id.action))
    ::::
  ==
--
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--