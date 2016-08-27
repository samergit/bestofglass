class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Image has been deleted' } 
      format.json { head :no_content }
      format.js   { render layout: false}
    end
  end
end