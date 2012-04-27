class Wakmarks.Bookmark extends Batman.Model
  @global yes # global exposes this class on the global object, so you can access `Todo` directly.

  @persist Batman.LocalStorage
  @encode 'read', 'url', 'text'

  read: false
  url: ""
  text: ""