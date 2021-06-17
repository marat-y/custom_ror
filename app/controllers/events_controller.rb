class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all.page(params[:page]).per(10)
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)

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
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :starttime, :endtime, :organizeremail, :organizertelegram, :link)
  end
end
