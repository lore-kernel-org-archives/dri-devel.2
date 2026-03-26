Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A43E10AB82F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5511D10EB15;
	Thu, 26 Mar 2026 23:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fAPm4hFl";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA1610EB15
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:40 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c73a5473bbdso668466a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568859; x=1775173659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=fAPm4hFlTWd+Vmk0N2NAldaV8DjFXR56E12R+GM3VN3pJMh7A3e2Y78m5o4oL0PCyY
 nneXpxdOuPFpavBIwYBdsg/1ct11PdE2qA3nE3col6WD/ov9/6dMg186tHcht56qgEb6
 fur2pt60VZ0O2Nif0TGCSeVY09jQbr5kGkHAYEtoT/vw3JLd9w8rIIZFwLnKCg7AsUnl
 ejReP5IN+s8YuoesfxN+J2YxLwg/JXk5zDkI9HRQWKuCRwMXR4gsVBP5BHVw15xVTXFn
 Ub0FiP2sbh7gySRYsTa+8HoASRIXalZVEvUOx5hU+QoVFCHE43QYwchz1+tx+h9x0MTp
 mE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568859; x=1775173659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=Z0yNedae0sNeZqWuI4EZBlhIjQgWgvLIPGkCgsceHb/nnMdk9LUbBSOTeVn5S+iNwd
 ItbD3EF/uIqcz1LTf6UL5REr5K2IBMqS1DumO1lzxWkHvWDWmwDsvuz/kBS31WSbqTOY
 nsvD5JmaOopIm/2VVEU/8dMzqkKQS/oLNKXpecUeG/MOO1Tg2mlY8Ocvx/84SxQHGfCM
 FnD/lMx6RiO3cEgpYCeT4CaOdPkfu1NGCn1IJ/PNTqd0N7QLVJYycG1K043CLo8ogl1v
 ySelN1zk0ELiijj35wZK8P+WtlkAIOVB9GAKR9uuf8wY3qjEQr9cnUCB3SKngufAGIkY
 ICTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqQkNCYNNoIfUyHD3B3B0PyEZyTVk55mLXiwfDw3ngOj037n+4hkfHTQQzjSeXyyYeh63jelxnkD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRf7DvPMyZQ6ZDCvc9UHpf2B5rDxzftFEw0nDAH130GN3k+nbF
 Pw0VL3pzfw3zBvw5UAbID6EmKeLaw4WYMgIEmOoAMNADGpJdwzp6qsIL
X-Gm-Gg: ATEYQzzc9pZWPogzOokErQidKKA7sBYEhBEafBEMwy3FchKeeJp81LVNXjbHBq1GfyA
 SDXYADIdl78YrjreTqcng8q3R826BGvXXqA3QhIry4mfn87Xd/qUJdS9uqdg4PsGixBrWZAf60b
 7Xy7iJ4YYOlIjwtcAwBDryPQV9fUb96iyivE8YRetqCRQSJoxclmy84FvylPWAQqxu1QORwS3TL
 EoyLEJpPORXcb5N0dKybTM92wGJu/5s/Qi2pTYT69mhNozVT1b45qx48Tu48It8NotRD+oFHnCu
 j6/jDWxXCQ+GmVrQEIVY81obpqk+N6CrCIBjo7H5a9+nmHAp+Sjp4MYrGo14iIr2MA8HuCDhlpW
 2LxcPlCGhXWvQyFAJ5uCDwHDyTwOkpa6h6I8Sd13qyNKLkv0QunbZsYBP9NSEZAtloWTyMTaNx2
 0zQXjCK4h0XAblGNQNUihrTD0KSrLtASus4IZe9WzHjeUPQLynVnVumgo=
X-Received: by 2002:a05:6a21:3287:b0:398:9ae9:7112 with SMTP id
 adf61e73a8af0-39c8781ff90mr479262637.1.1774568859447; 
 Thu, 26 Mar 2026 16:47:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 2/9] drm/amd/amdgpu: disable ASPM in some situations
Date: Thu, 26 Mar 2026 16:47:09 -0700
Message-ID: <20260326234716.16723-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
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

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit c770ef19673fb1defcbde2ee2b91c3c89bfcf164 ]

disable ASPM with some ASICs on some specific platforms.
required from PCIe controller owner.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dbee43c58741..eb3c6bfe2e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -84,6 +84,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
@@ -1758,6 +1759,35 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 	return true;
 }
 
+static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) ||
+		  amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 1)))
+		return false;
+
+	if (c->x86 == 6 &&
+		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
+		switch (c->x86_model) {
+		case VFM_MODEL(INTEL_ALDERLAKE):
+		case VFM_MODEL(INTEL_ALDERLAKE_L):
+		case VFM_MODEL(INTEL_RAPTORLAKE):
+		case VFM_MODEL(INTEL_RAPTORLAKE_P):
+		case VFM_MODEL(INTEL_RAPTORLAKE_S):
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1782,6 +1812,8 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
+	if (amdgpu_device_aspm_support_quirk(adev))
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0

