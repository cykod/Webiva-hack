
class Hack::AdminController < ModuleController

  component_info 'Hack', :description => 'Hack support', 
                              :access => :public
                              
  # Register a handler feature
  register_permission_category :hack, "Hack" ,"Permissions related to Hack"
  
  register_permissions :hack, [ [ :manage, 'Manage Hack', 'Manage Hack' ],
                                  [ :config, 'Configure Hack', 'Configure Hack' ]
                                  ]

  content_model :hack_ideas


  cms_admin_paths "options",
     "Hack Options" => { :action => 'index' },
     "Options" => { :controller => '/options' },
     "Modules" => { :controller => '/modules' }

  permit 'hack_config'

  public 
  def self.get_hack_ideas_info
    [{ :name => 'Hack Ideas', :url => { :controller => '/hack/manage', :action => 'index' }, :permission => :hack_manage }
     ]
  end


  def options
    cms_page_path ['Options','Modules'],"Hack Options"
    
    @options = self.class.module_options(params[:options])
    
    if request.post? && @options.valid?
      Configuration.set_config_model(@options)
      flash[:notice] = "Updated Hack module options".t 
      redirect_to :controller => '/modules'
      return
    end    
  
  end
  
  def self.module_options(vals=nil)
    Configuration.get_config_model(Options,vals)
  end
  
  class Options < HashModel
   # Options attributes 
   # attributes :attribute_name => value
  
  end

end
