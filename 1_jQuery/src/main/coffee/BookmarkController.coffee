class @BookmarkController
  $ = null
  KEYCODE_ENTER = 13
  KEYCODE_ESC = 27

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
    $(".cancel", @editBox).click($.proxy(@onEditBoxCancelClick, this))
    $("form input", @editBox).keydown($.proxy(@onEditFormInputKeyDown, this))
    @bookmarks.on("click", ".read", $.proxy(@onBookmarkReadClick, this));
    @bookmarks.on("click", ".unread", $.proxy(@onBookmarkReadClick, this));

    # Misc initialization
    $("input", @header).focus()

  onEditFormInputKeyDown : (event) ->
    if event.which == KEYCODE_ENTER || event.keyCode == KEYCODE_ENTER
      $(".apply", @editBox).click()
      false
    else if event.which == KEYCODE_ESC || event.keyCode == KEYCODE_ESC
      $(".cancel", @editBox).click()
      false
    else
      true

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

    # add the model ..
    if (! @currentID )
      @currentID = 0
    Bookmark bookmark = new Bookmark(@currentID++, nameField.val(), urlField.val() )
    bookmark.save()
    @closeEditBox()

    # .. and the view
    newElement = $.tmpl("bookmark", [
      {id:bookmark.id, name:bookmark.name, url:bookmark.url}
    ]);
    newElement.prependTo(@bookmarks)

  onEditBoxCancelClick : (event) ->
    event.preventDefault()
    @closeEditBox()

  closeEditBox : ->
    editForm = $('form', @editBox)
    $(editForm[0].elements['url']).val("")
    $(editForm[0].elements['name']).val("")
    @editBox.hide()
    $("input", @header).focus()

  isUrl : (value) -> value.indexOf("http://") == 0

  onBookmarkReadClick : (event) ->
    view = $(event.target).parents(".bookmark")

    # update the model ...
    bookmark = Bookmark.find(view.data('id'))
    bookmark.read = !bookmark.read
    bookmark.save()

    # ... and the view
    if(bookmark.read)
      $(event.target).addClass('read')
      $(event.target).removeClass('unread')
    else
      $(event.target).addClass('unread')
      $(event.target).removeClass('read')