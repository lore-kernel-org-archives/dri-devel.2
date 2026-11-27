Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DD606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kfrsMjXK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85AEE10E481;
	Fri, 27 Nov 2026 00:04:18 +0000 (UTC)
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0C510E481
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 00:04:12 +0000 (UTC)
Received: by mail-wm2-f8.google.com with SMTP id
 5b1f17b1804b1-4bbaf1ae076so1743495e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795737851; x=1796342651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uePKERkPYqyNMKFitbdJV3Xl/oPfgxHA9R+TZal+XKQ=;
 b=kfrsMjXKiKMcxnStMGUmuLK6pCPygFJdl1cXPeRfO+s8CJGim1iPtsEM4Irx42gMzV
 GB46RglVR9O5b1AE8DyFvyL+iM3qRFL+9LUfBlSqAP6PO5/3Oylaxv6HaVk0GoS2XTyt
 OZD5DBZfOL/Gw2e2qa4krBQlbSr13A1RevILZze95it5q6nQRwkltBqzzOb9EC0IqMsq
 YeGQ/H6r/nsnGqP6hhZ68/7+Vp/3zef8MDT5RaZ/YN8YRRmrRS3xmoqhOW4PQbCgLHLu
 6TvKN/l12dVaRW+42aS4KRgdVafmgQRA60HvXxPsWldNQMGPCGwRvAqrdcPG1vUlltYo
 EcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795737851; x=1796342651;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uePKERkPYqyNMKFitbdJV3Xl/oPfgxHA9R+TZal+XKQ=;
 b=cC+RYb8Kp2vnWSV1CPCGd1I4tCKWMM+8uDfHvUgbzFSCorSF5kdvlppocmDfryhJiY
 mVLHcuVAF6vUxPKU+99vy/+wCQF2CzDOveXPrTQaEDaJYz+C7urBrXEQk6oU+NOdjKhd
 +mmjKjcDl9C5Gyfvw6LPJWRoK0HNzLvWO58o2OXnJLOL9Pp+w5luqwhgkMyfjGYsg5jz
 P/LUJZSHsAP9Mjeb4i2AySLdQ1z+Y7Yf16D/SRCQlAUobRgC8/HX7Ew9Ljj9uvkXtsdj
 2CQ9KNrSYI4fRHq0AORvP6HzTPV5oqleEW228URqAP9PuvKQqYVBuWAJMOEjhB5AGH92
 pvFA==
X-Forwarded-Encrypted: i=1;
 AL+hErErP0KEt8LK1Zf/u5tK0zBPPwzxo/l6Uy718137YeWjoCyxbfQ3gekKBARK3exNMWuUmp8o9i7IrsY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+x3+W61jPM2jkgFrPXzspTYYQmypDM3zsTwIZM/loIvYcOpF6j
 AKZhSitwYyYA0BbSMsz+V/aC4GY7iNS6cxat0nS3oKN7JwjGFNquO49H
X-Gm-Gg: AZFdTZeANB9MNT00GYuM24pkXA/kWRXP5q5+SnoG5o5yAkg951ZjHiTAsciznZTGHOA
 1Xp1dpEhvE3qyDc1+tNOw6bI1zozA/eh+MJv35WbMTfin8HPPAdpPTQ9RXmgtaXEnsAnsSCghEK
 fe/HfFFVCRUwZcTByq1awi9+3X3Enq3hT4eDVu1LApgY4QLmt8KdfD+AeUOnCF0QDYiYLbeFsey
 CxLh5QJcTF1h2ieuG8Z9L1dm75pmhJ5rYVbrAEn5BuaUyElkDqe09dfwgT14tVasHRWyqsz5lm/
 yXMkaL64chc+2hl4jTDYPXIPRVfBzvMKwuiD8pw77DArNuUvFI5JddxTHSgU7wqo+UzPB80ybSL
 DVnpZq9Jpg0ZdSDzcAvMpc+rfnS/zVgpKsfNOAR97pbLcs2i0D9d5CA6K88u4l8d+Z6gk3kbr6p
 isZYm2Gv9FJYgjvKpWYa4viixV9o44QqKR3GbYOj3js+ti+JqUBrE76jm9DzZbQY0cqFxhmAwyq
 XKmoT693VKgZSKi6bM+Y+aAluGJ94wpIga19drclKadnfqPm+aBvCyLPFqY7u8RYrMk34yrngC0
 /KtueB740yLnQMIl7Y8l5paBMn9B7LMgmy9PJw==
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4bb88922c81mr452682765e9.32.1795737850830; 
 Thu, 26 Nov 2026 16:04:10 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm782004905e9.6.2026.11.26.16.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 16:04:10 -0800 (PST)
Message-ID: <90d8b44c-1aa5-46f7-9e5e-d108e3d2646a@gmail.com>
Date: Fri, 27 Nov 2026 00:04:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v4 1/3] drm/amdgpu: use pitch and surface offset for GMC v7/v8
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
