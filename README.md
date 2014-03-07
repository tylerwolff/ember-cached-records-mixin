Ember Cached Records Mixin
==========================
A mixin for Ember routes that makes smarter use of ember data's store when querying for multiple records.

Why use the mixin?
------------------
With Ember Data queries for single records resolve instantly when the record exists in the data store. However, queries for more than one record always require a call to the server before being resolved, even when some or all of the records may already exist in the data store. This mixin will always return what's in the data store first before querying the server for updates. Here are some more of the benefits:

  - Using this mixin will give your app a more snappy feel, especially on routes with lots of data.
  - Instant transitions. After the first initial load, the route will resolve instantly.
  - Any changes made locally will be reflected immediately everytime the route is visited (adding, deleting, or updating records).

Requirements for use
--------------------
- Ember Data v1.0 or above

How To Use It
-------------
Imagine you have a posts route on a blog. All you have to do to get this to work is to specify the name of the model used for Ember Data calls (ie: `this.store.find('post')`). Then the mixin will do the rest.

```javascript
App.PostsRoute = Ember.Route.extend(
  EmberCachedRecordsMixin, {

  modelType: 'post'
})
```
