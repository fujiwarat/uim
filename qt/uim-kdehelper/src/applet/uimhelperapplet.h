/*

 Copyright (c) 2003,2004 uim Project http://uim.freedesktop.org/

 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. Neither the name of authors nor the names of its contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 SUCH DAMAGE.

*/
#ifndef __uimhelperapplet_h__
#define __uimhelperapplet_h__

#include <kpanelapplet.h>

#include "../common/quimhelpertoolbar.h"

class UimHelperButtons;
class QResizeEvent;

class UimHelperApplet : public KPanelApplet
{
    Q_OBJECT

public:
    UimHelperApplet( const QString& configFile, Type t = Stretch,
                     int actions = 0, QWidget *parent = 0,
                     const char *name = 0 );

    int widthForHeight( int height ) const;
    int heightForWidth( int width ) const;

    void positionChange( Position p );

protected:
    UimHelperButtons* uhb;
};

class UimHelperButtons : public QUimHelperToolbar
{
    Q_OBJECT

public:
    UimHelperButtons( QWidget *parent = 0, const char *name = 0 );
    ~UimHelperButtons();
};

#endif
