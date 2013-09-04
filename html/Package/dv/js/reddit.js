(function($){

  $.reddit = function(options, cb) {
    var posts = [], o = $.extend({}, $.reddit.defaults, options);

    $.getJSON(o.api + '/' + o.subreddit + '?json=get_posts&count=' + o.limit, function(result){
      $.each(result.posts, function(i, post){
        // Create an absolute permalink containing the api url.
        //post.data.permalink_absolute = o.api + post.data.permalink;

        // Append to posts array.
        posts.push(post.url);

        // Fire callback when finished parsing through posts.
        if ( i + 1 == result.count ) {
          cb.call(self, posts);
        }
      });
    });
  };

  $.reddit.defaults = {
    api: 'http://dv-mobile.com/site',
    subreddit: '',
    limit: 6
  };

})(jQuery);