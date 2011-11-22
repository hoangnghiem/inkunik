var product = {
  num_of_variants: 0,
  default_variant_index: 0,
  init: function() {
    this.setupColorHover();
    this.setupKwick();
    this.setupQuickPriceBox();
  },
  setupColorHover: function() {
    $('.color').live('hover', function() {
      c = $(this).find("a").attr("title");
      $('#product-image').attr('src', '/images/tshirts/male/medium/' + c + ".png")
    }, function() {
      
    });
  },
  setupKwick: function() {
    Wspacing = 2;
    Wfabric= (650 - (Wspacing * product.num_of_variants))/product.num_of_variants;
    $('#fabric-swatches .kwick').width(Wfabric);
    $('#fabric-swatches').kwicks({
      sticky: true,
      min: 45,
      event: 'click',
      spacing: Wspacing,
      duration: 400,
      defaultKwick: product.default_variant_index,
      onActive: function(item) {
        dt = '#' + item[0].id + "-details";
        $('.pv-details').each(function(idx, elm) {
          $(elm).hide();
        });
        $(dt).show();
        color = $($(dt).find('.color').get(0)).children().get(0).title;
        $('#product-image').attr('src', '/images/tshirts/male/medium/' + color + ".png")
      }
    });
  },
  setupQuickPriceBox: function() {
    $('.quick_price').overlay({
        mask: {
          color: '#fff',
          loadSpeed: 200,
          opacity: 0.8
	},
        top: '3%',
        onBeforeLoad: function() {
          // grab wrapper element inside content
          var wrap = this.getOverlay().find(".contentWrap");
          // load the page specified in the trigger
          wrap.load(this.getTrigger().attr("href"));
        },
        onLoad: function() {
          Wspacing = 2;
          Wfabric= (490 - (Wspacing * product.num_of_variants))/product.num_of_variants;
          $('#quick-fabric-swatches .kwick').width(Wfabric);
          $('#quick-fabric-swatches').kwicks({
            sticky: true,
            min: 40,
            event: 'click',
            spacing: Wspacing,
            duration: 400,
            defaultKwick: product.default_variant_index,
            onActive: function(item) {
              min_qty = $(item).attr('data-min-qty');
              name = $(item).attr('data-name');
              vid = $(item).attr('data-variant-id');
              $('#variant_id').val(vid);
              $('#quick-fabric-name').text(name);
              $('#quick-min-qty').text(min_qty);
              if (min_qty > 1) {
                $('#quick-price-wrap .notice').show();
              } else {
                $('#quick-price-wrap .notice').hide();
              }
            }
          });
        }
    });
    $('#frm_quick_price').livequery(function() {
      $('#frm_quick_price #ink').click(function() {
        $('#frm_quick_price #ink-elm').show();
        $('#frm_quick_price #embr-elm').hide();
        $('#num_of_elements').val("");
        $('#quote-result').empty();
        $('#errors').empty();
      });
      $('#frm_quick_price #embroidery').click(function() {
        $('#frm_quick_price #ink-elm').hide();
        $('#frm_quick_price #embr-elm').show();
        $('#num_of_elements').val("");
        $('#quote-result').empty();
        $('#errors').empty();
      });
      $('#frm_quick_price .location').click(function() {
        $('#num_of_locations').val($('#frm_quick_price input:checked').length);
      });
      $('#frm_quick_price .img_location').toggle(function() {
        $(this).parent().find(":checkbox").attr("checked", true);
        $('#num_of_locations').val($('#frm_quick_price input:checked').length);
      }, function() {
        $(this).parent().find(":checkbox").attr("checked", false);
        $('#num_of_locations').val($('#frm_quick_price input:checked').length);
      });

      // get remote quote
      $(this).submit(function(e) {
        $('#loading').show();
        e.preventDefault();
        $.ajax({
          type: 'POST',
          url: $(this).attr("action"),
          data: $(this).serialize(),
          success: function(data) {
            $('#errors').empty();
            $('#quote-result').empty();
            $('#quote-result').append(data);
            $('#loading').hide();
          },
          error: function(xhr) {
            if (xhr.status == 422) {
              $('#errors').empty();
              $('#errors').append($(xhr.responseText));
              $('#quote-result').empty();
            } else {
              $('#quote-result').empty();
              alert("error occur while processing");
            }
            $('#loading').hide();
          }
        });
      });
      $('#clear_form').click(function() {
        $('#frm_quick_price table input').val("");
        $('#quote-result').empty();
      });
    });
  }
}
