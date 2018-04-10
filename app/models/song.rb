class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name
    self.try(:genre).try(:name)
  end

  def artist_name
    self.try(:artist).try(:name)
  end

  def genre_name=(gen)
    genre = Genre.find_or_create_by(name: gen)
    self.genre = genre
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def note_contents
    ans = self.notes.map do |note|
      note.content
    end
    return ans
  end

  def note_contents=(array)
    array.each do |content|
      if content != ""
        note = Note.find_or_create_by(content: content)
        self.notes << note
      end
    end
  end

end
