class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :recipients_for_select, only: [:new, :edit, :update, :create]

  # GET /transactions
  # GET /transactions.json
  def index
    if Transaction.find(current_member)
      @transactions = Transaction.find(current_member)
    else
      redirect_to new_transaction_path
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    if defined?(current_member.information) && current_member.information != nil
      @transaction = Transaction.new
    else
      redirect_to new_information_path
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.member = current_member

    if @transaction.pay_method == "boleto" && @transaction.division == true
      transaction = PagarMe::Transaction.new(
          amount:         @transaction.amount,    # in cents
          payment_method: @transaction.pay_method,
          split_rules: [
            @transaction.recipients.each do |recipient|
               { recipient_id: recipient.code, percentage: @transaction.split_rules.find(recipient.id).percentage }
            end
          ]
      )
    ############################################################################
    elsif @transaction.pay_method == "credit_card" && @transaction.division == true
      transaction = PagarMe::Transaction.new(
        amount:    @transaction.amount,      # in cents
        card_hash: @transaction.card_hash,  # how to get a card hash: docs.pagar.me/capturing-card-data
        payment_method: @transaction.pay_method,
        :customer => {
        :name => @transaction.member.name,
        :document_number => @transaction.member.information.document_number,
        :email => @transaction.member.email,
        :address => {
            :street => @transaction.member.information.street,
            :neighborhood => @transaction.member.information.neighborhood,
            :zipcode => @transaction.member.information.zipcode,
            :street_number => @transaction.member.information.street_number,
            :complementary => @transaction.member.information.complementary,
        },
        :phone => {
            :ddd => @transaction.member.information.ddd,
            :number => @transaction.member.information.phone_number
        }
        },
        split_rules: [
          @transaction.recipients.each do |recipient|
            { recipient_id: recipient.code, percentage: @transaction.split_rules.find(recipient.id).percentage }
          end
        ])
    #############################################################################
    elsif @transaction.pay_method == "boleto" # realiza a transação via boleto
      transaction = PagarMe::Transaction.new(
        amount:         @transaction.amount,    # in cents
        payment_method: @transaction.pay_method
    )
    #############################################################################
    elsif @transaction.pay_method == "credit_card" # realiza a transação via cartão
      transaction = PagarMe::Transaction.new(
        amount:    @transaction.amount,      # in cents
        card_hash: @transaction.card_hash,  # how to get a card hash: docs.pagar.me/capturing-card-data
        payment_method: @transaction.pay_method,
        :customer => {
        :name => @transaction.member.name,
        :document_number => @transaction.member.information.document_number,
        :email => @transaction.member.email,
        :address => {
            :street => @transaction.member.information.street,
            :neighborhood => @transaction.member.information.neighborhood,
            :zipcode => @transaction.member.information.zipcode,
            :street_number => @transaction.member.information.street_number,
            :complementary => @transaction.member.information.complementary,
        },
        :phone => {
            :ddd => @transaction.member.information.ddd,
            :number => @transaction.member.information.phone_number
        }
        })
    end

    transaction.charge

    @transaction.boleto_url = transaction.boleto_url
    @transaction.boleto_barcode = transaction.boleto_barcode

    @transaction.status = transaction.status

    @transaction.id = transaction.id

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def recipients_for_select
      @recipients_for_select = Recipient.all 
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:amount, :pay_method, :card_hash, :division,
        :split_rules_attributes => [:id, :percentage, :transaction_id, :recipient_id,
        :_destroy, :recipient_attributes => [:id, :legal_name]])
    end
end
