class DiskController < ApplicationController
  before_filter :authenticate_user!

  class TagMock
    attr_reader :name
    def initialize(name)
      @name = name
    end
  end

  def index
    @current_dir_path = _current_dir_path
    @media_resources = MediaResource.gets(current_user, @current_dir_path).web_order
  end

  def create
    file_entity = FileEntity.find params[:file_entity_id]
    path = params[:path]

    resource = MediaResource.put_file_entity current_user, path, file_entity

    render :json => {
      :id => resource.id,
      :name => resource.name,
      :html => (
        render_cell :disk, :file_table, :media_resources => [resource]
      )
    }
  end

  def destroy
    MediaResource.del current_user, params[:path]
    return _after_destroy
  rescue MediaResource::InvalidPathError
    return _after_destroy
  end

  def show
    @media_resource = MediaResource.get current_user, params[:path]
  end

  def create_folder
    path = params[:path]
    MediaResource.create_folder current_user, path
    _after_create_folder
  end

  private
    def _current_dir_path
      path = params[:path]
      return '/' if path.blank?
      return path
    end

    def _parent_path(path)
      path.split('/')[0...-1].join('/')
    end

    def _after_destroy
      if request.xhr?
        render :text => 'deleted.'
        return
      end

      parent_path = _parent_path params[:path]
      to_path = parent_path.blank? ? '/disk' : File.join('/disk', parent_path)
      redirect_to to_path
    end

    def _after_create_folder
      parent_path = _parent_path params[:path]
      to_path = URI.encode "/disk?path=#{parent_path}"
      redirect_to to_path
    end
end