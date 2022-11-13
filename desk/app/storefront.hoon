/-  *plug
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =stores]
+$  card  card:agent:gall
++  catalog-orm  ((on id product) gth)
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
    stores  ~
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
  ::  todo: update for more nuanced check when writing permissioning
  ::
  ?>  =(src.bowl our.bowl)
  ?+    mark  (on-poke:def mark vase)
      %noun
    =/  action  !<(?(%sub %unsub) vase)
    ?-    action
        %sub
      :_  this
      :~  [%pass /stores %agent [our.bowl %plug] %watch /updates]
      ==
        %unsub
      :_  this
      :~  [%pass /stores %agent [our.bowl %plug] %leave ~]
      ==
    ==
  ==
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  |^
  ?+    wire  (on-agent:def wire sign)
      [%stores ~]
    ?+    -.sign  (on-agent:def wire sign)
        %watch-ack
      ?~  p.sign
        ((slog '%storefront: Subscribed to PIM!' ~) `this)
      ((slog '%storefront: Could NOT Subscribe to PIM!' ~) `this)
    ::
        %kick
      %-  (slog '%storefront: Got kick, resubscribing...' ~)
      :_  this
      :~  [%pass /stores %agent [our.bowl %plug] %watch /updates]
      ==
    ::
        %fact
      ?+    p.cage.sign  (on-agent:def wire sign)
          %plug-update
        (handle-update !<(update q.cage.sign))
      ==
    ==
  ==
  ++  handle-update
    |=  =update
    ?-    -.update
    ::
        %initial
      %-  hear
      +.update
    ::
        %create-store
      %-  hear
      %+  ~(put by stores)  id.update
      :*  id=id.update
          title=title.update
          description=description.update
          avatar=avatar.update
          catalog=~
          stewards=~
      ==
    ::
        %update-store
      ?>  (~(has by stores) id.update)
      =/  s  `store`(~(got by stores) id.update)
      %-  hear
      %+  ~(put by stores)  id.update
      :*  id=id.update
          title=title.update
          description=description.update
          avatar=avatar.update
          catalog=catalog.s
          stewards=stewards.s
      ==
    ::
        %delete-store
      ?>  (~(has by stores) id.update)
      (hear (~(del by stores) id.update))
    ::
        %create-product
      ?>  (~(has by stores) store-id.update)
      =/  s  `store`(~(got by stores) store-id.update)
      %-  hear
      %+  ~(put by stores)  id.s
      :*  id=id.s
          title=title.s
          description=description.s
          avatar=avatar.s
          %^  put:catalog-orm  catalog.s  product-id.update
          %-  product
          :*  id=product-id.update
              title=title.update
              description=description.update
              images=images.update
              price=price.update
          ==
          stewards=stewards.s
      ==
    ::
        %update-product
      ?>  (~(has by stores) store-id.update)
      =/  s  `store`(~(got by stores) store-id.update)
      %-  hear
      %+  ~(put by stores)  id.s
      :*  id=id.s
          title=title.s
          description=description.s
          avatar=avatar.s
          %^  put:catalog-orm  catalog.s  product-id.update
          %-  product
          :*  id=product-id.update
              title=title.update
              description=description.update
              images=images.update
              price=price.update
          ==
          stewards=stewards.s
      ==
    ::
        %delete-product
      ?>  (~(has by stores) store-id.update)
      =/  s  `store`(~(got by stores) store-id.update)
      ?>  (has:catalog-orm catalog.s product-id.update)
      %-  hear
      %+  ~(put by stores)  id.s
      :*  id=id.s
          title=title.s
          description=description.s
          avatar=avatar.s
          +:(del:catalog-orm catalog.s product-id.update)
          stewards=stewards.s
      ==
    ::
    ==
  ++  hear
    |=  stores=$_(+.state)
    :-  ~  
    %=  this  state
      %=  state  stores
        stores
      ==
    ==
  --
::
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
