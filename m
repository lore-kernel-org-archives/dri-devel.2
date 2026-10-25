Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4E606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EoE9CzuE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837EB10E675;
	Sun, 25 Oct 2026 04:03:36 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC7710E678
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:03:29 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so3322707eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792901008; x=1793505808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ld0b6jnrv9lRwiEj850RVsyn17/7q2cRzxdIYpNocEM=;
 b=EoE9CzuE6p7kHUAzFVmmVt0qqx9n89Zr0FpiJXY0wKRrXvfa6SqtRH33NLMJThiMl7
 Q4K306xl1TSdHLyEchmz9DGW1BrNa0AHvzGwmzAhrvN3kbDAXnoC6V0K3RCC7sft6cla
 IhXuEGgIOOxQwMZr9NIIXJf+rWwzRDESQ3vw4fAWtAzotBVYiryHkP0djMGpaPC8DC7z
 EzbXJwttFZz74kc5sbmrIfGnEG7mJqUcH8QyGEEknBpV2bm/k0hUdIXlG+Ntys9kYr9Y
 QPPoGT1ZNvglFc5lFNdg2KPeEwgB9WcoclTsTIA4UExbJpa+NZvExWyCcrKcF0sr8Ppt
 8wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792901008; x=1793505808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ld0b6jnrv9lRwiEj850RVsyn17/7q2cRzxdIYpNocEM=;
 b=jImA0PMpX60pBSYIz2e+sjmoHlNZgX0GTo+xSIvBNl/bszXKhkakHg4t4Xcc//frsi
 BYhofxojwEL2sIghKsDFN5bwp2Iz4r6Oa9nZw33wV3Aau7N7APWXcfJxfdXju7VxorOv
 2if+Umv4uuqnijpRm3YYXoXxC1zzn4VqyCMDobQLeMyji57fSmENUDUX7jDR0ose0sk0
 iaolKK6/aS1EqnqvNv6cmfPBCaKc4WfuTfozV9ktFXhOkG+Y8KVkVImJd1Pa5EDx10fS
 hnEBCuyymmSPSb4akjsM3FDVtmItVa71/Z6xUK7msuolsAAIC2aOxYtohUqvlGvuVOs/
 yHLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAE/DBK8gZH4S2Ln5q9Z9z4sXhsMFKi9EIuw4LdqaGHMlbSHpI2aCjIJ7yjgD/DHqR5ZiRG7J1GCg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjuNFzFVsyrg7moWZ7Yem3fuUHC/AesvPgpfvA0oB53tmGnstB
 NG+QEcBbLRWM93/rThZFu09j9HAvspL9Zcv1PYdRgcTqwlMY1RoHXz4=
X-Gm-Gg: AYBFou0bO/qIVq5wLKOF6r/RfVcygHvBtMfyUzgofoWLNZCM96ZEk9/PO0HSAxpF2PM
 1ZdiTe6/MLond5Ng2v0ONtkhMrd7qIUx9wU3EemaBLm4j0QfGrmJ7Prz2YX9wl7Ke1alhSvOpYb
 444HWuW7M0xIq+dCuyoQLpX6F3T5i53JHfBotIsHvgHEPeVlxIvSwfV6mr2azcTJm19R6zbiaKp
 L1kdUUqEZQ3HGBMov48P6VNZGLeHanYW6y0rbcTx0t8B5Trf3UhUrpXsnWwL7R5N7FkUURMNcOD
 RTYYPciOXP8ldfBGX/D6vBBa1WkgstlXj6y4SKYe/ISUDOJ0doUcB+ZASWY6Sm4aED5DBaULhPN
 doYh9d7vH/EGvD1TCZ6XGquzPGBgRNGkRvu8Qq9ZdvSldbqD54TuSVP5ptxIlBY/pe9IQow2fWb
 wGc6fS+SzhOVGkI3R8r+iPD954BX3vqG04WCppSLNRUcrb1F86ruC4hxMV+P+VlloqZWz3voATw
 icGW2TJI8e5+c0NF06JNMwfBOVYClO5QwaceOxd8LiufQ1T7nzJhSe82fNbGb6A5ntuhA4UiSCq
 kZxLc+v31kA6IQQNJ+VWlcr9vQED7H+MvVny
