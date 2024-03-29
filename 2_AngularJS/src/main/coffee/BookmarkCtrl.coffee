class @BookmarkCtrl
  constructor: (@$scope) ->
    @$scope.bookmarks = [
      {id: 1, name:"one Bookmark", url:"http://some-url.de", read: false}
      {id: 2, name:"one Bookmark", url:"http://some-url.de", read: false}
      {id: 3, name:"one Bookmark", url:"http://some-url.de", read: false}
      {id: 4, name:"one Bookmark", url:"http://some-url.de", read: false}
    ]
    @$scope.editBoxStyle = "display: none;"

    @$scope.onBookmarkReadClick = (bookmark) ->
      bookmark.read = !bookmark.read

    @$scope.getBookmarkReadClass = (bookmark) ->
      if bookmark.read
        "read"
      else
        "unread"
