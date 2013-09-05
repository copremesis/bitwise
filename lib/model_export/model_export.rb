module ModelExport

  #override defaults
  #updates to model and export to cached source
  #all methods are the same some metaprogramming goes here
  #instance methods

  %w(save destroy delete).each {|method|
    define_method(method) {
      res = super() 
      export('html', self.class.name, self.class, self.class.column_names.reject {|x| %w(id created_at updated_at).include?(x) })
      res
    }
  }

  private

  def export(type, path, model, fields)
    case type
    when /html/i
      markup = build_table(model, fields)
      #File.open(path, 'w') {|fd| fd.puts markup } rescue nil
      Rails.cache.write(path, markup);
    else
    end
  end

  def build_table(model, fields)  #should be a mixin
    html = ['<table class="table" cellspacing="0">']
    html << '<tr>' + fields.map{|field| "<th>" + field + "</th>"}.join('') + '</tr>'
    model.all.each {|row|
      html << '<tr>' +fields.map{|field| '<td>' + row.send(field).to_s + '</td>' }.join('') + '</tr>'
    }
    html << '</table>'
    return html.join("")
  end

end
