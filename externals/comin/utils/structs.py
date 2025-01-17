#  @authors 11/2023 :: ICON Community Interface  <comin@icon-model.org>
#
#  SPDX-License-Identifier: BSD-3-Clause
#
#  Please see the file LICENSE in the root of the source tree for this code.
#  Where software is supplied by third parties, it is indicated in the
#  headers of the routines.

domain = {
    "grid_filename": ("char", 1, "ptr"),
    "grid_uuid": ("int8_t", 1, "ptr"),
    "number_of_grid_used": ("int", 1, "obj"),
    "id": ("int", 0, "ptr"),
    "n_childdom": ("int", 0, "ptr"),
    "dom_start": ("double", 0, "mem"),
    "dom_end": ("double", 0, "mem"),
    "nlev": ("int", 0, "ptr"),
    "nshift": ("int", 0, "ptr"),
    "nshift_total": ("int", 0, "ptr"),
    "cells": {"ncells": ("int", 0, "ptr"),
              "ncells_global": ("int", 0, "ptr"),
              "nblks": ("int", 0, "ptr"),
              "max_connectivity": ("int", 0, "ptr"),
              "clon": ("double", 2, "obj"),
              "clat": ("double", 2, "obj"),
              "area": ("double", 2, "ptr"),
              "hhl": ("double", 3, "obj"),
              "num_edges": ("int", 2, "ptr"),
              "refin_ctrl": ("int", 2, "ptr"),
              "start_index": ("int", 1, "ptr"),
              "end_index": ("int", 1, "ptr"),
              "start_block": ("int", 1, "ptr"),
              "end_block": ("int", 1, "ptr"),
              "child_id": ("int", 2, "ptr"),
              "child_idx": ("int", 3, "ptr"),
              "child_blk": ("int", 3, "ptr"),
              "parent_glb_idx": ("int", 2, "ptr"),
              "parent_glb_blk": ("int", 2, "ptr"),
              "vertex_idx": ("int", 3, "ptr"),
              "vertex_blk": ("int", 3, "ptr"),
              "neighbor_blk": ("int", 3, "ptr"),
              "neighbor_idx": ("int", 3, "ptr"),
              "edge_idx": ("int", 3, "ptr"),
              "edge_blk": ("int", 3, "ptr"),
              "glb_index": ("int", 1, "ptr"),
              "decomp_domain": ("int", 2, "ptr")},
    "verts": {"nverts": ("int", 0, "ptr"),
              "nverts_global": ("int", 0, "ptr"),
              "nblks": ("int", 0, "ptr"),
              "vlon": ("double", 2, "obj"),
              "vlat": ("double", 2, "obj"),
              "refin_ctrl": ("int", 2, "ptr"),
              "start_index": ("int", 1, "ptr"),
              "end_index": ("int", 1, "ptr"),
              "start_block": ("int", 1, "ptr"),
              "end_block": ("int", 1, "ptr"),
              "neighbor_blk": ("int", 3, "ptr"),
              "neighbor_idx": ("int", 3, "ptr"),
              "cell_idx": ("int", 3, "ptr"),
              "cell_blk": ("int", 3, "ptr"),
              "edge_idx": ("int", 3, "ptr"),
              "edge_blk": ("int", 3, "ptr")},
    "edges": {"nedges": ("int", 0, "ptr"),
              "nedges_global": ("int", 0, "ptr"),
              "nblks": ("int", 0, "ptr"),
              "elon": ("double", 2, "obj"),
              "elat": ("double", 2, "obj"),
              "refin_ctrl": ("int", 2, "ptr"),
              "start_index": ("int", 1, "ptr"),
              "end_index": ("int", 1, "ptr"),
              "start_block": ("int", 1, "ptr"),
              "end_block": ("int", 1, "ptr"),
              "child_id": ("int", 2, "ptr"),
              "child_idx": ("int", 3, "ptr"),
              "child_blk": ("int", 3, "ptr"),
              "parent_glb_idx": ("int", 2, "ptr"),
              "parent_glb_blk": ("int", 2, "ptr"),
              "cell_idx": ("int", 3, "ptr"),
              "cell_blk": ("int", 3, "ptr"),
              "vertex_idx": ("int", 3, "ptr"),
              "vertex_blk": ("int", 3, "ptr")}
    }

glob = {"n_dom": ("int", 0, "mem"),
        "max_dom": ("int", 0, "mem"),
        "nproma": ("int", 0, "mem"),
        "wp": ("int", 0, "mem"),
        "min_rlcell_int": ("int", 0, "mem"),
        "min_rlcell": ("int", 0, "mem"),
        "grf_bdywidth_c": ("int", 0, "mem"),
        "grf_bdywidth_e": ("int", 0, "mem"),
        "lrestartrun": ("bool", 0, "mem"),
        "vct_a": ("double", 1, "obj"),
        "yac_instance_id": ("int", 0, "mem")}

parallel = {
            "global_size": ("int", 0, "ptr")}
