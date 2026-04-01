Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F6E10F9311
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779F810EAB0;
	Wed,  1 Apr 2026 00:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVz8z4zj";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1679B10EAB0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:33 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c7d8bbad06so1463852eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003972; x=1775608772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=lVz8z4zjjB+ZcYb+2Vn1OzHNGdN6rWjMUC1A2iZRmFSEcGH6UsLWpqJbXIY4eD7E56
 D5afH6XDH4rVrTd4e2Rd91BBVakYA6jTTVa15dBnCbiiACTZHlnXWCOZ1ePzd3jBNKGh
 rLlsto09d+Tpy2hceki4Su2mheaiqrqVVc0W4HJBVDrEMpdxUGx/tPWW+d32LsgfRABx
 PFwNHmebC/AADeD6RC6g6NAYV4Gzh4qBY3xd/fwOCczrPMi/IJXlH3LNzzhMGJPnYd9h
 z9TDv8TqJp9LGOQy/2Ej1kR0MOygV/sUWKQ3FZJBfVtpdZ9nma2SijYVFCiHCDBfq4pf
 zdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003972; x=1775608772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=VtmUxbjapUG76SI862EEdl6dUaOHcRePVzmvGgbEvooNadROpiifZ/RFvF5sfLotKD
 BiiM+zysQmSOolNLvIF5B0p28eJJ6Aka/Fag6jfzFMgses1suGkGGinb0QpYoWWEBBt0
 zk8DLIRKg9dLvE1mf3CR0/wGd9keKiSIP2R44KIz6HZb/XIQPTYtq4uBNSWzq8EZozkQ
 /9FcmFkSri+bFK7ahlsACG5TzBvqfboYKKbE1Wo4fkqejDsntPKI48lGR1lsvYJnXyQ7
 dKmQYnEwKLwlUwTyNmfxisJW/IXgEadZZeN0bhlbeVUm3mwjhZpwXTOrrIUyyFfGU5Ym
 JF7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdmM9iehPcdpU+Vpv3nbSjvSWvWqpyWaQsdYZFDOLSv22u3NPTR4ezpsOy+HJMCd4IprQLus3EDQ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5EpwDSdVS6t4qaKlS2+6sDtYvuczR2P30tPGhJ2RMmYCEA2P8
 t5VIMjgWA5lhh5EcXlo2aWi6bw0d1WjdI1IgKoolydJ4RXciMChZv0Xe
X-Gm-Gg: ATEYQzxrVPyKjQgzhQyzwERiw+T/Bm1yw8wQpJPj4Lh66bvE5JFXbg+6dQrMFtbbuaB
 oo6BbbWllD6RtT80YJShzRDe3T/WWsDO9XzWYIz+mvxmdvvKqMAiD0nY0W7Ff1fRjicH1r3M3OX
 OxKe2NDd6/Xu/P5S9/ls/UIfCyvWWUAUYbPELtqR2/bNUyUjO/LMPJxPiImkYfb4WgCGviHskwZ
 jPJshuHNYPEVH7fCGqU+d1pYzUcbYItyQR68ejZbgbyRRSc/GYbnwQtH/Qesfoyw9T/wK6yQ1m7
 kU8KxZXnhSSWU7Nd0tp9d9iM0tbWmrYu+bl0ZHVFhtXQ8dJh87ZjRiVZVN2aru/2gptpDtRtwwv
 cFY5enY/xc4LiF47uaH/dPlTrpb0cEMJYMvWH4hayNEHxD1S/0E3U4+f2ObsjacKBAiv7WmhjX+
 LJ5xD7ZUYZPGvRq2BjO/BBvi+U9ccDVHSBkfWH/5Sddi/zo8CipAvVLnE=
X-Received: by 2002:a05:7300:3205:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c9309851dfmr1044767eec.5.1775003972186; 
 Tue, 31 Mar 2026 17:39:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 02/10] drm/amd/amdgpu: disable ASPM in some
 situations
Date: Tue, 31 Mar 2026 17:39:00 -0700
Message-ID: <20260401003908.3438-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
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

