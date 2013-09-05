


var bits = function(n) {
/*
  var flags = $.map(new Array(window.amenity_count), function(i, k) { return Math.pow(2, window.amenity_count - k) }),
      b = [], 
      n_dup = n; 
  for(i = 0; i<flags.length; i++) {
    var flag = flags[i];
    if((n_dup | flag) == n_dup) {
      b.push('1');
      n_dup -= flag;
    } else {
      b.push('0');
    }
  }
  return b.reverse().join('');
*/
  return n;
};


var callback = function(pid, flags) {
  $.get('/dashboard/update', 'pid='+pid+'&flags='+flags.toString(), function(response) {
      container = 'Property';
      $.get('/get_data', 'data='+container, function(response) {
        $('#' + container).html(response);
      });

      //how an Overview would appear
      $('#List').html([pid, ul(list(flags)), pretty_url(flags)].join('<br>'));
  });
};


var calc = function() {
  $('tr.flags').each(function(i, row) {
      //var flags = 0;
    
      var flags = new bigInt(0);
      $(this).find('td.bit input[type=checkbox]').each(function(j, checkbox) {
        //if(checkbox.checked) flags |= (1<<j); 
        //if(checkbox.checked) flags += (Math.pow(2, j)); 
        if(checkbox.checked) flags = flags.add(new bigInt(2).pow(j))
      });
      $(this).find('td.result').html(bits(flags.toString()));
  });
}

var init = function() {
  $('input[type=checkbox]', 'tr.flags').change(function(){
     var parent = $(this).closest('tr.flags'),
     bitArr = [],
     binary = '',
     flags = new bigInt(0);
     parent.find('td.bit input[type=checkbox]').each(function(i, obj){
       //if(obj.checked) flags |= (1<<i)
       // if(obj.checked) flags += (Math.pow(2, i)); 
        if(obj.checked) flags = flags.add(new bigInt(2).pow(i));
     });
     parent.find('td.result').html(bits(flags.toString()));
     var pid = parent.find('td.pid').html();
     callback(pid, flags);
  });

};

var list = function(flags) {
  var amenities = $('#Amenity').find('td').map(function(i, e) { 
    return $(this).text(); 
  }), list = [];
  amenities.each(function(i, amenitiy) {
    //if((flags | (1<<i)) == flags) list.push(amenitiy);
    //if((flags + (Math.pow(2, i))) == flags) list.push(amenitiy);
    if((flags.add(new bigInt(2).pow(i))).equals(flags)) list.push(amenitiy);
  });
  return list;
}

var ul = function(a) {
  return ['<ul class=amenities>', 
          a.map(function(e, i) { return ['<li>', e, '</li>'].join('') }).join(''),
          '</ul>'].join('');
}


$(document).ready(function() {
  document.filters = []
  setTimeout(function() {
    init();
    window.amenity_count = $('#Amenity tr').length - 3;
  }, 500);

  //$('.amenity').find('input[type=checkbox]')
  
});



