use "RDSInvrec_Extra.dta"
cmset id1, noalternatives
cmrologit InvitePref InvitePersonalE InviteAnonE InviteSms InviteFacebook
cmrologit RecruitPref RecruitPersonalE RecruitAnonE RecruitSms RecruitFacebook
cmrologit InvitePref InvitePersonalE InviteAnonE InviteSms InviteFacebook if agecat==1
cmrologit InvitePref InvitePersonalE InviteAnonE InviteSms InviteFacebook if agecat==2
cmrologit InvitePref InvitePersonalE InviteAnonE InviteSms InviteFacebook if agecat==3
cmrologit RecruitPref RecruitPersonalE RecruitAnonE RecruitSms RecruitFacebook if agecat ==1
cmrologit RecruitPref RecruitPersonalE RecruitAnonE RecruitSms RecruitFacebook if agecat ==2
cmrologit RecruitPref RecruitPersonalE RecruitAnonE RecruitSms RecruitFacebook if agecat ==3
