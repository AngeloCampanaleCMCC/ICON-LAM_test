/**
 * @file test_dummy_coupling_c.c
 *
 * @copyright Copyright  (C)  2013 DKRZ, MPI-M
 *
 * @author Moritz Hanke <hanke@dkrz.de>
 *         Rene Redler  <rene.redler@mpimet.mpg.de>
 *
 */
/*
 * Keywords:
 * Maintainer: Moritz Hanke <hanke@dkrz.de>
 *             Rene Redler <rene.redler@mpimet.mpg.de>
 * URL: https://dkrz-sw.gitlab-pages.dkrz.de/yac/
 *
 * This file is part of YAC.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are  permitted provided that the following conditions are
 * met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *
 * Neither the name of the DKRZ GmbH nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <mpi.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "tests.h"
#include "test_common.h"
#include "yac_interface.h"
#include "utils.h"
#include "grid.h"

#define NBR_CELLS 2
#define NBR_VERTICES 4

struct {
  char const * name;
  int collection_size;
} field[] =
  {{.name = "TAUX",   .collection_size = 2},
   {.name = "TAUY",   .collection_size = 2},
   {.name = "SFWFLX", .collection_size = 3},
   {.name = "SFTEMP", .collection_size = 1},
   {.name = "THFLX",  .collection_size = 4},
   {.name = "ICEATM", .collection_size = 4},
   {.name = "SST",    .collection_size = 1},
   {.name = "OCEANU", .collection_size = 1},
   {.name = "OCEANV", .collection_size = 1},
   {.name = "ICEOCE", .collection_size = 5}};

char * yaml_filename = "coupling_test.yaml";

enum {no_of_fields = sizeof(field) / sizeof(field[0])};

const int nbr_cells = NBR_CELLS;
const int nbr_vertices = NBR_VERTICES;
int nbr_vertices_per_cell[NBR_CELLS];

int info, ierror;
int comp_id;
int comp_ids[1];

int cell_point_ids[1];
int cell_mask_ids[1];

int grid_id;

int global_index[NBR_CELLS];
int cell_core_mask[NBR_CELLS];

double * buffer;
double * buffer_lon;
double * buffer_lat;
int * cell_to_vertex;

int * field_id;
int * cell_mask;

int flag;

static void dummy_atmosphere ();
static void dummy_ocean ();
static void dummy_io ();

int main (void) {

  yac_cinit();

  int size, rank;
  MPI_Comm_rank ( MPI_COMM_WORLD, &rank );
  MPI_Comm_size ( MPI_COMM_WORLD, &size );

  switch ( rank ) {

  case 0:
    dummy_atmosphere ( );
    break;

  case 1:
    dummy_ocean ( );
    break;

  case 2:
    dummy_io ( );
    break;

  default:
    PUT_ERR("Too many processes have been launched\n");
    return TEST_EXIT_CODE;
  }

  yac_cfinalize ();

  return TEST_EXIT_CODE;
}

/* -------------------------------------------------------------------- */

