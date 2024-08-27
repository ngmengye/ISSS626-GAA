
```{r}
pacman::p_load(ggstatsplot)
```

mpsz14_kml = st_read("C:/mengyeng/ISSS608-VAA/Hands-on_Ex/Hands-on_Ex01/data/geospatial/MasterPlan2014SubzoneBoundaryWebKML.kml")

preschool = st_read("C:/mengyeng/Hands-on_Ex01/data/geospatial/PreSchoolsLocation.kml")

mpsz = st_read(dsn = "C:/mengyeng/Hands-on_Ex01/data/geospatial", layer = "MP14_SUBZONE_WEB_PL")

mpsz3414 <- st_set_crs(mpsz, 3414)
st_write(mpsz14_shp,
         "C:/mengyeng/Hands-on_Ex01/data/geospatial/MP14_SUBZONE_WEB_PL.kml",
         delete_dsn = TRUE)

mpsz19_kml <- st_read("C:/mengyeng/ISSS608-VAA/In-class_Ex/In-class exercise 01/data/MPSZ-2019/MasterPlan2019SubzoneBoundaryNoSea.KML")

mpsz19_shp <- st_read(dsn = "C:/mengyeng/ISSS608-VAA/In-class_Ex/In-class exercise 01/data/MPSZ-2019", layer = "MPSZ-2019")

mpsz19_shp <- st_read(dsn = "data/",
                      layer = "MPSZ-2019" %>% 
                        st_transform(CRS=3414))
