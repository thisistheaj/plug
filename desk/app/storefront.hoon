/-  *plug
/+  default-agent, dbug, agentio
/=  store-page  /app/pages/index
/=  product-page  /app/pages/product
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
    io    ~(. agentio bowl)
::
++  on-init
  ^-  (quip card _this)
  :_
  %=  this
    stores  ~
  ==
  :~
    (~(arvo pass:io /bind) %e %connect `/'stores' %storefront)
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
  |^  ^-  (quip card _this)
  ?>  =(src.bowl our.bowl)
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
      %handle-http-request  (handle-http !<([@ta inbound-request:eyre] vase))
      %noun                 (toggle-sub !<(?(%sub %unsub) vase))
    ==
  [cards this]
  ++  toggle-sub
    |=  action=?(%sub %unsub)
    ^-  (quip card _state)
    ?-  action
        %sub
      :_  state
      :~  [%pass /stores %agent [our.bowl %plug] %watch /updates]
      ==
        %unsub
      :_  state
      :~  [%pass /stores %agent [our.bowl %plug] %leave ~]
      ==
    ==
  ++  handle-http
    |=  [rid=@ta req=inbound-request:eyre]
    ^-  (quip card _state)
    ?+  method.request.req
      ::  Error by default on other Request types
      ::
      :_  state
      (make-405 rid)
      :: Run Router on GET requests 
      ::
        %'GET'
      =/  path  url.request.req
      :_  state
      (router rid path)
    ::
    ==
  ++  router
    |=  [rid=@ta path=cord]
    =/  p  (parse-next-path path)
    ::  404 if it doesn't go to a store
    ::
    ?.  =('stores' front.p)
      (make-404 rid)
    ::  404 if the selected store does not exist
    ::
    =/  p  (parse-next-path back.p)
    =/  store-id  (parse-id front.p)
    ?.  (~(has by stores) store-id)
      (make-404 rid)
    ::  return the homepage if the path ends
    ::  at an existing store
    ::
    =/  s  (~(got by stores) store-id)
    ?:  =('' back.p)
      (make-200 rid (store-page bowl s))
    ::  404 if additional path does not go to a product
    ::
    =/  p  (parse-next-path back.p)
    ?.  =('products' front.p)
      (make-404 rid)
    ::  404 if the selected product does not exist
    ::
    =/  p  (parse-next-path back.p)
    =/  product-id  (parse-id front.p)
    ?.  (has:catalog-orm catalog.s product-id)
      (make-404 rid)
    ::  return the product detail page
    ::  if the path ends at an existing product
    ::
    =/  product  (got:catalog-orm catalog.s product-id)
    (make-200 rid (product-page bowl s product))
  ++  parse-next-path
    |=  path=cord
    ::  convert to tape and remove opening '/'
    =/  path  (tail (trim 1 (trip path)))
    =/  trio
    %+  roll  path      
    :: for the rest of the tape
    :: accumulate each letter by slamming a gate
    :: stop once you get to the next '/'
    |=  [char=@t acc=[front=tape back=tape incomplete=?]]
      ?:  =(incomplete.acc %.n)
        [front.acc (weld back.acc (trip char)) %.n]
      ?.  =(char '/')
        [(weld front.acc (trip char)) back.acc %.y]
      [front.acc (weld back.acc (trip char)) %.n]
    [front=(crip front.trio) back=(crip back.trio)]
  ++  parse-id
    |=  c=cord
    (parse-int (trip c))
  ++  parse-int
    |=  t=tape
    (scan t dim:ag)
  ++  make-200
    |=  [rid=@ta dat=octs]
    ^-  (list card)
    %^    give-http
        rid
      :-  200
      :~  ['Content-Type' 'text/html']
          ['Content-Length' (crip ((d-co:co 1) p.dat))]
      ==
    [~ dat]
  ++  make-404
    |=  rid=@ta
    =/  dat   (as-octs:mimes:html '<h1>404 Not Found</h1>')
    ^-  (list card)
    %^    give-http
        rid
      :-  404
      :~  ['Content-Type' 'text/html']
          ['Content-Length' (crip ((d-co:co 1) p.dat))]
      ==
    [~ dat]
  ++  make-405
    |=  rid=@ta
    =/  dat   (as-octs:mimes:html '<h1>405 Method Not Allowed</h1>')
    ^-  (list card)
    %^    give-http
        rid
      :-  405
      :~  ['Content-Type' 'text/html']
          ['Content-Length' (crip ((d-co:co 1) p.dat))]
      ==
    [~ dat]
  ++  give-http
    |=  [rid=@ta hed=response-header:http dat=(unit octs)]
    ^-  (list card)
    :~  [%give %fact ~[/http-response/[rid]] %http-response-header !>(hed)]
        [%give %fact ~[/http-response/[rid]] %http-response-data !>(dat)]
        [%give %kick ~[/http-response/[rid]] ~]
    ==
  ::
  --
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path
    (on-watch:def path)
  ::
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    `this
  ==
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
  :: hear:
  :: 
  :: Standard way listen to 'tell' events from PIM agent
  ::
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
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%bind ~] wire)
    (on-arvo:def [wire sign-arvo])
  ?>  ?=([%eyre %bound *] sign-arvo)
  ::  does not print correctly without this for some reason
  =/  path  (trip (crip path.binding.sign-arvo))
  ?:  accepted.sign-arvo
    %-  (slog leaf+"/{path} bound successfully!" ~)
    `this
  %-  (slog leaf+"Binding /{path} failed!" ~)
  `this
++  on-fail   on-fail:def
--
