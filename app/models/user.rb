class User
  include HTTParty
  # base_uri 'https://floating-river-22339.herokuapp.com'
  base_uri 'http://localhost:3001'

  attr_accessor :image
  attr_reader :email, :id

  def initialize(user_id: nil)
    if user_id
      @id = user_id
      @email = self.retrieve["email"]
      @image = self.retrieve["image"]
    end
  end

  def list
    self.class.get("/users").map do |user|
      user.slice("id", "email", "created_at", "updated_at", "image") 
    end
  end

  def retrieve
    self.class.get("/users/".concat(id))
  end

  def create(params)
    self.class.post("/users/", body: { user: params })
  end

  def update(params)
    self.class.put("/users/".concat(id), body: { user: params })
  end

  def destroy
    self.class.delete("/users/".concat(id))
  end

  def verify(params)
    self.class.post("/verify_user/".concat(params[:email]), body: {
      image: params[:image], user_agent: params[:user_agent]
    })
  end
end
