
NoteC=note(0.7, 40, 2);
NoteE=note(0.5, 44, 2);
NoteG=note(0.5, 47, 2);
 
Ctriad_org = NoteC+NoteE+NoteG;
Ctriad = Ctriad_org./max(abs(Ctriad_org)); %max abs shouls stop clipping 
%sound(Ctriad,11025); 
audiowrite('Ctriad.wav', Ctriad,11025); %is audio clipping why? 
