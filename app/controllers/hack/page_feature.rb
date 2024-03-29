class Hack::PageFeature < ParagraphFeature

  feature :hack_page_rate, :default_feature => <<-FEATURE
      <cms:hack_idea>
      <h1><cms:title/></h1>
      <cms:description/>

      <cms:next_link>Next!</cms:next_link>
      <span id='uplink' class='<cms:up>selected</cms:up>'><cms:rate_up_link>Up</cms:rate_up_link></span>
      <span id='downlink' class='<cms:down>selected</cms:down>'><cms:rate_down_link>Down</cms:rate_down_link></span>
      <cms:url/>
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

    end
  end

  feature :hack_page_view, :default_feature => <<-FEATURE
      <cms:hack_idea>
      <h1><cms:title/></h1>
      <cms:description/>
      <cms:url/>
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
    c.value_tag('hack_idea:desc_short') { |t| h(truncate(t.locals.hack_idea.description, :length => (t.attr['length'] || 200).to_i)) }
    
    c.expansion_tag('hack_idea:details') { |t| t.locals.hack_idea.description.length > (t.attr['length'] || 200).to_i }
    

      c.image_tag('hack_idea:image') { |t| t.locals.hack_idea.image }
      c.value_tag('hack_idea:votes') { |t| t.locals.hack_idea.votes }
      c.value_tag('hack_idea:score') { |t| t.locals.hack_idea.score }

      c.link_tag('hack_idea:') { |t| Configuration.link("#{data[:options].hack_page_url}/#{t.locals.hack_idea.permalink}") }


      c.link_tag('hack_idea:rate_up') do |t|

        { :href => 'javascript:void(0);',
          :onclick => "Hack.rate_up('#cmspara_#{paragraph.id}',#{t.locals.hack_idea.id},'#{ajax_url}');"
        }

      end

      c.link_tag('hack_idea:rate_down') do |t|

        { :href => 'javascript:void(0);',
          :onclick => "Hack.rate_down('#cmspara_#{paragraph.id}',#{t.locals.hack_idea.id},'#{ajax_url}');"
        }

      end

      c.expansion_tag('hack_idea:voted') { |t| data[:vote] && data[:vote].value.to_i != 0 }


      c.expansion_tag('hack_idea:up') { |t| data[:vote] && data[:vote].value.to_i > 0 }
      c.expansion_tag('hack_idea:down') { |t| data[:vote] && data[:vote].value.to_i < 0 }

  end

  feature :hack_page_submit, :default_feature => <<-FEATURE
  <h1>Submit your idea</h1>

  <cms:hack_idea>
    <ol class='form'>
    <li><label>Title</label><cms:title/></li>
    <li><label>Description</label><cms:description/></li>
    <li><label>Category (Optional)</label><cms:category/></li>
    <li><label>Email (Optional)</label><cms:email/></li>
    <li><label>Image (Optional)</label><cms:image_id/></li>
    <li><cms:submit/></li>
  </cms:hack_idea>
  <cms:submitted>
    Thank you, your idea has been submitted
  </cms:submitted>
  FEATURE

  def hack_page_submit_feature(data)
    webiva_feature(:hack_page_submit,data) do |c|
      c.form_for_tag('hack_idea','hack_idea', :html => { :method => 'post', :enctype => 'multipart/form-data' }) { |t| data[:submitted] ? nil : data[:hack_idea] }

      c.field_tag('hack_idea:title')
      c.field_tag('hack_idea:description', :control => :text_area)
      c.field_tag('hack_idea:email')
      c.field_tag('hack_idea:category')
      c.submit_tag('submit')
      c.field_tag('hack_idea:image_id',:control => 'upload_image')
      c.expansion_tag('submitted') { |t| data[:submitted] }


    end
  end

  feature :hack_page_list , :default_feature => <<-FEATURE
      <ul>
      <cms:hack_idea>
      <li><cms:link><cms:title/></cms:link></li>
      </cms:hack_idea>
      </ul>
  FEATURE

  def hack_page_list_feature(data)
    webiva_feature(:hack_page_list,data) do |c|
      c.loop_tag('hack_idea') { |t| data[:hack_ideas] }
      hack_details(c,data)
    end
  end

end
