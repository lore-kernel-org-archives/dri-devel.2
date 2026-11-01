Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F501606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAE1DLjl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAC010EBB5;
	Mon,  2 Nov 2026 08:03:59 +0000 (UTC)
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114F210EAE3
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:23:53 +0000 (UTC)
Received: by mail-wm2-f2.google.com with SMTP id
 5b1f17b1804b1-4a210b0d5c3so9994915e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793575431; x=1794180231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ff70TfoYW5vv+iBaKSoq6x1++Arz0G5jzkSXdb473iw=;
 b=YAE1DLjlpjoLD4eh0XbJZyk+O2f585B3kpcA/XiL8QRnWp8VRuCdZhROWnoCYdhja9
 EdH/pwP0PIt/NrkTIZEp0HLgdn4tiRLFecz7QftLw9txuTCUw5VcTHG9MSb65N/ipv7k
 4lGcxrtCLRK6NI/k02k+om3UCulS0a0am342w76QPFycVRklgkwt+9WodBCUGl0jLlA2
 kWL6c0M+oyiVfrBrsR9vl1WLZ73H89WdnNcZrX3frtFfRhXX/Kh8lxopnhxo6GOY/vmb
 OAGk2UXFL6Fj+gJpBFwEgFASYhbahlnFpWb7xU0aaJa3mek3j4RuFUwKu2AfB3F817LC
 NDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575431; x=1794180231;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ff70TfoYW5vv+iBaKSoq6x1++Arz0G5jzkSXdb473iw=;
 b=AGZINK64ayHqEwsDF1eUWf1wUZ0oFMgUqBII1PtvJbbwgiOOWf+/PpzQxntVgH50be
 NPCW5890rRv7BLXrFjrNrp3U5n3VhI6FolDW2e1MKfxqkk7tdOAwcSqHHkcKvhnuMyxc
 OgCHfJX95fKWK+5Q3zaD8QkTim2RHSXZDNFBP22P1D5ahQLgB5s+9S98idbsmsyUOIpn
 c9a2ez4Nsdapzx4xA5ccJ81Rm+h0UB2n0dSS0NQpVJwAssHZVUBVmkjNlmHxGr/vQcG3
 Dnpujb81SsCQbv1fjpTIjs6c+3xuLQH0aYtdeseoF3ybWp1AuZbWrVLv+9DX6RBG3s4s
 /s5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOreqJgni3ABZ5MWI5cpHQ8t/LmDIbWHz80UrZt43ZwneFeoCpEymdaCUP1/w8Sq1mJALWXhSTp2M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL2UoKfVqhIYYsYW8PTwHHd5DLi/6/dc0Ggz6bJJVZ/L73UprR2
 /yMQLJMv5q4rPj2U43SaXtOoD2FDtQPeOm4DTWX64EXFGR9S926MrJTN5Ihu4p8Iqx4HDQ==
X-Gm-Gg: AYBFou0aa8/BV30xJtmno8PVFeYXNimDrU1uZe7ipK7snJZF/TERtPoffQsqnkU0fhC
 oGF3ilqGgqNAvdhW+TpKiKUoCDOtILsG1ynzv4gmjCuXmhqmzXRbo4PcSedSATqguEREaxBpUEP
 H+wrZDpMsXydyUqnGtBXx1lBCDhbr90VEO7KLpHkxLFQd7oR1YLQ5mU3A1ppsmLjym3Epk3F9WM
 xZoJryUelSeXoVh7PcWXoPSPjKOb0YsoaVU3DvPLj4VlTFZ3mMrPRmFl3YFwVMM35MtzoZ//Ewn
 Hh9xid5oZEzZYgJZq2M+vuDE2v/hQnnLXphUlsaDokWos9aE/ekCAEo7BNew7w2NmQkumIXP75F
 L/ILyyJkb2PSzG3uSIMTw2OgrZei79aztEbpWCfeNbQsynwtDXA5irOKnEKB8Fj8GVMCJnF8teD
 6gn2xwJWTjo68m68CMjmQZjsopNDKeSM+87HpQci8XMMwgFq01Z23KCunRFrgv/r2Tvmls8LCQd
 1sixgxWsVaG1oO37WqedH3dDEeZiNXk9BlO0V5uDYVtH+jsAbVAmKVSghJlAVymXrHZ7DWkmVOE
 FTS5B9/9XymLxm/MKn8d/u5gCjCUwue8bQ==
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4ac151a84f0mr192130815e9.3.1793575431515; 
 Sun, 01 Nov 2026 15:23:51 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm342967035e9.5.2026.11.01.15.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 15:23:51 -0800 (PST)
Message-ID: <54c182e5-1474-47af-ae72-d28560a12bcf@gmail.com>
Date: Sun, 1 Nov 2026 23:23:49 +0000
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
Subject: [PATCH v2 1/3] drm/amdgpu: use pitch and surface offset for GMC v7/v8
 fb size
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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

On Apple 27" 5K iMacs, EFI initializes a single 2560x2880 viewport at
boot but allocates a 5120-pixel stride surface (mmGRPH_PITCH = 5120)
and places mmGRPH_PRIMARY_SURFACE_ADDRESS at a 3 MiB offset (0x300000)
from vram_start, spanning [3 MiB, 59.25 MiB) in VRAM. Reserving only
2560 * 2880 * 4 bytes allows permanent TTM driver BOs to overlap the
active scanout and corrupt the boot splash screen.

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
