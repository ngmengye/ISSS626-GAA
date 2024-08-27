#sf = simple features for importing, managing, and processing geospatial data
#tidyverse for performing data science tasks such as importing
#wrangling and visualizing data

pacman::p_load(sf,tidyverse)

mpsz = st_read(dsn = "Hands-on_Ex01/data/geospatial", 
               layer = "MP14_SUBZONE_WEB_PL")

cyclingpath = st_read(dsn = "Hands-on_Ex01/data/geospatial", 
                      layer = "CyclingPathGazette")

preschool = st_read("Hands-on_Ex01/data/geospatial/PreSchoolsLocation.kml")


#st_geometry = extract or replace geometry column
#geometry column contains the spatial data
st_geometry(preschool)
glimpse(cyclingpath)
head(mpsz,n=5)
plot(mpsz)
plot(st_geometry(mpsz))
plot(mpsz["PLN_AREA_N"])

#plot is meant for quick look, use tmap instead

st_crs(mpsz)
mpsz3414 <- st_set_crs(mpsz, 3414)
st_crs(mpsz3414)


# from GCS to PCS

st_geometry(preschool)
preschool3414 <- st_transform(preschool, 
                              crs = 3414)
st_geometry(preschool3414)

listings <- read_csv("Hands-on_Ex01/data/aspatial/listings.csv")

list(listings)

listings_sf <- st_as_sf(listings, 
                        coords = c("longitude", "latitude"),
                        crs=4326) %>%
  st_transform(crs = 3414)

glimpse(listings_sf)


buffer_cycling <- st_buffer(cyclingpath, 
                            dist=5, nQuadSegs = 30)

buffer_cycling$AREA <- st_area(buffer_cycling)
sum(buffer_cycling$AREA)

mpsz3414$`PreSch Count`<- lengths(st_intersects(mpsz3414, preschool3414))
summary(mpsz3414$`PreSch Count`)

top_n(mpsz3414,1,'PreSch Count')

mpsz3414$Area <- mpsz3414 %>% 
  st_area()

mpsz3414 <- mpsz3414 %>%
  mutate(`PreSch Density` = `PreSch Count`/Area * 1000000)

hist(mpsz3414$`PreSch Density`)

ggplot(data=mpsz3414, 
       aes(x= as.numeric(`PreSch Density`)))+
  geom_histogram(bins=20, 
                 color="black", 
                 fill="light blue") +
  labs(title = "Are pre-school even distributed in Singapore?",
       subtitle= "There are many planning sub-zones with a single pre-school, on the other hand, \nthere are two planning sub-zones with at least 20 pre-schools",
       x = "Pre-school density (per km sq)",
       y = "Frequency")


ggplot(data=mpsz3414, 
       aes(y = `PreSch Count`, 
           x= as.numeric(`PreSch Density`)))+
  geom_point(color="black", 
             fill="light blue") +
  xlim(0, 40) +
  ylim(0, 40) +
  labs(title = "",
       x = "Pre-school density (per km sq)",
       y = "Pre-school count")
