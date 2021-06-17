class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  load_and_authorize_resource
  before_action :set_event, only: %i[edit update destroy]

  def index
    @events = Event.all.page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.new
  end

  def edit; end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to @event, notice: t('views.events.create.success')
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t('views.events.update.success')
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: t('views.events.destroy.success')
  end

  private

  def set_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :starttime, :endtime, :organizeremail, :organizertelegram, :link)
  end
end
