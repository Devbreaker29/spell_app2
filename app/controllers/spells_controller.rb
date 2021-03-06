class SpellsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    @@spells = [
         {id: 1, name:"Fireball", description: "Ball of Fire", type: "fire"},
         {id: 2, name: "Magic Missle", description: "A missile of magic", type: "force"}, 
         {id: 3, name: "Avada Kedava", description: "It kills everyone except harry potter", type: "death"}
    ]
    
    before_action :set_spell, only: [:show, :update]
    def index
        render json: @@spells 
    end

    def show
        render json: @spell 
    end

    def create
        spell = {
            id: @@spells.last[:id] + 1,
            name: params[:name],
            description: params[:description], 
            type: params[:type]
        }
        created_spell = @@spells.push(spell).last

        render json: created_spell, status: 201
    end


    def update
        updated_spell = {
            id: @spell[:id],
            name: params[:name],
            description: params[:description],
            type: params[:type]
        }

        @@spells[@index] = updated_spell

        render json: updated_spell, status: 200
    end

    private

    def set_spell
        id = params[:id].to_i
        @index = @@spells.index {|spell| spell[:id] == id}
        if !@index
            render json: {error: "Could not find spell"}, status: 404
        else
            @spell = @@spells[@index]
        end    
    end
end

