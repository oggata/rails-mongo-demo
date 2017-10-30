class Word
  include Mongoid::Document
  field :text, type: String

  def self.getWordCount()
    @wordcount = Word.count()
    return @wordcount
  end

end
