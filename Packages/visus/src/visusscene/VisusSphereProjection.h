/***********************************************************************
*
* Copyright (c) 2008, Lawrence Livermore National Security, LLC.  
* Produced at the Lawrence Livermore National Laboratory  
* Written by bremer5@llnl.gov,pascucci@sci.utah.edu.  
* LLNL-CODE-406031.  
* All rights reserved.  
*   
* This file is part of "Simple and Flexible Scene Graph Version 2.0."
* Please also read BSD_ADDITIONAL.txt.
*   
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
*   
* @ Redistributions of source code must retain the above copyright
*   notice, this list of conditions and the disclaimer below.
* @ Redistributions in binary form must reproduce the above copyright
*   notice, this list of conditions and the disclaimer (as noted below) in
*   the documentation and/or other materials provided with the
*   distribution.
* @ Neither the name of the LLNS/LLNL nor the names of its contributors
*   may be used to endorse or promote products derived from this software
*   without specific prior written permission.
*   
*  
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL LAWRENCE
* LIVERMORE NATIONAL SECURITY, LLC, THE U.S. DEPARTMENT OF ENERGY OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING
*
***********************************************************************/

#ifndef VISUSSPHEREPROJECTION_H
#define VISUSSPHEREPROJECTION_H

#include "VisusProjection.h"
#include "VisusGroup.h"
#include "VisusIndexedData.h"
#include "VisusUnits.h"
#include "VisusEarthRadius.h"

//! Interface for a VisusProjection mapping IndexedData
/*! A VisusProjection implements the identity transform and defines
 *  the interface for mappings from one VisusIndexData instance to
 *  another. Derived classes will implement various different
 *  projections with different input or output dimensions and
 *  units. The user should call isCompatibleInput to determine whether
 *  a given indexed data set can be mapped by a particular
 *  transformation. Additionally, a VisusProjection provides the
 *  ability to determine an info node. If present the info node can be
 *  used to pull shared values (e.g. SharedEarthRadius) from the
 *  hierarchy. However, a projection can also set its necessary
 *  parameters directly which will override values pulled from the
 *  hierarchy.
 */
class VisusSphereProjection: public VisusProjection 
{
public:

//  typedef VisusIndexedData::VertexDataType VertexDataType;

  /***************************************************************
   ******       Constructors/Destructors                 *********
   **************************************************************/  

  //! Default constructor  
  VisusSphereProjection();

  //! Copy constructor
  VisusSphereProjection(const VisusSphereProjection& projection) {*this = projection;}

  //! Destructor
  virtual ~VisusSphereProjection();

  //! Allocate a new copy of myself  
  VisusProjection* clone() const;

  //! Assignment operator
  VisusSphereProjection& operator=(const VisusSphereProjection& projection);

  /***************************************************************
   ******       Hierarchy Information                    *********
   **************************************************************/  
  
  //! Declare the necessary parameters 
  virtual int declareParameters(pVisusGroup caller);
  
  //! Pull all necessary shared values from the given node
  virtual int updateShared(pVisusGroup info);

  /***************************************************************
   ******       Projection Information                   *********
   **************************************************************/  
  
  //! Return the preferred input units (there might be multiple)
  virtual VisusUnit preferedInputUnit() {return VISUS_POLAR_RADIANTS;}

  //! Return the output units
  virtual VisusUnit outputUnits() {return VISUS_METERS;}

  //! Determined wether the given data set can be used as input
  virtual bool isCompatibleInput(const VisusIndexedData* data) const;

private:

  
  //! Call to transform a single vertex 
  /*! This function is called within the inner loop of project to
   *  process a single vertex. Derived classes need only to overload
   *  this call to implement their own projection method.
   */
  virtual int projectVertex(const std::vector<VertexDataType>& source, std::vector<VertexDataType>& sink,
                            VisusUnit unit);

  
  // The radius of the sphere we are projecting
  VisusEarthRadius mRadius;

};  
#endif
