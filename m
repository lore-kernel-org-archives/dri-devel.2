Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE7108B8FF
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E0610E2CE;
	Sat, 21 Mar 2026 05:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EYGykoMx";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEEC310E2CE
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:45:14 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so1784901a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774071914; x=1774676714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+adMGPlhVk0bbFqFiUYYCeP0eNPb1PCXZHc4YqFFXSQ=;
 b=EYGykoMx/+fMjOtrExMmEXIpYeGaKsHPE9DE9LeS/a652h1sxe4dlfHL1hOEGWerck
 P1Nzo8e/gcs4L5eAkGJxh8HsfXGs0UbZxNtSj5xj0FYhe6VotpyP1oOyqXOKRW7a/nFk
 u6bRVvU3B9pP3YXRSRaA3unI4BJ2FxMUPUug2RGZ2qibaafb5oqln/OvFvXCioX2ye6W
 xhhjCLYcNTiWiiHTydsfD9z3p+jy9P0XzobgS8nHb/3b0WUjxMXWSNmKLYMebh1PPnz/
 QzCmZQ+1uptDyIa2exgZ0quVtvoF0gsGy0koCJiEuxLZ/NbWfhv0wMR1AGtb2WjIS6gi
 WK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774071914; x=1774676714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+adMGPlhVk0bbFqFiUYYCeP0eNPb1PCXZHc4YqFFXSQ=;
 b=beEtG3tNb7cYt8yweNMHHjzRy1sw91dLcGO8tRIAahOtCHC296JvYtWxjtPK/heaLB
 KJN7MzbdVzAJBDD/KCpg/b4gFNGe/ltsKcPzZyqlCm/7sunWGyd37Ur1JRhDoN+/HnV3
 KPfjSHRzCIL0HPsUilupq8CS6EF5wNuqE12MT8vceEF1vKXHCIRDHZhZqBn/5IcfUy+z
 lfcJwZlkXX3sHr+1jdHBmcopOxnf79P0pDEynp7BWdXIDsOcnRHy2xFc+BiqKLCH27Y5
 37VG6UGbXEx/GU8nE7uBRFNxxD272k3oUMfw0/cXJTTIF0q/tpZVJ5WoTI/LZ5BHb9vq
 zP+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+0XhlKnc/w9NpIk8Bv/vFul8Jqj7O9mWWE66qHIM6rFqp89rHlanHYi4+RfSHVg3qk0s0K9uI2tw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz69zoe+yBNuQsUJ/6rgXTSs5qOk0RXxjtrP6l50Z7f5kTBTpTz
 zmxQ8oJq8KgUcNF6UnUhgoa+FGYqpASL9fMFb2WY0wEYlqHeOjk6ZHXv
X-Gm-Gg: ATEYQzxIkjwuHUVAWJ7JuZJYAW3OtaWAPHUiszAMp37aNCtLjnyF7bGqiEY+VKI4U3Z
 PBuTPGmZRbz/ugSspOzDDzMiQT8WGXeWTb6waOZ0uV63ZSJ6ug+X40n+m7ai12DLc59qZ0YB2ho
 mP+JQUeBGaJ8pNc1hDZKzmepLMqKTHX2jd7PFrxnAHYSw5jE4FVqosENE+0YIVGA9bYN0IUmVTo
 pUXDr3JOiOBu4j11hk5gc38S9MKGHOtSunhWfOIoPetus+NBOVJ7a1S/Cb08pPZ1uDPQHVIKLDm
 fin1kKKZkmDFje59mOR2qHxhcEkk7LH2Ve+4AlN+FMBqgsLJAmx0iXd1jHmy4wGnGzNxOdKDfss
 FqHRfnsqQgjX7XoSoTQSQI09YzKR4+8fNmyBCqNicFm/OfcSqQQ4IUukVaBiHntc7orkDD6y5aQ
 mqvs30bXFg+U1m17RxCcpIFyMEu1U6baWdbA3Ik/jL/XxZc8II+9X3EoU=
X-Received: by 2002:a05:6a20:9146:b0:398:8bd7:4f80 with SMTP id
 adf61e73a8af0-39bcec0692amr4985522637.46.1774071914235; 
 Fri, 20 Mar 2026 22:45:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 22:45:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sasha Levin <sashal@kernel.org>, Rosen Penev <rosenp@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Zhigang Luo <Zhigang.Luo@amd.com>, Bert Karwatzki <spasswolf@web.de>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Roman Li <Roman.Li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>, decce6 <decce6@proton.me>,
 Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 for 6.1 1/4] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
Date: Fri, 20 Mar 2026 22:44:50 -0700
Message-ID: <20260321054453.19683-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321054453.19683-1-rosenp@gmail.com>
References: <20260321054453.19683-1-rosenp@gmail.com>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 96ce96f8773da4814622fd97e5226915a2c30706 ]

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index cd0bccc95205..98cce09684f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
--
2.53.0

