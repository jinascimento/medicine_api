# frozen_string_literal: true

require 'swagger_helper'

describe 'Customers API' do
  path '/v1/customers' do
    post 'Create a customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :customer, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: ['name']
      }

      response '201', 'created' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 name: { type: :string },
                 links: { type: :array,
                          items: {
                            properties: {
                              rel: { type: :string },
                              href: { type: :string }
                            }
                          }
                 }
               },
               required: %w[id]

        let(:customer) { FactoryBot.create(:customer) }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }


        let(:customer) { { name: nil } }
        run_test!
      end
    end

    get 'List all customers' do
      tags 'Customers'
      consumes 'application/json'

      response '200', 'OK' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :number },
                   name: { type: :string },
                   links: { type: :array,
                            items: {
                              properties: {
                                rel: { type: :string },
                                href: { type: :string }
                              }
                            }
                   }
                 },
               }
        FactoryBot.create(:customer)
        run_test!
      end
    end
  end

  path '/v1/customers/{id}' do
    put 'Update a customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :customer, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
        },
        required: ['name']
      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 name: { type: :string },
                 links: { type: :array,
                          items: {
                            properties: {
                              rel: { type: :string },
                              href: { type: :string }
                            }
                          }
                 }
               },
               required: %w[id]

        let(:customer) { FactoryBot.create(:customer) }
        let(:id) { customer.id }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }


        let(:customer_create) { FactoryBot.create(:customer) }
        let(:customer) { { name: nil } }
        let(:id) { customer_create.id }
        run_test!
      end
    end

    get 'Retrieves a customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 name: { type: :string },
                 links: { type: :array,
                          items: {
                            properties: {
                              rel: { type: :string },
                              href: { type: :string }
                            }
                          }
                 }
               },
               required: %w[id]

        let(:id) { FactoryBot.create(:customer).id }

        run_test!
      end

      response '404', 'Not Found' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        let(:id) { 0 }

        run_test!
      end
    end

    delete 'Destroy a customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'No content' do

        let(:id) { FactoryBot.create(:customer).id }

        run_test!
      end

      response '404', 'Not Found' do
        schema type: :object,
               properties: {
                   message: { type: :string }
               }

        let(:id) { 0 }

        run_test!
      end
    end
  end
end