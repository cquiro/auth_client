class User
  include HTTParty
  base_uri 'http://localhost:3001'

  attr_accessor :image
  attr_reader :email, :id

  def initialize(user_id = nil)
    if user_id
      @id = user_id
      @email = self.get_user["email"]
      @image = self.get_user["image"]
    end
  end

  def list_users
    self.class.get("/users").map do |user|
      user.slice("id", "email", "created_at", "updated_at") 
    end
  end

  def get_user
    self.class.get("/users/".concat(id))
  end

  def create_user(params)
    self.class.post("/users/", body: { user: params })
  end

  def update_user(params)
    self.class.put("/users/".concat(id), body: { user: params })
  end

  def destroy_user
    self.class.delete("/users/".concat(id))
  end
end
