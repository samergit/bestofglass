$(document).ready(function() {
  var time_left = $("#time_left").data('seconds');
  var slug = $(".auctimeleft").data('slug');
  var active = $("#auction_data").data('active');

  function grabTime() {
    jQuery.ajax({
      url: "/auctions/" + slug + "/auction_timer",
      type: "GET",
      dataType: "script"
      });
    active = $("#auction_data").data('active');
    time_left = $("#time_left").data('seconds');
    if (time_left <= 0 || active === false ){
      location.reload();
    }
  }
  
  if (time_left >= 0 ) {
      setInterval(grabTime, 1000);
  }
});