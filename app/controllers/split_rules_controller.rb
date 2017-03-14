class SplitRulesController < ApplicationController
  before_action :set_split_rule, only: [:show, :edit, :update, :destroy]

  # GET /split_rules
  # GET /split_rules.json
  def index
    @split_rules = SplitRule.all
  end

  # GET /split_rules/1
  # GET /split_rules/1.json
  def show
  end

  # GET /split_rules/new
  def new
    @split_rule = SplitRule.new
  end

  # GET /split_rules/1/edit
  def edit
  end

  # POST /split_rules
  # POST /split_rules.json
  def create
    @split_rule = SplitRule.new(split_rule_params)

    respond_to do |format|
      if @split_rule.save
        format.html { redirect_to @split_rule, notice: 'Split rule was successfully created.' }
        format.json { render :show, status: :created, location: @split_rule }
      else
        format.html { render :new }
        format.json { render json: @split_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /split_rules/1
  # PATCH/PUT /split_rules/1.json
  def update
    respond_to do |format|
      if @split_rule.update(split_rule_params)
        format.html { redirect_to @split_rule, notice: 'Split rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @split_rule }
      else
        format.html { render :edit }
        format.json { render json: @split_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /split_rules/1
  # DELETE /split_rules/1.json
  def destroy
    @split_rule.destroy
    respond_to do |format|
      format.html { redirect_to split_rules_url, notice: 'Split rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_split_rule
      @split_rule = SplitRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def split_rule_params
      params.require(:split_rule).permit(:percentage, :transaction_id, :recipient_id)
    end
end
