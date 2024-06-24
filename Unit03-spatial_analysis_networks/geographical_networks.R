# Geographic data in R

## call geographic coordinates, define them as nodes in your network

install.packages(c("sf", "ggmap", "cccd", "deldir", "geosphere", "RBGL"))
library(sf)
download.file(url = "https://book.archnetworks.net/data/Hispania_nodes.csv", destfile = "data_raw/Hispania_nodes.csv")
download.file(url = "https://book.archnetworks.net/data/Hispania_roads.csv", destfile = "data_raw/Hispania_roads.csv")
nodes <- read.csv("data_raw/Hispania_nodes.csv", header = T)
locs <- st_as_sf(nodes, coords = c("long", "lat"), crs = 4326)

locs

## call basemap

library(ggmap)
register_stadiamaps(key="c4a054a7-3219-48a0-8dfb-bfc01b8b68f8")
map <- get_stadiamap(bbox = c(-9.5, 36, 3, 43.8),
                     maptype = "stamen_terrain_background",
                     zoom = 6)
ggmap(map)

## Case study: Roman roads

library(igraph)
library(ggmap)
library(sf)

# Read in edge list and node location data and covert to network object
edges1 <- read.csv("data_raw/Hispania_roads.csv", header = TRUE)
nodes <- read.csv("data_raw/Hispania_nodes.csv", header = TRUE)
road_net <-
  graph_from_edgelist(as.matrix(edges1[, 1:2]), directed = FALSE)

# Convert attribute location data to sf coordinates
locations_sf <-
  st_as_sf(nodes, coords = c("long", "lat"), crs = 4326)
# We also create a simple set of xy coordinates as this is used
# by the geom_point function
xy <- data.frame(x = nodes$long, y = nodes$lat)

# Extract edge list from network object
edgelist <- get.edgelist(road_net)

# Create data frame of beginning and ending points of edges
edges <- as.data.frame(matrix(NA, nrow(edgelist), 4))
colnames(edges) <- c("X1", "Y1", "X2", "Y2")
# Iterate across each edge and assign lat and long values to
# X1, Y1, X2, and Y2
for (i in seq_len(nrow(edgelist))) {
  edges[i, ] <- c(nodes[which(nodes$Id == edgelist[i, 1]), 3],
                  nodes[which(nodes$Id == edgelist[i, 1]), 2],
                  nodes[which(nodes$Id == edgelist[i, 2]), 3],
                  nodes[which(nodes$Id == edgelist[i, 2]), 2])
}

# Download stamenmap background data.
my_map <- get_stadiamap(bbox = c(-9.5, 36, 3, 43.8),
                        maptype = "stamen_terrain_background",
                        zoom = 6)

# Produce map starting with background
ggmap(my_map) +
  # geom_segment plots lines by the beginning and ending
  # coordinates like the edges object we created above
  geom_segment(
    data = edges,
    aes(
      x = X1,
      y = Y1,
      xend = X2,
      yend = Y2
    ),
    col = "black",
    size = 1
  ) +
  # plot site node locations
  geom_point(
    data = xy,
    aes(x, y),
    alpha = 0.8,
    col = "black",
    fill = "white",
    shape = 21,
    size = 2,
    show.legend = FALSE
  ) +
  theme_void()

## Boyer-Myrvold planarity test (Boyer and Myrvold 2004)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("RBGL")
library(RBGL)
# First convert to a graphNEL object for planarity test
g <- as_graphnel(road_net)
# Implement test
boyerMyrvoldPlanarityTest(g)

## plot the data to evaluate this and do see crossed edges that could not be re-positioned
install.packages("ggraph")
library(ggraph)
set.seed(5364)
ggraph(road_net, layout = "kk") +
  geom_edge_link() +
  geom_node_point(size = 3) +
  ggtitle("Network of Roman Roads") +
  theme_graph()

## planar test success

install.packages("igraph")
library(igraph)
library(RBGL)
set.seed(49)
g <- erdos.renyi.game(20, 1 / 8)
set.seed(939)
plot(g)
g <- as_graphnel(g)
boyerMyrvoldPlanarityTest(g)