static void dummy_atmosphere () {

  int size, rank;

  MPI_Comm local_comm;

  char * comp_name = "dummy_atmosphere";
  char * grid_name = "dummy_atmosphere_grid";

  // Inform the coupler about what we are
  yac_cdef_comp ( comp_name, &comp_id );
  comp_ids[0] = comp_id;

  yac_cget_comp_comm ( comp_id, &local_comm );

  MPI_Comm_rank ( local_comm, &rank );
  MPI_Comm_size ( local_comm, &size );

  // printf (" %s rank %d : local size %d \n", comp_name, rank, size );

  buffer_lon = xmalloc ( nbr_vertices * sizeof(*buffer_lon) );
  buffer_lat = xmalloc ( nbr_vertices * sizeof(*buffer_lat) );
  cell_to_vertex = xmalloc ( 3 * nbr_cells * sizeof(*cell_to_vertex) );

  /* Define vertices

      0
     / \
    / o \
   /     \
  1-------2   Eq.
   \     /
    \ o /
     \ /
      3

  */

  buffer_lon[0] =  0.0; buffer_lat[0] =  1.0;
  buffer_lon[1] = -1.0; buffer_lat[1] =  0.0;
  buffer_lon[2] =  1.0; buffer_lat[2] =  0.0;
  buffer_lon[3] =  0.0; buffer_lat[3] = -1.0;

  // Connectivity

  cell_to_vertex[0] = 0; cell_to_vertex[1] = 1; cell_to_vertex[2] = 2; // cell 1
  cell_to_vertex[3] = 1; cell_to_vertex[4] = 3; cell_to_vertex[5] = 2; // cell 2

  for (unsigned i = 0; i < nbr_cells; ++i ) nbr_vertices_per_cell[i] = 3;

  // Define unstructured grid

  yac_cdef_grid_unstruct(
    grid_name, nbr_vertices, nbr_cells, nbr_vertices_per_cell,
    buffer_lon, buffer_lat, cell_to_vertex, &grid_id);

  // Decomposition information

  for (int i = 0; i < nbr_cells; ++i ) {
    global_index[i] = i;
    cell_core_mask[i] = 1;
  }

  yac_cset_global_index(global_index, CELL, grid_id);
  yac_cset_core_mask(cell_core_mask, CELL, grid_id);

  // Center points in cells (needed e.g. for nearest neighbour)

  buffer_lon[0] = 0.0; buffer_lat[0] =  0.5;
  buffer_lon[1] = 0.0; buffer_lat[1] = -0.5;

  yac_cdef_points_unstruct(
    grid_id, nbr_cells, CELL, buffer_lon, buffer_lat, &cell_point_ids[0]);

  free ( buffer_lon );
  free ( buffer_lat );

  // Mask generation

  cell_mask = xmalloc (nbr_cells * sizeof(*cell_mask));

  for (unsigned i = 0; i < nbr_cells; ++i) cell_mask[i] = 1;

  yac_cdef_mask ( grid_id, nbr_cells, CELL, cell_mask, cell_mask_ids );

  yac_cset_mask(cell_mask, cell_point_ids[0]);

  free (cell_mask);

  yac_cdef_calendar(YAC_PROLEPTIC_GREGORIAN);

  field_id = xmalloc ( no_of_fields * sizeof(*field_id));

  for (unsigned i = 0; i < no_of_fields/2; ++i )
    yac_cdef_field ( field[i].name,
                     comp_id,
                     cell_point_ids,
                     1, field[i].collection_size,
                     "600", YAC_TIME_UNIT_SECOND,
                     &field_id[i] );

  for (unsigned i = no_of_fields/2; i < no_of_fields; ++i )
    yac_cdef_field_mask ( field[i].name,
                          comp_id,
                          cell_point_ids,
                          cell_mask_ids,
                          1, field[i].collection_size,
                          "600", YAC_TIME_UNIT_SECOND,
                          &field_id[i] );

  // read couplings from YAML configuration file
  yac_cread_config_yaml(yaml_filename);

  yac_cenddef ( );

  // these queries can only be fulfilled once the search has been completed.

  for (unsigned i = 0; i < no_of_fields; ++i ) {
    const char* timestep_string = yac_cget_timestep_from_field_id ( field_id[i] );
    if (strcmp(timestep_string,"PT10M")) PUT_ERR ( "wrong model time step\n");

    int collection_size;
    int const ref_collection_size[no_of_fields] = {2,2,3,1,4,4,1,1,1,5};
    collection_size = yac_cget_collection_size_from_field_id( field_id[i] );
    if (collection_size != ref_collection_size[i])
      PUT_ERR ( "wrong collection size\n");

    int role = yac_cget_role_from_field_id(field_id[i] );
    if ((i < 6) && (role != 1)) PUT_ERR( "Wrong requested role\n" );
    if ((i > 5) && (role != 2)) PUT_ERR( "Wrong requested role\n" );
  }

  // Data exchange

  buffer = xmalloc (5 * nbr_cells * sizeof (*buffer));

  /* field_id[0] represents "TAUX"   wind stress component
     field_id[1] represents "TAUY"   wind stress component
     field_id[2] represents "SFWFLX" surface fresh water flux
     field_id[3] represents "SFTEMP" surface temperature
     field_id[4] represents "THFLX"  total heat flux
     field_id[5] represents "ICEATM" ice temperatures and melt potential

     field_id[6] represents "SST"    sea surface temperature
     field_id[7] represents "OCEANU" u component of ocean surface current
     field_id[8] represents "OCEANV" v component of ocean surface current
     field_id[9] represents "ICEOCE" ice thickness, concentration and temperatures
  */

  // Send fields to ocean
  // --------------------

  {
    double *point_set_data[5];
    double **collection_data[5];

    for (int i = 0; i < 5; ++i) {
      point_set_data[i] = buffer + i * nbr_cells;
      collection_data[i] = &(point_set_data[i]);
    }

    // meridional wind stress
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 10.1;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[1*nbr_cells+i] = 10.2;

    yac_cput ( field_id[0], 2, collection_data, &info, &ierror );

    // zonal  wind stress
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 20.1;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[1*nbr_cells+i] = 20.2;

    yac_cput ( field_id[1], 2, collection_data, &info, &ierror );

    // surface fresh water flux
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 30.1;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[1*nbr_cells+i] = 30.2;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[2*nbr_cells+i] = 30.3;

    yac_cput ( field_id[2], 3, collection_data, &info, &ierror );

    // surface temperature

    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 40.1;

    yac_cput ( field_id[3], 1, collection_data, &info, &ierror );

    // total heat flux

    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 50.1;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[1*nbr_cells+i] = 50.2;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[2*nbr_cells+i] = 50.3;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[3*nbr_cells+i] = 50.4;

    yac_cput ( field_id[4], 4, collection_data, &info, &ierror );

    // ice temperatures and melt potential

    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 60.1;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[1*nbr_cells+i] = 60.2;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[2*nbr_cells+i] = 60.3;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[3*nbr_cells+i] = 60.4;

    yac_cput ( field_id[5], 4, collection_data, &info, &ierror );

    // check whether yac_ctest does not crash here
    yac_ctest ( field_id[5], &flag );
  }

  //
  // Receive fields from ocean
  // -------------------------

  {
    double *collection_data[5];

    for (int i = 0; i < 5; ++i) {
      collection_data[i] = buffer + i * nbr_cells;
    }

    // SST

    yac_cget ( field_id[6], 1, collection_data, &info, &ierror );
    if (info > 0 && double_are_unequal(buffer[0], 110.1 ))
      PUT_ERR("wrong atmosphere CPL SST\n");

    // zonal velocity

    yac_cget ( field_id[7], 1, collection_data, &info, &ierror );
    if (info > 0 && double_are_unequal(buffer[0], 120.1 ))
      PUT_ERR("wrong atmosphere CPL OCEANU\n");

    // meridional velocity

    yac_cget ( field_id[8], 1, collection_data, &info, &ierror );
    if (info > 0 && double_are_unequal(buffer[0], 130.1 ))
      PUT_ERR("wrong atmosphere CPL OCEANV\n");

    // Ice thickness, concentration, T1 and T2

    yac_cget ( field_id[9], 5, collection_data, &info, &ierror );

    for (int i = 0; i < nbr_cells; ++i) {
      if ( info > 0 ) {
        if (double_are_unequal(buffer[0*nbr_cells + i], 140.1 ))
          PUT_ERR ( "wrong atmosphere CPL ice 1\n");
        if (double_are_unequal(buffer[1*nbr_cells + i], 140.2 ))
          PUT_ERR ( "wrong atmosphere CPL ice 2\n");
        if (double_are_unequal(buffer[2*nbr_cells + i], 140.3 ))
          PUT_ERR ( "wrong atmosphere CPL ice 3\n");
        if (double_are_unequal(buffer[3*nbr_cells + i], 140.4 ))
          PUT_ERR ( "wrong atmosphere CPL ice 4\n");
        if (double_are_unequal(buffer[4*nbr_cells + i], 140.5 ))
          PUT_ERR ( "wrong atmosphere CPL ice 5\n");
      }
    }

    // for target fields, yac_ctest should always return 1
    yac_ctest ( field_id[9], &flag );
    if (!flag) PUT_ERR("error in yac_ctest");
  }

  free (buffer);
  free (field_id);

  MPI_Comm_free ( &local_comm );
}

