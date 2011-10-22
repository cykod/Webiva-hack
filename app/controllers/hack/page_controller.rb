class Hack::PageController < ParagraphController

  editor_header 'Hack Paragraphs'
  
  editor_for :rate, :name => "Rate", :feature => :hack_page_rate
  editor_for :view, :name => "View", :feature => :hack_page_view, :inputs => [ [ :view, "url", :path ]],
      :outputs => [[:content_id, 'Content Identifier', :content]]

  editor_for :submit, :name => "Submit", :feature => :hack_page_submit

 editor_for :list, :name => 'List', :feature => :hack_page_list, :no_options => true

  user_actions :rate_up, :rate_down,:track

  class RateOptions < HashModel
    # Paragraph Options
    # attributes :success_page_id => nil

    options_form(
                 # fld(:success_page_id, :page_selector) # <attribute>, <form element>, <options>
                 )
  end

  class ViewOptions < HashModel
    # Paragraph Options
    # attributes :success_page_id => nil

    options_form(
                 # fld(:success_page_id, :page_selector) # <attribute>, <form element>, <options>
                 )
  end

  class SubmitOptions < HashModel
    # Paragraph Options
    # attributes :success_page_id => nil

    options_form(
                 # fld(:success_page_id, :page_selector) # <attribute>, <form element>, <options>
                 )
  end

  def rate_up
    HackIdea.find(params[:hack_idea_id]).rate(myself,session[:domain_log_session][:id],1)
    render :nothing => true
  end


  def rate_down
    HackIdea.find(params[:hack_idea_id]).rate(myself,session[:domain_log_session][:id],-1)
    
    render :nothing => true
  end

  def track
    HackIdea.find(params[:hack_idea_id]).track(myself,session[:domain_log_session][:id])
    
    render :nothing => true

  end

end
