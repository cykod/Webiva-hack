class Hack::PageRenderer < ParagraphRenderer

  features '/hack/page_feature'

  paragraph :rate, :ajax => true
  paragraph :view, :ajax => true
  paragraph :submit
  paragraph :list

  def rate
    @options = paragraph_options :rate

    session[:except] ||= []

    if ajax? && params[:hack_idea_id]
      @hack_idea = HackIdea.find(params[:hack_idea_id])
      @hack_idea.rate(myself,session[:domain_log_session][:id],params[:points].to_i > 0 ? 1 : -1)
      @hack_idea.reload

    else 
      @hack_idea = HackIdea.random_idea(session[:except])

      session[:except] = [] if !@hack_idea
      @hack_idea ||= HackIdea.random_idea(session[:except])

      session[:except] << @hack_idea.id if @hack_idea
    end

    @vote = HackVote.fetch(@hack_idea.id,myself,session[:domain_log_session] && session[:domain_log_session][:id])
  
    require_component_js
    render_paragraph :feature => :hack_page_rate
  end

  def view
    @options = paragraph_options :view

    conn_type, conn_id = page_connection 

    if ajax? && params[:hack_idea_id]
      @hack_idea = HackIdea.find(params[:hack_idea_id])
      @hack_idea.rate(myself,session[:domain_log_session][:id],params[:points].to_i > 0 ? 1 : -1)
      @hack_idea.reload
    else 
      @hack_idea = HackIdea.find_by_permalink(conn_id)
    end

    @hack_idea ||= HackIdea.first if editor?

    set_title(@hack_idea.title) if @hack_idea

    set_page_connection(:content_id, ['HackIdea',@hack_idea.id] ) if @hack_idea

    # Any instance variables will be sent in the data hash to the 
    # hack_page_rate_feature automatically
    #
    @vote = HackVote.fetch(@hack_idea.id,myself,session[:domain_log_session] && session[:domain_log_session][:id])
  
    require_component_js
    render_paragraph :feature => :hack_page_view
  end

  def submit
    @options = paragraph_options :submit

    @hack_idea = HackIdea.new()

    if request.post? && params[:hack_idea]
      @hack_idea.end_user_id = myself.id
      if @hack_idea.update_attributes(params[:hack_idea])
        @submitted = true
      end
    end
  
    require_component_js
    render_paragraph :feature => :hack_page_submit
  end

  def list
    @options = paragraph_options :list
    @hack_ideas = HackIdea.find(:all,:order => 'score DESC',:limit => 10)

    render_paragraph :feature => :hack_page_list
  end


  def require_component_js

    require_js("http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js")
    require_js('/components/hack/js/hack.js')
  end
end
