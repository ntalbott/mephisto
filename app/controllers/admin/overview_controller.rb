class Admin::OverviewController < Admin::BaseController
  session :off, :only => :feed
  before_filter :basic_auth_required, :only => :feed
  caches_page :feed
  
  helper Admin::ArticlesHelper
  
  def index
    @users = User.find(:all)
    @events, @todays_events, @yesterdays_events = [], [], []
    today, yesterday = Time.now.to_date, 1.day.ago.to_date
    Event.find(:all, :order => 'events.created_at DESC', :include => [:article, :user], :limit => 50).each do |event|
      case event.created_at.to_date
        when today     then @todays_events
        when yesterday then @yesterdays_events
        else                @events
      end << event
    end
  end

  def feed
    @events = Event.find(:all, :order => 'events.created_at DESC', :include => [:article, :user], :limit => 25)
    render :layout => false
  end
  
  def delete
    Event.find(params[:id]).destroy
    render :update do |page|
      page["event-#{params[:id]}"].visual_effect :drop_out
    end
  end
end
