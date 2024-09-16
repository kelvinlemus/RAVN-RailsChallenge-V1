class TrainersController < ApplicationController
  PER_PAGE = 10
  before_action :set_trainer, only: [ :edit, :update, :destroy, :show ]

  def index
    authorize(User)

    page = params.fetch(:page, 1).to_i

    @trainers = policy_scope(User.all)
    @trainers = @trainers.by_name_or_email(params[:search]) if params[:search].present?

    @trainers = @trainers.page(page).per(PER_PAGE)
  end

  def show
    authorize(@trainer)
  end

  def edit
    authorize(@trainer)
  end

  def create
    @trainer = User.trainers.new(permitted_params)
    @trainer.skip_password_validation = true
    authorize(@trainer)

    if @trainer.save
      redirect_to trainers_path
    else
      render :new
    end
  end

  def update
    authorize(@trainer)
    @trainer.skip_password_validation = true

    if @trainer.update(permitted_params)
      redirect_to trainers_path
    else
      render :edit
    end
  end

  def destroy
    authorize(@trainer)

    @trainer.destroy

    redirect_to trainers_path
  end

  def new
    @trainer = User.trainers.new
    authorize(@trainer)
  end

  private

  def set_trainer
    @trainer = User.trainers.find(params[:id])
  end

  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, :country_id, pokemon_ids: [])
  end
end
