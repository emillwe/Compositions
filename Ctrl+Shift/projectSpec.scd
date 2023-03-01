/*
Title: myLastName-final

Course: DXARTS 462a Spring 2022 (https://canvas.uw.edu/courses/1546999)
Authors: Joseph Anderson, Dan Peterson, James Wenlock, et al.
Affiliation: DXARTS, University of Washington (https://dxarts.washington.edu/)
License: GPLv3

*/

/*
Using the following template -> myLastName-final.zip, compose a 3' piece using the digital sound processing and composition techniques reviewed in class. You're advised to use a variety of processing (and synthesis) techniques to create a variety of textures and materials for your piece. Additionally, consider deploying similar strategies developed for your mid-term project. E.g.,  choose a particular compositional idea and explore that in three different ways. Another possibility could be to seek to create variations on the material found in a single (or a number of) moment(s) of a piece from the repertoire of electro-acoustic & computer music. (Numerous examples found here.)

Further advice, your work will be reviewed in three areas:

SuperCollider3 language proficiency: demonstrate competence and creativity through your use of sc-lang
musical signal processing: develop and explore creative signal processing designs
musical language & composition: illustrate your understanding of the repertoire through pastiche composition and mastery of techniques reviewed
Be prepared to present your work to the class during the scheduled final.



Specific Requirements:

1 [myLastName]-final.scd file that successfully renders your composition
1 visual score (PDF)
1 commentary (300 words)
discuss the synthesis and compositional techniques used
reference pieces from the repertoire of electro-acoustic & computer music of influence
Please submit your project as a zip file of the complete project folder named using the following syntax

[myLastName]-final.zip

IMPORTANT: INSERT YOUR NAME BEFORE YOU ZIP YOUR FILE!



NOTE:

Your piece should not:
use techniques (UGens) we have not reviewed
use voice as a sound source
use externally recorded audio files
use only recordings from our Week 1 recording session
Additionally, your final piece should:
creatively explore the techniques we've encountered this Quarter
creatively explore compositional approaches we've reviewed in the literature
show what you've learned
You MAY include:
analysis of spectra of audio files (reference these!)
For the visual scores: Do not take a screenshot of the waveform, do not take a screenshot of the spectrogram, this MUST be a handmade score, NOT a computer analysis


Final How-To
--------------

Below is the final project file hierarchy.

final/

____commentary.scd <-- commentary (300 words) on composition

____functions/

________DO-NOT-EDIT/

________myFunctions/ <-- functions of your design

____graphicScore/ <-- visual scores for each composition

____[myLastName]-final.scd

____README.scd

____soundIn/

____soundOut/

____uGenGraphs/

________DO-NOT-EDIT/

________myUGens/ <-- uGens of your design

You will be writing code in two directories

myFunctions/ <-- folder containing functions of your design

myUGens/ <-- UGen graphs that you have modified or otherwise created

In addition to this, place 1 pdf with visual scores in the graphicScores/ directory and a 300 word commentary on your composition discussing synthesis techniques and references to the repertoire as comments in the commentary.scd file. You can find a template for your score inside of graphicScores/

This structure works identically to lecture code and previous assignments where functions and UGen graphs are accessed and executed using main. The overall structure of your composition will be created in [myLastName]-final.scd

The myUGens/ and myFunctions/ directories are designated for code you write. Inside you will find an empty template that you can copy and rename if you'd like to create something from scratch.

You might have noticed that there is no lecture material in the DO-NOT-EDIT folders inside of the functions/ and uGenGraphs/ directories. It is up to you to appropriately copy and edit lecture code for use in your projects.

Your composition is rendered by running the [myLastName]-final.scd file. Please write your full name at the top of this project. There is a variable called lastName. Please assign this variable a string containing your last name. You will also noticed six booleans: renderSection1, renderSection2 ... renderSection6. These booleans indicate whether or each section is rendered and can be changed as you work on your final. You will also notice that within the function for each section there is a var named sectionStartTime. Change this value to adjust when each section starts.

NOTE: Feel free to add more sections as desired. Additionally, a minimum of six sections is not a requirement, you may choose to have fewer.

*/