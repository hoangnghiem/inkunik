class ProductsController < ApplicationController
  def index
    cat_id = nil
    if !params[:sub_category_id].blank?
      cat_id = params[:sub_category_id]
    elsif !params[:category_id].blank?
      cat_id = params[:category_id]
    elsif !params[:parent_category_id].blank?
      cat_id = params[:parent_category_id]
    end

    @products = []
    @category = Category.find(cat_id)
    if @category.products.count == 0
      @category.sub_categories.each do |sub|
        @products.concat(sub.products)
      end
    else
      @products = @category.products.includes(:product_variants)
    end
    @active_menu = Category.find(params[:parent_category_id]).slug

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  def show
    @product = Product.includes(:product_variants).find(params[:id])
  end

  def quick_price
    if request.post?
      quote = Quote.build_quote(params)
      if quote.valid?
        return render :partial => "quote", :locals => { :quote => quote }, :status => :ok
      else
        require 'markaby'
        markaby = Markaby::Builder.new
        markaby.div.error do
          ul do
            quote.errors.each do |k,v|
              li do
                v
              end
            end
          end
        end
        return render :text => markaby.to_s, :status => :unprocessable_entity
      end
    else
      quote = Quote.build_quote(:product_id => params[:product_id])
      return render :partial => "quick_price", :locals => { :quote => quote }
    end 
  end

end
