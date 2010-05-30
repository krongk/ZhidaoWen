class Log < ActiveRecord::Base
  def self.add(info)
    Log.create(:text=>info)
  end
end
