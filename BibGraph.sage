##############################################
# BibGraph
#
# a BibDesk export template by Alejandro Erickson

# Created in March, 2014.

# Released under a Creative Commons License, Attribution 4.0
# International, https://creativecommons.org/licenses/by/4.0/

# Use this at your own risk.  If your BibTeX file contains python
# code, it may execute when you run the output of this template in
# Sage.

# This BibDesk template works with Sage (6.1.1), which can be used
# online at http://www.sagenb.org/ or downloaded from
# http://www.sagemath.org/, and the output can be adjusted with
# inkscape.

# ABOUT: When used succesfully, this template (and your ensuing
# labour) draws authors and references as points which are connected
# by lines.  It should highlight prolific authors, collaborations, and
# the chronology of an individual's work within your bibliography.

# TECHNICAL NOTE: The sage script differentiates authors and
# publications by searching for digits in exported string.  Authors
# with numbers in their names, or publications without years may
# appear in the wrong place.  Additionally, if an author appears with
# different spellings of their first names or initials, they will
# appear twice in the graph.

# INSTRUCTIONS: For best results, sort the desired BibDesk entries by
# date, and DO NOT SELECT ANY ENTRIES WITHOUT A YEAR.  Use this export
# template (see BibDesk documentation).

# Copy the template output to a sage notebook worksheet and execute it.
# If necessary adjust the step sizes

vertical_step = 40
horizontal_step = 2000

# and perhaps the figure width and height

fig_width = 30
fig_height = 30

# and re-execute.

##################################
#################################

G = Graph({<$publications>
<$fields.Year?>
"""<$fields.Year.stringByDeTeXifyingString/>,<$fields.Title.stringByDeTeXifyingString/>,<$fields.Journal.stringByDeTeXifyingString/>,<$authors.unpunctuatedAbbreviatedNormalizedName.stringByDeTeXifyingString.@componentsJoinedByComma/>""".decode("utf-8",errors='ignore').encode('ascii',errors='ignore'):[
<$authors?>
"""</$authors?>
<$authors>
<$unpunctuatedAbbreviatedNormalizedName.stringByDeTeXifyingString/><?$authors>
""".decode("utf-8",errors='ignore').encode('ascii',errors='ignore'),"""</$authors>
<$authors?>
""".decode("utf-8",errors='ignore').encode('ascii',errors='ignore')</$authors?>
]
</$fields.Year?>
<?$publications>
,
</$publications>
})

L = [<$publications>
"""<$fields.Year.stringByDeTeXifyingString/>,<$fields.Title.stringByDeTeXifyingString/>,<$fields.Journal.stringByDeTeXifyingString/>,<$authors.unpunctuatedAbbreviatedNormalizedName.stringByDeTeXifyingString.@componentsJoinedByComma/>""".decode("utf-8",errors='ignore').encode('ascii',errors='ignore')<$authors?>
,"""</$authors?>
<$authors>
<$unpunctuatedAbbreviatedNormalizedName.stringByDeTeXifyingString/><?$authors>
""".decode("utf-8",errors='ignore').encode('ascii',errors='ignore'),"""</$authors>
<$authors?>
""".decode("utf-8",errors='ignore').encode('ascii',errors='ignore')</$authors?>
<?$publications>
,
</$publications>
]

i=0
j=0
vDict = {}
for v in L:
    #This is how we differentiate between authors and publications
    if (not v in vDict) and (len(v) == len(v.strip("0123456789"))):
        vDict[v] = (0,i)
        i=i+vertical_step
    elif (not v in vDict):
        vDict[v] = (horizontal_step,j)
        j=j+vertical_step
G.set_pos(vDict)  

#This is a hack to align the labels nicely.
lDict = {}
for v in vDict:
    if vDict[v][0] == 0:
        lDict[v] = v + len(v)*' ' + '.'
    else:
        lDict[v] = ''.join(['.',len(v)*' ',v])
G.relabel(lDict)

import matplotlib as mpl
mpl.rcParams['font.family'] = 'monospace'
#mpl.rcParams['font.weight'] = 'bold'


show(G.plot(vertex_size=0),figsize=[fig_width,fig_height])
#To save to file you can use 
#show(G.plot(vertex_size=0),figsize=[fig_width,fig_height], filename='FULL PATH TO FILE.svg or .eps or .png')
