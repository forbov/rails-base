# frozen_string_literal: true

class HelpPagesController < ApplicationController
  before_action :set_help_page, only: %i[show edit update destroy]

  # GET /help_pages or /help_pages.json
  def index
    @help_pages = if current_user.admin?
                    HelpPage.all
    else
                    HelpPage.where(active: 1)
                            .order(:page_order)
    end
  end

  # GET /help_pages/1 or /help_pages/1.json
  def show; end

  # GET /help_pages/new
  def new
    @help_page = HelpPage.new
  end

  # GET /help_pages/1/edit
  def edit; end

  # POST /help_pages or /help_pages.json
  def create
    @help_page = HelpPage.new(help_page_params)

    respond_to do |format|
      if @help_page.save
        format.html { redirect_to help_page_url(@help_page), notice: "Help page was successfully created." }
        format.json { render :show, status: :created, location: @help_page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @help_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /help_pages/1 or /help_pages/1.json
  def update
    respond_to do |format|
      if @help_page.update(help_page_params)
        format.html { redirect_to help_page_url(@help_page), notice: "Help page was successfully updated." }
        format.json { render :show, status: :ok, location: @help_page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @help_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /help_pages/1 or /help_pages/1.json
  def destroy
    @help_page.destroy!

    respond_to do |format|
      format.html { redirect_to help_pages_url, notice: "Help page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_help_page
    @help_page = HelpPage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def help_page_params
    params.require(:help_page).permit(:title, :page_order, :active, :details)
  end
end
