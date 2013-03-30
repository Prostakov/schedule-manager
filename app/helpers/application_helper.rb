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

  def school_show_path school
    '/'+school.slug
  end

  def belongs_to_school? schedule
    return schedule.group.nil? ? false : true
  end

  def redirect_to_schedule schedule
    redirect_to belongs_to_school?(schedule) ? school_group_schedule_path(schedule.group.school, schedule.group, schedule) : schedule
  end
end
