# SimpleReativeAgent
Implementation of multi-agent (reactive) system simulation

A multi-agent system (MAS or "self-organized system") is a computerized system composed of multiple interacting intelligent agents. Multi-agent systems can solve problems that are difficult or impossible for an individual agent or a monolithic system to solve. Intelligence may include methodic, functional, procedural approaches, algorithmic search or reinforcement learning.

Multi-agent systems consist of agents and their environment. Typically multi-agent systems research refers to software agents. However, the agents in a multi-agent system could equally well be robots, humans or human teams. A multi-agent system may contain combined human-agent teams.

Agents can be divided into types spanning simple to complex. Categories include: "reativos" e "deliberativos"

The difference is related to the fact that [reactive] agents consider the current information from the environment for decision-making, they do not have "memory" to store experiences, act by "instinct". The [deliberatives], also known as cognitive agents, they can learn through experiences and use acquired knowledge to assist in taking decision.

<table width:100%>
  <tr>
    <td><img src="./_/SimpleReativeAgent_img1.png"></td>
    <td><img src="./_/SimpleReativeAgent_img2.png"></td>
  </tr>
</table>

# Install the gem ruby2d

    $sudo apt-get update

    $sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev

    $gem install ruby2d


# Run the game

    $ruby main.rb
