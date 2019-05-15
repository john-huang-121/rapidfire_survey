module Rapidfire
  class AttemptsController < Rapidfire::ApplicationController
    if Rails::VERSION::MAJOR ==  5
      before_action :find_survey!
    else
      before_filter :find_survey!
    end

    def show
      @attempt = @survey.attempts.find_by(attempt_params_for_find)
    end

    def new
      @attempt_builder = AttemptBuilder.new(attempt_params)
    end

    def create
      checkbox_fix()
      @attempt_builder = AttemptBuilder.new(attempt_params)
      if @attempt_builder.save
        redirect_to after_answer_path_for
      else
        render :new
      end
    end

    def edit
      @attempt_builder = AttemptBuilder.new(attempt_params)
    end

    def update
      @attempt_builder = AttemptBuilder.new(attempt_params)

      if @attempt_builder.save
        redirect_to surveys_path
      else
        render :edit
      end
    end

    private

    # this fixes the checkbox bug, intercept faulty solution and cleans it up in controller
    def checkbox_fix
      # this assumes checkbox answers are not strings
      if params[:attempt].values[0]["answer_text"].class != String
        params[:attempt].values[0]["answer_text"] = 
          params[:attempt].values[0]["answer_text"].values.reject {|value| value == "0"}
      else
        nil
      end
    end

    def find_survey!
      @survey = Survey.find(params[:survey_id])
    end

    def attempt_params
      answer_params = { params: (params[:attempt] || {}) }
      answer_params.merge(user: current_user, survey: @survey, attempt_id: params[:id])
    end

    def attempt_params_for_find
      these_params = attempt_params
      these_params[:id] = these_params.delete(:attempt_id)
      these_params
    end

    # Override path to redirect after answer the survey
    # Write:
    #   # my_app/app/decorators/controllers/rapidfire/answer_groups_controller_decorator.rb
    #   Rapidfire::AnswerGroupsController.class_eval do
    #     def after_answer_path_for
    #       main_app.root_path
    #     end
    #   end
    
    def after_answer_path_for
      # if @survey.after_survey_content.present?
      #   survey_attempt_path(@survey, @attempt_builder.to_model)
      # else
      #   surveys_path
      # end
      main_app.root_path
    end

    def rapidfire_current_scoped
      send 'current_'+scoped.to_s
    end
  end
end
