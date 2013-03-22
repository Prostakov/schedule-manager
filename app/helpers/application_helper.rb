module ApplicationHelper

  def respond_obj obj
    respond_to do |format|
      format.html { redirect_to obj }
      format.json { render json: obj.to_json }
    end
  end

  def respond_obj_error obj
    respond_to do |format|
      format.html { redirect_to obj }
      format.json { render json: 'Error'.to_json }
    end		
  end
  
  def link_to_school(name, school, args=nil)
    link_to name, '/'+school.slug, args
  end

  def link_to_school_edit(name, school, args=nil)
  	link_to name, '/'+school.slug+'/edit', args
  end
end
