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
#ifndef _QUIMINPUT_CONTEXT_WITH_SLAVE_H_
#define _QUIMINPUT_CONTEXT_WITH_SLAVE_H_

#include "quiminputcontext.h"

// This class is for dealing with Dead/Multi key composing.
// Have QSimpleInputContext as slave and forward event to the
// slave when isComposing==false.

class QUimInputContextWithSlave : public QUimInputContext
{
    Q_OBJECT
public:
    QUimInputContextWithSlave( const char *imname = 0, const char *lang = 0 );
    ~QUimInputContextWithSlave();

    virtual void setFocus();
    virtual void unsetFocus();

#if defined(Q_WS_X11)
    virtual void setFocusWidget( QWidget *w );
    virtual void setHolderWidget( QWidget *w );
#endif

    virtual bool filterEvent( QEvent *event );

signals:
    void imEventGenerated( QWidget *, QIMEvent * );

protected slots:
    virtual void destroyInputContext();

protected:
    QInputContext *slave;
};

#endif /* Not def: _QUIMINPUT_CONTEXT_WITH_SLAVE_H_ */
