/-  *plug
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =stores =products =default-store =current-store]
+$  card  card:agent:gall
++  product-orm  ((on id product) gth)
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
    stores  (molt ~[[1 [id=1 title="Default Store" catalog=[id=1 ~ ~ ~] ~]]])
    products  ~
    default-store  1
    current-store  1
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
    ?-  -.action
      %add-product
      :-  ~
      %=  state
        products
        %^  put:product-orm  products  1
        (product [id=1 title=title.action ~ ~ ~ ~])
      ==
    ::
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