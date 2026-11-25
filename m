Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA11606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M3s8vPVE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111DD10E895;
	Wed, 25 Nov 2026 01:02:41 +0000 (UTC)
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com
 [74.125.225.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FF210E8E3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:02:35 +0000 (UTC)
Received: by mail-wm2-f11.google.com with SMTP id
 5b1f17b1804b1-4a5f76661b5so19037435e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 17:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795568553; x=1796173353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uePKERkPYqyNMKFitbdJV3Xl/oPfgxHA9R+TZal+XKQ=;
 b=M3s8vPVEEI1M/JC3A8Tsc6Y3xxwcI5npD9F1S66UGOWJZPiRz3w3LXokmeSUz4UVza
 NmWbgHnUiQ5x82S/9JbLLZTCYThW30EBHnwIzvMa3HVySwHPWzPL8IxTGgurfB9u+ROU
 YOYeKtmhq8vWbMi0Ij6rc2/yTvenpDL8YQv0mbSdJCM9GE25FydJagKW4oYX3yQj3yF9
 5xsd4439u2Wg5kh50OW9IskjlYrJTJxQI6VR4x2+2a7uo5ePsU+ut8JY7gWlCh5i8gTn
 qEB+TKSI5p7iO0KYLMjE/7+w3TS6GhV8hKnsmQf113TtGVysQFXiS/RZ8n0fxb6Rn3DK
 Npow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795568553; x=1796173353;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uePKERkPYqyNMKFitbdJV3Xl/oPfgxHA9R+TZal+XKQ=;
 b=Y/Vxq6P2I1M4G2z6g+PXk4RT3O/o9xG4CP0peb5G78euN2DXtqzx18l0O0XFgZRw68
 R98iIOnA2Y9qcy4c+LJgFdRNCxtzXeEwa1ThNhutjPt00b3uwl6QTVByMobfSt04Nyun
 l5CzEeYBMXOcMAdrZawILKpB9ymqaHV/bylpqPWVEUMOkc4/X/b72uEUUFeDG5TtMI1Y
 9bYn8He68lQgzhq9t4PpG3J7ayD6CIc1j01xFzbEsXnt+m8kVVce33mgnmcF+v5sK8mS
 q7+RjXURFsww4DzgkgL4M3diLHeYSKMQEgZMrnQ71Joy2luAVHC7oPkChnlqclVvwOAb
 0Hdw==
X-Forwarded-Encrypted: i=1;
 AL+hErHpjXa+Nv8AQO5W7cEPAabzvUUOt5w8WdBcZ5LElzfGlwnz+1U6EhXFSwUIx9u8ounaRhaNptf0bm8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+foKmZMGeQ6NfwGoXlHHUCzhHMGnxKQwZ4LSM8kR+zsl9pTIoR
 edw+8v+vDhQB5iK7lmo5/vx4XOr/b/d734nWgmp6AKpWjBz0alXoeC+C
X-Gm-Gg: AZFdTZfYz2L6toHZAQUyTM1J+EGzu27l3IDxlL+4DUvvYfQoblEhy4H8BQRcDT7FMB5
 Hgr63QGItcAlZlFSaBpoQmuOXgounzq24jgefmhVJGhZ9AIQXZILlD/p9d3CJmTcZnBtDvzxIOC
 d48pbKw4qhj+6uWvG8F1ZUKNPidC6rCX3SJY7x10lJ6kOLMaaZTfoamb0m0o0JhjP8+VHyuKnxa
 EnDzU4Xz5EPria24tzpPancBcvHwN331mEEpL0gAezcKIxOzl18vrO+4G/KfBWO9LnPeWkGO2/h
 T26Q0skOxiOJW+WAEc+XavwA62f5cnZwhJaLhlgW51UuJCYOCo5L34iB64dg6U6KqRJCvs6Bone
 b0bitXA6jOvh7+iV2Is2Q/n89NiuCFrBvrCI9QX1whTIrfkYwOeenvAP7Wl6IT7z5X0FyOGlymJ
 gwweQ9fi4w6kqKFHva6n5/d2LNFJsHejG+U3JRkN6LUbxi0LpT2K39p6zgxpW/mPB5TRQ4a2Ada
 jE6nbsiNC74BY0JzSGYdebNdaK8vTdN16DK6oBn4Kc3800LSRtGIN85FxmYnMRIShBJoKsIq48a
 Jr7ycY+rCwxFLLZiNuX+HrGwTDue2Er1292BXSfSzGxpe5PV/8qkpdyXOw==
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id
 5b1f17b1804b1-4bb888074bbmr395065225e9.12.1795568553403; 
 Tue, 24 Nov 2026 17:02:33 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm31262183f8f.5.2026.11.24.17.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 17:02:32 -0800 (PST)
Message-ID: <77a4adb4-5539-4d5b-911f-36b5be6fdc0d@gmail.com>
Date: Wed, 25 Nov 2026 01:02:31 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v3 1/3] drm/amdgpu: use pitch and surface offset for GMC v7/v8
 fb size
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gmc_v7_0_get_vbios_fb_size() and gmc_v8_0_get_vbios_fb_size() currently
calculate the pre-OS framebuffer reservation as VIEWPORT_WIDTH *
VIEWPORT_HEIGHT * 4, assuming the scanout stride matches the viewport
width and that the surface starts at offset 0 of VRAM.

On Apple Retina iMacs, EFI initializes a single-tile viewport at boot
but allocates a full-panel stride surface in mmGRPH_PITCH and places
mmGRPH_PRIMARY_SURFACE_ADDRESS at an offset (e.g. 0x300000) from
vram_start. Reserving only VIEWPORT_WIDTH * VIEWPORT_HEIGHT * 4 bytes
allows permanent TTM driver BOs to overlap the active scanout and
corrupt the boot splash screen.

Calculate the reservation size using mmGRPH_PITCH instead of
VIEWPORT_WIDTH and add the mmGRPH_PRIMARY_SURFACE_ADDRESS offset from
vram_start so the full active pre-OS scanout region is preserved.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c09f5153679e..00704dbfc1bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -929,9 +929,11 @@ static unsigned int gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
 
-		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
-			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) *
-			4);
+		size = REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
+		       RREG32(mmGRPH_PITCH) * 4;
+		if (size)
+			size += RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS) -
+				lower_32_bits(adev->gmc.vram_start);
 	}
 
 	return size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 15592027e7c0..a64a3cc07858 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1037,9 +1037,11 @@ static unsigned int gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
 
-		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
-			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) *
-			4);
+		size = REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
+		       RREG32(mmGRPH_PITCH) * 4;
+		if (size)
+			size += RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS) -
+				lower_32_bits(adev->gmc.vram_start);
 	}
 
 	return size;
-- 
2.55.0
