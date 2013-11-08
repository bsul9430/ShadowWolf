require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProjectExperiencesController do

  # This should return the minimal set of attributes required to create a valid
  # ProjectExperience. As you add validations to ProjectExperience, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "start_date" => "2013-11-08" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjectExperiencesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all project_experiences as @project_experiences" do
      project_experience = ProjectExperience.create! valid_attributes
      get :index, {}, valid_session
      assigns(:project_experiences).should eq([project_experience])
    end
  end

  describe "GET show" do
    it "assigns the requested config_model as @config_model" do
      project_experience = ProjectExperience.create! valid_attributes
      get :show, {:id => project_experience.to_param}, valid_session
      assigns(:config_model).should eq(project_experience)
    end
  end

  describe "GET new" do
    it "assigns a new config_model as @config_model" do
      get :new, {}, valid_session
      assigns(:config_model).should be_a_new(ProjectExperience)
    end
  end

  describe "GET edit" do
    it "assigns the requested config_model as @config_model" do
      project_experience = ProjectExperience.create! valid_attributes
      get :edit, {:id => project_experience.to_param}, valid_session
      assigns(:config_model).should eq(project_experience)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ProjectExperience" do
        expect {
          post :create, {:config_model => valid_attributes}, valid_session
        }.to change(ProjectExperience, :count).by(1)
      end

      it "assigns a newly created config_model as @config_model" do
        post :create, {:config_model => valid_attributes}, valid_session
        assigns(:config_model).should be_a(ProjectExperience)
        assigns(:config_model).should be_persisted
      end

      it "redirects to the created config_model" do
        post :create, {:config_model => valid_attributes}, valid_session
        response.should redirect_to(ProjectExperience.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved config_model as @config_model" do
        # Trigger the behavior that occurs when invalid params are submitted
        ProjectExperience.any_instance.stub(:save).and_return(false)
        post :create, {:config_model => { "start_date" => "invalid value" }}, valid_session
        assigns(:config_model).should be_a_new(ProjectExperience)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ProjectExperience.any_instance.stub(:save).and_return(false)
        post :create, {:config_model => { "start_date" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested config_model" do
        project_experience = ProjectExperience.create! valid_attributes
        # Assuming there are no other project_experiences in the database, this
        # specifies that the ProjectExperience created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ProjectExperience.any_instance.should_receive(:update).with({ "start_date" => "2013-11-08" })
        put :update, {:id => project_experience.to_param, :config_model => { "start_date" => "2013-11-08" }}, valid_session
      end

      it "assigns the requested config_model as @config_model" do
        project_experience = ProjectExperience.create! valid_attributes
        put :update, {:id => project_experience.to_param, :config_model => valid_attributes}, valid_session
        assigns(:config_model).should eq(project_experience)
      end

      it "redirects to the config_model" do
        project_experience = ProjectExperience.create! valid_attributes
        put :update, {:id => project_experience.to_param, :config_model => valid_attributes}, valid_session
        response.should redirect_to(project_experience)
      end
    end

    describe "with invalid params" do
      it "assigns the config_model as @config_model" do
        project_experience = ProjectExperience.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ProjectExperience.any_instance.stub(:save).and_return(false)
        put :update, {:id => project_experience.to_param, :config_model => { "start_date" => "invalid value" }}, valid_session
        assigns(:config_model).should eq(project_experience)
      end

      it "re-renders the 'edit' template" do
        project_experience = ProjectExperience.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ProjectExperience.any_instance.stub(:save).and_return(false)
        put :update, {:id => project_experience.to_param, :config_model => { "start_date" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested config_model" do
      project_experience = ProjectExperience.create! valid_attributes
      expect {
        delete :destroy, {:id => project_experience.to_param}, valid_session
      }.to change(ProjectExperience, :count).by(-1)
    end

    it "redirects to the project_experiences list" do
      project_experience = ProjectExperience.create! valid_attributes
      delete :destroy, {:id => project_experience.to_param}, valid_session
      response.should redirect_to(project_experiences_url)
    end
  end

end
