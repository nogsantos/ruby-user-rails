require 'test_helper'

class ExpenseGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense_group = expense_groups(:one)
  end

  test "should get index" do
    get expense_groups_url, as: :json
    assert_response :success
  end

  test "should create expense_group" do
    assert_difference('ExpenseGroup.count') do
      post expense_groups_url, params: { expense_group: { name: @expense_group.name, observation: @expense_group.observation, status: @expense_group.status } }, as: :json
    end

    assert_response 201
  end

  test "should show expense_group" do
    get expense_group_url(@expense_group), as: :json
    assert_response :success
  end

  test "should update expense_group" do
    patch expense_group_url(@expense_group), params: { expense_group: { name: @expense_group.name, observation: @expense_group.observation, status: @expense_group.status } }, as: :json
    assert_response 200
  end

  test "should destroy expense_group" do
    assert_difference('ExpenseGroup.count', -1) do
      delete expense_group_url(@expense_group), as: :json
    end

    assert_response 204
  end
end
