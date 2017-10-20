class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

	def set_profile(user_id)
		@user = User.find(user_id)
		@page_count = 1
	end

	def current_page
		params[:page].try(:to_i) || 1
	end
	helper_method :current_page

	def first_page?(page)
		page == 1 || page == 0 || page == nil
	end

	def pv_id
		@_pv_id ||= SecureRandom.uuid
	end
	helper_method :pv_id

	def current_page_id
		@_current_page_id ||= "#{request.path.sub('/', '').gsub('/', '.')}.#{request.method.downcase}"
	end
	helper_method :current_page_id

	def default_description
		@_default_description = "CATSNAP(キャットナップ)-猫のいる暮らしをもっと楽しく-";
	end
	helper_method :default_description


	def meta_keywords
		@_meta_keywords = "猫,ネコ";
	end
	helper_method :meta_keywords

	def title
		@_title = "CATSNAP(キャットナップ)-猫のいる暮らしをもっと楽しく-";
	end
	helper_method :title

	def title_logo
		@_title_logo = "CATSNAP";
	end
	helper_method :title_logo

	def website
		@_website = "xxx";
	end
	helper_method :website

	def og_url
		@_og_url = "xxx";
	end
	helper_method :og_url

	def og_image
		@_og_image = "xxx";
	end
	helper_method :og_image

	def website
		@_og_url = "xxx";
	end
	helper_method :og_url

	def default_og_description
		@_default_og_description = "CATSNAP(キャットナップ)-猫のいる暮らしをもっと楽しく-";
	end
	helper_method :default_og_description
end
