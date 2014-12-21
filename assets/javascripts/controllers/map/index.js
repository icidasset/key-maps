K.MapIndexController = Ember.Controller.extend({
  fullWidthTypes: ["text"],


  structure_arrays: function() {
    var structure = JSON.parse(this.get("model.structure"));
    var fwt = this.get("fullWidthTypes");
    var full = [];
    var all = [];

    structure.forEach(function(s) {
      var l = all.length === 0 ? undefined : all[all.length - 1];

      if (fwt.contains(s.type)) {
        full.push(s);
      } else {
        if (l === undefined || l.length >= 2) {
          l = [];
          all.push(l);
        }

        l.push(s);
      }
    });

    return [all, [full]];
  }.property("model.structure"),


  actions: {

    add: function() {
      //
    },


    save: function() {
      //
    }

  }
});