/* -------------------------------------------------------------------- */

static void dummy_ocean () {

  int size, rank;

  MPI_Comm local_comm;
 
  char * comp_name = "dummy_ocean";
  char * grid_name = "dummy_ocean_grid";

  // Inform the coupler about what we are
  yac_cdef_comp ( comp_name, &comp_id );
  comp_ids[0] = comp_id;

  yac_cget_comp_comm ( comp_id, &local_comm );

  MPI_Comm_rank ( local_comm, &rank );
  MPI_Comm_size ( local_comm, &size );

  // printf (" %s rank %d : local size %d \n", comp_name, rank, size );

  buffer_lon = xmalloc ( nbr_vertices * sizeof(*buffer_lon) );
  buffer_lat = xmalloc ( nbr_vertices * sizeof(*buffer_lat) );
  cell_to_vertex = xmalloc ( 3 * nbr_cells * sizeof(*cell_to_vertex) );

  /* Define vertices

      0
     / \
    / o \
   /     \
  1-------2   Eq.
   \     /
    \ o /
     \ /
      3

  */

  buffer_lon[0] =  0.0; buffer_lat[0] =  1.0;
  buffer_lon[1] = -1.0; buffer_lat[1] =  0.0;
  buffer_lon[2] =  1.0; buffer_lat[2] =  0.0;
  buffer_lon[3] =  0.0; buffer_lat[3] = -1.0;

  // Connectivity

  cell_to_vertex[0] = 0; cell_to_vertex[1] = 1; cell_to_vertex[2] = 2; // cell 1
  cell_to_vertex[3] = 1; cell_to_vertex[4] = 3; cell_to_vertex[5] = 2; // cell 2

  for (unsigned i = 0; i < nbr_cells; ++i ) nbr_vertices_per_cell[i] = 3;

  yac_cdef_grid_unstruct(
    grid_name, nbr_vertices, nbr_cells, nbr_vertices_per_cell,
    buffer_lon, buffer_lat, cell_to_vertex, &grid_id);

  // Decomposition information

  for (int i = 0; i < nbr_cells; ++i ) {
    global_index[i] = i;
    cell_core_mask[i] = 1;
  }

  yac_cset_global_index(global_index, CELL, grid_id);
  yac_cset_core_mask(cell_core_mask, CELL, grid_id);

  // Center points in cells (needed e.g. for nearest neighbour)

  buffer_lon[0] = 0.0; buffer_lat[0] =  0.5;
  buffer_lon[1] = 0.0; buffer_lat[1] = -0.5;

  yac_cdef_points_unstruct(
    grid_id, nbr_cells, CELL, buffer_lon, buffer_lat, &cell_point_ids[0]);

  free ( buffer_lon );
  free ( buffer_lat );

  // Mask generation

  cell_mask = xmalloc (nbr_cells * sizeof(*cell_mask));

  for (unsigned i = 0; i < nbr_cells; ++i) cell_mask[i] = 1;

  yac_cdef_mask ( grid_id, nbr_cells, CELL, cell_mask, cell_mask_ids );

  yac_cset_mask(cell_mask, cell_point_ids[0]);

  free (cell_mask);

  yac_cdef_calendar(YAC_PROLEPTIC_GREGORIAN);

  field_id = xmalloc ( no_of_fields * sizeof(*field_id));

  for (unsigned i = 0; i < no_of_fields/2; ++i )
    yac_cdef_field ( field[i].name,
                     comp_id,
                     cell_point_ids,
                     1, field[i].collection_size,
                     "3600", YAC_TIME_UNIT_SECOND,
                     &field_id[i] );

  for (unsigned i = no_of_fields/2; i < no_of_fields; ++i )
    yac_cdef_field_mask ( field[i].name,
                          comp_id,
                          cell_point_ids,
                          cell_mask_ids,
                          1, field[i].collection_size,
                          "3600", YAC_TIME_UNIT_SECOND,
                          &field_id[i] );

  // read couplings from YAML configuration file
  yac_cread_config_yaml(yaml_filename);

  yac_cenddef ( );

  // Data exchange

  buffer = xmalloc (5 * nbr_cells * sizeof (*buffer));

  /* field_id[0] represents "TAUX"   wind stress component
     field_id[1] represents "TAUY"   wind stress component
     field_id[2] represents "SFWFLX" surface fresh water flux
     field_id[3] represents "SFTEMP" surface temperature
     field_id[4] represents "THFLX"  total heat flux
     field_id[5] represents "ICEATM" ice temperatures and melt potential

     field_id[6] represents "SST"    sea surface temperature
     field_id[7] represents "OCEANU" u component of ocean surface current
     field_id[8] represents "OCEANV" v component of ocean surface current
     field_id[9]represents "ICEOCE" ice thickness, concentration and temperatures
  */

  // Send fields from ocean to atmosphere
  // ------------------------------------

  {
    double *point_set_data[5];
    double **collection_data[5];

    for (unsigned i = 0; i < 5; ++i) {
      point_set_data[i] = buffer + i * nbr_cells;
      collection_data[i] = &(point_set_data[i]);
    }

    // SST
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 110.1;

    yac_cput ( field_id[6], 1, collection_data, &info, &ierror );

    // zonal velocity

    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 120.1;

    yac_cput ( field_id[7], 1, collection_data, &info, &ierror );

    // meridional velocity

    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 130.1;

    yac_cput ( field_id[8], 1, collection_data, &info, &ierror );

    // Ice thickness, concentration, T1 and T2

    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[0*nbr_cells+i] = 140.1;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[1*nbr_cells+i] = 140.2;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[2*nbr_cells+i] = 140.3;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[3*nbr_cells+i] = 140.4;
    for (unsigned i = 0; i < nbr_cells; ++i ) buffer[4*nbr_cells+i] = 140.5;

    yac_cput ( field_id[9], 5, collection_data, &info, &ierror );
  }

  // Receive fields from atmosphere
  // ------------------------------

  {
    double *collection_data[5];

    for (unsigned i = 0; i < 5; ++i) {
      collection_data[i] = buffer + i * nbr_cells;
    }

    // zonal wind stress

    yac_cget ( field_id[0], 2, collection_data, &info, &ierror );

    // meridional wind stress

    yac_cget ( field_id[1], 2, collection_data, &info, &ierror );

    // freshwater flux

    yac_cget ( field_id[2], 3, collection_data, &info, &ierror );

    // surface air temperature
    yac_cget ( field_id[3], 1, collection_data, &info, &ierror );

    // total heat flux - 4 parts - record 5

    yac_cget ( field_id[4], 4, collection_data, &info, &ierror );

    // ice parameter

    yac_cget ( field_id[5], 4, collection_data, &info, &ierror );

  }

  free (buffer);
  free (field_id);

  MPI_Comm_free ( &local_comm );
}

/* -------------------------------------------------------------------- */

static void dummy_io () {

  int size, rank;

  MPI_Comm local_comm;

  field_id = NULL;

  char * comp_name = "dummy_io";

  // Inform the coupler about what we are
  yac_cdef_comp ( comp_name, &comp_id );

  yac_cget_comp_comm ( comp_id, &local_comm );

  MPI_Comm_rank ( local_comm, &rank );
  MPI_Comm_size ( local_comm, &size );

  // printf (" %s rank %d : local size %d \n", comp_name, rank, size );

  // An empty search call to mark the end of the definition phase

  yac_cenddef ( );

  MPI_Comm_free ( &local_comm );
}
