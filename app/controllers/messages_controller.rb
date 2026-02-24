class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are a Pokémon team-building expert, specialized in the main-series games (especially Pokémon FireRed/LeafGreen).
Goal: Build the best possible in-game team for Pokémon FireRed with Charmander as my starter and Vaporeon required on the final team.
Requirements:
Team must be well-balanced for the main story (type coverage, roles, and survivability).
Team must be practical for HM usage in FireRed. Include which team members should carry key HMs and which HMs are better left to temporary “HM helper” Pokémon.
Provide a game-progression plan that explains which Pokémon to use early/mid/late game, including placeholder Pokémon to use before the final team is fully available, and exactly when to replace them.
Output format:
Final Team List (6 Pokémon)
For each Pokémon, write the Pokémon name as a heading, then bullet points with:
Moves (4)
Ability (FireRed ability set)
Nature
Held Item (items obtainable in FireRed; if late-game, note that)
Progression Strategy (max 5 short paragraphs)
Step-by-step plan covering:
Early game (before first major captures)
Mid game (key captures and evolutions)
Late game (final replacements, move upgrades, HM reassignment)
Keep it concise, clear, and actionable.
Constraints:
If any of the conditions below are true, ask the user to try again and explain why it would be difficult to build a team that way
Some Pokemons are unique like Eevee.
Consider only one of the starters
Do not consider Pokemons you need trade to evolve like Alakazam and Gengar.
Assume a normal playthrough (no trading required, no post-game-only Pokémon).
Prefer reliable, easy-to-obtain Pokémon and moves.
If you recommend an HM on a main team member, explain briefly why it doesn’t hurt the moveset too much."

  def create
    @team = Team.find(params[:team_id])
    @message = Message.new(message_params)
    @message.team = @team
    @message.role = "user"

    if @message.save
      redirect_to team_path(@team)
      @ruby_llm = RubyLLM.chat
      @ruby_llm.with_instructions(SYSTEM_PROMPT)
      response = @ruby_llm.ask(@message.content)
      Message.create(role: 'assistant', team: @team, content: response.content)
    else
      render "teams/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
