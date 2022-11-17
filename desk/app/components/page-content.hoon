::  page-content component: 
::  wraps manx (usually page) in responsive layer
::
|=  content=manx
^-  manx
;div.pure-g
  ;div.pure-u-1-12.mobile-hide;
  ;div.pure-u-5-6.mobile-hide
    ;+  content
  ==         
  ;div.pure-u-5-6.desktop-hide
    ;+  content
  ==         
  ;div.pure-u-1-12.mobile-hide;          
==