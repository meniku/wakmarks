
class Wakmarks.Bookmark extends Batman.Model
  @global yes # global exposes this class on the global object, so you can access `Todo` directly.

  @persist Batman.LocalStorage
  @encode 'read', 'url', 'text'

  read: false
  url: ""
  text: ""

class Wakmarks.AppController extends Batman.Controller
  index: ->

    Bookmark.load (error, bookmarks) ->
      throw error if error
      unless bookmarks and bookmarks.length
        callback = (error) -> throw error if error
        new Bookmark(read: true, name: "some bookmark", url: "http://some-url").save(callback)

     # prevent the implicit render of views/todos/index.html
     # @render false

  readClicked: (node, event) ->
    console.log("blubb")

  # Add actions to this controller by defining functions on it.
  #
  # show: (params) ->

  # Routes can optionally be declared inline with the callback on the controller:
  #
  # edit: @route('/batman_app/:id', (params) -> ... )

  # Add functions to run before an action with
  #
  # @beforeFilter 'someFunctionKey'  # or
  # @beforeFilter -> ...

