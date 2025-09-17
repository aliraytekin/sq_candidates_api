class Api::V1::JobsController < ApplicationController
  before_action :set_job, only: %i[update destroy publish archive]

  def index
    where = {}

    query = params[:q].presence || "*"

    if params[:min_exp].present? || params[:max_exp].present?
      rng = {}

      rng[:gte] = params[:min_exp] if params[:min_exp].present?

      rng[:lte] = params[:max_exp] if params[:max_exp].present?

      where[:min_experience] = rng
    end

    if params[:min_salary].present?
      where[:max_salary] = { gte: params[:min_salary].to_i }
    end

    if params[:max_salary].present?
      where[:min_salary] = { lte: params[:max_salary].to_i }
    end

    results = Job.search(
      query,
      where: where,
      order: { category: :asc },
      fields: ["title^3", "category^2", "location^2", "years_exp^2", "salary^2", "employment_type"],
      match: :word_start,
      misspellings: { below: 3 }
    )

    render json: {
      jobs: results.map { |j| j.as_json(only: %i[id title location min_experience max_experience min_salary max_salary
                                                status employment_type category]) }
    }
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
    params.require(:job).permit(:title, :category, :employment_type, :location, :status, :description,
                                :min_salary, :max_salary, :min_experience, :max_experience, :posted_at)
  end
end
