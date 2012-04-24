describe "Bookmark", ->

  beforeEach ->
    Bookmark.reset()

  it "should have empty records", ->
    expect(Bookmark.records).toEqual({})

  describe "new instance", ->
    bookmark = null

    beforeEach ->
      bookmark = new Bookmark(1, "My first Bookmark", "http://google.de")

    it "should have correct id", ->
      expect(bookmark.id).toEqual(1)

    it "should have correct name", ->
      expect(bookmark.name).toEqual("My first Bookmark")

    it "should have correct URL", ->
      expect(bookmark.url).toEqual("http://google.de")

    it "should not be contained in records", ->
      expect(Bookmark.records).toEqual({})

    it "should be a new record", ->
      expect(bookmark.newRecord).toEqual(true)

    it "should not be a new record", ->
      bookmark.create()
      expect(bookmark.newRecord).toEqual(false)

    it "should be contained in records", ->
      bookmark.create()
      expect(Bookmark.records).toEqual({1 : bookmark})

    it "should not be a new record", ->
      bookmark.save()
      expect(bookmark.newRecord).toEqual(false)

    it "should be contained in records", ->
      bookmark.save()
      expect(Bookmark.records).toEqual({1 : bookmark})

    it "should not be contained in records", ->
      bookmark.create()
      bookmark.destroy()
      expect(Bookmark.records).toEqual({})

    it "should not create twice", ->
      bookmark.create()
      expect(-> bookmark.create()).toThrow("record already exists")

    it "should not destroy twice", ->
      bookmark.create()
      bookmark.destroy()
      expect(-> bookmark.destroy()).toThrow("record not yet exists")

    it "should not update", ->
      bookmark.create()
      bookmark.destroy()
      expect(-> bookmark.update()).toThrow("record not yet exists")

  describe "multiple instances", ->
    bookmark1 = null
    bookmark2 = null
    bookmark3 = null

    beforeEach ->
      bookmark1 = new Bookmark(1, "My first Bookmark", "http://google.de")
      bookmark1.save()
      bookmark2 = new Bookmark(2, "My second Bookmark", "http://google.de")
      bookmark2.save()
      bookmark3 = new Bookmark(3, "My third Bookmark", "http://google.de")
      bookmark3.save()

    it "should find nothing", ->
      expect(-> Bookmark.find(4)).toThrow("unknown record")

    it "should find bookmark 2", ->
      expect(Bookmark.find(2)).toEqual(bookmark2)

    it "should contain all instances", ->
      expect()