Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83829606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WEcTjWaZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68B510E680;
	Sun, 25 Oct 2026 04:04:15 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACEC10E682
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:04:09 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35d0be18c71so3510999eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792901048; x=1793505848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
 b=WEcTjWaZxZh8WyqZsmt4ane309t5BOigBarL+fJw7J7i0d+xUShAKMaMLvHYf9pDk2
 5wybFT9VSpZfxwPoroWCC2mBBG4PBQk3J18XDc57Ko+0KvWhUQec53CAWRLL+6CwjRhT
 23vR5oKLSJZdhd2viPtjUQqQpbc5dPih0GbCH3/VA5d5CtMJHoEVphG7yiv8c5dn5S0k
 rQV34CoSFpDcaXBThbF2Pn10nGpwpyMx36hSABnqlOcjgsP4quKj6wG8sratOaOLWuuX
 7EIGipARhm7dGXQxxrR7iLB+Wmd7jFYXonjrLhtzYMcE0gNtqc+0hlhFy/K7NqoI7a9T
 5i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792901048; x=1793505848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
 b=hGxQSGNmE375vAhO8cNZjCWfRPnX8uDqxbO9i0x/gyLUoXaxKNZxGnWRk126/b594F
 Y8euT8WuBN9AUPfLgN3/jHOeouOPgfi/q1UJSXzE/dDMsS6qbZIQdmdYaTI3A/Wpl/2X
 KcvxIK3gRovDFEtBsdG7xZYCPMc5EVDMWNdPI891YW6Fhb1YB+KvASk2n1Krx0ZdTTp8
 BMGGz60mkE48lTklxoLZ/pSsucxOxedF//LCL977oaBC9m4HCt/htEdrYBOru54ywJ83
 Q+1oCnOoUNm7Lxsodc9Ord4Z2QI7GIwhvjQsxxJFCHnWJRZg/6xEkZsss2Kann/tHs0k
 uf1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNjvhvX469TN+z66QWa4yCKebPNaISEDC/BEUBvrRqWLdyQ3V6ArJMhHQQIj4/WMnlfLEcm4tNI5k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUun+MgpDEl12kjgm8QudXK5irow5FVAnpMUAO/eTe/b9MOtbq
 3mRWQ68ugQyzkFykKzrmbtu1dIBcgRIs0ZnrhzBNu6ecR9B9kCGuT1Y=
X-Gm-Gg: AYBFou1j3ksrcnMxG1FXe9nKqcEjBeoCPoql0NI1A9rMHNFS1SLBIqzYBD3G16dWDrH
 xPVe3tu7w8cybWOglYGj12Nd8pFfhx2NWPe+y/Xry7HnYYRsMAq5E6ucNmzR9S5Bi7esqapL/FZ
 EQnm8JAkm9HmkakkI6QPrjrB+TH8mAqRnNBD22PCM+oY8g7rQeoI3ThEiX1MkdLmCXsJdRk5ioQ
 pPqOozDHafxqBja6Vp2nZiF4n4bvrqKoiVaHGRs/STtUE2Q70iRrbkKySIWkbXw48OJ4rpYNSFN
 yAsaWCZLonZj4dTncy+6u3adLa0g+EzExj5s3i6RNgozdM2z59tuuvJbiB5GNps6Ux9XVds5v5K
 XC7lswDZJO8bpR+0oCVVKJVJEkbS3bzd3hrTqkCnH5Vi7QkG+WLFUrj9BM/x4uV1ZHEQwGJoetV
 Z+z9iGCLQnulTu0GZ07pIUriCRCEVMAhSpiRFzTh4XC4jaGfvrHt40pYzg4CkBaPF4kuQVXf8QJ
 pX3g6goAT3AlH3r0E/j5segeqrmawRp4TV65J1zSTL+W0j4ZjmPJU36ccF9k/ylizzlosNoX1bY
 Z58bRIR1hY36tdJckrmMeu4bxc009ezKoKS/Dv9RHswqAwsZE/OFrft9dMiy+W2rkw==
X-Received: by 2002:a05:7022:5f14:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-1994cb430a1mr4374141c88.3.1792901048032; 
 Sat, 24 Oct 2026 21:04:08 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:04:07 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU is
 runtime suspended
Date: Sat, 24 Oct 2026 23:59:48 -0400
Message-ID: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andre Eikmeyer <dev@deq.rocks>

Plugging or unplugging the charger raises an ACPI AC event. The handler
sent the new power source to the SMU without a runtime PM reference, so
with GMUX keeping the GPU off every SMU message spun on skipped register
reads for seconds. A runtime resume racing with that left the SMU
firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
error state. Record the power source only and let the resume apply it.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 808be6c42..b64f0b681 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
+	int active = 0;
+
 	if (adev->pm.dpm_enabled) {
 		mutex_lock(&adev->pm.mutex);
+		active = adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX ?
+				pm_runtime_get_if_active(adev->dev) : 1;
+
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
 
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->notify_ac_dc)
-			amdgpu_dpm_notify_ac_dc(adev);
-
-		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
+		if (active) {
+			if (adev->powerplay.pp_funcs &&
+			    adev->powerplay.pp_funcs->notify_ac_dc)
+				amdgpu_dpm_notify_ac_dc(adev);
 
+			if (is_support_sw_smu(adev))
+				smu_set_ac_dc(adev->powerplay.pp_handle, true);
+		}
 		mutex_unlock(&adev->pm.mutex);
 	}
 }
-- 
2.55.0

