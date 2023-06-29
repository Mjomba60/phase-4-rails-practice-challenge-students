class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def index
        render json: Instructor.all, except:[:created_at, :updated_at], status: :ok
    end

    def show
        render json: Instructor.find(params[:id]), except:[:created_at, :updated_at], status: :ok
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, except:[:created_at, :updated_at], status: :accepted
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, except:[:created_at, :updated_at], status: :created
    end
    
    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def record_not_found_response
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def invalid_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

    def instructor_params
        params.permit(:name)
    end
end
