---
title: ACTION 권한 LUA 처리
date: 2026-01-29
tags: [erp, 개발, Ace이벤트]
---

# ACTION 권한 LUA 처리

-- 액션ID에 대한 권한 확인

local mySecu = GetActionSecu('AC_SaveTable')

 

if mySecu == 1 then

    -- \[읽고쓰기 권한\] : 정상적인 저장 로직 수행

    RunPgmMethod('Save')

    

elseif mySecu == 2 then

    -- \[읽기 권한\] : 권한 부족 메시지 출력 또는 조회만 수행

    MessageBox('읽기 권한만 존재하여 저장할 수 없습니다.', '알림', 'MsgBoxTypeOK')

    return

    

else

    -- \[권한 없음\] : 버튼 숨김 또는 접근 차단

    btnSave.Visible = false

    return

end

 

출처: \<<https://call.sysware.co.kr/>\>