// Generated by CoffeeScript 1.6.3
(function() {
  var User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  User = (function(_super) {
    __extends(User, _super);

    function User(Epic, view_nm) {
      var ss;
      ss = User.__super__.constructor.call(this, Epic, view_nm);
    }

    User.prototype.action = function(act, p) {
      var debug;
      debug = "action:" + act;
      switch (act) {
        case "home":
          console.log(debug);
          return this.Table = {};
      }
    };

    User.prototype.loadTable = function(tbl_nm) {
      var debug;
      return debug = "loadTable:" + tbl_nm;
    };

    User.prototype.fistLoadData = function(oFist) {};

    User.prototype.fistGetFieldChoices = function(oFist, field_nm) {};

    return User;

  })(window.EpicMvc.ModelJS);

  window.EpicMvc.Model.User = User;

}).call(this);
