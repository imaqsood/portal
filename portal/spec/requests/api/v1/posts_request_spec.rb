 require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do

  let(:user)               { create(:user, :confirmed) }
  let(:valid_attributes)   { build(:post, user: user).attributes }
  let(:invalid_attributes) { build(:post, user: nil).attributes }

  describe "GET /index" do
    it "renders a successful response" do
      Post.create! valid_attributes
      get api_v1_posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      post = Post.create! valid_attributes
      get api_v1_posts_url(post)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post api_v1_posts_url, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post api_v1_posts_url, params: { post: valid_attributes }
        # expect(response).to redirect_to(api_v1_post_url(Post.last))
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post api_v1_posts_url, params: { post: invalid_attributes }
        }.to change(Post, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post api_v1_posts_url, params: { post: invalid_attributes }
        # expect(response).to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {body: 'New Body'}
      }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        patch api_v1_post_url(post), params: { post: new_attributes }
        post.reload
        expect(post.body).to eql new_attributes[:body]
      end

      it "redirects to the post" do
        post = Post.create! valid_attributes
        patch api_v1_post_url(post), params: { post: new_attributes }
        post.reload
        # expect(response).to redirect_to(api_v1_post_url(post))
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        post = Post.create! valid_attributes
        patch api_v1_post_url(post), params: { post: invalid_attributes }
        # expect(response).to be_successful
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete api_v1_post_url(post)
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete api_v1_post_url(post)
      expect(response).to have_http_status(:no_content)
    end
  end
end
