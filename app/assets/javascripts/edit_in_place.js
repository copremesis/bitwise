
var EditInPlace = function() {

  this.reset = function(s) {
    $('div.insert').html( s || "<span class=placeholderValue>New Amenity</span>");
  };

  this.create = function(value) {
      var that = this; 
      $('#debug').html(value);
      $.ajax({
          type: 'POST',
          url: 'dashboard/push',
          data: { amenity: value },
          success: function(response) {
            //that.reset();
            console.log(response);
          } 
      });
  };

  this.init = function() {

    this.reset();
    var that = this;
/*
    $('div.insert').click(function() { $(this).html(''); })
                   .keyup(function(e) {e.stopPropagation(); console.log(e.keyCode); if(e.keyCode == 13) that.create(); })
                   //.size.blur(function() { that.create(); });
*/
    $('input.foo').keyup(function(e) { 
      e.stopImmediatePropagation();
      if(e.keyCode == 13) {
        that.create(this.value); 
        this.value = ''; 
      }     
    });
  };
  
  this.init();
};

