################################################################################
#github-zsdawson
#idea-proof of concept, see if you can import and export from Google sheets with-
#in r studio
#gs will mean (Google sheets) in documentation 
################################################################################
install.packages(googlesheets4)
library(googlesheets4)

gs4_auth(
  email = gargle::gargle_oauth_email(),# more used when using token
  path = NULL,
  scopes = "https://www.googleapis.com/auth/spreadsheets",
  cache = gargle::gargle_oauth_cache(),
  use_oob = gargle::gargle_oob_default(),
  token = NULL
)


x <- gs4_find()#lists all 
gs4_find(order_by =
         "createdTime desc", n_max = 11
         ) # lists 11 most recently created sheets


# use this to get the id for the sheets file once you see the pattern you can 
# grab it straight from the URL but this helps and its simpler 
#
# to demo this id gram something simple that you know well in your drive i used 
#the iris data set
as_id("https://docs.google.com/spreadsheets/d/1GRvYRDtzcDH50JP1VEH7x29uzO5Y2-Cy0FOtGN_visA/edit#gid=750754761")
 # 1GRvYRDtzcDH50JP1VEH7x29uzO5Y2-Cy0FOtGN_visA


# imports first row as col names so take that in to thought while formatting sheets 
# but it takes the data from gs and puts it in r 
x <- range_read(
  "1GRvYRDtzcDH50JP1VEH7x29uzO5Y2-Cy0FOtGN_visA",
  col_names = TRUE,
  col_types = NULL,
)

# makes new gs file that is blank and uploads the data to it
gs4_create(
  "sheet-write-test",
  sheets = x#data from line 37ish
)

# moves the gs file just made to the trash
gs4_find("sheet-write-test") %>%
  googledrive::drive_trash()


