class Api::V1::JobsController < ApplicationController
  before_action :set_job, only: %i[update destroy publish archive]

  def index
    @jobs = Job.all

    if params[:q].present?
      q = "%#{params[:q]}%"
      @jobs = @jobs.where("title ILIKE ? OR location ILIKE ?", q, q)
    end

    render json: @jobs
  end

  def create
    job = current_recruiter.jobs.build(job_params)
    if job.save
      render json: { job: job }, status: :created
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render json: { job: @job }
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    head :no_content
  end

  def publish
    @job.published!
    render json: { job: @job, status: "published" }
  end

  def archive
    @job.archived!
    render json: { job: @job, status: "archived" }
  end

  private

  def set_job
    @job = current_recruiter.jobs.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :category, :employment_type, :location, :posted_at, :status, :description)
  end
end
