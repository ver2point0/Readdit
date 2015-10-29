class Label < ActiveRecord::Base
    
    has_many :labelings
    
    belongs_to :labelable, polymorphic: true
    
    has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
    
    has_many :post, through: :labelings, source: :labelable, source_type: :Post
    
end