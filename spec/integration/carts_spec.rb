# frozen_string_literal: true

require 'swagger_helper'

describe 'Carts API' do
  path '/v1/customers/{customer_id}/carts/add_items' do
    post 'Add items' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: :customer_id, in: :path, type: :string
      parameter name: :cart, in: :body, schema: {
        type: :object,
        properties: {
          cart_items_attributes:
            {
              type: :array,
              items: {
                properties: {
                  medicine_id: { type: :number },
                  quantity: { type: :number }
                }
              }
            }
        },
        required: %w[customer_id cart_item_attributes]
      }

      response '201', 'created' do

        schema type: :object,
               properties: {
                 id: { type: :number },
                 status: { type: :string },
                 total_amount: { type: :string },
                 customer_id: { type: :number },
                 cart_items: { type: :array,
                               items: {
                                 properties: {
                                   id: { type: :number },
                                   cart_id: { type: :number },
                                   medicine_id: { type: :number },
                                   quantity: { type: :number },
                                   price: { type: :string },
                                   created_at: { type: :string },
                                   updated_at: { type: :string }
                                 }
                               } },
                 links: { type: :array,
                          items: {
                            properties: {
                              rel: { type: :string },
                              href: { type: :string }
                            }
                          } }
               }

        let(:medicine) { FactoryBot.create(:medicine) }
        let(:customer_id) { FactoryBot.create(:customer).id }
        let(:cart) { { cart: {cart_items_attributes: [{ medicine_id: medicine.id, quantity: 3 }] } }}
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        let(:medicine) { FactoryBot.create(:medicine, stock: 3) }
        let(:customer_id) { FactoryBot.create(:customer).id }
        let(:cart) { { cart: { cart_items_attributes: [ { medicine_id: medicine.id, quantity: 4 } ]} }}
        run_test!
      end
    end
  end

  path '/v1/customers/{customer_id}/carts/{id}' do
    get 'Retrieves a cart' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: :customer_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 status: { type: :string },
                 total_amount: { type: :string },
                 customer_id: { type: :number },
                 cart_items: { type: :array,
                               items: {
                                 properties: {
                                   id: { type: :string },
                                   cart_id: { type: :string },
                                   medicine_id: { type: :string },
                                   quantity: { type: :string },
                                   price: { type: :string },
                                   created_at: { type: :string },
                                   updated_at: { type: :string }
                                 }
                               } },
                 links: { type: :array,
                          items: {
                            properties: {
                              rel: { type: :string },
                              href: { type: :string }
                          }
                          } }
               },
               required: %w[customer_id]


        let(:customer_id) { FactoryBot.create(:customer).id }
        let(:id) { FactoryBot.create(:cart, customer_id: customer_id).id }

        run_test!
      end

      response '404', 'Not Found' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        let(:customer_id) { 0 }
        let(:id) { 0 }

        run_test!
      end
    end

    delete 'Destroy a cart' do
      tags 'Carts'
      consumes 'application/json'
      parameter name: :customer_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '204', 'No content' do

        let(:customer_id) { FactoryBot.create(:customer).id }
        let(:id) { FactoryBot.create(:cart, customer_id: customer_id).id }
        run_test!
      end

      response '404', 'Not Found' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        let(:customer_id) { 0 }
        let(:id) { 0 }

        run_test!
      end
    end

  end
end
