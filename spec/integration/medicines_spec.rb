# frozen_string_literal: true

require 'swagger_helper'

describe 'Medicines API' do
  path '/v1/medicines' do
    post 'Create a medicine' do
      tags 'Medicines'
      consumes 'application/json'
      parameter name: :medicine, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              value: { type: :number },
              quantity: { type: :number },
              stock: { type: :number }
          },
          required: ['name']
      }

      response '201', 'created' do
        schema type: :object,
               properties: {
                 id: { type: :number },
                 name: { type: :string },
                 value: { type: :string },
                 quantity: { type: :number },
                 stock: { type: :number },
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

        let(:medicine) { FactoryBot.create(:medicine) }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                   message: { type: :string }
               }


        let(:medicine) { { name: nil } }
        run_test!
      end
    end

    get 'List all medicines' do
      tags 'Medicines'
      consumes 'application/json'

      response '200', 'OK' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :number },
                   name: { type: :string },
                   value: { type: :number },
                   quantity: { type: :number },
                   stock: { type: :number },
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
        FactoryBot.create(:medicine)
        run_test!
      end
    end
  end

  path '/v1/medicines/{id}' do
    put 'Update a medicine' do
      tags 'Medicines'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :medicine, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              value: { type: :number },
              quantity: { type: :number },
              stock: { type: :number },
          },
          required: ['name']
      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                   id: { type: :number },
                   name: { type: :string },
                   value: { type: :string },
                   quantity: { type: :number },
                   stock: { type: :number },
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

        let(:medicine) { FactoryBot.create(:medicine) }
        let(:id) { medicine.id }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }


        let(:medicine_create) { FactoryBot.create(:medicine) }
        let(:medicine) { { name: nil } }
        let(:id) { medicine_create.id }
        run_test!
      end
    end

    get 'Retrieves a medicine' do
      tags 'Medicines'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                   id: { type: :number },
                   name: { type: :string },
                   value: { type: :string },
                   quantity: { type: :number },
                   stock: { type: :number },
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

        let(:id) { FactoryBot.create(:medicine).id }

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

    delete 'Destroy a medicine' do
      tags 'Medicines'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'No content' do

        let(:id) { FactoryBot.create(:medicine).id }

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