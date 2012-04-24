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
    if Bookmark.records[@id]
      throw "record already exists"
    Bookmark.records[@id] = this

  update : ->
    if !Bookmark.records[@id]
      throw "record not yet exists"
    Bookmark.records[@id] = this

  save : ->
    if @newRecord 
      @create() 
    else
      @update()  

  destroy : ->
    if !Bookmark.records[@id]
      throw "record not yet exists"
    delete Bookmark.records[@id]