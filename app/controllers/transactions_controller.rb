class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    if defined?(current_member.information.street) && current_member.information.street != '' 
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

    if @transaction.pay_method == "boleto"
      transaction_type = PagarMe::Transaction.new(
        amount:         @transaction.amount,    # in cents
        payment_method: @transaction.pay_method
      )

      @transaction.boleto_url = transaction_type.boleto_url
      @transaction.boleto_barcode = transaction_type.boleto_barcode

    elsif @transaction.pay_method == "credit_card"
      transaction_type = PagarMe::Transaction.new(
        amount:    @transaction.amount,      # in cents
        card_hash: @transaction.card_hash,  # how to get a card hash: docs.pagar.me/capturing-card-data
        payment_method: @transaction.pay_method,
        :customer => {
        :name => "Sheila Ribeiro",
        :document_number => "92545278157",
        :email => "sheilaribeiro304@gmail.com",
        :address => {
            :street => "Rua Hercules Malatesta",
            :neighborhood => "Boa Vista",
            :zipcode => "13201000",
            :street_number => "40",
            :complementary => "Seila"
        },
        :phone => {
            :ddd => "11",
            :number => "974182124"
        }
      }
      )
      
    end

    transaction_type.charge

    @transaction.status = transaction_type.status

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
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:amount, :pay_method, :card_hash)
    end
end
