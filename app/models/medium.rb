class Medium < ActiveRecord::Base
  PILLARS 	  = %w(prayer faith healing consecration wisdom vision word_of_god praise success holy_spirit prosperity supernatural) 
  MEDIA_TYPES = %w(video audio sermon_note)

  # scope :pillar, -> { where("pillar = ?", :pillar) }

  validates :pillar, inclusion: { :in => PILLARS }
  validates  :media_type, inclusion: { :in => MEDIA_TYPES }, presence: true

  PILLARS.each do |pillar|
  	define_method "#{pillar}?" do 
  	  self.pillar == pillar
  	end
  end

  MEDIA_TYPES.each do |media_type|
  	define_method "#{media_type}" do 
  	  self.pillar == media_type
  	end
  end

  def self.search(query)
  	if query.present?
  	  where("name like :q", q: "%#{query}%")
  	else
  	  return self.all
  	end
  end

  def latest?
    if self == Medium.last
      return true
    end
  end

  def pillar_as_title
    pillar.upcase.gsub('_', ' ')
  end

  class << self
  	PILLARS.each do |pillar|
  	  define_method "#{pillar}" do 
  	    pillar
  	  end
  	end

  	MEDIA_TYPES.each do |media_type|
  	  define_method "#{media_type}" do
  	  	media_type
  	  end
  	end
  end
 
end
