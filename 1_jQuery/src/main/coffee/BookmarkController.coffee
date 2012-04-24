class BookmarkController
  $ = null

  constructor : (jQuery) ->
    $ = jQuery

    # Views
    @header = $ '#header'
    @editBox = $ '#edit-box'
    @bookmarks = $ '#bookmarks'

    # Templates
    $.template("bookmark", $("#bookmarks .template").html())

    # Events
    $("form", @header).submit($.proxy(@onHeaderFormSubmit, this))
    $("form", @editBox).submit($.proxy(@onEditBoxFormSubmit, this))

    # Misc initialization
    $("input", @header).focus()

  onHeaderFormSubmit : (event) ->
    event.preventDefault()
    nameOrUrl = $(event.target.elements['search']).val()
    $(event.target.elements['search']).val("")
    @showAddItemForm nameOrUrl

  showAddItemForm : (nameOrUrl) ->
    @editBox.show()
    editForm = $('form', @editBox)
    if( @isUrl(nameOrUrl) )
      $(editForm[0].elements['url']).val(nameOrUrl)
      $(editForm[0].elements['name']).focus()
    else
      $(editForm[0].elements['url']).focus()
      $(editForm[0].elements['name']).val(nameOrUrl)

  onEditBoxFormSubmit : (event) ->
    event.preventDefault()
    editForm = $('form', @editBox)
    urlField = $(editForm[0].elements['url'])
    nameField = $(editForm[0].elements['name'])
    if (! @currentID )
      @currentID = 0
    Bookmark bookmark = new Bookmark(@currentID++, nameField.val(), urlField.val() )
    bookmark.save()
    $(editForm[0].elements['url']).val("")
    $(editForm[0].elements['name']).val("")
    @addBookmarkView(bookmark)

  addBookmarkView : (bookmark) ->
    newElement = $.tmpl("bookmark", [
      {name:bookmark.name, url:bookmark.url}
    ]);
    newElement.prependTo(@bookmarks)
    @editBox.hide()
    $("input", @header).focus()

  isUrl : (value) -> value.indexOf("http://") == 0