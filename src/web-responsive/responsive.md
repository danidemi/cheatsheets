## Responsive Design

### Big Picture

* Lot Of Formats
	* Smartphone
	* Tablet
	* Phablet
	* 54" TV
	* 14" LCD
* Problems
	* content should be shown correctly on all those
* Responsive Design
	* to adapt the content to the device

### Vieport

* Use meta viewport tag to control width and scaling
* Include `width=device-width`.
* Include `initial-scale=1`.
* Ensure your page is accessible by not disabling user scaling.

	<meta name="viewport" content="width=device-width, initial-scale=1">

* `width=device-width` instructs the page to match the screen’s width in device independent pixels
* `initial-scale=1` instructs browsers to establish a 1:1 relationship between CSS pixels and device independent pixels regardless of device orientation, and allows the page to take advantage of the full landscape width.
* don't use `minimum-scale`, `maximum-scale` to avoid accessibility issues.
* allow `user-scalable` 

### Size

* Use percentage size
	* content automatically scale
* Don't use absolute size
	* content can be bigger than viewport

### Media Query

* Media queries can be used to apply styles based on device characteristics.

	@media print {
		/\* print style sheets go here \*/
	}

	@import url(print.css) print;

	&lt;link rel="stylesheet" href="print.css" media="print"&gt;

Media query

	@media (query) {
		/* CSS Rules used when query matches */
	}

* query
	* min-width
	* max-width
	* min-height
	* max-height
	* orientation=portrait
	* orientation=landscape

## References

<https://developers.google.com/web/fundamentals/layouts/rwd-fundamentals/>
<https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes>
<https://developers.google.com/web/fundamentals/layouts/rwd-fundamentals/set-the-viewport>
