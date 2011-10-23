
class Hack::ManageController < ModuleController

  component_info 'Hack'

  permit 'manage_manage'

  cms_admin_paths 'content', 
                  'Hack Ideas' => { :action => 'index' }
  


  active_table :hack_idea_table,
                HackIdea,
                [ :check,
                  :check,
                  :title,
                  :score,
                  :votes,
                  "User",
                  :permalink,
                  :created_at,
                  hdr(:options,:weight, :options =>  HackIdea.weight_select_options ),
                  :category
                ]

    public


  def display_hack_idea_table(display=true)
    active_table_action 'hack_idea' do |act,ids|
      case act
      when 'delete'
        HackIdea.destroy ids
      when 'up'
        HackIdea.find(ids).map(&:moderate_up)
      when 'down'
        HackIdea.find(ids).map(&:moderate_down)
      when 'hide'
        HackIdea.find(ids).map(&:moderate_hide)
      end
    end

    @tbl = hack_idea_table_generate params, :order => 'created_at DESC'

    render :partial => 'hack_idea_table' if display
  end


  def index
    cms_page_path ['Content'], 'Hack Ideas'
    display_hack_idea_table(false)
  end

 
  def edit
    @idea = HackIdea.find_by_id(params[:path][0]) || HackIdea.new
    cms_page_path ['Content', 'Hack Ideas'], @idea.id ? 'Edit Idea' : 'Create Idea'

    if request.post? 
      if params[:commit] && @idea.update_attributes(params[:hack_idea])
        flash[:notice] = "Idea Saved"
        redirect_to :action => 'index'
      else
        redirect_to :action => 'index'
      end
    end

  end

end
