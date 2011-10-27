module Lokka
  module Disqus
    def self.registered(app)
      app.get '/admin/plugins/disqus' do
        haml :"plugin/lokka-disqus/views/index", :layout => :"admin/layout"
      end

      app.put '/admin/plugins/disqus' do
        Option.disqus_shortname = params['disqus_shortname']
        flash[:notice] = 'Updated.'
        redirect '/admin/plugins/disqus'
      end

      app.before do
        shortname = Option.disqus_shortname
        if !shortname.nil? && !shortname.empty?
          dev_mode = ENV['RACK_ENV'] == 'production' ? 0 : 1;

          Lokka::Helpers.send :define_method, :comment_form do
            haml :'plugin/lokka-disqus/views/comment_form', :layout => false,
              :locals => {:shortname => shortname, :dev_mode => dev_mode }
          end
          Lokka::Helpers.send :define_method, :comments_link do |id, link|
            %Q(<a href="#{link}#disqus_thread" data-disqus-identifier="#{id}">Comments</a>)
          end

          disqus_count_script =<<-JS
<script type="text/javascript">
  var disqus_shortname = '#{shortname}';
  var disqus_developer = #{dev_mode};
  (function () {
      var s = document.createElement('script'); s.async = true;
      s.type = 'text/javascript';
      s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
      (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
  }());
</script>
          JS
          unless entry?
            content_for :footer do
              disqus_count_script
            end
          end
        end
      end
    end
  end
end
