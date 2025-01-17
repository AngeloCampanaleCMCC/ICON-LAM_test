#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "cdi.h"
#include "dmemory.h"

int
main(void)
{
  char fname[] = "test_grib.grb";
  int filetype = CDI_FILETYPE_GRB;
  enum
  {
    nlat = 18,
    nlon = 2 * nlat,
  };
  double *data = NULL;
  int nlevel;
  int varID;
  int streamID1, streamID2;
  int gridID, zaxisID;
  int nvars;
  int tsID;
  int levelID;
  int vlistID, taxisID;
  SizeType nmiss;

  size_t datasize = (size_t) nlon * (size_t) nlat;
  data = (double *) Malloc(datasize * sizeof(double));
  memset(data, 0, datasize * sizeof(double));

  gridID = gridCreate(GRID_GAUSSIAN, (int) datasize);
  gridDefXsize(gridID, nlon);
  gridDefYsize(gridID, nlat);

  zaxisID = zaxisCreate(ZAXIS_SURFACE, 1);

  vlistID = vlistCreate();
  vlistDefVar(vlistID, gridID, zaxisID, TIME_VARIABLE);

  taxisID = taxisCreate(TAXIS_ABSOLUTE);
  vlistDefTaxis(vlistID, taxisID);

  streamID1 = streamOpenWrite(fname, filetype);
  if (streamID1 < 0)
    {
      fprintf(stderr, "Open failed on %s\n", fname);
      fprintf(stderr, "%s\n", cdiStringError(streamID1));
      return (-1);
    }

  streamDefVlist(streamID1, vlistID);

  (void) streamDefTimestep(streamID1, 0);

  streamWriteVar(streamID1, 0, data, 0);

  free(data);
  return (0);

  vlistID = streamInqVlist(streamID1);

  filetype = streamInqFiletype(streamID1);

  streamID2 = streamOpenWrite(fname, filetype);
  if (streamID2 < 0)
    {
      fprintf(stderr, "Open failed on %s\n", fname);
      fprintf(stderr, "%s\n", cdiStringError(streamID2));
      return (-1);
    }

  streamDefVlist(streamID2, vlistID);

  nvars = vlistNvars(vlistID);

  for (varID = 0; varID < nvars; varID++)
    {
      int varGridID = vlistInqVarGrid(vlistID, varID);
      int varZaxisID = vlistInqVarZaxis(vlistID, varID);
      size_t gridsize = (size_t) gridInqSize(varGridID);
      size_t varNlevel = (size_t) zaxisInqSize(varZaxisID);
      if (gridsize * varNlevel > datasize) datasize = gridsize * varNlevel;
    }

  data = (double *) Realloc(data, datasize * sizeof(double));
  memset(data, 0, datasize * sizeof(double));

  taxisID = vlistInqTaxis(vlistID);

  tsID = 0;
  while (streamInqTimestep(streamID1, tsID))
    {
      /* int vdate =  */ taxisInqVdate(taxisID);
      /* int vtime =  */ taxisInqVtime(taxisID);

      streamDefTimestep(streamID2, tsID);

      for (varID = 0; varID < nvars; varID++)
        {
          streamReadVar(streamID1, varID, data, &nmiss);

          /* int code = */ vlistInqVarCode(vlistID, varID);
          gridID = vlistInqVarGrid(vlistID, varID);
          zaxisID = vlistInqVarZaxis(vlistID, varID);
          /* int gridtype = */ gridInqType(gridID);
          /* int gridsize = */ gridInqSize(gridID);
          nlevel = zaxisInqSize(zaxisID);
          /* double missval = */ vlistInqVarMissval(vlistID, varID);

          for (levelID = 0; levelID < nlevel; levelID++)
            {
              /* int level  = (int) */ zaxisInqLevel(zaxisID, levelID);
              /* int offset = gridsize*levelID; */
            }

          streamWriteVar(streamID2, varID, data, nmiss);
        }
      tsID++;
    }

  free(data);

  streamClose(streamID2);
  streamClose(streamID1);

  return (0);
}
/*
 * Local Variables:
 * c-file-style: "Java"
 * c-basic-offset: 2
 * indent-tabs-mode: nil
 * show-trailing-whitespace: t
 * require-trailing-newline: t
 * End:
 */
