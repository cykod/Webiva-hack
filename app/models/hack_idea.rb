

class HackIdea < DomainModel

  before_save :generate_permalink
  has_many :hack_votes 

  has_domain_file :image_id

  def generate_permalink
    self.permalink = generate_url(:permalink,self.title.to_s.strip)
  end

  def self.random_idea(except = [])
    except = except.compact
    cnt = HackIdea.count
    if except.length == 0
      self.find(:first, :offset => rand(cnt))
    else
      self.find(:first,:conditions => [ "id NOT in (?)", except ], :offset => rand(cnt - except.length))
    end
  end

  def rate(user,domain_log_session_id,points,source='site')
     HackVote.submit(self.id,user,domain_log_session_id,source,points)
  end

  def recalculate!
    self.update_attributes(
      :votes => self.hack_votes.count,
      :score => self.hack_votes.sum(:value)

    )
  end
  

end
