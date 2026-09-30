Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5E7CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 20:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C9E10EC09;
	Wed, 30 Sep 2026 20:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YayvKTzr";
	dkim-atps=neutral
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com
 [74.125.229.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C689E10F4D2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 20:03:37 +0000 (UTC)
Received: by mail-dl2-f41.google.com with SMTP id
 a92af1059eb24-14936924913so762725c88.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790798617; x=1791403417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cASLx32ym87jdhS0h2FvPN2AduCc3BT2HfqD8zMngx0=;
 b=YayvKTzrZRVoCpfIAupEZxhGiQLSfp1KKZFfOksMwZLYDDtGLa6XaJYTz8kkcZmsAU
 XB1e8FHhnDkH/Tpx7YwGr5fnl7MW9LFEV2BzaWl3qVjOc7zeTVoublM7MBElYbSq5Z2E
 Tz21zWt3dzYBC6uv6jH0gHIFi3ygaVcMdSVfRIk6FTqshR77lubbQhbR5ACE1S3rNj1f
 5DW559odl35oahYZZSY+hJ0E1LH4MCGKmZq3YkRmA385QHmfg288gUebg5PK9hL4Sv3x
 HNDZv6wmBYRXTA5V1AUP9h/KJv1ka2FVx0hrEnhNCS4tj1A1eBYrFwPtWfwpARUd9xEj
 vVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790798617; x=1791403417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cASLx32ym87jdhS0h2FvPN2AduCc3BT2HfqD8zMngx0=;
 b=SQll25/KX4pxRCcOZOuzcav4bT7dGPpWwTenJT5eKMqX2Vl9fWRbJjeuG3/W2lYPqt
 H7fHzLXzNr1tP5lfo1V1TJaijlwhpbX4Bz1gQQDd3YXHUEE7umZWrHiwVssT5WbIO9j6
 IlQGBRtQCidrBbXyaXXRO79b5Zj+CdBFOBHIHo0qLJm07IOSwZubsabELscuFzpn0vwq
 Pzs83j97gd5r9vQhCEp4CgyA1VNOGfkc4zAVtSQGDoPTTcmBpt0d6ZvGZ+xXRLaNOSxk
 PowrtGh1wlw+dDYF5Lb17T7O/L2o5Uylu1cIJhE4JeoYqBMy6z1o6qrJjRDssLTRjWLs
 vHTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5+WIq7FG3WA6a6xXDuWtioZG8S+eiR9RgpyS3HjFMZ9fIjsWlPVw2Lp4PlTtR2NN2aPGntkEpQDU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZVGaVAYwraf2m/b4lSkuflvqT+UbnBK7j3FMiG7KveDRB28r7
 EfMCwmz+brpPcBOjFSXRVt22nyX+Xtjqp+q8xCnGvN64F81lveHoSj4h
X-Gm-Gg: AYBFou3W9AOvHAhG4djSxqa38L8rzOk1fV6Pj0uIAq9AF0Vshr/cv/pZP/iC+aSPKA7
 bZPkCUDuhTRV22GsaB+00WSL4K8xEbhUOJ4yCvEcCD61DjZIaeQH+gNgbmEQMqBWTZvL6Y8aBOE
 VwrPGj+HMDiw77zvzau7Y3pdY9p0GS4PEBOC4ynu7jq1PBqjxf3yU66BACwOSyDNcUNefyeaY6k
 499+y7Df4avlqUmcu6HoBsM3to7Q5dRHa1BHP1W8Xe50KE9rOg8CpmTOJqozTYarw0NXogtIXVp
 VUwk05aOKtOxJ9v2P4N4sL/zgbj14CBVnloFjAslJ8TiOuu6koH6/prN9yEmeCEeLR17T+4+1k5
 iSO6q2N8o7aJ6dEpks7jNhFpiuKs6Bq1hmgyCy4koxAVfmK8QZteN+ps1P3DvwkHA4SXRYUDGYz
 kw74wdC8Z9TOCPhDfzTwctxF6ZfOmFa8V991mi+FlIErGMT5mXNiLVo3YCgbY/FsxdzkjNKBRWY
 li2gqk=
X-Received: by 2002:a05:7022:158b:b0:141:5281:8a41 with SMTP id
 a92af1059eb24-14d33494dfamr2639297c88.9.1790798616734; 
 Wed, 30 Sep 2026 13:03:36 -0700 (PDT)
Received: from G15-5520 ([36.255.19.64]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14df11858b3sm460601c88.2.2026.09.30.13.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:03:36 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] amdgpu: Use 2-argument strscpy() where destination size is
 known
Date: Wed, 30 Sep 2026 20:03:25 +0000
Message-ID: <20260930200326.42827-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Simplify the code by dropping the explicit size argument from strscpy()
where the destination buffer has a compile-time known size.

No functional change.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 1e21e3444802..34defcfc563d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -327,7 +327,7 @@ static int amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgpu_device *
 			uma_info->entries[i].memory_carved_mb = (uint32_t)opts[i].memoryCarvedGb << 10;
 
 		uma_info->entries[i].flags = opts[i].uma_carveout_option_flags.all8;
-		strscpy(uma_info->entries[i].name, opts[i].optionName, MAX_UMA_OPTION_NAME);
+		strscpy(uma_info->entries[i].name, opts[i].optionName);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 92c98e999efe..40829d2f9c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -428,7 +428,7 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		if (!mode)
 			return;
-		strscpy(mode->name, common_modes[i].name, DRM_DISPLAY_MODE_LEN);
+		strscpy(mode->name, common_modes[i].name);
 
 		drm_mode_probed_add(connector, mode);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e780feb7..aafcd60d2107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3591,7 +3591,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	 * remains intact for multi-GPU systems where this function is called
 	 * once per device.
 	 */
-	strscpy(buf, amdgpu_lockup_timeout, sizeof(buf));
+	strscpy(buf, amdgpu_lockup_timeout);
 
 	while ((timeout_setting = strsep(&input, ",")) &&
 	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f280e2..9796eeab73bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1410,7 +1410,7 @@ static void atom_get_vbios_name(struct atom_context *ctx)
 
 no_name:
 	/* do not know where to find name */
-	strscpy(ctx->name, na, sizeof(ctx->name));
+	strscpy(ctx->name, na);
 }
 
 static void atom_get_vbios_date(struct atom_context *ctx)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c3322058720f..a50d2885d786 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2356,7 +2356,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
 			ring = &adev->gfx.sw_gfx_ring[i];
 			ring->ring_obj = NULL;
-			strscpy(ring->name, amdgpu_sw_ring_name(i), sizeof(ring->name));
+			strscpy(ring->name, amdgpu_sw_ring_name(i));
 			ring->use_doorbell = true;
 			ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 			ring->is_sw_ring = true;
-- 
2.53.0

