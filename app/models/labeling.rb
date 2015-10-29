class Labeling < ActiveRecord::Base
    
   belongs_to :labelable, polymorphic: true
    
end