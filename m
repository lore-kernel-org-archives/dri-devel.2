Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C58CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF9610E5B3;
	Wed,  7 Oct 2026 13:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyuTOvzV";
	dkim-atps=neutral
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125DE10E5FE
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:26:37 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id
 38308e7fff4ca-3a20f06cce6so27176551fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379595; x=1791984395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NfnoS6laDtDOjlhPtBWxVPWGkEBbm6NCgizgXhR32xk=;
 b=iyuTOvzVVBIJ8xK4M+83Crw+yoOt3rWdVRN0QCi20WYE8YwTvWoA3TlW5I/cfVZ48E
 13tMFsdicRE3rUxtm3O4iwkf14X+mtSR0982aafInYH1FfJ8Dr8lxEFcVaT2fDcDK5ZG
 aYVOIRTUmntAlW+EQh8e2sbHwOORzVJjMaWZvBkMLNcRcRvEDOWBrGZU8hEVmdvHYI4k
 ijMBCaZqpz/SQ/BCXld7q1ANd0alqLexSobWABiU+3H0p5oJCpccuEwTPOjiluKRinvV
 S0Fmv9veSIS8L93vUPD4IWs6TZ61AoAkUxAcvbSLbmty12e3qVfEi0kBCL35Ela594Uc
 IW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379595; x=1791984395;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NfnoS6laDtDOjlhPtBWxVPWGkEBbm6NCgizgXhR32xk=;
 b=GcE2+bYhN464pMY1v6U/UEgkt80qZXjui0me7IB4qESlJWdY0gNrXwtGEoDFVpS0st
 uyOwZzrvaYwc9GEDa48+3X/C000LEag2SaWDXSeuhiQxzcHj3QYyfgiu2Jx4qQ0b+YYn
 7EuuA/rPUvJBehgcCHC7D2iz578NhSyxXm9aGnxpBgC4B0ganWcr+DoiC/Vn2iLVIfLH
 TUAWasKr/5p3jRdx9SIsXHzt6saBOt4CctAGrrvJVY3lx/H1YjTppKA79G/E7dgtnuKg
 aI+teY3YoOsUDpwfHMyB+ab23HJJF4nVtZYNWKCcPgQ/3N52sKb93SullYujzY8tiw/Y
 CYFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0WZVPu65Vic7BENttSRTNJ4+QtFStY5xmvs/FkhVHvepVT6VYfcSsAryLOhsqsqi5gExTthxcm2I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLuT4EPTPYKi2X7YlnrSA35cyDUdw5IAmQ6NnzDuM9LW+yjp34G
 hIsFYubldvDiDkXRe+18BGb4AKI47d80XwmjEqQUAzH7yar23fK0F86g
X-Gm-Gg: AYBFou24fOMOEVFaGE596IlcDoO+o7WOt03EPCiWchaAkPmjCQZyrJNjvGqXTb0tCT4
 bY9iiJHXnd9Ie8XwTXdoMTwEKw70gUm1joOiNxBVgnSgIoLb7q4frUawetk9DgrxoHxuzAnsGTQ
 Gm6J0cjATGqADMuf+A7X4i5m182DMyEPcuKEZ2rIjNZT86pkhxusFp7ryEr3FicUQc6xRB4feBB
 5OTJPlJ/YVvgt3xzJgq8UQERTnq7E8jzN/Lt/+42TcDm12es9FTnO60GIbr9KQkzKzMMWzDhcz6
 xfNuAnVV5bPsBxyjijTWHtLNtG0cmvEedAEmxI1dxYbcDehno8rf7Q4pOOtVXlY6a6p3m9YYudV
 reJcaakz0fBlS3wNvEmN/p0vwMqxXMsSk9AmqjxLjJV5ERwl+4Udz3jT4k/MMUXPP9m4R0r/MP9
 m1Kpn+K1EUeYtrvH62NggBNf4PBC5Yj7x0E60Pp5Ry1us77pm1qz2YtaAsS1BJju7Xb20MGD2KL
 gXUOXmIjxFx+pVy9sxXlKrTE+4=
X-Received: by 2002:a05:651c:b12:b0:3a6:5c8f:857 with SMTP id
 38308e7fff4ca-3a9941d9654mr13497871fa.8.1791379595005; 
 Wed, 07 Oct 2026 06:26:35 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9a1d33f1asm6191851fa.11.2026.10.07.06.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:26:32 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Yinjie Yao <yinjie.yao@amd.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
Date: Wed,  7 Oct 2026 16:26:18 +0300
Message-ID: <20261007132619.121324-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Yinjie Yao <yinjie.yao@amd.com>

commit 79405e774ede411c6b47ed41c651e40b92de64a2 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3216a7f4e2642bda5fd14f57586e835ae9202587)
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Roman: Version 5.10 does not yet support JPEG2.6, so the fix is being
applied only to JPEG2.5 ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63847

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8c84e35c2719..dfb96f052f6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -566,6 +566,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
-- 
2.53.0

