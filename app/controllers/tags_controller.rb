class TagsController < ApplicationController
  def professor_tags
    @tags = Tag.where(professor_id: params[:id])

    api_response(@tags, 'tags/professor_tags')
  end
end
