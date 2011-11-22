require 'RMagick'
require 'fileutils'

class DesignsController < ApplicationController
  include Magick
  # GET /designs
  # GET /designs.xml
  def index
    @designs = Design.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @designs }
    end
  end

  # GET /designs/1
  # GET /designs/1.xml
  def show
    @design = Design.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @design }
    end
  end

  # GET /designs/new
  # GET /designs/new.xml
  def new
    @design = Design.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @design }
    end
  end

  # GET /designs/1/edit
  def edit
    @design = Design.find(params[:id])
  end

  # POST /designs
  # POST /designs.xml
  def create
    @design = Design.new(params[:design])
    formAction = params[:form_action];

      #TODO: Only save design
      respond_to do |format|
        if @design.save
          if formAction == 'SAVE'
            format.html { redirect_to(@design, :notice => 'Design was successfully saved.') }
            format.xml  { render :xml => @design, :status => :created, :location => @design }
          elsif formAction == 'ADDTOCART'
              #TODO: -> save design_item -> save design_item_options => add design_item to shopping cart => forward to cart page.
              @design_item = DesignItem.new(:design_id => @design.id,
                                :product_variant_id => @design.product_variant_id,
                                :ink_type => @design.ink_type,
                                :front_design => @design.front_design,
                                :back_design => @design.back_design,
                                :left_design => @design.left_design,
                                :right_design => @design.right_design,
                                :num_of_color => @design.num_of_color,
                                :num_of_photo => @design.num_of_photo,
                                :num_of_location => @design.num_of_location,
                                :total_quantity => params[:design_total_quantity].to_i,
                                :total_price => params[:design_total_price].to_f)

              if @design_item.save
                #TODO: loop for options and save them.
#                size_options = params[:garment_size_name]
#                color_options = params[:garment_color_name]
#                quantities = params[:quantity]
#                for i in size_options do
#                  @design_item_option = DesignItemOption.new(:design_item_id => @design_item.id,
#                                        :garment_size_name => size_options[i],
#                                        :garment_color_name => color_options[i],
#                                        :quantity => quantities[i])
#                  if !@design_item_option.save
#                    format.html { render :action => "new" }
#                    format.xml  { render :xml => @design_item_option.errors, :status => :unprocessable_entity }
#                  end
#                end
                if params[:qtyS].to_i != 0
                  @design_item_option = DesignItemOption.new(:design_item_id => @design_item.id,
                                        :garment_size_name => "S",
                                        :garment_color_name => params[:garment_color_name],
                                        :quantity => params[:qtyS].to_i)
                  if !@design_item_option.save
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @design_item_option.errors, :status => :unprocessable_entity }
                  end
                end
                if params[:qtyM].to_i != 0
                  @design_item_option = DesignItemOption.new(:design_item_id => @design_item.id,
                                        :garment_size_name => "M",
                                        :garment_color_name => params[:garment_color_name],
                                        :quantity => params[:qtyM].to_i)
                  if !@design_item_option.save
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @design_item_option.errors, :status => :unprocessable_entity }
                  end
                end
                if params[:qtyL].to_i !=0
                  @design_item_option = DesignItemOption.new(:design_item_id => @design_item.id,
                                        :garment_size_name => "L",
                                        :garment_color_name => params[:garment_color_name],
                                        :quantity => params[:qtyL].to_i)
                  if !@design_item_option.save
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @design_item_option.errors, :status => :unprocessable_entity }
                  end
                end
                if params[:qtyXL].to_i != 0
                  @design_item_option = DesignItemOption.new(:design_item_id => @design_item.id,
                                        :garment_size_name => "XL",
                                        :garment_color_name => params[:garment_color_name],
                                        :quantity => params[:qtyXL].to_i)
                  if !@design_item_option.save
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @design_item_option.errors, :status => :unprocessable_entity }
                  end
                end
                if params[:qtyXXL].to_i != 0
                  @design_item_option = DesignItemOption.new(:design_item_id => @design_item.id,
                                        :garment_size_name => "XXL",
                                        :garment_color_name => params[:garment_color_name],
                                        :quantity => params[:qtyXXL].to_i)
                  if !@design_item_option.save
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @design_item_option.errors, :status => :unprocessable_entity }
                  end
                end

                #Design Item was successfully added to cart.
                format.html { redirect_to(:controller => 'checkout/cart', :action => 'add_to_cart', :design_item_id => @design_item.id) }
                format.xml  { render :xml => @design_item, :status => :created, :location => @design_item }

              else
                format.html { render :action => "new" }
                format.xml  { render :xml => @design_item.errors, :status => :unprocessable_entity }
              end
          end
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
        end
      end
  end

  # PUT /designs/1
  # PUT /designs/1.xml
  def update
    @design = Design.find(params[:id])

    respond_to do |format|
      if @design.update_attributes(params[:design])
        format.html { redirect_to(@design, :notice => 'Design was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /designs/1
  # DELETE /designs/1.xml
  def destroy
    @design = Design.find(params[:id])
    @design.destroy

    respond_to do |format|
      format.html { redirect_to(designs_url) }
      format.xml  { head :ok }
    end
  end

  def upload
    customart = params[:customart]
    if customart.original_filename =~ /(\.gif)|(\.png)|(\.jpeg)^/
      working_dir = "#{RAILS_ROOT}/dsg/#{@session_id}"
      FileUtils.mkdir_p(working_dir) unless File.exist?(working_dir)
      output = "#{working_dir}/ca_#{customart.original_filename}"
      img = Image.read(customart.path).first
      # TODO: resize image here
      img.write(output)
      render :text => "upload success, locate the file in #{output}"
    else
      render :text => "Only gif/png/jpeg formats are accepted"
    end
  end

  def total_calculate
    if request.post?
      quote = Quote.build_quote(params)
      if quote.valid?
        render :json => quote.total_price
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
      render :number => quote.total_price
    end
  end
end
