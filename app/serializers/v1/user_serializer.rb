class V1::UserSerializer < V1::BaseSerializer
    type 'User'
    attributes :id, :name, :username, :email, :status, :created_at, :updated_at
        
    
end
