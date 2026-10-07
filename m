Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F6CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6230910E5E2;
	Wed,  7 Oct 2026 13:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lla2iTPO";
	dkim-atps=neutral
Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BC110E5E2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:33:01 +0000 (UTC)
Received: by mail-lr2-f1.google.com with SMTP id
 38308e7fff4ca-3a772511049so25309901fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379979; x=1791984779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sXzba+xG1WBG1R2U3C2ihk+Wr/g1fNt8Yr32nUgb40w=;
 b=lla2iTPOI41HBQ5muN4w5MxFVDVuMqSEFMvTi/VQbPFNsbrJTTmsL2enbSz7Z6GpTS
 I2KxrFAkR0MQUHo/lWziylgB8JOHPnorqdky0MrYGZwovKxxYl6lz4fn9b9yuKeJoFsb
 U8i9ogM1safnja8VHyTVRHsRrJEXhTlIEdZfAlaFjf1YwyYWSkslrt+s3/N93iZo6jB9
 qIVPyx0mHEVVR6DKtWwtzMHlM37l+KvINZH1ZhSrIIC+48r0SnJG5uN7n2sR836+848w
 maxDcfpc186qrM+gvMpkB1mPW79F2OonwK5CQUqQ/Vd/mb9hvP+DyMmlvYwRsONhLK9O
 uzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379979; x=1791984779;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sXzba+xG1WBG1R2U3C2ihk+Wr/g1fNt8Yr32nUgb40w=;
 b=02N3gFEgNR9ggvLcFX+RDlA0+LQzeOOQZ7ei2VT0v2AM7bAVeI1GQwF68emkOJEITV
 jJCSXXPVVaqA6M7tl1OBF1jDOxK/TakBAnROxVW5gpxmcByhgZeiSl8gIRHcXy8KlMzY
 XF9IMDwV+AOLXrlI5YEToKHL/80m1Wi4BGLMLol4/p8TycfuGTMRF40F07a4lNevRIKS
 4rmD0Ju5sq6Q6GkvzPNuCU+KXVQnDNj1YibBwiR0YnjMrF+IjHM1xRTg4LPLDpaWUbmE
 SSyCq1YWOzOluUfgylDH8hzvJEdLp6MIwZUXpmgDXgYHcjevZ5BJSM4HZAJtUW3tuV9c
 RYCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzla/PlPWlaDsJMpEsOZfRhGT0p5zs4ZBp/6N3ELNwie1/YavoPNliyIo5uv0Cux8EDSiUxhyMmtII=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVwj5XFih9EE7xRL0ncwLR2E1QRXcZknjXW25TXGwjTdX1D9Tc
 Sv5rlT3C54vFDtrwuNCsEdP90cMN66mSLaif0RMO97a48/M7ReV5joO9
X-Gm-Gg: AYBFou2A4XzZJFMWpbmyQ5nh2VcvNN3D/NtrBvNxu23KMtd892MVADr9B3RUCiLsG8g
 zdPOBiVeqENpZj06NQNU044EzqHSRDPirGDnPmsiqSKU3RDHRTE8L1CmFZdHStQQX+UmLxvl5Fi
 YTQS2jU3Kl4RCQ5Y18SHOd15MY7JmDrbbRLUzpHEQ5qH4SIWKbwZgznHq4yhdXNwV2qKrP/Qh6O
 gyJIPfzNAa3yFcSXuzOiP5WYpPcj7qDAqTTDLSxAj+lO8EF+CUfRPcOd1prfCQIPT+XOuJQQ4Ak
 O9NxsTYeauH4uH6faG/c4sdT3qEQQ7VC/ctHsex4EdrACEz5T6uLviOQu3ixTYqMHhS9PvMVM93
 TqLz/U+Cpyn7vrHob3bnjvX2hC6vb2Tj7X9Zr1fiQKEmcy6dGy293d+bPYUzgeFsYyimNWSeQ9W
 K5NIZwiGVr8jkdFhpidl5s/wqzDmh8uJZbV8sIkBYC7LHiBDRrzjPv2PhlAPowCT5SZhkIin0kP
 Sxmd9mPMFy6fUQE
X-Received: by 2002:a05:6512:68c:b0:5bb:7b2a:5b2d with SMTP id
 2adb3069b0e04-5bcd0708cd9mr821802e87.35.1791379979145; 
 Wed, 07 Oct 2026 06:32:59 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd30a474csm33636e87.80.2026.10.07.06.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:32:57 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Yinjie Yao <yinjie.yao@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10/5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG
 v3.0 ring
Date: Wed,  7 Oct 2026 16:32:43 +0300
Message-ID: <20261007133244.121787-1-roman.demidov.nn@gmail.com>
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

commit a2baf12eec41f246689e6a3f8619af1200031576 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: dfd57dbf44dd ("drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d7d774f100efb5089c86a1fb8c5bf47c63fc9ef)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63846

 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 323d68b2124f..f1957d4fa7a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -560,6 +560,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
-- 
2.53.0

