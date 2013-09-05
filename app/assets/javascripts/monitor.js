
var Monitor = function(options) {
  this.initialize = function(options) {
    var options = options || {};
    var f = function(options) {
      var callback = options.callback || function() {};
      $.get(options.url, 'data='+options.container, function(response) {
        $('#' + options.container).html(response);
        callback();
       });
    };
    f(options);
    var handle = setInterval(function() {
      f(options);
    }, options.interval || 10000);
  };
  this.initialize(options);
};

$(document).ready(function() {

  new Monitor({
    container: 'Flags',
    url: '/dashboard/flag_table',
    interval: 10000,
    callback: function() { init(); calc(); }
  });

  new Monitor({
    container: 'constellation',
    url: '/get_data?data=constellation',
    interval: 5000,
    //callback: function() { init(); calc(); }
  });

  new Monitor({ 
    container: 'Amenity',
    url: '/get_data',
    interval: 10000,     
    callback: function() {
      $('#Amenity tr:last').after('<tr><td><div class=eip><b>New Amenity</b></div></td></tr>'); 
      $('div.eip').click(function() {
        $.get('/dashboard/edit_in_place', '', function(response) {
          //console.log(this,response);
          $('div.eip').html(response);
          new EditInPlace(); //setup EIP
          $('div.eip').removeClass('eip');
        });
      }); 
    }
  });



//  $('#Amenity').hide();
//  $('#Property').hide();
//  $('#search').hide();



});
