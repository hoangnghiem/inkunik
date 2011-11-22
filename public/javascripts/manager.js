$(function() {
  $('.grid td').hover(function() {
    $(this).parent().children('td').addClass('hover');
  }, function() {
    $(this).parent().children('td').removeClass('hover');
  })
})
