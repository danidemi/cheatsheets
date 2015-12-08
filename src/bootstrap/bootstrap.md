# Bootstrap 

## Container For Layout

Use `.container` for a responsive fixed width container.

	<div class="container">
	  ...
	</div>

Use `.container-fluid` for a full width container, spanning the entire width of your viewport.

	<div class="container-fluid">
	  ...
	</div>
	
## Layout

 * `.row` for each row
 * `.col-<media>-<width>` for each cell
 * `<media>`: `xs` (extra small), `sm` (small), `md` (medium), `lg` (large)
 * `<width>`: 1 to 12
 
## Alignement

	<p class="text-left">Left aligned text.</p>
	<p class="text-center">Center aligned text.</p>
	<p class="text-right">Right aligned text.</p>
	<p class="text-justify">Justified text.</p>
	<p class="text-nowrap">No wrap text.</p>
	
## Transformations

	<p class="text-lowercase">Lowercased text.</p>
	<p class="text-uppercase">Uppercased text.</p>
	<p class="text-capitalize">Capitalized text.</p>
	
## &lt;article> &lt;address>

	<address>
	  <strong>Twitter, Inc.</strong><br>
	  1355 Market Street, Suite 900<br>
	  San Francisco, CA 94103<br>
	  <abbr title="Phone">P:</abbr> (123) 456-7890
	</address>
	
## Lists

Unordered

	<ul>
	  <li>...</li>
	</ul>

Ordered

	<ol>
	  <li>...</li>
	</ol>
	
Unstyled	
	
	<ul class="list-unstyled">
	  <li>...</li>
	</ul>	
	
Inline

	<ul class="list-inline">
	  <li>...</li>
	</ul>

## Descriptions

Default

	<dl>
	  <dt>...</dt>
	  <dd>...</dd>
	</dl>
	
Horizontal

	<dl class="dl-horizontal">
	  <dt>...</dt>
	  <dd>...</dd>
	</dl>
	
## Form

Classes for errors.

`has-success`
`has-warning`
`has-success`

### Alerts

	<div th:if="${param.containsKey('error')}" class="alert alert-warning fade in">
		<strong>Attenzione!</strong> L'account non è stato trovato.
	</div>

## Buttons

`.btn-lg`, `.btn-sm`, or `.btn-xs`
