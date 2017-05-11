class HomeController < ApplicationController
    def index
        render(
            json: "by Fabricio Nogueira <nogsantos@gmail.com>"
        )
    end
end
