# http://jashkenas.github.com/coffee-script/

class Bookmark
  @records = {}

  @reset : ->
    @records = {}

  @find : (id) ->
    @records[id] || throw "unknown record"

  constructor: (@id, @name, @url) ->
    @newRecord = true
  
  create : ->
    @newRecord = false
    Bookmark.records[@id] = this

  update : ->
    Bookmark.records[@id] = this

  save : ->
    if @newRecord 
      @create() 
    else
      @update()  

  destroy : ->
    delete Bookmark.records[@id]