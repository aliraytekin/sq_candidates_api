class JobsController < ApplicationController
  def index
    @jobs = current_recruiter.jobs
  end

  def edit
  end

  def publish
  end

  def archive
  end

  def delete
  end
end
