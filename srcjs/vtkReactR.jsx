import { reactWidget } from 'reactR';
import { View,
         VolumeDataRepresentation,
         VolumeRepresentation,
         VolumeController,
         ImageData,
       } from 'react-vtk-js';

import 'react-vtk-js';

reactWidget('vtkReactR', 'output', {
  View: View,
  VolumeDataRepresentation: VolumeDataRepresentation,
  VolumeController: VolumeController,
  VolumeRepresentation: VolumeRepresentation,
  ImageData: ImageData
});
