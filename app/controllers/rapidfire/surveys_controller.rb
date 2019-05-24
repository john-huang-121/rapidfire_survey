module Rapidfire
  class SurveysController < Rapidfire::ApplicationController
    if Rails::VERSION::MAJOR == 5
      before_action :authenticate_administrator!, except: :index
    else
      before_filter :authenticate_administrator!, except: :index
    end

    def index
      @surveys = if defined?(Kaminari)
        Survey.page(params[:page])
      else
        Survey.all
      end
    end

    def new
      @survey = Survey.new
    end

    def create
      @survey = Survey.new(survey_params)

      if @survey.save
        respond_to do |format|
          format.html { redirect_to surveys_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.js
        end
      end
    end

    def edit
      @survey = Survey.find(params[:id])
    end

    def update
      @survey = Survey.find(params[:id])
      if @survey.update(survey_params)
        respond_to do |format|
          format.html { redirect_to surveys_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.js
        end
      end
    end

    def destroy
      @survey = Survey.find(params[:id])
      @survey.destroy

      respond_to do |format|
        format.html { redirect_to surveys_path }
        format.js
      end
    end

    def results
      @survey = Survey.find(params[:id])
      @survey_results =
        SurveyResults.new(survey: @survey).extract

      respond_to do |format|
        format.json { render json: @survey_results, root: false }
        format.html
        format.js
      end
    end

    private

    def survey_params
      if Rails::VERSION::MAJOR >= 4
        params.require(:survey).permit(:name, :description, :after_survey_content)
      else
        params[:survey]
      end
    end
  end
end
