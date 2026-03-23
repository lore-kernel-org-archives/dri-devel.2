Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2921F4610A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C9910E3E9;
	Mon, 23 Mar 2026 13:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdjJHA5j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247E610E3E9;
 Mon, 23 Mar 2026 13:04:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 85015600C4;
 Mon, 23 Mar 2026 13:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98957C4CEF7;
 Mon, 23 Mar 2026 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774271051;
 bh=nj+qiVG7IbV8YyBFK4Zymy8knypFitPwdeCO1dTeODQ=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=mdjJHA5jSbQmBqHMVL7U/FQKcVxlyZCaRZNhgzPFewKtWfFbqM82/J5io3zNaKV1n
 NAPWtryUbhz25aS1KbKF40q+6YVGWlMjo4lJ5QgzhodmOECHMQdqWspVN+TSGf8pms
 CXprloAnuKQLGZshpkezfBZp1UyRIN9Fy5Na5pz0=
Subject: Patch "drm/amdgpu: clarify DC checks" has been added to the
 6.1-stable tree
To: Jun.Ma2@amd.com, Rodrigo.Siqueira@amd.com, Roman.Li@amd.com,
 Wayne.Lin@amd.com, Xinhui.Pan@amd.com, Zhigang.Luo@amd.com, airlied@gmail.com,
 alex.hung@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, daniel@ffwll.ch, decce6@proton.me,
 dri-devel@lists.freedesktop.org, evan.quan@amd.com, gregkh@linuxfoundation.org,
 harry.wentland@amd.com, hersenxs.wu@amd.com, lijo.lazar@amd.com,
 mario.limonciello@amd.com, ray.wu@amd.com, rosenp@gmail.com, sashal@kernel.org,
 spasswolf@web.de, srinivasan.shanmugam@amd.com, sunpeng.li@amd.com,
 superm1@kernel.org, timur.kristof@gmail.com, vulab@iscas.ac.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Mar 2026 14:03:39 +0100
In-Reply-To: <20260321054453.19683-3-rosenp@gmail.com>
Message-ID: <2026032338-raging-elm-0386@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore
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


This is a note to let you know that I've just added the patch titled

    drm/amdgpu: clarify DC checks

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdgpu-clarify-dc-checks.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From rosenp@gmail.com Sat Mar 21 06:45:17 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 22:44:51 -0700
Subject: drm/amdgpu: clarify DC checks
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Evan Quan" <evan.quan@amd.com>, "Mario Limonciello" <mario.limonciello@amd.com>, "Sasha Levin" <sashal@kernel.org>, "Rosen Penev" <rosenp@gmail.com>, "Lijo Lazar" <lijo.lazar@amd.com>, "Ma Jun" <Jun.Ma2@amd.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Zhigang Luo" <Zhigang.Luo@amd.com>, "Bert Karwatzki" <spasswolf@web.de>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <Wayne.Lin@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Hersen Wu" <hersenxs.wu@amd.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, decce6 <decce6@proton.me>, "Went
 ao Liang" <vulab@iscas.ac.cn>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260321054453.19683-3-rosenp@gmail.com>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit d09ef243035b75a6d403ebfeb7e87fa20d7e25c6 ]

There are several places where we don't want to check
if a particular asic could support DC, but rather, if
DC is enabled.  Set a flag if DC is enabled and check
for that rather than if a device supports DC or not.

Acked-by: Christian KÃ¶nig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c       |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |   32 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |    2 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |    2 -
 8 files changed, 25 insertions(+), 21 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1071,6 +1071,7 @@ struct amdgpu_device {
 	struct work_struct		reset_work;
 
 	bool                            job_hang;
+	bool                            dc_enabled;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -857,7 +857,7 @@ int amdgpu_acpi_init(struct amdgpu_devic
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
 	if (atif->notifications.brightness_change) {
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1981,7 +1981,7 @@ int amdgpu_debugfs_init(struct amdgpu_de
 	amdgpu_ta_if_debugfs_init(adev);
 
 #if defined(CONFIG_DRM_AMD_DC)
-	if (amdgpu_device_has_dc_support(adev))
+	if (adev->dc_enabled)
 		dtn_debugfs_init(adev);
 #endif
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4404,25 +4404,27 @@ int amdgpu_device_resume(struct drm_devi
 
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
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domain
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_has_dc_support(adev) &&
+	    adev->dc_enabled &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
@@ -1330,7 +1330,7 @@ int amdgpu_display_modeset_create_props(
 					 "dither",
 					 amdgpu_dither_enum_list, sz);
 
-	if (amdgpu_device_has_dc_support(adev)) {
+	if (adev->dc_enabled) {
 		adev->mode_info.abm_level_property =
 			drm_property_create_range(adev_to_drm(adev), 0,
 						  "abm level", 0, 4);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2530,7 +2530,7 @@ static int amdgpu_runtime_idle_check_dis
 		if (ret)
 			return ret;
 
-		if (amdgpu_device_has_dc_support(adev)) {
+		if (adev->dc_enabled) {
 			struct drm_crtc *crtc;
 
 			drm_for_each_crtc(crtc, drm_dev) {
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4842,6 +4842,7 @@ static int dm_early_init(void *handle)
 		adev_to_drm(adev)->dev,
 		&dev_attr_s3_debug);
 #endif
+	adev->dc_enabled = true;
 
 	return 0;
 }
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1567,7 +1567,7 @@ static void pp_pm_compute_clocks(void *h
 	struct pp_hwmgr *hwmgr = handle;
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (!amdgpu_device_has_dc_support(adev)) {
+	if (!adev->dc_enabled) {
 		amdgpu_dpm_get_active_displays(adev);
 		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
 		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);


Patches currently in stable-queue which might be from rosenp@gmail.com are

queue-6.1/drm-amdgpu-clarify-dc-checks.patch
queue-6.1/drm-amd-pm-use-pm_display_cfg-in-legacy-dpm-v2.patch
queue-6.1/drm-amdgpu-use-proper-dc-check-in-amdgpu_display_supported_domains.patch
queue-6.1/drm-amd-display-add-pixel_clock-to-amd_pp_display_configuration.patch
