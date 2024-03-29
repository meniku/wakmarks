// Generated by CoffeeScript 1.3.1
(function() {

  this.BookmarkController = (function() {
    var $, KEYCODE_ENTER, KEYCODE_ESC;

    BookmarkController.name = 'BookmarkController';

    $ = null;

    KEYCODE_ENTER = 13;

    KEYCODE_ESC = 27;

    function BookmarkController(jQuery) {
      $ = jQuery;
      this.header = $('#header');
      this.editBox = $('#edit-box');
      this.bookmarks = $('#bookmarks');
      $.template("bookmark", $("#bookmarks .template").html());
      $("form", this.header).submit($.proxy(this.onHeaderFormSubmit, this));
      $("form input", this.header).keydown($.proxy(this.onHeaderFormKeyDown, this));
      $("form", this.editBox).submit($.proxy(this.onEditBoxFormSubmit, this));
      $(".cancel", this.editBox).click($.proxy(this.onEditBoxCancelClick, this));
      $("form input", this.editBox).keydown($.proxy(this.onEditFormInputKeyDown, this));
      this.bookmarks.on("click", ".read", $.proxy(this.onBookmarkReadClick, this));
      this.bookmarks.on("click", ".unread", $.proxy(this.onBookmarkReadClick, this));
      this.bookmarks.on("click", ".remove", $.proxy(this.onBookmarkRemoveClick, this));
      $("input", this.header).focus();
    }

    BookmarkController.prototype.onHeaderFormKeyDown = function(event) {
      return setTimeout(function() {
        var bookmark, value, _i, _len, _ref, _results;
        value = $(event.currentTarget).val();
        _ref = Bookmark.all();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          bookmark = _ref[_i];
          if (bookmark.name.indexOf(value) > -1 || bookmark.url.indexOf(value) > -1) {
            _results.push($("[data-id=" + bookmark.id + "]", this.bookmarks).show());
          } else {
            _results.push($("[data-id=" + bookmark.id + "]", this.bookmarks).hide());
          }
        }
        return _results;
      }, 0);
    };

    BookmarkController.prototype.onEditFormInputKeyDown = function(event) {
      if (event.which === KEYCODE_ENTER || event.keyCode === KEYCODE_ENTER) {
        $(".apply", this.editBox).click();
        return false;
      } else if (event.which === KEYCODE_ESC || event.keyCode === KEYCODE_ESC) {
        $(".cancel", this.editBox).click();
        return false;
      } else {
        return true;
      }
    };

    BookmarkController.prototype.onHeaderFormSubmit = function(event) {
      var nameOrUrl;
      event.preventDefault();
      nameOrUrl = $(event.target.elements['search']).val();
      $(event.target.elements['search']).val("");
      return this.showAddItemForm(nameOrUrl);
    };

    BookmarkController.prototype.showAddItemForm = function(nameOrUrl) {
      var editForm;
      this.editBox.show();
      editForm = $('form', this.editBox);
      if (this.isUrl(nameOrUrl)) {
        $(editForm[0].elements['url']).val(nameOrUrl);
        return $(editForm[0].elements['name']).focus();
      } else {
        $(editForm[0].elements['url']).focus();
        return $(editForm[0].elements['name']).val(nameOrUrl);
      }
    };

    BookmarkController.prototype.onEditBoxFormSubmit = function(event) {
      var bookmark, editForm, nameField, newElement, urlField;
      event.preventDefault();
      editForm = $('form', this.editBox);
      urlField = $(editForm[0].elements['url']);
      nameField = $(editForm[0].elements['name']);
      if (!this.currentID) {
        this.currentID = 0;
      }
      Bookmark(bookmark = new Bookmark(this.currentID++, nameField.val(), urlField.val()));
      bookmark.save();
      this.closeEditBox();
      newElement = $.tmpl("bookmark", [
        {
          id: bookmark.id,
          name: bookmark.name,
          url: bookmark.url
        }
      ]);
      return newElement.prependTo(this.bookmarks);
    };

    BookmarkController.prototype.onEditBoxCancelClick = function(event) {
      event.preventDefault();
      return this.closeEditBox();
    };

    BookmarkController.prototype.closeEditBox = function() {
      var editForm;
      editForm = $('form', this.editBox);
      $(editForm[0].elements['url']).val("");
      $(editForm[0].elements['name']).val("");
      this.editBox.hide();
      return $("input", this.header).focus();
    };

    BookmarkController.prototype.isUrl = function(value) {
      return value.indexOf("http://") === 0;
    };

    BookmarkController.prototype.onBookmarkReadClick = function(event) {
      var bookmark, view;
      view = $(event.target).parents(".bookmark");
      bookmark = Bookmark.find(view.data('id'));
      bookmark.read = !bookmark.read;
      bookmark.save();
      if (bookmark.read) {
        $(event.target).addClass('read');
        return $(event.target).removeClass('unread');
      } else {
        $(event.target).addClass('unread');
        return $(event.target).removeClass('read');
      }
    };

    BookmarkController.prototype.onBookmarkRemoveClick = function(event) {
      var bookmark, view;
      view = $(event.target).parents(".bookmark");
      bookmark = Bookmark.find(view.data('id'));
      bookmark.destroy();
      return view.remove();
    };

    return BookmarkController;

  })();

}).call(this);
