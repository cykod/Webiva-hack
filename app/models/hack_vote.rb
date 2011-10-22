


class HackVote < DomainModel

  belongs_to :hack_idea

  after_save :update_hack_idea

  def self.fetch(hack_idea_id,end_user,domain_log_session_id) 


    vote = self.find(:first,:conditions => {
        :hack_idea_id => hack_idea_id,
        :end_user_id => end_user.id
    }) if end_user.id.present?

    vote ||= self.find(:first,:conditions => {
        :hack_idea_id => hack_idea_id,
        :domain_log_session_id => domain_log_session_id})


    vote ||= self.new(
        :hack_idea_id => hack_idea_id,
        :end_user_id => end_user.id,
        :domain_log_session_id => domain_log_session_id
    )

    vote


  end

  def self.submit(hack_idea_id,end_user,domain_log_session_id,source,value)
    vote = self.fetch(hack_idea_id,end_user,domain_log_session_id)

    vote.update_attributes(
      :source => source || 'site',
      :value => value
    )

    vote
  end

    def update_hack_idea
    self.hack_idea.recalculate!
  end
end
