Started 18 May 2022
By Lizzie
Trying to organize things in Marseille, France

We have a lot of code in the lab related to nested models, but I am not sure any of it runs without divergences (and/or returns the correct values). While trying to work on adding a hierarchical level to our phylogeny Gaussian process model I started to try and sift through them. The below reviews that along with some links.

Useful links:
Mike Betancourt's factor modeling case studies reviews nested models: 
https://betanalpha.github.io/assets/case_studies/factor_modeling.html

Equations:
See git/teaching/gelmanhill/equations/sync_eqns.pdf (and .tex)

Dan Flynn models:
- Files like lday_ind2.stan lday_ind5.stan etc.
- Dan worked on nested models. I can't recall if he ever got them running properly, but it looks hopeful if you go back through commits (see below). 
- Progress on this is in (same models across these two folders):
	treegarden/budexperiments/analyses/stan/models_archive_nested
	treegarden/traits/analyses (lots of work here)
- Remember that Dan did not usually include mu and sigma values for his normals, he used offsets from the mean so have to sort of back construct the parameters. 
- Here's the latest commit: https://github.com/lizzieinvancouver/treetraits/commit/449d1bb10f93ca7ba663983655d66d14e46e0a4e
- If you follow Dan's commits, it looks like lday_ind5.stan was close to or working (https://github.com/lizzieinvancouver/treetraits/commit/449d1bb10f93ca7ba663983655d66d14e46e0a4e, and on Jun 3 -- https://github.com/lizzieinvancouver/treetraits/commit/6140ee2f9b8224a73250344266ac67c3c02e3ba5 -- he refers to it as mostly working) 

Cat Chamberlain models:
- See nointer_3levelwpop_force&photo_ncp.stan in OSPREE (analyses/ranges/stan/)
- Working on populations nested within species ... I need to ask her how this worked out in the end. 

Models working with Megan (in 2017 in Oahu):
- ** I think these are our best hope of working models. **
- Files generally named some variant of: threelevel_plotsinsites.stan
- These files used to exist in two folders ... I am moving them all now to nestedmodels (and renaming lizzieinvancouver/examplegit repo to nestedmodels) and clearing out a ton of stuff 

marseille2022:
- generatedata_threelevel_plotsinsites_interceptonly.R and .stan Lizzie built (from generatedata_threelevel_plotsinsites) on 18 May 2022
- This model runs, but have divergences. Mike Betancourt said these models can be finicky so I think the issue could be needing an NCP on the site level or such. Switching to only one sigma across sites might also help (there's code to do this shown; just need to turn on mostly I think; or can find it in oahu2017)

