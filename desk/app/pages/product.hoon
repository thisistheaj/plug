::  global imports
::
/-  plug
::  sail imports
::
/=  styles  /app/components/styles
/=  page-content  /app/components/page-content
::  product page component
::
|=  [=bowl:gall store=store:plug product=product:plug]
|^  ^-  octs
%-  as-octs:mimes:html
%-  crip
%-  en-xml:html
^-  manx
:: Sail Page
::
;html
  ;head
    ;script(src "https://unpkg.com/@urbit/http-api");
    ;script(src "/session.js");
    ;link/"https://cdn.jsdelivr.net/npm/purecss@2.1.0/build/pure-min.css"(rel "stylesheet", crossorigin "anonymous", integrity "sha384-yHIFVG6ClnONEA5yB5DJXfW2/KC173DIQrYoZMEtBvGzmf0PKiGyNEqe9N6BNDBH");
    ;meta(charset "utf-8");
    ;style: {styles}
    ;meta
      =name  "viewport"
      =content  "width=device-width, initial-scale=1";
  ==
  ;body
    ;div#app
      ;+  product-page
    ==
  ==
==
++  product-page
  ^-  manx
  |^
  ;div
    ;+  (page-content content)
  ==
  ++  content
    ^-  manx
    ;div
      ;+  store-header
    ==
  --

++  store-header
  ^-  manx
  ;div.preview-header
    ;div.header-avatar
      ;img(src avatar.store);
    ==
    ;div.preview-header-title
      ;h1: {title.store}
    ==
  ==
--