// Generated by CoffeeScript 1.6.3
(function() {
  var Activity,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Activity = (function(_super) {
    __extends(Activity, _super);

    function Activity(Epic, view_nm) {
      var ss;
      ss = {
        total_posts: 10,
        active_post_url: false
      };
      Activity.__super__.constructor.call(this, Epic, view_nm, ss);
      this.cache_activities = [];
    }

    Activity.prototype.action = function(act, p) {
      var debug, i, m, r;
      debug = "action:" + act;
      console.log(debug, p);
      r = {};
      i = new window.EpicMvc.Issue(this.Epic, this.view_nm, act);
      m = new window.EpicMvc.Issue(this.Epic, this.view_nm, act);
      switch (act) {
        case "view_more":
          console.log(debug);
          total_posts += 6;
          this.Table = {};
          break;
        case "set_active_post_url":
          console.log(debug);
          this.active_post_url = p.url;
          this.invalidateTables(['ActivePostUrl']);
      }
      return [r, i, m];
    };

    Activity.prototype.loadTable = function(tbl_nm) {
      var debug, results, table;
      debug = "loadTable:" + tbl_nm;
      switch (tbl_nm) {
        case 'ActivityPost':
          results = this.getActivities();
          console.log(debug, results);
          return this.Table[tbl_nm] = results;
        case 'ActivePostUrl':
          table = [];
          table.push({
            url: this.active_post_url
          });
          return this.Table[tbl_nm] = table;
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
        url: 'http://www.dv-mobile.com/dev/?json=get_posts&count=10',
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
          if (post.thumbnail_images) {
            row.picture = post.thumbnail_images.full.url;
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
