(function() {
  var Wakmarks;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Wakmarks = (function() {

    __extends(Wakmarks, Batman.App);

    function Wakmarks() {
      Wakmarks.__super__.constructor.apply(this, arguments);
    }

    Wakmarks.global(true);

    Wakmarks.controller('app');

    Wakmarks.root('app#index');

    return Wakmarks;

  })();

}).call(this);
