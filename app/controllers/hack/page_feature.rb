class Hack::PageFeature < ParagraphFeature

  feature :hack_page_rate, :default_feature => <<-FEATURE
      <cms:hack_idea>
      <h1><cms:title/></h1>
      <cms:description/>

      <cms:next_link>Next!</cms:next_link>
      <span id='uplink' class='<cms:up>selected</cms:up>'><cms:rate_up_link>Up</cms:rate_up_link></span>
      <span id='downlink' class='<cms:down>selected</cms:down>'><cms:rate_down_link>Down</cms:rate_down_link></span>
      </cms:hack_idea>
  FEATURE

  def hack_page_rate_feature(data)
    webiva_feature(:hack_page_rate,data) do |c|
      c.expansion_tag('hack_idea') { |t| t.locals.hack_idea = data[:hack_idea] } 
      hack_details(c,data)

      c.link_tag('hack_idea:next') do |t|
        { :href => 'javascript:void(0);',
          :onclick => "Hack.next('#cmspara_#{paragraph.id}','#{ajax_url}')"
        }
      end

      c.link_tag('hack_idea:rate_up') do |t|

        { :href => 'javascript:void(0);',
          :onclick => "Hack.rate_up(#{t.locals.hack_idea.id},this,'#{url_for :controller => '/hack/page', :action => 'rate_up'}');"
        }

      end

      c.link_tag('hack_idea:rate_down') do |t|

        { :href => 'javascript:void(0);',
          :onclick => "Hack.rate_down(#{t.locals.hack_idea.id},this,'#{url_for :controller => '/hack/page', :action => 'rate_down'}');"
        }

      end

      c.expansion_tag('hack_idea:up') { |t| data[:vote] && data[:vote].value.to_i > 0 }
      c.expansion_tag('hack_idea:down') { |t| data[:vote] && data[:vote].value.to_i < 0 }
    end
  end

  feature :hack_page_view, :default_feature => <<-FEATURE
      <cms:hack_idea>
      <h1><cms:title/></h1>
      <cms:description/>
      </cms:hack_idea>
  FEATURE

  def hack_page_view_feature(data)
    webiva_feature(:hack_page_view,data) do |c|
      c.expansion_tag('hack_idea') { |t| t.locals.hack_idea = data[:hack_idea] } 
      hack_details(c,data)


    end
  end

  def hack_details(c,data) 
    c.h_tag('hack_idea:title') { |t|t.locals.hack_idea.title }
    c.value_tag('hack_idea:description') { |t| simple_format(h(t.locals.hack_idea.description)) }
    
  end

  feature :hack_page_submit, :default_feature => <<-FEATURE
  <h1>Submit your idea</h1>

  <cms:hack_idea>
    <ol class='form'>
    <li><label>Title</label><cms:title/></li>
    <li><label>Description</label><cms:description/></li>
    <li><cms:submit/></li>
  </cms:hack_idea>
  <cms:submitted>
    Thank you, your idea has been submitted
  </cms:submitted>
  FEATURE

  def hack_page_submit_feature(data)
    webiva_feature(:hack_page_submit,data) do |c|
      c.form_for_tag('hack_idea','hack_idea') { |t| data[:submitted] ? nil : data[:hack_idea] }

      c.field_tag('hack_idea:title')
      c.field_tag('hack_idea:description', :control => :text_area)
      c.submit_tag('submit')

      c.expansion_tag('submitted') { |t| data[:submitted] }


    end
  end

end
