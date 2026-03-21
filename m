Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352DE1099B54
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E7C10E2E2;
	Sat, 21 Mar 2026 05:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXvdzev5";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B7910E2D5
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:45:16 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-82c20b9fb16so379354b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774071916; x=1774676716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FP34IF1NqA/DrYCuAVhgwWOfQKjwg0Ze9v4T9XeI0k=;
 b=WXvdzev5BE+fUwVwfOLCrte3KgM8p71Wh/HxkTWOZP4IZ9BuMGpeTzM68llU3juGR+
 LX/EjYuSywDRO1rj5Xd3gUUJ0iqVzQToh7abUgif5VgKfHIluDrGsXAqekT4qH3RYltw
 OH6r7VwM+tNfJzjRIJKxabjO3TMc24P+8NpZFQIAZ2wN7H7N8arFL/iB2iGdytXdTJ5f
 q0VCw6UPvKTho8RgWbn7fRFBte1jnnGgJde0SkH5aWma1ro4Cskjk+FqKnln6/Tnw8OZ
 RNpC7LaCN3M+wNRWI9lxvYPwQ/uVwHGA9uXYn9q0Gz1mtmkEXY81S6rGQcqwvcc3C284
 43lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774071916; x=1774676716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4FP34IF1NqA/DrYCuAVhgwWOfQKjwg0Ze9v4T9XeI0k=;
 b=huapxq+CjliVSGhwv6a/51s4uKkYwJ5gS1l3NRzi/UrDPEvWjmdD/bA7YbsOuCgJlu
 vROLlGXrfHaLNhrfrLwNpUXPW1ieYbvSm9nf9r6Aha5rtK/Of+aOtrp3BPZVeUZgRXTz
 kSCjMe3XQ03MxLRFilV/kAQA6AQDU3D67N+lMT0lX0Get/DL4Kc1lnlnxf+/xzaR/obL
 qm8xwD16C6nVqTodXaMaWZ9V39KqcnRaEosQVrgrUZVAUxCEcQlVEji92MPPYHMppWO3
 SngMcaX5brMI+4IKXrz9YWPXrRjQBZClvH6nVCGQl3vIz0qTOGxY9XZBrzfSnAd08Rmm
 Iblw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKsPE4EX4nFhvKSO/HrmEpxxS3yfl9FdP2et337ouIButjsUSOtc3jasQITHls/sPSZhDr9RVX/oE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG1ZHUaLbyZTVJrr3l62mNywksdGbFcFTxPVraUpYVcIezK3QT
 KXkmbXz+PAnFsPDWCT6ylhuPqtLXFyeBOZ84sloZenFVNY5sjPLd8knJ
X-Gm-Gg: ATEYQzxhfb5YHH4UD5wTYx4Phs5Nio/llD+5y9diASJctNw8uyjPkvXIlWDkNMNbPql
 4F4j/pZHnL1B9g2f6D2swaWuvrhXPiD/a82c28W1fVAwvjz+qDkp7jcGIoS176nlQyVnf8UzBzx
 DY3Un5DrzR6dwxc1nC2o9BZQAY5WFkn8WNiukWO0rx7aDOukCovh0KCaGp6rhHEWnrMSuEsHw1t
 HC2KQIKRRtMzothlhX9eQ1KSy1fozkfDHK8UD7wD9bQb8j5L7huZyI48as8kCFBZqKBCtV9qwAP
 BO3nujx3q/uPcbRBU5PuqnJbaXv9aeno9cwjk7YT/mOvn30SE/yzG7CQ7q1NH0P6erwlnOseESY
 ixHPVrTX8SPng6zrelNN1IHuvqTVbNL9eXYyeipekY3Wye3lb/xdO7PN5L96Si/90LwAebYauxL
 pUCPs+5Wj29T4fg0Xtv1Nx8aDoCXC9WkY/nmyodCGobP4/SI9fVNkU/Wk=
X-Received: by 2002:a05:6a00:13a9:b0:81e:6d2d:a121 with SMTP id
 d2e1a72fcca58-82a8c3c3239mr4749010b3a.62.1774071916251; 
 Fri, 20 Mar 2026 22:45:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 22:45:15 -0700 (PDT)
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
Subject: [PATCHv3 for 6.1 2/4] drm/amdgpu: clarify DC checks
Date: Fri, 20 Mar 2026 22:44:51 -0700
Message-ID: <20260321054453.19683-3-rosenp@gmail.com>
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

