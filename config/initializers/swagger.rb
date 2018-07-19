# frozen_string_literal: true

GrapeSwaggerRails.options.url      = '/api/docs.json'
GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'
GrapeSwaggerRails.options.app_name = 'Studytube Issue Tracker API'
GrapeSwaggerRails.options.doc_expansion = 'list'

# # Default Authorization token for Swagger.
# if Rails.env.development?
#   TEST_USER_EMAIL = 'name@post.dom'
#   user = User.find_by(email: TEST_USER_EMAIL)
#
#   if user.present?
#     last_token = user.authentication_tokens.valid.last
#     token = last_token.present? ? last_token : AuthenticationToken.generate(user)
#     GrapeSwaggerRails.options.headers['Authorization'] = token.token
#   end
# end
