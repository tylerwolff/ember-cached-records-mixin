# A mixin for index pages that makes use of the data store's cache
# to show results immediately if available, before updating from server.
#
# Route requirements:
#
# modelType (string)       - Name of model used for ember data calls.

EmberCachedRecordsMixin = Ember.Mixin.create

  needsUpdate: false

  model: ->
    cached = @loadModelFromCache()

    if cached.get('length')
      @needsUpdate = true
      cached
    else
      @loadModel()

  loadModel: ->
    @store.find(@get('modelType')).then =>
      @loadModelFromCache()

  loadModelFromCache: ->
    @store.all(@get('modelType'))

  checkForUpdates: ->
    @loadModel().then (model) =>
      @controller.set('model', model)

  setupController: (controller, model) ->
    @_super(controller, model)
    @checkForUpdates() if @needsUpdate

  actions:
    refresh: ->
      @checkForUpdates()