[ Upstream commit d09ef243035b75a6d403ebfeb7e87fa20d7e25c6 ]

There are several places where we don't want to check
if a particular asic could support DC, but rather, if
DC is enabled.  Set a flag if DC is enabled and check
for that rather than if a device supports DC or not.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 8 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dcb5de01a220..c4287e09658f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1071,6 +1071,7 @@ struct amdgpu_device {
 	struct work_struct		reset_work;

 	bool                            job_hang;
+	bool                            dc_enabled;
 };

 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 5fa7f6d8aa30..9ced0c60ec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -857,7 +857,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;

 	if (atif->notifications.brightness_change) {
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3cca3f07f34d..11bfbf1d6a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1981,7 +1981,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_ta_if_debugfs_init(adev);

 #if defined(CONFIG_DRM_AMD_DC)
-	if (amdgpu_device_has_dc_support(adev))
+	if (adev->dc_enabled)
 		dtn_debugfs_init(adev);
 #endif

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 535cc74c5880..a43f18defa7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4402,25 +4402,27 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)

 	amdgpu_ras_resume(adev);

-	/*
-	 * Most of the connector probing functions try to acquire runtime pm
-	 * refs to ensure that the GPU is powered on when connector polling is
-	 * performed. Since we're calling this from a runtime PM callback,
-	 * trying to acquire rpm refs will cause us to deadlock.
-	 *
-	 * Since we're guaranteed to be holding the rpm lock, it's safe to
-	 * temporarily disable the rpm helpers so this doesn't deadlock us.
-	 */
+	if (adev->mode_info.num_crtc) {
+		/*
+		 * Most of the connector probing functions try to acquire runtime pm
+		 * refs to ensure that the GPU is powered on when connector polling is
+		 * performed. Since we're calling this from a runtime PM callback,
+		 * trying to acquire rpm refs will cause us to deadlock.
+		 *
+		 * Since we're guaranteed to be holding the rpm lock, it's safe to
+		 * temporarily disable the rpm helpers so this doesn't deadlock us.
+		 */
 #ifdef CONFIG_PM
-	dev->dev->power.disable_depth++;
+		dev->dev->power.disable_depth++;
 #endif
-	if (!amdgpu_device_has_dc_support(adev))
-		drm_helper_hpd_irq_event(dev);
-	else
-		drm_kms_helper_hotplug_event(dev);
+		if (!adev->dc_enabled)
+			drm_helper_hpd_irq_event(dev);
+		else
+			drm_kms_helper_hotplug_event(dev);
 #ifdef CONFIG_PM
-	dev->dev->power.disable_depth--;
+		dev->dev->power.disable_depth--;
 #endif
+	}
 	adev->in_suspend = false;

 	if (adev->enable_mes)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 98cce09684f2..f9692e724409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_has_dc_support(adev) &&
+	    adev->dc_enabled &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
@@ -1330,7 +1330,7 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 					 "dither",
 					 amdgpu_dither_enum_list, sz);

-	if (amdgpu_device_has_dc_support(adev)) {
+	if (adev->dc_enabled) {
 		adev->mode_info.abm_level_property =
 			drm_property_create_range(adev_to_drm(adev), 0,
 						  "abm level", 0, 4);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 055e05b2cb22..3c01bb464248 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2530,7 +2530,7 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
 		if (ret)
 			return ret;

-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 			struct drm_crtc *crtc;

 			drm_for_each_crtc(crtc, drm_dev) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 213054071904..7eff2b94ab66 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4842,6 +4842,7 @@ static int dm_early_init(void *handle)
 		adev_to_drm(adev)->dev,
 		&dev_attr_s3_debug);
 #endif
+	adev->dc_enabled = true;

 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index ab8ae7464664..9bf85ca607c3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1567,7 +1567,7 @@ static void pp_pm_compute_clocks(void *handle)
 	struct pp_hwmgr *hwmgr = handle;
 	struct amdgpu_device *adev = hwmgr->adev;

-	if (!amdgpu_device_has_dc_support(adev)) {
+	if (!adev->dc_enabled) {
 		amdgpu_dpm_get_active_displays(adev);
 		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
 		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
--
2.53.0

