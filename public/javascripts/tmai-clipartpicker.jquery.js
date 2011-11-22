/**
	An extremely primitive color picker, designed to be used with a jQuery selector, as in:

	<div id='MyColorSelector'></div>

	$(function() {
		$('#MyColorSelector').pickColorSelector({colorPickClass:'ColorPickClass', 
							clickSelect: function(color) {alert($(color).css('background-color'));}});
	});

	it creates a set of "color colorPickes" elements and uses jQuery(this).append() to add them
	to the current element. If it is called outside of a jQuery context then it will throw
	an exception.

	Arguments:

	props = an optional array of key/val pairs:

	props.colors = array of colors (hex, rgb(), or null). The default
	contains a hex-encoded "premium, hand-picked selection" of common
	reds/yellows/blues, plus null (treated as transparent).

	props.colorPickElemType: Element Type for each color colorPick (default='span')

	props.colorPickClass: CSS class for each element (default='ColorBlotch')

	props.clickCallback: a callback tied to each colorPick, called when the colorPick
	is clicked. It is passed a single color argument (hex-encoded or rgb(r,g,b)
	or null, as defined in .colors). null is conventionally used to mean
	'transparent'. The default callback does nothing.

	props.iteractionCallback: function(target,elem,color,iterationNumber) is
	called after each colorPick is append()ed. It is passed the target jQuery
	object, the colorPick jQuery object, current color (same encoding as in
	.colors), and the current iteration count (starts at 0 and increments 1
	per colorPick added). This can be used to gain some control over the layout,
	e.g. by inserting a <br/> every 5 iterations. e.g.:
		iterationCallback: function(tgt,elem,i) { if( !((i+1)%5) ) tgt.append('<br/>') }
	The default callback is null.


	Peculiarities of the implementation:

	- each "cell" of the selector is populated with a single &nbsp; UNLESS
	the color is null, in which case a '?' is used (this is to avoid visual
	confusion with a colorPick of the same background container as the target
	element. If you don't like this, you can use the iterationCallback to
	change the content using jQuery's .text() or .html() functions.

	Licensed by Thanh Mai (maichithanh@gmail.com)
*/
jQuery.fn.pickClipArtSelector = function( props ) {
	//var tgt = (targetElem instanceof jQuery) ? targetElem : $(targetElem);
	var tgt = jQuery(this);
	if( ! tgt ) {
		throw new Error( "BPIApp.pickClipArtSelector(,...): $(this) is "+
				"not a valid argument to jQuery(...).");
	}
	if( ! props ) { props = []; }
	var dp = jQuery.fn.pickClipArtSelector.defaultProps;
	for( var p in dp ) {
		if( undefined == props[p] ) props[p] = dp[p];
	}
	var count = props.artNames.length;
	for( var i = 0; i < count; ++i ) {
        var an = props.artNames[i];
        var im = props.images[i];

        var a = document.createElement('a');
        a = jQuery(a);
        a.attr('href','#'+props.imagePanelID);
        a.addClass( props.fancyBoxClass);

		var s = document.createElement(props.artPickElemType);
		if( ! s ) {
			throw new Error('jQuery.pickClipArtSelector(): '+
			'documentCreateElement('+props.artPickElemType+') failed.');
		}
		s = jQuery(s);

		s.addClass( props.artPickClass );
		s.css( 'cursor', props.cursorCSS );
		/*s.css( 'float', props.floatCSS );*/
        s.attr('alt', an);
        s.attr('src', props.artDepot + im);
        
		if( an ) {
			if( props.clickCallback ) {
				s.click( function() { 
					props.clickCallback($(this).attr('src'));
					props.clickSelect(this);
				});
			}
		} else {
			s.text('Art');
			if( props.clickCallback ) {
				s.click( function() { props.clickCallback(null); });
			}
		}
        a.append( s );
		tgt.append( $("<div class='photo-thumb-view'></div>").html(a) );
		if( props.iterationCallback ) props.iterationCallback( tgt, s, an, i );
	}
	return tgt;
};
jQuery.fn.pickClipArtSelector.defaultProps = {
		artPickElemType: 'img',
		artPickClass:'ArtPick',
        artDepot:'/images/art/',
        imagePanelID: 'imagePanel',
        fancyBoxClass: 'addImageArt',
		clickCallback: function(ignoredArt) {},
		clickSelect: function(selectedArt) {},
		iterationCallback: null,
		cursorCSS: 'pointer',
		floatCSS: 'left',
        artNames: [null, 'butterfly','tiger'],
        images: [null, 'butterfly.png','tiger.png']
};

