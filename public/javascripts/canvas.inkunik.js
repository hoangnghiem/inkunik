/**
 * This contains the scripts for design canvas (inkunil studio)
	Licensened by Thanh Mai (inkunik.com)
*/

/* colors for small picker color*/
var colorValues = Array("#000202","#953503","#35381D","#003906","#03316D","#020274","#282AA1","#373737","#7C0200","#F76905","#848000","#037B0D","#008589","#0001FE","#63649D","#7E7E7E","#FE0000","#F7981A","#93CD00","#2D9C69","#21D4CE","#3860FF","#700788","#909090","#F60EE0","#FFC500","#FFFC01","#00FF00","#0CFFFD","#03CBFF","#AB245F","#B9B9B9","#FF8CCE","#FFCB90","#FFFF94","#BFFFC5","#C4FFFF","#92CDFF","#D996FF","#FFFFFF");
var colorNames = Array("black","brown","DarkOliveGreen","DarkGreen","RoyalBlue4","NavyBlue","DarkBlue","gray19","maroon","OrangeRed","olive","DarkGreen","DarkCyan","blue","SlateBlue","gray","red","DarkGoldenrod1","YellowGreen","MediumSeaGreen","turquoise","SteelBlue3","DarkViolet","grey57","fuchsia","gold","yellow","green1","turquoise1","turquoise2","MediumVioletRed","gray72","orchid1","PeachPuff1","khaki1","DarkSeaGreen1","PaleTurquoise1","PaleTurquoise2","plum","white");


    $(function() {
      /***Start: TextArt Actions ***/
      /*---Add TextArt actions */
        $('#textart_form').submit(function() {
            var url = "";
            url += "t=" + $('#textart_form input[name=t]').val() + "&f=" + $('#textart_form select[name=f]').val() + "&fs=" + $('#textart_form select[name=fs]').val();

            if ($('#textart_form select[name=s]').val() != "") {
                url += "&s=" + $('#textart_form select[name=s]').val();
            }
            if ($('#textart_form select[name=e]').val() != "") {
                url += "&e=" + $('#textart_form select[name=e]').val();
            }
            if ($('#textart_form input[name=r]').val() != "") {
                url += "&r=" + $('#textart_form input[name=r]').val();
            }
            if ($('#textart_form input[name=c]').val() != "") {
                url += "&c=" + $('#textart_form input[name=c]').val();
            }
            if ($('#textart_form select[name=oc]').val() != "") {
                url += "&oc=" + $('#textart_form select[name=oc]').val();
            }
            if ($('#textart_form select[name=l]').val() != "") {
                url += "&l=" + $('#textart_form select[name=l]').val();
            }
            if ($('#textart_form input[name=a]').val() != "") {
                url += "&a=" + $('#textart_form input[name=a]').val();
            }
            var img_src = $('#textart_form').attr('action') + "?" + encodeURI(url);
            var randomId = 'textart_' + Math.floor(Math.random()*2010);

            $("<a id='" + randomId + "'url='#' class='draggable text-adding ui-draggable' style='position: absolute;'><img src='" + img_src + "'/><input type='hidden' value='" + $('#textart_form input[name=c]').val() + "' name='designed_colors'></a>")
                    .appendTo('#' + $('div#positionPanel input[name=selected_position]').val());

            $('a#fancybox-close').click();
            $('a#' + randomId).attr('text_src',$('#textart_form input[name=t]').val());
            $.canvasReload();
            $('a#' + randomId).click(); /*select item to edit*/
            
            return false;
        });

    /*----Edit TextArt actions */
        $("#edit_textart select, #edit_textart input[type='text']").change(function() {
            var url = "";
            url += "t=" + $('#edit_textart input[name=t]').val() + "&f=" + $('#edit_textart select[name=f]').val() + "&fs=" + $('#edit_textart select[name=fs]').val();

            if ($('#edit_textart select[name=s]').val() != "") {
                url += "&s=" + $('#edit_textart select[name=s]').val();
            }
            if ($('#edit_textart select[name=e]').val() != "") {
                url += "&e=" + $('#edit_textart select[name=e]').val();
            }
            if ($('#edit_textart input[name=r]').val() != "") {
                url += "&r=" + $('#edit_textart input[name=r]').val();
            }
            if ($('#edit_textart input[name=c]').val() != "") {
                url += "&c=" + $('#edit_textart input[name=c]').val();
            }
            if ($('#edit_textart select[name=oc]').val() != "") {
                url += "&oc=" + $('#edit_textart select[name=oc]').val();
            }
            if ($('#edit_textart select[name=l]').val() != "") {
                url += "&l=" + $('#edit_textart select[name=l]').val();
            }
            if ($('#edit_textart input[name=a]').val() != "") {
                url += "&a=" + $('#edit_textart input[name=a]').val();
            }
            
            var img_src = $('#edit_textart').attr('action') + "?" + encodeURI(url);

            $('#' + $('#edit_textart input[name=selected_textart]').val()).children().eq(1).attr("value",$('#edit_textart input[name=c]').val());
            $('#' + $('#edit_textart input[name=selected_textart]').val()).children().first().attr("src",img_src);

            $('#' + $('#edit_textart input[name=selected_textart]').val()).attr('text_src',$('#edit_textart input[name=t]').val());

            $.canvasReload();
            return false;
        });
    /***End: TextArt Actions ***/

    /***Start: ClipArt Actions ***/
    /*----Add ClipArt actions */
        $('#clipart').submit(function() {
            var url = "";
            url += "src=" + $('#clipart input[name=src]').val();

            if("clipart" == $('div.image-preview img').attr('img_src')){
                if ($('#clipart input[name=b]').val() != "") {           
                    url += "&b=" + $('#clipart input[name=b]').val();
                } else {
                    url += "&b=black";
                }
            }
            if ($('#clipart select[name=rs]').val() != "") {
                url += "&rs=" + $('#clipart input[name=rs]').val();
            }
            if ($('#clipart input[name=r]').val() != "") {
                url += "&r=" + $('#clipart input[name=r]').val();
            }

            var img_src = $('#clipart').attr('action') + "?" + encodeURI(url);
            var randomId = 'clipart_' + $('#clipart input[name=src]').val() + Math.floor(Math.random()*2010);
            randomId = $.replaceAllString($.replaceAllString($.replaceAllString($.replaceAllString(randomId,"/","-")," ","_"),".","_"),"#","_");

            if("uploaded" == $('div.image-preview img').attr('img_src')){
                $("<a id='" + randomId + "' url='#' class='draggable img-adding ui-draggable el-resizable-xxx' style='position: absolute;'><img class='img_croppable' src='" + img_src + "'/><input type='hidden' value='uploaded' name='designed_colors'><input type='hidden' value='' name='original_size'></a>")
                                    .appendTo('#' + $('div#positionPanel input[name=selected_position]').val());
            } else {  /*clipart*/
                $("<a id='" + randomId + "' url='#' class='draggable img-adding ui-draggable el-resizable-xxx' style='position: absolute;'><img class='img_croppable' src='" + img_src + "'/><input type='hidden' value='" + $('#clipart input[name=b]').val() + "' name='designed_colors'><input type='hidden' value='' name='original_size'></a>")
                                    .appendTo('#' + $('div#positionPanel input[name=selected_position]').val());
            }

            $('a#' + randomId).attr('art_src',$('#clipart input[name=src]').val());
            $.canvasReload();
            $('a#' + randomId).click(); /*select item to edit*/
            
            return false;
        });

    /*----Edit ClipArt actions */
        $("#edit-clipart select, #edit-clipart input:text, #edit-clipart input:checkbox, #edit-clipart input:radio").change(function() {
            var url = "";
            url += "src=" + $('#edit-clipart input[name=src]').val();

            if ($('#edit-clipart input[name=b]').val() != "" && $('#edit-clipart input[name=b]').val() != "none") {
                url += "&b=" + $('#edit-clipart input[name=b]').val();
            }
            if ($('#edit-clipart input[name=rs]').val() != "") {
                url += "&rs=" + $('#edit-clipart input[name=rs]').val();
            }
            if ($('#edit-clipart input[name=r]').val() != "") {
                url += "&r=" + $('#edit-clipart input[name=r]').val();
            }

            if ($('#edit-clipart input[name=vig]').attr('checked') != "") {
                url += "&vig=" + $('#edit-clipart input[name=vig]').attr('checked');
            }

            $('#edit-clipart input[name=ff]').each(function(){
               if ($(this).attr('checked')) {
                url += "&ff=" + $(this).val();
               }
            });

            if ($('#edit-clipart input[name=emb]').attr('checked') != "") {
                url += "&emb=" + $('#edit-clipart input[name=emb]').attr('checked');
            }
            if ($('#edit-clipart input[name=qr]').val() != "1") {
                url += "&qr=" + $('#edit-clipart input[name=qr]').val();
            }

            var img_src = $('#edit-clipart').attr('action') + "?" + encodeURI(url);
            
            $('#' + $('#editImagePanel input[name=selected_image]').val()).children().first().attr("src",img_src);

            if ($('#edit-clipart input[name=b]').val() != "") {
                $('#' + $('#editImagePanel input[name=selected_image]').val()).children().eq(1).attr("value",$('#edit-clipart input[name=b]').val());
            }
            $('#' + $('#editImagePanel input[name=selected_image]').val()).attr('art_src',$('#edit-clipart input[name=src]').val());
            $.canvasReload();
            return false;

        });
   /***End: ClipArt Actions ***/

   /*--- Garment Color Picker Box  */
        $('#colorTemplate').pickColorSelector(
            {
                colorPickClass:'color',
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
                'LightBlue.jpeg','BlueJean.jpeg','Turqoise.jpeg','RoyalBlue.jpeg','Navy.jpeg',
                'Mint.jpeg','Sagestone.jpeg','Jade.jpeg','KellyGreen.jpeg','OliveGreen.jpeg',
                'Cream.jpeg','Sand.jpeg','Khaki.jpeg','Brown.jpeg','ArmyGreen.jpeg',
                'White.jpeg','SilverGrey.jpeg','Heatherish.jpeg','DarkGrey.jpeg','Black.jpeg',
                'Fuchsia.jpeg','Red.jpeg','Maroon.jpeg','Purple.jpeg','Eggplant.jpeg',
                'Pink.jpeg','Lemon.jpeg','Banana.jpeg','Gold.jpeg','Orange.jpeg'
                ],
                clickSelect: function(color) {
                    $('#design-canvas-front').css('background','url("/images/garments/'+ $('#garmentStylePanel input[name=selected_style]').val() +'/' + $(color).attr('image') +'") no-repeat scroll 0pt 0pt transparent');
                    $('#design-canvas-behind').css('background','url("/images/garments/'+ $('#garmentStylePanel input[name=selected_style]').val() +'/back/' + $(color).attr('image') +'") no-repeat scroll 0pt 0pt transparent');
                    $('#design-canvas-left').css('background','url("/images/garments/'+ $('#garmentStylePanel input[name=selected_style]').val() +'/left/' + $(color).attr('image') +'") no-repeat scroll 0pt 0pt transparent');
                    $('#design-canvas-right').css('background','url("/images/garments/'+ $('#garmentStylePanel input[name=selected_style]').val() +'/right/' + $(color).attr('image') +'") no-repeat scroll 0pt 0pt transparent');
                    $('input[name=garment_color_name]').val($(color).attr('colorname'));
                    $('input[name=garment_image_bkg]').val('/images/garments/'+ $('#garmentStylePanel input[name=selected_style]').val() +'/' + $(color).attr('image'));
                }
            }
        );

        /* small color picker box*/
        $('#edit_textart #edit_text_color').smallColorPicker({
            colorValues: colorValues,
            colorNames: colorNames
        });
        $('#textart_form #add_text_color').smallColorPicker({
            colorValues: colorValues,
            colorNames: colorNames
        });
        $('form#clipart #add_major_color').smallColorPicker({
            colorValues: colorValues,
            colorNames: colorNames
        });
        $('form#edit-clipart #edit_major_color').smallColorPicker({
            colorValues: colorValues,
            colorNames: colorNames
        });

      /*-- Art Picker Box */
        $('#artSelector').pickClipArtSelector(
            {
                artPickClass:'ArtPick',
                artDepot:'/images/arts/clip_art/',
                artNames: ['lemons','Dragon','reindeer','Angel_wings','Tribal_Tattoo_with_Rose','World_Map','Santa_Hat','ornate_sun'],
                images: ['lemons.png','Dragon.png','reindeer.png','Angel_wings.png','Tribal_Tattoo_with_Rose.png','World_Map.png','Santa_Hat.png','ornate_sun.png'],
                clickSelect: function(art) {
                    $('div.image-preview img').attr('src',$(art).attr('src'));
                    $('form#clipart div.major_color_field').removeClass("hidden");
                    $('div.image-preview img').attr('img_src','clipart');
                    $('form#clipart input[name=src]').val($(art).attr('src'));
                    $('form#clipart input[name=rs]').val('0.35');
                    $('a#fancybox-close').click();
                    $('#clipart').submit();
                }
            }
        );

        /* upload a picture*/
        $('#uploadPhotoForm input').change(function(){
            $(this).parent().ajaxSubmit({
                beforeSubmit: function(a,f,o) {
                    o.dataType = 'json';
                },
                complete: function(XMLHttpRequest, textStatus) {
					  $('div.image-preview img').attr('src', XMLHttpRequest.responseText);
                      $('form#clipart div.major_color_field').addClass("hidden");                    
                      $('div.image-preview img').attr('img_src', 'uploaded');
					  $('form#clipart input[name=src]').val(XMLHttpRequest.responseText);
					  $('a#fancybox-close').click();
                      $('#clipart').submit();
                }
            });
        });

        /*---- Position Select Action */
        $('div#canvas-frame div.canvas-data').addClass('hidden');
        $('div#design-canvas-front').removeClass('hidden');
        $('div#positionPanel input[name=selected_position]').val('containment-front-tshirt');
        /*$('#garmentStylePanel input[name=selected_style]').val('tshirt');*/

        $('div.pos-buttons').click(function(){
            $('div.canvas-data').addClass('hidden');
            $('div#' + $(this).attr('position')).removeClass('hidden');
            $('div#positionPanel input[name=selected_position]').val($(this).attr('container'));
        });

        /*-- Rotate text Sliders for adding*/
        $("#textPanel #add-text-rotate-amount").empty().append(0);
        $("#textPanel #add-text-rotate-slider").slider({
            value: 0,
            step: 15,
            min: -180,
            max: 180,
            slide: function(event, ui) {
                $("#textPanel #add-text-rotate-amount").empty().append(ui.value);
                $('#textPanel input[name=r]').val(ui.value);
            }
        });

        /*-- Rotate text Sliders for editing*/
        $("#editTextPanel #edit-text-rotate-slider").slider({
            value: 0,
            step: 15,
            min: -180,
            max: 180,
            slide: function(event, ui) {
                $("#editTextPanel #edit-text-rotate-amount").empty().append(ui.value);
                $('#editTextPanel #edit_textart input[name=r]').val(ui.value);
                $('#editTextPanel #edit_textart input[name=r]').change();
            }
        });
        /*-- Arg angle text Sliders for editing*/
        $("#editTextPanel #edit-text-angle-slider").slider({
            value: 0,
            step: 20,
            min: 0,
            max: 360,
            slide: function(event, ui) {
                $("#editTextPanel #edit-text-angle-amount").empty().append(ui.value);
                $('#editTextPanel #edit_textart input[name=a]').val(ui.value);
                $('#editTextPanel #edit_textart input[name=a]').change();
            }
        });

        /*-- Rotate image Sliders for adding*/
        $("#imagePanel #add-image-rotate-amount").empty().append(0);
        $("#imagePanel #add-image-rotate-slider").slider({
            value: 0,
            step: 15,
            min: 0,
            max: 360,
            slide: function(event, ui) {
                $("#imagePanel #add-image-rotate-amount").empty().append(ui.value);
                $('#imagePanel input[name=r]').val(ui.value);
            }
        });

        /*-- Rotate image Sliders for editing*/
        $("#editImagePanel #edit-image-rotate-slider").slider({
            value: 0,
            step: 15,
            min: 0,
            max: 360,
            slide: function(event, ui) {
                $("#editImagePanel #edit-image-rotate-amount").empty().append(ui.value);
                $('#editImagePanel input[name=r]').val(ui.value);
                $('#editImagePanel input[name=r]').change();
            }
        });

        /*-- Resize image Sliders for adding*/
        $("#imagePanel #add-image-resize-amount").empty().append(1);
        $("#imagePanel #add-image-resize-slider").slider({
            value: 1,
            step: 0.05,
            min: 0.05,
            max: 1,
            slide: function(event, ui) {
                $("#imagePanel #add-image-resize-amount").empty().append(ui.value);
                $('#imagePanel input[name=rs]').val(ui.value);
            }
        });

        /*-- Resize image Sliders for editing*/
        $("#editImagePanel #edit-image-resize-slider").slider({
            value: 1,
            step: 0.05,
            min: 0.05,
            max: 1,
            slide: function(event, ui) {
                $("#editImagePanel #edit-image-resize-amount").empty().append(ui.value);
                $('#editImagePanel input[name=rs]').val(ui.value);
                $('#editImagePanel input[name=rs]').change();
            }
        });

         /*-- Color QuantumRange image Sliders for editing*/
        $("#editImagePanel #edit-image-quantum-slider").slider({
            value: 1,
            step: 0.05,
            min: 0.05,
            max: 1,
            slide: function(event, ui) {
                $("#editImagePanel #edit-image-quantum-amount").empty().append(ui.value);
                $('#editImagePanel input[name=qr]').val(ui.value);
                $('#editImagePanel input[name=qr]').change();
            }
        });

        $('div#quantity-size-fields input.qtySize').change(function(){
            var sumQty = $.sumQuantity('qtySize');
            $('#total-quantity span.#sum-qty').html(sumQty);
            $('#design_total_quantity').val(sumQty); /*hidden field*/

            /*submit form to calculate total*/
            $('#frm_total_cal #cal_quantities').val(sumQty);
            $('#frm_total_cal').ajaxSubmit({
                beforeSubmit: function(a,f,o) {
                    o.dataType = 'json';
                },
                complete: function(XMLHttpRequest, textStatus) {
                    $('#total-price span.#sum-price').html(XMLHttpRequest.responseText);
                    $('input#design_total_price').val(XMLHttpRequest.responseText);
                }
            });
        });

    });

 /**--- Reload the Canvas */
    $.extend({
        canvasReload:function () {

            var numPhoto = $.countNumberOfPhotos('designed_colors');
            $('div#number-photo span').html(numPhoto);
            $('input#number_photo_field').val(numPhoto);

            var numColor = $.countNumberOfColors('designed_colors');
            $('div#number-color span').html(numColor);
            $('input#number_color_field').val(numColor);

            $('#frm_total_cal #cal_num_of_colors').val(numColor);
            $('#frm_total_cal #cal_num_of_photos').val(numPhoto);
            $('#frm_total_cal').ajaxSubmit({
                beforeSubmit: function(a,f,o) {
                    o.dataType = 'json';
                },
                complete: function(XMLHttpRequest, textStatus) {
                    $('#total-price span.#sum-price').html(XMLHttpRequest.responseText);
                    $('input#design_total_price').val(XMLHttpRequest.responseText);
                }
            });

            $('div#quantity-size-fields input.qtySize').change();

            /*reset the fields*/
            $("#textPanel #add-text-rotate-slider").slider("value",0);
            $("#textPanel #add-text-rotate-amount").empty().append(0);
            $('#textPanel input[name=r]').val(0);

            $("#imagePanel #add-image-rotate-amount").empty().append(0);
            $("#imagePanel #add-image-rotate-slider").slider("value",0);
            $('#imagePanel input[name=r]').val(0);

            $("#imagePanel #add-image-resize-amount").empty().append(1);
            $("#imagePanel #add-image-resize-slider").slider("value",1);
            $('#imagePanel input[name=rs]').val(1);

            $("#canvas-frame .img-adding, #canvas-frame .text-adding").draggable({ cursor: 'move' }, { containment: 'parent' });

            $('.el-resizable').resizable({
                            aspectRatio: true,
                            containment: '#containment-front-tshirt',
                            stop: function(event, ui) {
                                var original_size = $('#' + $(this).attr('id')).children().eq(2).attr('value');

                                if (original_size==null || original_size=="") {
                                    original_size =  ui.originalSize.width;
                                    $('#' + $(this).attr('id')).children().eq(2).attr('value', original_size);
                                }

                                var url = "";
                                url += "src=" + $('#edit-clipart input[name=src]').val();

                                if ($('#edit-clipart input[name=b]').val() != "") {
                                    url += "&b=" + $('#edit-clipart input[name=b]').val();
                                }

                                url += "&rs=" + ui.size.width/original_size;
                                $('#edit-clipart input[name=rs]').val(ui.size.width/original_size);

                                if ($('#edit-clipart input[name=r]').val() != "") {
                                    url += "&r=" + $('#edit-clipart input[name=r]').val();
                                }
                                var img_src = $('#edit-clipart').attr('action') + "?" + encodeURI(url);

                                $('#' + $(this).attr('id')).children().first().attr("src",img_src);

                                $.canvasReload();
                                return false;
                            }
                        });

            $("#canvas-frame .img-adding").click(function(){
                var allVars = $.getUrlVars($(this).children().first().attr("src"));
                var src = allVars['src'];
                var b = allVars['b'];
                var rs = allVars['rs'];
                var r = allVars['r'];
                var qr = allVars['qr'];
                var vig = allVars['vig'];
                var emb = allVars['emb'];
                var ff = allVars['ff'];
                if (src!=null) {
                    $('#edit-clipart input[name=src]').val(src);
                    $('div#editImagePanel .image-preview img').attr('src', src);
                }

                $('#edit-clipart input[name=vig]').removeAttr('checked');
                $('#edit-clipart input[name=ff]').removeAttr('checked');

                if (vig!=null) {
                    $('#edit-clipart input[name=vig]').attr('checked',vig);
                }

                if (ff!=null) {
                    $('#edit-clipart input[name=ff]').each(function(){
                        if($(this).val() == ff) {
                            $(this).attr('checked',true);
                        }                        
                    });
                }

                $('#edit-clipart input[name=emb]').attr('checked',false);
                if (emb!=null) {
                    $('#edit-clipart input[name=emb]').attr('checked',emb);
                }

                if (b!=null){
                    $('#edit-clipart input[name=b]').val(b);
                    $('#edit-clipart div.major_color_field').removeClass("hidden");
                    for(i in colorNames) {
                        if(colorNames[i] == b){
                            $("#picker_shower_edit_major_color").css('background-color',colorValues[i]);
                        }
                    }
                } else {
                    $('#edit-clipart div.major_color_field').addClass("hidden");
                    $('#edit-clipart input[name=b]').val('');
                }
                if (rs!=null){
                    $('#edit-clipart input[name=rs]').val(rs);
                    $("#editImagePanel #edit-image-resize-amount").empty().append(rs);
                    $("#editImagePanel #edit-image-resize-slider").slider("value",rs);
                } else {
                    $('#edit-clipart input[name=rs]').val(1);
                    $("#editImagePanel #edit-image-resize-amount").empty().append(1);
                    $("#editImagePanel #edit-image-resize-slider").slider("value",1);
                }

                if (r!=null){
                    $('#edit-clipart input[name=r]').val(r);
                    $("#editImagePanel #edit-image-rotate-amount").empty().append(r);
                    $("#editImagePanel #edit-image-rotate-slider").slider("value",r);
                } else {
                    $('#edit-clipart input[name=r]').val(0);
                    $("#editImagePanel #edit-image-rotate-amount").empty().append(0);
                    $("#editImagePanel #edit-image-rotate-slider").slider("value",0);
                }
                if (qr!=null){
                    $('#edit-clipart input[name=qr]').valq(r);
                    $("#editImagePanel #edit-image-quantum-amount").empty().append(qr);
                    $("#editImagePanel #edit-image-quantum-slider").slider("value",qr);
                } else {
                    $('#edit-clipart input[name=qr]').val(1);
                    $("#editImagePanel #edit-image-quantum-amount").empty().append(1);
                    $("#editImagePanel #edit-image-quantum-slider").slider("value",1);
                }
                var selected_id = $(this).attr('id');
                $("#edit-clipart input[name='selected_image']").val(selected_id);
                $.openActionPanel("#editImagePanel");
                $('#edit-actions-board-btn').click();
            });

            $("#canvas-frame .text-adding").click(function(){
                var allVars = $.getUrlVars($(this).children().first().attr("src"));
                var t = allVars['t'];
                var f = allVars['f'];
                var fs = allVars['fs'];
                var s = allVars['s'];
                var e = allVars['e'];
                var r = allVars['r'];
                var c = allVars['c'];
                var oc = allVars['oc'];
                var l = allVars['l'];
                var a = allVars['a'];

                if (t!=null) {
                    $('#edit_textart input[name=t]').val(decodeURI(t));
                }
                if (f!=null){
                    $('#edit_textart select[name=f]').val(f);
                }
                if (fs!=null){
                    $('#edit_textart select[name=fs]').val(fs);
                }
                if (s!=null) {
                    $('#edit_textart select[name=s]').val(s);
                } else {
                    $('#edit_textart select[name=s]').val('');
                }
                if (e!=null) {
                    $('#edit_textart select[name=e]').val(e);
                } else {
                    $('#edit_textart select[name=e]').val('');
                }
                if (r!=null) {
                    $('#edit_textart input[name=r]').val(r);
                    $("#editTextPanel #edit-text-rotate-slider").slider("value",r);
                    $("#editTextPanel #edit-text-rotate-amount").empty().append(r);
                } else {
                    $('#edit_textart input[name=r]').val(0);
                    $("#editTextPanel #edit-text-rotate-slider").slider("value",0);
                    $("#editTextPanel #edit-text-rotate-amount").empty().append(0);
                }
                if (c!=null) {
                    $('#edit_textart input[name=c]').val(c);
                    for(i in colorNames) {
                        if(colorNames[i] == c){
                            $("#picker_shower_edit_text_color").css('background-color',colorValues[i]);
                        }
                    }
                }
                if (oc!=null) {
                    $('#edit_textart select[name=oc]').val(oc);
                } else {
                    $('#edit_textart select[name=oc]').val('');
                }
                if (l!=null) {
                    $('#edit_textart select[name=l]').val(l);
                } else {
                    $('#edit_textart select[name=l]').val('');
                }
                if (a!=null) {
                    $('#edit_textart input[name=a]').val(a);
                    $("#editTextPanel #edit-text-angle-slider").slider("value",a);
                    $("#editTextPanel #edit-text-angle-amount").empty().append(a);
                } else {
                    $('#edit_textart input[name=a]').val(0);
                    $("#editTextPanel #edit-text-angle-slider").slider("value",0);
                    $("#editTextPanel #edit-text-angle-amount").empty().append(0);
                }

                $("#edit_textart input[name='selected_textart']").val($(this).attr('id'));

                /* get the info to generate the thumbnail of design*/
                if ($('#containment-front-tshirt').parent().css("display")!="none") {
                    $("#front-thumb img").attr("src","/api/design2image?side=BODY&bkg="+$('input[name=garment_image_bkg]').val()+$.containment2thumbnail('#containment-front-tshirt'));
                } else if ($('#containment-behind-tshirt').parent().css("display")!="none") {
                    $("#back-thumb img").attr("src","/api/design2image?side=BODY&bkg="+$('input[name=garment_image_bkg]').val()+$.containment2thumbnail('#containment-behind-tshirt'));
                }
                $.openActionPanel("#editTextPanel");
                //$.overlayMe('#edit-actions-board');
                $('#edit-actions-board-btn').click();
            });
        }
    });

  /*--Count the number of colors */
    $.extend({
        countNumberOfColors:function (elementName) {
            var num = 0;
            var colors="";
            $('input[name=' +elementName+ ']').each(function(){
                var usedColor = $(this).attr('value');
                if (usedColor=="") {
                    usedColor = "Black";
                }
                if (usedColor!="uploaded" && colors.indexOf(usedColor) == -1) {
                   colors += "," + usedColor;
                   num ++;
                }
            });
            return num;
        },
        countNumberOfPhotos:function (elementName) {
            var num = 0;
            var colors="";
            $('input[name=' +elementName+ ']').each(function(){
                var usedColor = $(this).attr('value');
                if (usedColor=="uploaded") {
                  num ++;
                }
            });
            return num;
        },
        sumQuantity:function(fieldClass) {
            var sum = 0;
            var qty = 0;
            $('div#quantity-size-fields input.' + fieldClass).each(function(){
               if ($(this).val() != '') {
                   qty = parseInt($(this).val());
                   if (qty == NaN) {
                       qty = 0;
                   }
                   sum += qty;
               }

            });
            return sum;
        }
    });

  /** Extend Defined Functions*/
    /*--- retrieve the param values of url  */
    $.extend({
        getUrlVars: function(url){
            var vars = [], hash;
            var hashes = url.slice(url.indexOf('?') + 1).split('&');
            for(var i = 0; i < hashes.length; i++)
            {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        },
        getUrlVar: function(name){
            return $.getUrlVars()[name];
        },
        setUrlVar: function(name, value){
            $.getUrlVars()[name] = value;
        }
    });

/**-------The extend functions ---*/
    $.extend({
        replaceAllString: function(source,replaceStr,withStr){
            var temp = source;
            var index = temp.indexOf(replaceStr);
            while(index != -1){
                temp = temp.replace(replaceStr,withStr);
                index = temp.indexOf(replaceStr);
            }
            return temp;
        },
        removeImageArt: function() {
            $('#' + $('#editImagePanel input[name=selected_image]').val()).remove();
            $.canvasReload();
            $('#edit-actions-board a.close').click();
        },
		removeTextArt: function() {
            $('#' + $('#editTextPanel input[name=selected_textart]').val()).remove();
            $.canvasReload();
            $('#edit-actions-board a.close').click();
        },
        selectGarmentStyle: function(styleName, gener, imFormat) {
            $('#garmentStylePanel input[name=selected_style]').val(styleName+'/'+gener);
            if (imFormat == null || imFormat=="") {
                imFormat='jpeg';
            }
			if (gener == null || gener=="") {
                gener='man';
            }
            $('#design-canvas-front').css('background','url("/images/garments/'+ styleName +'/'+ gener +'/White.'+imFormat+'") no-repeat scroll 0pt 0pt transparent');
            $('#design-canvas-behind').css('background','url("/images/garments/'+ styleName +'/'+ gener +'/back/White.'+imFormat+'") no-repeat scroll 0pt 0pt transparent');
            $('#design-canvas-left').css('background','url("/images/garments/'+ styleName +'/'+ gener +'/left/White.'+imFormat+'") no-repeat scroll 0pt 0pt transparent');
            $('#design-canvas-right').css('background','url("/images/garments/'+ styleName +'/'+ gener +'/right/White.'+imFormat+'") no-repeat scroll 0pt 0pt transparent');
            $('input[name=garment_image_bkg]').val('/images/garments/'+ styleName +'/'+ gener +'/right/White.'+imFormat);
        },
        openActionPanel: function(elementID) {
            //$("#action-board .action-panel").addClass("hidden");
            //$("#action-board .action-panel").removeClass("displayed");        
            $("#action-board .edit-panel").removeClass("displayed");
            $("#action-board .edit-panel").addClass("hidden");
            $("#action-board " + elementID).removeClass("hidden");
            $("#action-board " + elementID).addClass("displayed");
        },
        overlayMe: function(elementSelector) {
            $(elementSelector).overlay({
                oneInstance: false,
                closeOnClick: false,
                top: 150,
                left: 630,
                effect: 'apple'
            });
        },
        containment2thumbnail: function(containment) {
            var srcUrl="";
            $(containment + " a").each(function(){
                if ($(this).attr('art_src')!=null) {
                    srcUrl += "&art[]="+$(this).attr('art_src')+"&art_top[]="+$(this).css('top').replace("px","")+"&art_left[]="+$(this).css('left').replace("px","");
                } else if ($(this).attr('text_src')!=null) {
                    srcUrl += "&text[]="+$(this).attr('text_src')+"&text_top[]="+$(this).css('top').replace("px","")+"&text_left[]="+$(this).css('left').replace("px","");
                }
            });

            return srcUrl;
        }
    });