X-Received: by 2002:a05:701b:42cd:10b0:187:ec67:2fc5 with SMTP id
 a92af1059eb24-1993702567cmr5122803c88.32.1792901008081; 
 Sat, 24 Oct 2026 21:03:28 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:03:27 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 09/13] drm/amdgpu: Add Apple GMUX runtime PM support
Date: Sat, 24 Oct 2026 23:59:45 -0400
Message-ID: <20261025040046.1602-10-atharvatiwarilinuxdev@gmail.com>
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

The T2 MacBookPro's uses Apple GMUX to control power to the discrete GPU,
but it does not expose the ATPX or ACPI power-resource interfaces currently
recognized by amdgpu. The driver therefore leaves runtime PM disabled even
though vga_switcheroo can switch the GPU reliably.

A dedicated GMUX runtime PM mode uses the existing vga_switcheroo PM domain
to sequence GPU power. A runtime-suspended GMUX GPU can remain powered off
across system sleep, following the smart-suspend handling already used by
BOCO devices.

On muxed systems the inactive GPU cannot reach the panel AUX channel. Like
the macOS driver, tell Display Core that eDP is disconnected before
dc_create() when the GMUX GPU is not the boot display device, and skip eDP
detection at init as the resume path already does. This avoids powering the
panel from the inactive GPU and retaining a fail-safe sink that reports as
connected and keeps the GPU runtime busy.

This allows the discrete GPU to enter D3cold while the integrated GPU is
primary and allows PRIME workloads and external displays to wake it on
demand.

This was tested on MacBookPro15,1, 16,1, 16,4 together
with the corresponding apple-gmux power-sequencing support.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 55 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 40 +++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 5 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a9c6f5d4a..6fd607587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1194,6 +1194,8 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_device_link_reset(struct amdgpu_device *adev);
 bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
 bool amdgpu_device_supports_px(struct amdgpu_device *adev);
+bool amdgpu_device_supports_gmux(struct amdgpu_device *adev);
+bool amdgpu_device_has_gmux_edp(struct amdgpu_device *adev);
 bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
 bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
 int amdgpu_device_supports_baco(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e780f..c1f196242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
+#include <linux/dmi.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
 #include <linux/nospec.h>
@@ -570,6 +571,45 @@ bool amdgpu_device_supports_px(struct amdgpu_device *adev)
 	return false;
 }
 
