Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC850606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyW84AFH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7AB10EC66;
	Sat, 14 Nov 2026 16:11:12 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AB510EC73
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:11:06 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso131026eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672666; x=1795277466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MmSYBT0oM+9e7OOhRP6rlPjvDndoWmXiY3l/U4zXmz0=;
 b=QyW84AFHrmxIxZXINtTkEvq3akfjvRnMmORGA1cYZ5nc1aNDPLhQZxbvYXVE+Y3nnf
 CKhl2sJqurOoMebVIIHgMjfvsxg+15nVN+4lW8XzuLAyrMGFl/bcg+2qDQSuM9rmtycT
 NgSrVoGl2t4+Ndl7vBIXTzios1XaSL3QJObXSLUW6sapljCTe8GkERjmBcufFxtmbhpQ
 wJuQD59PxC7X2PdEO7VYDv5SVpwHDsnKHc8jsnM2J/B4a8HP7yIWVknT3eEcM7dh1q3A
 SAjIzu2B0zwgbQEFrDul14hxuP1d+BVm44hfd+X6w3KSpRiHhzOg/KxnBfavyt86aC6m
 MoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672666; x=1795277466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MmSYBT0oM+9e7OOhRP6rlPjvDndoWmXiY3l/U4zXmz0=;
 b=SxdEtcAh22TZeIQfjrZ21p9Wkpi6IdY4PI7NbX1cAoLY6jlmUNRzIAZaejpV1M5/Me
 iEEX7CE6o/CbyhX5kL8l6zh3kKBMqmfO8t0nBa3wWPsUAjdpZmbDXa/q/vSIQ9+8SNyl
 hzcV5lGeSVMSYd3oriuvDvqK4+Ulaqzc5Hjk69UZ2kf0HDdVNPfYvTnmVMsDDOUH1Ehd
 6jZoKPTuQxM2Mwx7JITAIIEXMIch+tUQk1m4znVR3wDou3IQmPyoeKP8qzqULMwR6Pzz
 cG3LXsledtXtK9RazmnHfkPJIV1V6mBIpgdOzjd6qx+AoxYdhUBGVhT5fusAG1nmFC48
 MbQA==
X-Forwarded-Encrypted: i=1;
 AL+hErG2t5zcA/yfDiRb5ukW7mlE3u6qKw3qCNaYCl9Udli5CmNZ4ayQjc0kzcBr3p9YowPFfCd3milMX1s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z93fmwzBa9F52Av/VBFrTiJOyliEknmEBRRV4mk6C+8saInpnpk
 9m5Sv6H/OJVd4cF535fcC5rP2XttkhZ4cb6MslVgYviCvJa9owWCiAA=
X-Gm-Gg: AYBFou0HwiX+Ghq0Kp2vpjWj1EANf+VX/FSrbupnrVbWiORRuMmcZRF8M4MALkva0Zo
 9m+AC0vO5owYkOgBFI/JSuNULXnYEr+cr7YL8y1T8MoFGnjrbJhziZ8b/PcXhUfmaE8FMf8/HoV
 IVFqotO6+5V4lDw20KZ1gnj879NGh50yJ7VH5JlLILPGr4gk6OuduD+tG3hp+GJ5KWwU7/UvOti
 0bl8I2brEfGXCQXBDPf9Oeaki1P5700BSXrjT6A7ahVnd1a75oXbubVMZQF0SyUpjtE1cWGqFmo
 Q9lRq5HVA3ksqBLvAq9oE4W4QLrjRycRurymHpaOZ1nnLFtiHMhqhCsOXnhchY7EN5Y2EPh24XX
 4k70Wrn67A04Z+u1vDM53FInia/bR7ZUigZOsz9oXXjv+DNZFfiO6j7ypAgo4US7tp7kYAKUuqb
 SKcsHjIEPrdKlQ95rDD36NkEA1ht+kBxRqr1qTHwAUdPLYrWAQsjlPMBsaEecf2bciJ0FJTjBwZ
 cEsSjNTAo+JxWxVzBrfhOLwRJyxibjEmkeyTE7KohrlHX6l2XKTfg8zgaNcqNzoMTvUIgaNOxX8
 7Nz6vufNvs4ooLIpBq6oY9za7t4Dm6lBzaeLsc9TShkBOckoVUaRw/yuv60anQRsVA==
X-Received: by 2002:a05:7300:cc9e:b0:372:2ed7:8f89 with SMTP id
 5a478bee46e88-3796702a36amr5694460eec.34.1794672665837; 
 Sat, 14 Nov 2026 08:11:05 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:11:05 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>,
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
Subject: [PATCH v2 11/12] drm/amdgpu: Skip AC/DC notification while the GPU is
 runtime suspended
Date: Sat, 14 Nov 2026 11:06:35 -0500
Message-ID: <20261114160731.3756-12-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 808be6c42..3c6dde386 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -498,19 +499,27 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
+	int active = 0;
+
 	if (adev->pm.dpm_enabled) {
 		mutex_lock(&adev->pm.mutex);
+		active = pm_runtime_get_if_active(adev->dev);
+
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
 
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->notify_ac_dc)
-			amdgpu_dpm_notify_ac_dc(adev);
+		if (active > 0) {
+			if (adev->powerplay.pp_funcs &&
+			    adev->powerplay.pp_funcs->notify_ac_dc)
+				amdgpu_dpm_notify_ac_dc(adev);
 
-		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
+			if (is_support_sw_smu(adev))
+				smu_set_ac_dc(adev->powerplay.pp_handle, true);
+
+			pm_runtime_put(adev->dev);
+		}
 
 		mutex_unlock(&adev->pm.mutex);
 	}
-- 
2.55.0

