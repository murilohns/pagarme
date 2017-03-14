require 'test_helper'

class SplitRulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @split_rule = split_rules(:one)
  end

  test "should get index" do
    get split_rules_url
    assert_response :success
  end

  test "should get new" do
    get new_split_rule_url
    assert_response :success
  end

  test "should create split_rule" do
    assert_difference('SplitRule.count') do
      post split_rules_url, params: { split_rule: { percentage: @split_rule.percentage, recipient_id: @split_rule.recipient_id, transaction_id: @split_rule.transaction_id } }
    end

    assert_redirected_to split_rule_url(SplitRule.last)
  end

  test "should show split_rule" do
    get split_rule_url(@split_rule)
    assert_response :success
  end

  test "should get edit" do
    get edit_split_rule_url(@split_rule)
    assert_response :success
  end

  test "should update split_rule" do
    patch split_rule_url(@split_rule), params: { split_rule: { percentage: @split_rule.percentage, recipient_id: @split_rule.recipient_id, transaction_id: @split_rule.transaction_id } }
    assert_redirected_to split_rule_url(@split_rule)
  end

  test "should destroy split_rule" do
    assert_difference('SplitRule.count', -1) do
      delete split_rule_url(@split_rule)
    end

    assert_redirected_to split_rules_url
  end
end
