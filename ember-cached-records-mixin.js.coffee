# A mixin for index routes that makes use of ember data's store
# to return the route's model immediately if there are already records
# available in cache, before making a call to update from the server.
#
# Requirements for route:
#
# modelType (string) - Name of model used for ember data calls.

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
