require 'rails_helper'

RSpec.describe Label, type: :model do
    
    it { should belong_to :labelable }
    
end
