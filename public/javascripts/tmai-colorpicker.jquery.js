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
	
	License: Public Domain

	Author: stephan beal

	Customized by Thanh Mai
*/
jQuery.fn.pickColorSelector = function( props ) {
	//var tgt = (targetElem instanceof jQuery) ? targetElem : $(targetElem);
	var tgt = jQuery(this);
	if( ! tgt ) {
		throw new Error( "BPIApp.pickColorSelector(,...): $(this) is "+
				"not a valid argument to jQuery(...).");
	}
	if( ! props ) { props = []; }
	var dp = jQuery.fn.pickColorSelector.defaultProps;
	for( var p in dp ) {
		if( undefined == props[p] ) props[p] = dp[p];
	}
	var count = props.colors.length;
	for( var i = 0; i < count; ++i ) {
		var c = props.colors[i];
        var cn = props.colorNames[i];
        var im = props.images[i];

		var s = document.createElement(props.colorPickElemType);
		if( ! s ) {
			throw new Error('jQuery.pickColorSelector(): '+
			'documentCreateElement('+props.colorPickElemType+') failed.');
		}
		s = jQuery(s);

		s.addClass( props.colorPickClass );
		s.css( 'background-color',c );
		s.css( 'cursor', props.cursorCSS );
		s.css( 'float', props.floatCSS );
        s.attr('colorname', cn);
        s.attr('image', im);
        
		if( c ) {
			s.html('&nbsp;&nbsp;&nbsp;&nbsp;');
			if( props.clickCallback ) {
				s.click( function() { 
					props.clickCallback($(this).css('background-color'));
					props.clickSelect(this);
				});
			}
		} else {
			s.text('Color');
			if( props.clickCallback ) {
				s.click( function() { props.clickCallback(null); });
			}
		}
		tgt.append( s );
		if( props.iterationCallback ) props.iterationCallback( tgt, s, c, i );
	}
	return tgt;
};
jQuery.fn.pickColorSelector.defaultProps = {
		colorPickElemType: 'div',
		colorPickClass:'ColorPick',
		clickCallback: function(ignoredColor) {},
		clickSelect: function(selectedColor) {},
		iterationCallback: null,
		cursorCSS: 'pointer',
		floatCSS: 'left',
		colors: [
        '#c0e1ff','#7299c6','#00a5d9','#093eb6','#06294d', // light-blue,blue-jean,turqoise,royal-blue,navy
        '#00ffd8','#719986','#00a185','#269c4a','#949b51', // (greens) mint,sagestone, jade, kelly green, olive green
        '#fff6dc','#d3cab7','#c8b89e','#774E39','#59582b',  // cream,sand,khaki,brown, army green,
        '#ffffff','#e4e5e6','#b6b8ba','#4f4b4d','#0f0f0f', // white,silver grey, heatherish,dark grey,black,
        '#ef5091','#dc1414','#820024','#53247f','#4a1f4b', // fuchsia,red,maroon,purple,eggplant,
        '#f9c4ce','#f5ffbb','#fff578','#e6b329','#ef6821'  // pink,lemon, banana, gold, orange
        ],
        colorNames: [
        'Light Blue','Blue Jean','Turqoise','Royal Blue','Navy',
        'Mint','Sagestone','Jade','Kelly Green','Olive Green',
        'Cream','Sand','Khaki','Brown','Army Green',
        'White','Silver Grey','Heatherish','Dark Grey','Black',
        'Fuchsia','Red','Maroon','Purple','Eggplant',
        'Pink','Lemon','Banana','Gold','Orange'
        ],
        images: [
        'LightBlue.png','BlueJean.png','Turqoise.png','RoyalBlue.png','Navy.png',
        'Mint.png','Sagestone.png','Jade.png','KellyGreen.png','OliveGreen.png',
        'Cream.png','Sand.png','Khaki.png','Brown.png','ArmyGreen.png',
        'White.png','SilverGrey.png','Heatherish.png','DarkGrey.png','Black.png',
        'Fuchsia.png','Red.png','Maroon.png','Purple.png','Eggplant.png',
        'Pink.png','Lemon.png','Banana.png','Gold.png','Orange.png'
        ]
};

