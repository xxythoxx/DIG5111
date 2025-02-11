Silence=note(0.0, 0, 0.1);
NoteC=note(0.5, 28, 0.5);
NoteD=note(0.5, 30, 0.5);
NoteF=note(0.7, 33, 0.5);
NoteA=note(0.6, 37, 0.5);
NoteC2=note(0.7, 40, 0.5);
NoteD2=note(0.6,42, 1.0);
NoteE=note(0.7, 44, 2.0);
NoteFMel=note(0.7, 45, 0.5);
NoteG=note(0.7, 47, 0.5);
NoteA2=note(0.7, 49, 0.5);

 
TwinPeaks_org = horzcat(NoteC, NoteF,NoteC2,NoteFMel,NoteG,NoteA2,NoteG,NoteFMel, ...
    NoteC,NoteD,NoteA,NoteE,NoteD2);
TwinPeaksOutput = TwinPeaks_org./max(abs(TwinPeaks_org)); %max abs should stop clipping 
%sound(Chord1,11025); 
audiowrite('TwinPeaksMatlab.wav', TwinPeaksOutput,11025); %is audio clipping why? 
