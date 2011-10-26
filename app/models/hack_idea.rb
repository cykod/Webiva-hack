

class HackIdea < DomainModel

  before_save :generate_permalink
  has_many :hack_votes, :dependent => :destroy

  has_domain_file :image_id
  belongs_to :end_user

  validates_presence_of :title
  validates_presence_of :description

  has_options :weight, [[ "Unmoderated", 0], ["Show Often", 1 ], ["Show Rarely",-1], ["Show Never",-2 ]]
  
  def generate_permalink
    self.permalink = generate_url(:permalink,self.title.to_s.strip) if self.permalink.blank?
  end

  def self.random_idea(except = [])
    except = except.compact
    cnt = HackIdea.count(:all,:conditions => ['weight > -2'])
    if except.length == 0
      self.find(:first, :order=>'weight DESC',:conditions => ['weight > -2' ], :offset => rand(cnt))
    else
      self.find(:first,:conditions => [ "weight > -2 AND id NOT in (?)", except ], :offset => rand(cnt - except.length), :order => 'weight DESC' )
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

  def moderate_up
    self.update_attribute(:weight,1)
  end

  def moderate_down
    self.update_attribute(:weight,-1)
  end

  def moderate_hide
    self.update_attribute(:weight,-2)
  end
  

end
