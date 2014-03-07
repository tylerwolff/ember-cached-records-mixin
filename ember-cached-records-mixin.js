(function() {
  var EmberCachedRecordsMixin;

  EmberCachedRecordsMixin = Ember.Mixin.create({
    needsUpdate: false,
    model: function() {
      var cached;
      cached = this.loadModelFromCache();
      if (cached.get('length')) {
        this.needsUpdate = true;
        return cached;
      } else {
        return this.loadModel();
      }
    },
    loadModel: function() {
      var _this = this;
      return this.store.find(this.get('modelType')).then(function() {
        return _this.loadModelFromCache();
      });
    },
    loadModelFromCache: function() {
      return this.store.all(this.get('modelType'));
    },
    checkForUpdates: function() {
      var _this = this;
      return this.loadModel().then(function(model) {
        return _this.controller.set('model', model);
      });
    },
    setupController: function(controller, model) {
      this._super(controller, model);
      if (this.needsUpdate) {
        return this.checkForUpdates();
      }
    },
    actions: {
      refresh: function() {
        return this.checkForUpdates();
      }
    }
  });

}).call(this);
