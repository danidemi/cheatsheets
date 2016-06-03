# CSS Cheat Sheet

* Cascading Style Sheets
    * The latter style applied wins.
    * It's importnat how the browser read the css.

!important overrides a rule.

~~~~~~~~~~~~~~~~~~~~~~~~~ {#syntax}
P {
  p { color: red; !important}
  p { color: black;} <-- this wins, it's the lastone.
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~ {#syntax}
P {
  p { color: red; !important} <-- this wins, it's !important.
  p { color: black;}
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Syntax

~~~~~~~~~~~~~~~~~~~~~~~~~ {#syntax}
/* comment */
<selector> {
  <property>:<value>;
  <property>:<value>; /* comment */
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Selectors

Priorities of selectors.
* 100 points for IDs
* 10 points for classes and pseudo-classes
* 1 point for tag selectors and pseudo-elements

\.class     
css 1
\.intro => Selects all elements with class="intro"

\.class.class
css 1
\.heart.on => Selects all elements with both classed "heart" and “on”

\#id          
css 1
\#firstname => Selects the element with id="firstname"

element>element          
css 2
div > p => Selects all <p> elements where the parent is a <div> element

:nth-child(n)          
css 3
p:nth-child(2) => Selects every <p> element that is the second child of its parent

#Placing Objects

## Fixed Position

~~~~~~~ {#prelude .css .numberLines}
.selector {
  position:fixed;
  bottom: 0;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Center a Table
"text-align" applies to inline content, not to a block-level element like "table".

#### Method 1
To center a table, you need to set the margins, like this:

~~~~~~~ {#prelude .css .numberLines}
table.center {
 margin-left:auto;
 margin-right:auto;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

And then do this:

~~~~~~~ {#prelude .css .numberLines}
<table class="center">
</table>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At this point, Mozilla and Opera will center your table. 
Internet Explorer 5.5 and up, however, needs you to add this to your CSS as well:

~~~~~~~ {#prelude .css .numberLines}
body {text-align:center;}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### Method 2

If you want your table to be a certain percentage width, you can do this:

~~~~~~~ {#prelude .css .numberLines}
  table.center {
    width:70%;
    margin-left:15%;
    margin-right:15%;
  }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### Method 3
If you want your table to be of fixed width, define your CSS like this:

~~~~~~~ {#prelude .css .numberLines}
  div.container {
    width:98%;
    margin:1%;
  }
  table#table1 {
    text-align:center;
    margin-left:auto;
    margin-right:auto;
    width:100px;
  }
  tr,td {text-align:left;}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Set "width:100px" to whatever width you need.

"text-align: center" is there for Internet Explorer, which won't work without it. 
Unfortunately, "text-align: center" will center all the text inside your table cells, 
but we counter that by setting "tr" and "td" to align left.

In your HTML, you would then do this:


~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {#prelude .html}
  <div class="container">
    <table id="table1">
      ...
    </table>
  </div>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Tables

### Remove Table Borders

~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {#prelude .html}
table {
    border-collapse: collapse;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Pictures
Picture in DIV with CSS

~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.html}
<div class="image"></div>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.css}
div.image:before {
   content:url(http://placehold.it/350x150);
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~


## References
* !important
    * http://webdesign.about.com/od/css/f/blcssfaqimportn.htm
* Rule priority
    * http://stackoverflow.com/questions/20721248/best-way-to-override-bootstrap-css#27704409

