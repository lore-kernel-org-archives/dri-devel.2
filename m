Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF07FC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5DF10E429;
	Fri,  7 Aug 2026 15:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyeTa2Zy";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41D810E429
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:06:41 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso2961885f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786115200; x=1786720000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G28kgXcfjTi7WfcubT6ss2iDfVIyc9TJDmSGXp/+TIA=;
 b=GyeTa2Zy3Sux5cj69LNolJh+DFeMv6BXL3kMlAGEq/SC1C2WeVdlBM775fSwnrhwl2
 vcUNksSfEzKSKxSSAPN9yptjfPyahLw7NAHK48FgImIXjDv6cDcr5OTLOwXPTNWjIPz9
 VUoBfSrh85FcyOZsyWnq7tgmnIM0M5gXyEEaYJ5TfyJnYSo4K4la3edBvwPMyBAUVCVb
 y/DpN8ADLzKbVyuORAB/8klGXxnj9+7ObmRj5tduoYRmZlIk/QwazN+fd2E78iolSD3b
 +MZYonDojflur8b435720XlABoNtSvPYRDam6nG7+4VMqtxYtdSlMEbmzFSuzlcYPunR
 Xw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115200; x=1786720000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G28kgXcfjTi7WfcubT6ss2iDfVIyc9TJDmSGXp/+TIA=;
 b=V2wn9j0BJvdVdZVcNLs4emibouj/Mgr3R/aQs12U8F6EyenERA8PiFhQTn890RNpMi
 O7F0cqOU4KTagNBfOI+4CV8s2B9GyXg8nbib1rouGqMmF54Im0ajftynektmZdp761lv
 gAHGB6GZO+mrVQGwOhXMQMlrEs27jTHN6SUP8lGL3FgfLZeZRlx4EdzE2eimJkHDl7yc
 WbkRiv3M9811kiW9GKNtSRY9uHq/Cpt8ZuM3UU1D1CTQHpNK1WXdo5YGm9Akp81vP4q5
 oAK360iJhQPRY+BugUmPcixW2b21Y4PhrYRpTiT0o4aNcW2vvGZQeSMGhPTMXDafwgpE
 Ddcw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8jTEI+oVGtho4rG3R4Da1fZBqH5i6g2hYw++CIWlmGYsPt94EmOmFgo/zGMwKctiPPSENRutlxkQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMlh/P5GXcA/qv4V/wLCfnTTokv/ZhjqrZjEI/GHyC2Jwo45QL
 TQPCVjMgOFDsr0PKkwZ6cwUnWwSxQ7AYBcboa4l0cXQafwmiVeUqy16k
X-Gm-Gg: AR+sD13lYcG6uJlV6LtR003UjOyi/C9wyDzBDcLZmBXa3+ZI2TH+OwCZuFrCw18MYPw
 sXWDFHpsEouOHxr3f2ZCvOgNcBsgfw12zvghtFfTIxBirt6qlxZpG5qe6nVtoKOZcqe/0lcPGdt
 oowZqdZLkQuipfHlvNPWilauB00/kKRAdJfLpzXZT2mnsZJWhhU0PEB6NU0/XjvXnyVpQJyZ7zG
 sJkmkjOyt2VA2Is/qHPSp+avj66CmEZMOOjTmTijKU6lFft5L1+6bM7Z/0CT3ndgPXVKWpIDs/A
 pL47CtQ+Ldv5tDIM1UfAno1PoODzjhAYTNTuyQkEKC6eU1O7DAgtYU/B5a+FIjvfgPbUCOu6uvx
 2GCxxDe3ICq5on019AreIF/lPvhdCDQnAAmVM0/UNim/cCF02ICw5VLjwdHUdxvB9o7OK7l2/IS
 CUjC5Zszc8AQcydjC/f0dKBouszgliFZXHA9rZ+sv+hLEBQ0PqxhbYCvtJGK4Z63XsaphvtQ4ce
 7I=
X-Received: by 2002:a05:6000:46cf:b0:475:3a97:8e2c with SMTP id
 ffacd0b85a97d-47fec62d8b8mr28368415f8f.16.1786115199830; 
 Fri, 07 Aug 2026 08:06:39 -0700 (PDT)
Received: from jessie ([2a01:e0a:11a7:6110:b562:8bda:11ee:8074])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f8f33sm7237899f8f.27.2026.08.07.08.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:06:39 -0700 (PDT)
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
To: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org
Cc: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 amdgpu_dm_crtc_set_vblank()
Date: Fri,  7 Aug 2026 16:58:55 +0200
Message-ID: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

amdgpu_dm_crtc_set_vblank() dereferences acrtc_state->stream when
vblank is enabled/queried from DRM_IOCTL_MODE_CRTC_GET_SEQUENCE before
a stream is attached to it.

BUG: kernel NULL pointer dereference, address: 0000000000000008
RIP: amdgpu_dm_crtc_set_vblank+0x6b/0x4d0 [amdgpu]
Call Trace:
 drm_vblank_enable
 drm_vblank_get
 drm_crtc_get_sequence_ioctl
 drm_ioctl_kernel
 drm_ioctl

Reproduced by running VKCTS with WSI tests enabled on RADV.

Guard the enable path on acrtc_state->stream being non-NULL, matching
the existing checks in this function.

Fixes: 34d66bc7ff10 ("drm/amd/display: Fix Xorg desktop unresponsive on Replay panel")
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 46d85457c77b..62eac6e65334 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -268,7 +268,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
-	if (enable) {
+	if (enable && acrtc_state->stream) {
 		struct dc *dc = adev->dm.dc;
 		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
-- 
2.54.0

