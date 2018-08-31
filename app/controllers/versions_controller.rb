class VersionsController < ApplicationController
	def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    link_name = params[:redo] == "true" ? "undo" : "redo"
    link = view_context.link_to(link_name, revert_version_create_path(@version.next, :redo => !params[:redo]), :method => :post)
    link = view_context.link_to(link_name, revert_version_update_path(@version.next, :redo => !params[:redo]), :method => :patch)
    redirect_back(fallback_location: root_path)
  end
end
