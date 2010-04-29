########################################################################
#
# Copyright (c) 2008, Lawrence Livermore National Security, LLC.  
# Produced at the Lawrence Livermore National Laboratory  
# Written by bremer5@llnl.gov,pascucci@sci.utah.edu.  
# LLNL-CODE-406031.  
# All rights reserved.  
#   
# This file is part of "Simple and Flexible Scene Graph Version 2.0."
# Please also read BSD_ADDITIONAL.txt.
#   
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#   
# @ Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the disclaimer below.
# @ Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the disclaimer (as noted below) in
#   the documentation and/or other materials provided with the
#   distribution.
# @ Neither the name of the LLNS/LLNL nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#   
#  
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANVISUS_NO_FTGLTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL LAWRENCE
# LIVERMORE NATIONAL SECURITY, LLC, THE U.S. DEPARTMENT OF ENERGY OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING
#
########################################################################


"""Test simple functions (i.e. no pointers involved)"""
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *

from pyvisus.core import VisusFont, VisusColor, VectorInt, VisusXMLInterface, VisusOpenGLState
from pyvisus.component import * 
from pyvisus.data import VisusBlockData, PV_FLOAT32
from pyvisus.display import * 

window = None
gFocus = None
gRoot = None
winWidth = 800
winHeight= 600
gMouseX = 0
gMouseY = 0
gPressed = 0
gMouseMotion = False
gColorMap = 0

def initDisplay():

    ambient  = [0, 0, 0, 1];
    diffuse  = [1, 1, 1, 1];
    specular = [1, 1, 1, 1];
    position = [1, 1, 1, 0];
    
    glLightfv(GL_LIGHT0, GL_AMBIENT,  ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE,  diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, specular);
    glLightfv(GL_LIGHT0, GL_POSITION, position);

    glViewport(0, 0, winWidth, winHeight);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(-10, 10, -10*winHeight/float(winWidth), 10*winHeight/float(winWidth), -100, 100);

    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    return


def display():
    glutSetWindow(window);

    state = VisusOpenGLState()
    state.fetchState()
    gRoot.setValue(state)

    glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()
    glColor3f(1,1,1)
    glLineWidth(1.0)
    gRoot.display()
    glutSwapBuffers()
    return


def reshape( *args ):
    (x, y) = args
    glutSetWindow(window);
    glViewport(0,0,x,y)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    glOrtho(-10,10,-10*3/4.0,10*3/4.0,-100,100)
    gluLookAt(0,0,10,0,0,-1,0,1,0)
    return


def keyboard( *args ):
    global gColorMap,gColorMaps

    import sys
    (key, x, y) = args

    if key == 27:
      sys.exit(0)
    elif key == 'x':
      sys.exit(0)
    elif key == 'm':
      VisusXMLInterface().write("restart.xml", gRoot)

    glutPostRedisplay()
    return


def motion( *args ):
    global gFocus,gPressed,gMouseMotion,gMouseX,gMouseY,gSceneFile
    (x, y) = args 

    if not gMouseMotion:
        return

    newX = (x-gMouseX) / (1.0 * winWidth)
    newY = (y-gMouseY) / (1.0 * winHeight)

    if gPressed == GLUT_LEFT_BUTTON:
        if gFocus is not None: 
            gFocus.rotate(newX,newY)

    elif gPressed == GLUT_MIDDLE_BUTTON:
        if gFocus is not None:
            gFocus.scale(newX,newY)

    elif gPressed == GLUT_RIGHT_BUTTON:
        if gFocus is not None:
            gFocus.translate(newX,newY)

    gMouseX = x
    gMouseY = y

    glutPostRedisplay()
    return


def mouse( *args ):
    global gPressed,gMouseMotion,gMouseX,gMouseY
    (button, state, x, y) = args

    if state == GLUT_DOWN:
        gPressed = button
        gMouseMotion = True
        gMouseX = x
        gMouseY = y
    else:
        gMouseMotion = False
        gPressed = -1

    glutPostRedisplay()
    return


def idle():
    return


def createLine1():
    data = createGraphData(10)
    print "Creating line 1:"
    x=0.0
    y=0.01
    k=0
    for i in xrange(10):
      data[k] = x
      k+=1
      data[k] = y
      k+=1
      print "\tpoint (%f, %f)" % (x,y)
      x+=0.18
      y*=2.8
    return data


def createLine2():
    data = createGraphData(10)
    print "Creating line 2:"
    x=1.0
    y=0.01
    k=0
    for i in xrange(10):
      data[k] = x
      k+=1
      data[k] = y
      k+=1
      print "\tpoint (%f, %f)" % (x,y)
      x-=0.078
      y*=1.2
    return data


if __name__ == "__main__":
  import sys

  newArgv = glutInit(sys.argv)

  glutInitDisplayMode( GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH | GLUT_MULTISAMPLE )
  glutInitWindowSize(winWidth, winHeight)
  glutInitWindowPosition(200, 200)
  window = glutCreateWindow("ViSUS Line Graph Test")

  glutDisplayFunc( display )
  glutReshapeFunc( reshape )
  glutMouseFunc( mouse )
  glutKeyboardFunc( keyboard )
  glutMotionFunc( motion )
  glutIdleFunc( idle )

  initDisplay()

  # Create the default scene graph 
  gRoot = VisusSceneNode.construct()

  # Create Font 
  font = VisusFont()
  font.fontSize(3);

  # Create Lines
  line1 = createLine1()
  line2 = createLine2()

  # Create First Line Graph 
  lineGraph = VisusLineGraph.construct()
  lineGraph.setValue(VisusColor(1,0,0))
  lineGraph.autoAdjustMinMax(True)
  lineGraph.unitLength(0.8)
  lineGraph.xUnits(1.5)
  lineGraph.lineWidth(2.0)
  gRoot.attachSubTree(lineGraph)

  axis = lineGraph.axis(BB_X_AXIS)
  axis.legendText("X")
  axis.labelFont(font)
  lineGraph.axis(BB_X_AXIS, axis)

  axis = lineGraph.axis(BB_Y_AXIS)
  axis.legendText("Y")
  axis.labelFont(font)
  lineGraph.axis(BB_Y_AXIS, axis)

  # Connect to data
  lineGraph.numberOfLines(1)
  lineGraph.loadData(line1, 0)

  # Create Second Line Graph 
  lineGraph = VisusLineGraph.construct()
  lineGraph.position(-0.65,0)
  lineGraph.orientation(BB_VERTICAL)
  lineGraph.pointSize(4.0)
  gRoot.attachSubTree(lineGraph)

  axis = lineGraph.axis(BB_X_AXIS)
  axis.tickPosition(AXIS_BOTH)
  axis.labelPosition(AXIS_BOTH)
  axis.labelFont(font)
  axis.legendText("X")
  lineGraph.axis(BB_X_AXIS, axis)

  axis = lineGraph.axis(BB_Y_AXIS)
  axis.tickPosition(AXIS_BOTH)
  axis.labelPosition(AXIS_BOTH)
  axis.labelFont(font)
  axis.legendText("Y")
  lineGraph.axis(BB_Y_AXIS, axis)
  
  # Connect to data
  lineGraph.numberOfLines(2)
  lineGraph.lineColor(0, VisusColor(0,1,0))
  lineGraph.lineColor(1, VisusColor(0,1,1))
  lineGraph.loadData(line1, 0)
  lineGraph.loadData(line2, 1)

  # Run The Main
  glutMainLoop()


