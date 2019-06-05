class UpdateCommentService
   def initialize(comment, params)
      @comment = comment
      @params = params
    end

    def call
      if @params[:file] && !file?(@params[:file])
        delete_file if @comment.file.attached?
        @params.delete(:file)
      end
      @comment.update(@params)
    end
  
    private
  
    def file?(param)
      param.is_a?(ActionDispatch::Http::UploadedFile)
    end
    
    def delete_image
      @comment.image.purge
    end
  end