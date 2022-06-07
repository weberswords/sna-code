library("openxlsx") 
library("tidyverse")
library("igraph")
library("ggraph")
library("tidygraph")
library("here") 

file = readline(prompt="Enter the name of the file: ")
data=read.xlsx(file, 1)

create_edge_graph <- function(data) {
    data %>% select(author_id, parent_question_user_id) -> edges
    return(edge_graph=graph_from_data_frame(edges, directed=TRUE))
}

create_dot_plot <- function(data) {
    edge_graph = create_edge_graph(data)
    print("Creating dot plot...")
    plot(edge_graph, vertex.size=10, vertex.label=NA)
}

create_line_circle <- function(data) {
    edge_graph = create_edge_graph(data)
    print("Creating line circle...")
    ggraph(edge_graph, layout = 'circle') + geom_edge_link() + geom_node_point()
}

create_node_lines <- function(data) {
    edge_graph = create_edge_graph(data)
    edge_graph %>% ggraph(layout = "kk") + geom_edge_link() + geom_node_point()
}

# Plots by Metrics
edge_graph = create_edge_graph(data)
create_table_graph <- function(edge_graph) {
    table_graph = as_tbl_graph(edge_graph)
    return(table_graph)
}

create_graph_layout <- function() {
    table_graph = create_table_graph(edge_graph)
    layout = create_layout(table_graph, layout = "kk")
    return(layout)
}

centrality_nodes <- function() {
    table_graph = create_table_graph(edge_graph)

    table_graph %>%
    activate(nodes) %>%
    mutate(deg = centrality_degree(mode = "total")) %>% arrange(desc(deg)) -> table_graph
    table_graph %>%
    ggraph(layout="kk") + geom_edge_link() + geom_node_point(aes(size = deg )) + theme(legend.position="bottom")
}