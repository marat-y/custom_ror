class Admin::EventsController < Admin::BaseController
  load_and_authorize_resource
  before_action :set_event, only: %i[edit update destroy]

  def index
    @events = Event.all.page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: t('views.events.update.success')
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: t('views.events.destroy.success')
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :starttime, :endtime, :organizeremail, :organizertelegram, :link)
  end
end