+static const struct dmi_system_id amdgpu_gmux_runpm_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{ }
+};
+
+bool amdgpu_device_supports_gmux(struct amdgpu_device *adev)
+{
+	return dmi_check_system(amdgpu_gmux_runpm_dmi_table) &&
+	       !dev_is_removable(&adev->pdev->dev) &&
+	       apple_gmux_detect(NULL, NULL);
+}
+
+bool amdgpu_device_has_gmux_edp(struct amdgpu_device *adev)
+{
+	return amdgpu_device_supports_gmux(adev) &&
+	       (dmi_match(DMI_PRODUCT_NAME, "MacBookPro15,3") ||
+		dmi_match(DMI_PRODUCT_NAME, "MacBookPro16,1") ||
+		dmi_match(DMI_PRODUCT_NAME, "MacBookPro16,4"));
+}
+
 /**
  * amdgpu_device_supports_boco - Is the device a dGPU with ACPI power resources
  *
@@ -640,6 +680,9 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 			/* enable PX as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_gmux(adev)) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_GMUX;
+			dev_info(adev->dev, "Using Apple GMUX for runtime pm\n");
 		} else if (amdgpu_device_supports_boco(adev)) {
 			/* enable boco as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
@@ -3767,7 +3810,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 {
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool px = false;
+	bool gmux, px = false;
 	u32 max_MBps;
 	int tmp;
 
@@ -4202,12 +4245,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
 	px = amdgpu_device_supports_px(adev);
+	gmux = amdgpu_device_supports_gmux(adev);
 
 	if (amdgpu_device_should_register_switcheroo(adev, px))
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, px);
+					       &amdgpu_switcheroo_ops, px || gmux);
 
-	if (px)
+	if (px || gmux)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
 	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
@@ -4336,7 +4380,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int i;
-	bool px;
+	bool gmux, px;
 
 	amdgpu_device_ip_fini(adev);
 	amdgpu_fence_driver_sw_fini(adev);
@@ -4367,11 +4411,12 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	adev->xcp_mgr = NULL;
 
 	px = amdgpu_device_supports_px(adev);
+	gmux = amdgpu_device_supports_gmux(adev);
 
 	if (amdgpu_device_should_register_switcheroo(adev, px))
 		vga_switcheroo_unregister_client(adev->pdev);
 
-	if (px)
+	if (px || gmux)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d9d794a7d..5ad7b6dd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2494,11 +2494,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
-		/* only need to skip on ATPX */
+		/* ATPX requires a full system-sleep transition. */
 		if (amdgpu_device_supports_px(adev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(adev))
+		/* BOCO and GMUX can remain runtime suspended across system sleep. */
+		if (amdgpu_device_supports_boco(adev) ||
+		    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2610,7 +2611,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
+	if ((amdgpu_device_supports_boco(adev) ||
+	     adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) &&
+	    pm_runtime_suspended(dev))
 		return 1;
 
 	/* if we will not support s3 or s2i for the device
@@ -2881,6 +2884,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
+	/* GMUX dGPUs drive displays, so hotplug handlers may reopen them. */
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -2891,7 +2895,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	 * platforms.
 	 * TODO: this may be also needed for PX capable platform.
 	 */
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
 	ret = amdgpu_device_prepare(drm_dev);
@@ -2900,16 +2905,19 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+		    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 			adev->mp1_state = PP_MP1_STATE_NONE;
 		return ret;
 	}
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		adev->mp1_state = PP_MP1_STATE_NONE;
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
-		/* Only need to handle PCI state in the driver for ATPX
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) {
+		/* Only need to handle PCI state in the driver for ATPX and GMUX.
 		 * PCI core handles it for _PR3.
 		 */
 		amdgpu_device_cache_pci_state(pdev);
@@ -2956,10 +2964,12 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
-		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) {
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
+			drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
-		/* Only need to handle PCI state in the driver for ATPX
+		/* Only need to handle PCI state in the driver for ATPX and GMUX.
 		 * PCI core handles it for _PR3.
 		 */
 		pci_set_power_state(pdev, PCI_D0);
@@ -2979,12 +2989,14 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
 	if (ret) {
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+		    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 			pci_disable_device(pdev);
 		return ret;
 	}
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 
 	amdgpu_restore_umd_profile_pstate_after_runpm(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47a0ff2ed..aee12cd76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -81,6 +81,7 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
+#include <linux/vgaarb.h>
 #include <linux/pci.h>
 #include <linux/power_supply.h>
 #include <linux/firmware.h>
@@ -623,6 +624,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	else
 		init_data.bb_from_dmub = NULL;
 
+	if (amdgpu_device_has_gmux_edp(adev) &&
+	    adev->pdev != vga_default_device())
+		init_data.flags.edp_not_connected = true;
+
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
 
@@ -2545,6 +2550,15 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			dm->hpd_rx_offload_wq[aconnector->base.index].aconnector =
 				aconnector;
 
+		/* Like the resume path, skip eDP detection without a sink. */
+		if (link->connector_signal == SIGNAL_TYPE_EDP &&
+		    amdgpu_device_has_gmux_edp(adev) &&
+		    !link->edp_sink_present) {
+			drm_info(adev_to_drm(adev), "Skipping detection of inactive GMUX eDP link %d\n",
+				 i);
+			continue;
+		}
+
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 8e8a052e1..025fa806d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -48,6 +48,7 @@ enum amdgpu_int_thermal_type {
 enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_NONE,
 	AMDGPU_RUNPM_PX,
+	AMDGPU_RUNPM_GMUX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
 	AMDGPU_RUNPM_BAMACO,
-- 
2.55.0

