/-  *plug
/+  default-agent, dbug, agentio
/=  index  /app/store/index
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
  ~[(~(arvo pass:io /bind) %e %connect `/'stores' %storefront)]
  ::[%pass /bind %arvo %e %connect `/'stores' %storefront]~
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
    :: if the request doesn't contain a valid session cookie
    :: obtained by logging in to landscape with the web logic
    :: code, we just redirect them to the login page
    ::
    ::?.  authenticated.req
    ::  :_  state
    ::  (give-http rid [307 ['Location' '/~/login?redirect='] ~] ~)
    :: if it's authenticated, we test whether it's a GET or
    :: POST request.
    ::
    ~&  [mark req]
    ?+  method.request.req
      :: if it's neither, we give a method not allowed error.
      ::
      :_  state
      %^    give-http
          rid
        :-  405
        :~  ['Content-Type' 'text/html']
            ['Content-Length' '31']
            ['Allow' 'GET, POST']
        ==
      (some (as-octs:mimes:html '<h1>405 Method Not Allowed</h1>'))
    :: if it's a get request, we call our index.hoon file
    :: with the current app state to generate the HTML and
    :: return it. (we'll write that file in the next section)
    ::
        %'GET'
      :_  state
      (make-200 rid (index bowl stores))
    ::
    ==
  :: this function makes a status 200 success response.
  :: It's used to serve the index page.
  ::
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
  :: this function composes the underlying HTTP responses
  :: to successfully complete and close the connection
  ::
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
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%bind ~] wire)
    (on-arvo:def [wire sign-arvo])
  ?>  ?=([%eyre %bound *] sign-arvo)
  ?:  accepted.sign-arvo
    %-  (slog leaf+"/stores bound successfully!" ~)
    `this
  %-  (slog leaf+"Binding /stores failed!" ~)
  `this
++  on-fail   on-fail:def
--
