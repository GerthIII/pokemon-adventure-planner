class MessagesController < ApplicationController

SYSTEM_PROMPT = <<~PROMPT
You are a Pokémon team-building expert specialized in Pokémon FireRed/LeafGreen.
Build the best possible in-game team following all constraints below.

IMPORTANT OUTPUT RULES:
- Return ONLY valid JSON
- Do NOT include explanations, markdown, headings, or extra text
- The response must be directly parseable by JSON.parse

OUTPUT FORMAT:
{
  "team": [
    {
      "pokemon_name": STRING,
      "ability": STRING,
      "nature": STRING,
      "held_item": STRING,
      "move_1": STRING,
      "move_2": STRING,
      "move_3": STRING,
      "move_4": STRING,
      "progression_strategy": STRING
    }
  ]
}

CONSTRAINTS:
- Starter must be Charmander
- If in the text of the following parenthesis (mewtwo) it must be included unless it is out of the constraints scope
- Only Pokemons from FireRed and LeafGreen games
- If you are not sure if the Pokemon is within the scope, stick with the 151 first generation Pokemons.
- Only one starter Pokémon
- No trade-evolution Pokémon
- No post-game Pokémon
- Normal playthrough assumptions
- Prefer easy-to-obtain Pokémon and reliable moves
- If a main team Pokémon uses an HM, explain briefly in progression_strategy why it is acceptable
-The team must contain exactly 6 Pokémon.
PROMPT

  def create
    TeamMember.destroy_all
    Message.destroy_all
    @team = Team.find(params[:team_id])
    @message = Message.new(message_params)
    @message.team = @team
    @message.role = "user"

    if @message.save
      ruby_llm = RubyLLM.chat
      ruby_llm.with_instructions(SYSTEM_PROMPT)
      @response = ruby_llm.ask(@message.content)
      assistant_message = Message.create(role: 'assistant', team: @team, content: @response.content)

      team_hash = JSON.parse(assistant_message.content)
      team_hash["team"].each do |pokemon|
      pokemon_instance = Pokemon.find_by(name: pokemon["pokemon_name"].downcase)

      TeamMember.create(
        team: @team,
        pokemon: pokemon_instance,
        ability: pokemon["ability"],
        nature: pokemon["nature"],
        held_item: pokemon["held_item"],
        move_1: pokemon["move_1"],
        move_2: pokemon["move_2"],
        move_3: pokemon["move_3"],
        move_4: pokemon["move_4"]
      )

    end

      redirect_to team_path(@team)

    else
      render "teams/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
