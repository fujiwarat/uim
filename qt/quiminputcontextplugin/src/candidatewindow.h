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
#ifndef _CANDIDATE_WINDOW_H_
#define _CANDIDATE_WINDOW_H_

#include <uim/uim.h>

#include <qvbox.h>
#include <qlistview.h>
#include <qvaluelist.h>

class QLabel;

class QUimInputContext;
class CandidateListView;

class CandidateWindow : public QVBox
{
    Q_OBJECT

public:
    CandidateWindow( QWidget *parent, const char * name = 0 );
    ~CandidateWindow();

    void activateCandwin( int dLimit );
    void deactivateCandwin();
    void clearCandidates();
    void popup();

    void setCandidates( int displayLimit, const QValueList<uim_candidate> &candidates );
    void setPage( int page );
    void shiftPage( bool forward );
    void layoutWindow( int x, int y, int w, int h );
    void setIndex( int totalindex );
    void setIndexInPage( int index );

    void setQUimInputContext( QUimInputContext* m_ic ) { ic = m_ic; }

protected slots:
    void slotCandidateSelected( QListViewItem* );

protected:
    void updateLabel();

    // not completed
    void adjustCandidateWindowSize();

    QUimInputContext *ic;

    CandidateListView *cList;
    QLabel *numLabel;

    QValueList<uim_candidate> stores;

    int nrCandidates;
    int candidateIndex;
    int displayLimit;
    int pageIndex;
};


class CandidateListView : public QListView
{
    Q_OBJECT

public:
    CandidateListView( QWidget *parent, const char *name = 0, WFlags f = 0 ) : QListView( parent, name, f ) {}
    ~CandidateListView() {}

    int itemIndex( const QListViewItem *item ) const
    {
        if ( !item )
            return -1;
        if ( item == firstChild() )
            return 0;
        else
        {
            QListViewItemIterator it( firstChild() );
            uint j = 0;
            for ( ; it.current() && it.current() != item; ++it, ++j )
                ;
            if ( !it.current() )
                return -1;
            return j;
        }
    }

    QListViewItem* itemAtIndex( int index )
    {
        if ( index < 0 )
            return 0;
        int j = 0;
        for ( QListViewItemIterator it = firstChild(); it.current(); ++it )
        {
            if ( j == index )
                return it.current();
            j++;
        }

        return 0;
    }
};

#endif /* Not def: _CANDIDATE_WINDOW_H_ */
