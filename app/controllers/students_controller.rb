class StudentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def index
        render json: Student.all, except:[:created_at, :updated_at], status: :ok
    end

    def show
        render json: Student.find(params[:id]), except:[:created_at, :updated_at], status: :ok
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, except:[:created_at, :updated_at], status: :accepted
    end

    def create
        student = Student.create!(student_params)
        render json: student, except:[:created_at, :updated_at], status: :created
    end
    
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def record_not_found_response
        render json: {error: "Student not found"}, status: :not_found
    end

    def invalid_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
