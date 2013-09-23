// Generated by CoffeeScript 1.6.2
(function() {
  var Activity,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Activity = (function(_super) {
    __extends(Activity, _super);

    function Activity(Epic, view_nm) {
      var ss;

      ss = {
        total_posts: 6
      };
      Activity.__super__.constructor.call(this, Epic, view_nm, ss);
      this.cache_activities = [];
    }

    Activity.prototype.action = function(act, p) {
      var debug;

      debug = "action:" + act;
      switch (act) {
        case "view_more":
          console.log(debug);
          total_posts += 6;
          return this.Table = {};
      }
    };

    Activity.prototype.loadTable = function(tbl_nm) {
      var debug, results;

      debug = "loadTable:" + tbl_nm;
      switch (tbl_nm) {
        case 'ActivityPost':
          results = this.getActivities();
          console.log(debug, results);
          return this.Table[tbl_nm] = results;
      }
    };

    Activity.prototype.getActivities = function() {
      var debug, options, results,
        _this = this;

      debug = "Activity.getActivities";
      console.log(debug, this.cache_activities);
      if (this.cache_activities.length) {
        return this.cache_activities;
      }
      results = [];
      options = {
        url: 'http://www.dv-mobile.com/site/?json=get_posts&count=6',
        type: 'GET',
        dataType: 'jsonp'
      };
      return ($.ajax(options)).always(function(data, textStatus, errorThrown) {
        var post, row, _i, _len, _ref;

        console.log(debug, 'success function:', data);
        _ref = data.posts;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          post = _ref[_i];
          row = {};
          row.title = post.title_plain;
          row.url = post.url;
          row.picture = '';
          if (post.attachments[0]) {
            row.picture = post.attachments[0].url;
          }
          console.log(debug, row);
          results.push(row);
        }
        _this.cache_activities = results;
        _this.invalidateTables(['ActivityPost']);
        return console.log('final table', results);
      });
    };

    return Activity;

  })(window.EpicMvc.ModelJS);

  window.EpicMvc.Model.Activity = Activity;

}).call(this);
