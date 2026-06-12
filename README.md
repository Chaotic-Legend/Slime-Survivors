[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.6.3-blue?style=plastic&logo=godotengine)](https://godotengine.org/) ![GitHub top language](https://img.shields.io/github/languages/top/Chaotic-Legend/Slime-Survivors?logo=godotengine)

# Slime Survivors | Project Touchstone #
[Your First 2D GAME From Zero in Godot 4 **Vampire Survivor Style**](http://youtube.com/watch?v=GwCiGixlqiU&t) by [GDQuest](https://www.youtube.com/@Gdquest) ([Discord](discord.gg/CHYVgar))

This project is a beginner-friendly walkthrough for building an inspired 2D "shoot 'em up" arena survival game in the Godot Engine, focusing on the core systems needed for responsive player movement and an engaging enemy swarm combat loop. It introduces and applies essential concepts, including node-based scene organization, physics-based player movement, input handling, enemy spawning, wave progression logic, projectile combat, collision detection, score tracking, UI implementation, and game over and restart conditions. This tutorial also demonstrates important gameplay features, including implementing scalable difficulty through wave escalation, managing enemy lifecycle and spawning systems, integrating audio and visual feedback for combat interactions, and structuring overall game flow to create a cohesive and polished gameplay experience. The result is a fully playable bullet-hell survival experience where players must endure progressively challenging waves of enemies while refining movement and strategy, upgrading weapons, and improving combat efficiency to survive. It also served as the foundation for completing a structured implementation task on Feather, with the project integrated into the broader development workflow supporting the Handshake AI Project Touchstone initiative.

# Assets #
[Slime Suvivors Assets](https://www.gdquest.com/library/first_2d_game_godot4_vampire_survivor/) by [GDQuest](https://www.gdquest.com/) ([Twitter](https://x.com/NathanGDQuest))

![Sprite Asset](assets/icon.png)

# Create a Godot task #
<ins> What application is this task for? </ins>
<br>
Godot

### **Task prompt** ###
First, enter the **task prompt** and any relevant reference files (e.g., docs, diagrams, sketches, photos, schematics).

Tasks should sound like what a manager might give a skilled but junior employee: high-level guidance with some leeway on executional details, but with very clear success metrics. What a good outcome looks like must be very clear and easy to understand.

Please include any relevant **reference files** (e.g., docs, diagrams, sketches, photos, schematics) needed to complete this task.

Reminder on the difference between reference and starting state files:
- **Reference files**: anything the Employee should look at or read while completing the project that does not need to be directly loaded into the application (*'please make something that looks like XYZ image'*)
- **Starting state files (upload below)**: anything that the Employee would need to load into their workspace to complete the task (*'here is the existing file you should adapt'*)

<ins> Task prompt (ask the Employee) </ins>
<br>
We are beginning development of a 2D arena-based action game that emphasizes fast-paced combat encounters, responsive player control, enemy pressure systems, and clear visual feedback to create an engaging survival experience. The player navigates a compact environment while facing continuously emerging threats that require constant repositioning, awareness of surrounding space, and precise concentration. The camera maintains a stable follow system that keeps the player centered within the visible area while preserving consistent awareness of nearby hazards and open movement paths throughout exploration and combat. Enemy units emerge dynamically from the environment and apply persistent pressure through contact-based interactions, encouraging sustained engagement and continuous spatial adaptation as encounters escalate. The gameplay is organized around a responsive control and combat framework that stays stable under pressure while keeping encounters easy to read and player progress clearly communicated. The completed gameplay system must support the following behaviors and mechanics:

- The player character moves using the WASD keys, which enable full omnidirectional navigation within the arena.
- The gun automatically targets nearby enemies and fires bullets, producing muzzle flash and impact effects.
- Green slime enemies spawn continuously, bounce towards the player character, and require three hits to die.
- A health bar displays the player's health, shifting colors as damage accumulates and signaling critical status.
- A scoring system awards 50 points for defeating the green slimes while separately tracking total eliminations.
- The game-over screen displays the high score and provides a clear replay button to restart the game.
- The player can pause with the P key, reset the game with the R key, and exit the game with the Esc key.
- Audio systems provide sound effects for shooting and slim death while background music plays during gameplay.
- The environment features a white background with scattered tree props to maintain readability and spatial clarity.

Visual feedback remains readable during high-intensity encounters while preserving sharp rendering of all sprites and assets, ensuring no unintended scaling, blurring, or distortion occurs across characters, enemies, projectiles, or environmental objects. Collision systems ensure the player properly interacts with slimes and environmental obstacles without passing through terrain or hazards. Combat feedback is reinforced through bullet impact effects and smoke-based explosion effects that appear on both enemy and player death, supporting a clear interpretation of combat outcomes. The overall structure supports persistent progression tracking across sessions by maintaining and updating a saved high score that carries forward between gameplay runs. UI systems present real-time gameplay information, including score, health status via a dynamic health bar that changes color and flashes under critical conditions, lives display, pause state indication via a toggled "PAUSED" label, and a game-over screen with score summary, high score display, and retry option. Game state controls include full session reset functionality, high score reset functionality, and ensure consistent gameplay behavior and responsiveness across all session transitions.

<ins> Which of the following best fits this task? </ins>
<br>
Task from scratch

<ins> How long would you anticipate an 'Employee' to complete this task? (in hours) </ins>
<br>
5

### **Starting state** ###
Please describe and include below any information about the starting state of this project:
- Existing work to be modified
- Other assets or other inputs the Employee needs to bring to be able to complete this task

Reminder on the difference between the starting state and the reference files:
- **Starting state files**: anything that the Employee would need to load into their workspace to complete the task ('*here is the existing file you should adapt*')
- **Reference files (upload above)**: anything the Employee should look at or read while completing the project that does not need to be directly loaded into the application ('*please make something that looks like XYZ image*')

<ins> Starting state description </ins>
<br>
The starting state is a clean 2D project with a colorpicker_presets script included to define the intended development color palette and visual styling within the engine, along with an icon image asset to enhance the project's presentation and identification in the game engine. The only required resources are visual and audio assets included to support the development of a top-down roguelike "shoot 'em up" experience centered around surviving increasingly difficult enemy waves while navigating open combat arenas. These assets include modular player character sprite components for body parts and animation assembly, slime enemy sprites with normal and damaged states, environmental props such as pine trees and ground shadows, pistol and projectile sprites, muzzle flash and impact effect graphics, smoke explosion visual effects and shaders, interface icon resources, background music, and multiple sound effects for weapon firing, enemy interactions, and combat feedback. The Employee is responsible for designing and implementing the complete game from the ground up using the provided assets, including all required scenes, nodes, scripts, enemy spawning logic, player movement and aiming behavior, projectile handling, and collision systems, health and damage systems, visual effect playback, audio integration, score tracking, pause and restart functionality, and UI systems. The Employee must create and integrate all gameplay programming, animation behavior, scene organization, and combat interactions, using the supplied resources as the foundation for the gameplay experience.

### **Overall context** ###
Finally, include context on this task and why it is realistic and representative of real-life work:
- Why is this a reasonable task for a manager to ask a junior-level employee to do?
- Is there a larger project it might be a part of?

<ins> Task context </ins>
<br>
This task is a realistic and appropriate assignment for a junior-level developer, as it focuses on implementing the core mechanics of a top-down roguelike "shoot 'em up" game using a provided collection of visual and audio resources. It involves building foundational gameplay systems, including player movement and aiming controls, projectile and combat handling, enemy spawning and wave progression, collision and damage systems, health and survival mechanics, upgrade and progression features, visual effects integration, and user interface management. The work requires applying essential programming, gameplay architecture, and problem-solving skills to transform a clean project structure and supporting assets into a complete interactive combat experience while organizing reusable scenes, scripts, and gameplay systems within the engine. This type of assignment reflects common real-world development practices, where junior developers are responsible for implementing gameplay mechanics, enemy behaviors, progression systems, audio feedback, and visual polish within a larger production pipeline. It could serve as part of a broader project to develop a complete roguelike action game framework with additional enemy varieties, unlockable weapons and abilities, procedural stage generation, expanded progression systems, and enhanced visual effects. By implementing these core gameplay systems and combat interactions, the task establishes a scalable foundation to expand with additional mechanics, content, balancing, and long-term progression features.

<ins> Rubric Items </ins>
<br>
1. All imported sprites and assets preserve their original visual quality with sharp rendering and no unintended scaling, blurring, or distortion.
- Run the main scene and verify that the character sprites, objects, and game elements render without scaling, blurring, or distortion.
- Verifies that pixel-art assets retain their original appearance without scaling, blurring, or distortion caused by incorrect import settings.

2. The player character can collide with the enemy slimes and obstacles.
- Run the main scene and move the player character against the slimes and obstacles to confirm that the sprite collides with them.
- Without functional collision, the player would pass through the ground and obstacles, and break the core challenge of the game.

3. The camera follows and displays the player character when moving.
- Run the main scene and move the player character around the environment to confirm that the camera displays and follows.
- The camera accurately displays and follows the player character for spatial awareness and consistent player control during movement.

4. The score counter increases by 50 points when defeating the slimes.
- Run the main scene and have the player character shoot to kill slimes to observe the score counter increase by 50 points.
- Score is the only persistent measure of player skill in this game, providing the feedback loop and incentive to improve across runs.

5. The game resets from the start when the player presses the R key.
- Run the main scene, press the R key during gameplay to confirm that the game, sprites, score, and visual elements reset completely.
- Without a quick reset, the player must close and relaunch the game between runs, breaking the rapid-retry loop that defines the genre.

6. The game closes when pressing the Escape key during gameplay.
- Run the main scene and press the Escape key during gameplay to confirm that the game application terminates completely.
- Exiting the game application lets the player leave while preserving the keyboard-only control system for the roguelike experience.

7. The game includes sound effects for shooting and killing slimes.
- Run the main scene and observe distinct sound effects when the player character shoots and when the slime enemies die.
- The sound effects provide immediate feedback for combat and enemy defeat, reinforcing game actions and responsiveness.

8. The game-over screen displays score information and a retry option.
- Run the main scene, fail by losing all health, and observe a game-over screen displaying a high score value and a retry button.
- The game-over screen message confirms the run ended, shows the player how they did, and gives them a path back into another run.

9. Pressing the P key displays a "PAUSED" label in the center, and pressing the same input again hides the label to resume the gameplay.
- Run the main scene, press the P key to show a "PAUSED" label, then press the P key again to hide the label and resume gameplay.
- Pausing lets players step away without losing progress, since interruptions would otherwise force them to abandon the match.

10. The game stores and updates the player's highest achieved score.
- Run the main scene, achieve a higher score than the previous best score, and confirm that the high score updates and saves correctly.
- Persistent high scores provide long-term goals across sessions, preventing best score progression from resetting after every run.

11. The background music continues to play when the game starts.
- Run the main scene and observe that the background music begins playing and loops at the end of the music audio with proper volume.
- Background music sets the atmosphere and provides continuous audio presence so the game does not feel silent during gameplay.

12. The game includes a kills counter under the score counter, displaying the total number of slimes defeated by the player character.
- Run the main scene and defeat multiple slimes to confirm that the slime kill counter increases correctly for each defeated enemy.
- The slime defeat counter tracks combat progress and provides immediate feedback on player performance throughout the run.

13. The game environment includes a white background with scattered green pine trees throughout the playable area.
- Run the main scene and observe that the environment displays a white background with green pine trees positioned around the map.
- The environmental visuals define the game atmosphere, improve visual clarity, and prevent the playable area from feeling unfinished.

14. The player character can move in all directions using the WASD keys.
- Run the main scene and move the player character with the WASD keys to confirm that movement control functions in all directions.
- WASD movement provides a consistent keyboard control scheme to allow the player to navigate the environment during gameplay.

15. The player character has a blue gun with muzzle flash and bullet impact effects, rotates while moving, and automatically targets the closest enemy on screen.
- Run the main scene and observe the player character shooting at nearby slimes to confirm muzzle flashes, bullet impacts, movement rotation, and automatic enemy targeting.
- Automatic enemy targeting and responsive weapon effects provide readable combat feedback and maintain smooth enemy encounters.

16. A health bar appears above the player character that decreases, changes color from green to red, and flashes a transparent white rapidly when health becomes critically low.
- Run the main scene, let the player character receive damage, and observe the health bar decrease, change color, and flash white rapidly when health becomes critically low.
- The health bar provides constant visual feedback about player survivability and warns the player during dangerous combat.

17. Green slimes continuously spawn around the environment, bounce to the player, and visually react to damage before dying after three hits.
- Run the main scene and observe green slimes spawning, following the player, reacting to attacks, and dying after taking three hits.
- Enemy spawning and damage reactions create sustained gameplay pressure and communicate combat interactions during encounters.

18. A smoke explosion effect appears when a slime dies, and when the player character dies after losing all health.
- Run the main scene, defeat a slime, then lose all player health to confirm that the smoke explosion effect appears in both events.
- Explosion effects provide visual confirmation for enemy and player deaths, improving combat readability and gameplay feedback.

19. The player character displays smooth body animations during movement, and slime enemies display bouncing and damage reactions.
- Run the main scene and observe the player character and slime enemies to confirm that body movement, bouncing, and damage animations play smoothly and consistently.
- Smooth animations improve gameplay readability and make character movement and combat interactions feel responsive.

20. Pressing the 0 key resets the stored high score during gameplay.
- Run the main scene, achieve a high score value, then press the 0 key to confirm that the stored high score resets correctly.
- Resetting the high score allows players to clear previous records at any time and restart score progression without deleting any saves.
<br>
Godot - Full Vertical Slice (Game Prototype) - Finished prompt creation.
