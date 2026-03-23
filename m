Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D77F46101
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC33710E3E4;
	Mon, 23 Mar 2026 13:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/VVSfaC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F57110E3E4;
 Mon, 23 Mar 2026 13:04:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B6F141950;
 Mon, 23 Mar 2026 13:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C538C4CEF7;
 Mon, 23 Mar 2026 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774271048;
 bh=CLGN9TV+4eXnJuBafh1A1gXl2c+kpMSEsShhqNEMJ4A=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=k/VVSfaCJ86FgUWa3XjBBovtKc4PSuIL3x07BvnXLQvm+OmUDQ+cA5H4z/eS8F4Tc
 CjSsR2DS7iF4w9LOBEZjMM2/oLPsjMck6K4Z2MfBKYoogbFk6embsufFdo2Xnoj8B5
 xZAFqSe5FyOwRL/oZpKFhh6xke39/OmWbZcTstFA=
Subject: Patch "drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)" has been
 added to the 6.1-stable tree
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
Date: Mon, 23 Mar 2026 14:03:38 +0100
In-Reply-To: <20260321054453.19683-5-rosenp@gmail.com>
Message-ID: <2026032337-capture-slate-e62d@gregkh>
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

    drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-pm-use-pm_display_cfg-in-legacy-dpm-v2.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From rosenp@gmail.com Sat Mar 21 06:45:21 2026
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Mar 2026 22:44:53 -0700
Subject: drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
To: stable@vger.kernel.org
Cc: "Alex Deucher" <alexander.deucher@amd.com>, "Christian König" <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, "Evan Quan" <evan.quan@amd.com>, "Mario Limonciello" <mario.limonciello@amd.com>, "Sasha Levin" <sashal@kernel.org>, "Rosen Penev" <rosenp@gmail.com>, "Lijo Lazar" <lijo.lazar@amd.com>, "Ma Jun" <Jun.Ma2@amd.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Zhigang Luo" <Zhigang.Luo@amd.com>, "Bert Karwatzki" <spasswolf@web.de>, "Ray Wu" <ray.wu@amd.com>, "Wayne Lin" <Wayne.Lin@amd.com>, "Roman Li" <Roman.Li@amd.com>, "Hersen Wu" <hersenxs.wu@amd.com>, "Timur Kristóf" <timur.kristof@gmail.com>, "Alex Hung" <alex.hung@amd.com>, decce6 <decce6@proton.me>, "Went
 ao Liang" <vulab@iscas.ac.cn>, amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20260321054453.19683-5-rosenp@gmail.com>

From: Timur KristÃ³f <timur.kristof@gmail.com>

[ Upstream commit 9d73b107a61b73e7101d4b728ddac3d2c77db111 ]

This commit is necessary for DC to function well with chips
that use the legacy power management code, ie. SI and KV.
Communicate display information from DC to the legacy PM code.

Currently DC uses pm_display_cfg to communicate power management
requirements from the display code to the DPM code.
However, the legacy (non-DC) code path used different fields
and therefore could not take into account anything from DC.

Change the legacy display code to fill the same pm_display_cfg
struct as DC and use the same in the legacy DPM code.

To ease review and reduce churn, this commit does not yet
delete the now unneeded code, that is done in the next commit.

v2:
Rebase.
Fix single_display in amdgpu_dpm_pick_power_state.

Signed-off-by: Timur KristÃ³f <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c     |   67 +++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h |    2 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |    4 -
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c   |    6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c       |   65 +++++++---------------
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |   11 ---
 6 files changed, 97 insertions(+), 58 deletions(-)

--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -100,3 +100,70 @@ u32 amdgpu_dpm_get_vrefresh(struct amdgp
 
 	return vrefresh;
 }
+
+void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
+	struct single_display_configuration *display_cfg;
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_connector *conn;
+	int num_crtcs = 0;
+	int vrefresh;
+	u32 vblank_in_pixels, vblank_time_us;
+
+	cfg->min_vblank_time = 0xffffffff; /* if the displays are off, vblank time is max */
+
+	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
+		list_for_each_entry(crtc, &ddev->mode_config.crtc_list, head) {
+			amdgpu_crtc = to_amdgpu_crtc(crtc);
+
+			/* The array should only contain active displays. */
+			if (!amdgpu_crtc->enabled)
+				continue;
+
+			conn = to_amdgpu_connector(amdgpu_crtc->connector);
+			display_cfg = &adev->pm.pm_display_cfg.displays[num_crtcs++];
+
+			if (amdgpu_crtc->hw_mode.clock) {
+				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
+
+				vblank_in_pixels =
+					amdgpu_crtc->hw_mode.crtc_htotal *
+					(amdgpu_crtc->hw_mode.crtc_vblank_end -
+					amdgpu_crtc->hw_mode.crtc_vdisplay +
+					(amdgpu_crtc->v_border * 2));
+
+				vblank_time_us =
+					vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* The legacy (non-DC) code has issues with mclk switching
+				 * with refresh rates over 120 Hz. Disable mclk switching.
+				 */
+				if (vrefresh > 120)
+					vblank_time_us = 0;
+
+				/* Find minimum vblank time. */
+				if (vblank_time_us < cfg->min_vblank_time)
+					cfg->min_vblank_time = vblank_time_us;
+
+				/* Find vertical refresh rate of first active display. */
+				if (!cfg->vrefresh)
+					cfg->vrefresh = vrefresh;
+			}
+
+			if (amdgpu_crtc->crtc_id < cfg->crtc_index) {
+				/* Find first active CRTC and its line time. */
+				cfg->crtc_index = amdgpu_crtc->crtc_id;
+				cfg->line_time_in_us = amdgpu_crtc->line_time;
+			}
+
+			display_cfg->controller_id = amdgpu_crtc->crtc_id;
+			display_cfg->pixel_clock = conn->pixelclock_for_modeset;
+		}
+	}
+
+	cfg->display_clk = adev->clock.default_dispclk;
+	cfg->num_display = num_crtcs;
+}
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
@@ -29,4 +29,6 @@ u32 amdgpu_dpm_get_vblank_time(struct am
 
 u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
 
+void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev);
+
 #endif
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -2312,7 +2312,7 @@ static void kv_apply_state_adjust_rules(
 
 		if (pi->sys_info.nb_dpm_enable) {
 			force_high = (mclk >= pi->sys_info.nbp_memory_clock[3]) ||
-				pi->video_start || (adev->pm.dpm.new_active_crtc_count >= 3) ||
+				pi->video_start || (adev->pm.pm_display_cfg.num_display >= 3) ||
 				pi->disable_nb_ps3_in_battery;
 			ps->dpm0_pg_nb_ps_lo = force_high ? 0x2 : 0x3;
 			ps->dpm0_pg_nb_ps_hi = 0x2;
@@ -2371,7 +2371,7 @@ static int kv_calculate_nbps_level_setti
 			return 0;
 
 		force_high = ((mclk >= pi->sys_info.nbp_memory_clock[3]) ||
-			      (adev->pm.dpm.new_active_crtc_count >= 3) || pi->video_start);
+			      (adev->pm.pm_display_cfg.num_display >= 3) || pi->video_start);
 
 		if (force_high) {
 			for (i = pi->lowest_valid; i <= pi->highest_valid; i++)
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -797,8 +797,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick
 	int i;
 	struct amdgpu_ps *ps;
 	u32 ui_class;
-	bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
-		true : false;
+	bool single_display = adev->pm.pm_display_cfg.num_display < 2;
 
 	/* check if the vblank period is too short to adjust the mclk */
 	if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
@@ -1003,7 +1002,8 @@ void amdgpu_legacy_dpm_compute_clocks(vo
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_dpm_get_active_displays(adev);
+	if (!adev->dc_enabled)
+		amdgpu_dpm_get_display_cfg(adev);
 
 	amdgpu_dpm_change_power_state_locked(adev);
 }
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3058,7 +3058,7 @@ static int si_get_vce_clock_voltage(stru
 static bool si_dpm_vblank_too_short(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 vblank_time = amdgpu_dpm_get_vblank_time(adev);
+	u32 vblank_time = adev->pm.pm_display_cfg.min_vblank_time;
 	/* we never hit the non-gddr5 limit so disable it */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
 
@@ -3424,9 +3424,10 @@ static void rv770_get_engine_memory_ss(s
 static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 					struct amdgpu_ps *rps)
 {
+	const struct amd_pp_display_configuration *display_cfg =
+		&adev->pm.pm_display_cfg;
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
-	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
@@ -3477,14 +3478,9 @@ static void si_apply_state_adjust_rules(
 	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
 	 * Find number of such displays connected.
 	 */
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
-			!adev->mode_info.crtcs[i]->enabled)
-			continue;
-
-		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
-
-		if (conn->pixelclock_for_modeset > 297000)
+	for (i = 0; i < display_cfg->num_display; i++) {
+		/* The array only contains active displays. */
+		if (display_cfg->displays[i].pixel_clock > 297000)
 			high_pixelclock_count++;
 	}
 
@@ -3517,7 +3513,7 @@ static void si_apply_state_adjust_rules(
 		rps->ecclk = 0;
 	}
 
-	if ((adev->pm.dpm.new_active_crtc_count > 1) ||
+	if ((adev->pm.pm_display_cfg.num_display > 1) ||
 	    si_dpm_vblank_too_short(adev))
 		disable_mclk_switching = true;
 
@@ -3665,7 +3661,7 @@ static void si_apply_state_adjust_rules(
 						   ps->performance_levels[i].mclk,
 						   max_limits->vddc,  &ps->performance_levels[i].vddc);
 		btc_apply_voltage_dependency_rules(&adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk,
-						   adev->clock.current_dispclk,
+						   display_cfg->display_clk,
 						   max_limits->vddc,  &ps->performance_levels[i].vddc);
 	}
 
@@ -4190,16 +4186,16 @@ static void si_program_ds_registers(stru
 
 static void si_program_display_gap(struct amdgpu_device *adev)
 {
+	const struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
 	u32 tmp, pipe;
-	int i;
 
 	tmp = RREG32(CG_DISPLAY_GAP_CNTL) & ~(DISP1_GAP_MASK | DISP2_GAP_MASK);
-	if (adev->pm.dpm.new_active_crtc_count > 0)
+	if (cfg->num_display > 0)
 		tmp |= DISP1_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
 	else
 		tmp |= DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE);
 
-	if (adev->pm.dpm.new_active_crtc_count > 1)
+	if (cfg->num_display > 1)
 		tmp |= DISP2_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
 	else
 		tmp |= DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE);
@@ -4209,17 +4205,8 @@ static void si_program_display_gap(struc
 	tmp = RREG32(DCCG_DISP_SLOW_SELECT_REG);
 	pipe = (tmp & DCCG_DISP1_SLOW_SELECT_MASK) >> DCCG_DISP1_SLOW_SELECT_SHIFT;
 
-	if ((adev->pm.dpm.new_active_crtc_count > 0) &&
-	    (!(adev->pm.dpm.new_active_crtcs & (1 << pipe)))) {
-		/* find the first active crtc */
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (adev->pm.dpm.new_active_crtcs & (1 << i))
-				break;
-		}
-		if (i == adev->mode_info.num_crtc)
-			pipe = 0;
-		else
-			pipe = i;
+	if (cfg->num_display > 0 && pipe != cfg->crtc_index) {
+		pipe = cfg->crtc_index;
 
 		tmp &= ~DCCG_DISP1_SLOW_SELECT_MASK;
 		tmp |= DCCG_DISP1_SLOW_SELECT(pipe);
@@ -4230,7 +4217,7 @@ static void si_program_display_gap(struc
 	 * This can be a problem on PowerXpress systems or if you want to use the card
 	 * for offscreen rendering or compute if there are no crtcs enabled.
 	 */
-	si_notify_smc_display_change(adev, adev->pm.dpm.new_active_crtc_count > 0);
+	si_notify_smc_display_change(adev, cfg->num_display > 0);
 }
 
 static void si_enable_spread_spectrum(struct amdgpu_device *adev, bool enable)
@@ -5535,7 +5522,7 @@ static int si_convert_power_level_to_smc
 	    (pl->mclk <= pi->mclk_stutter_mode_threshold) &&
 	    !eg_pi->uvd_enabled &&
 	    (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
-	    (adev->pm.dpm.new_active_crtc_count <= 2)) {
+	    (adev->pm.pm_display_cfg.num_display <= 2)) {
 		level->mcFlags |= SISLANDS_SMC_MC_STUTTER_EN;
 
 		if (gmc_pg)
@@ -5687,7 +5674,7 @@ static bool si_is_state_ulv_compatible(s
 	/* XXX validate against display requirements! */
 
 	for (i = 0; i < adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count; i++) {
-		if (adev->clock.current_dispclk <=
+		if (adev->pm.pm_display_cfg.display_clk <=
 		    adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[i].clk) {
 			if (ulv->pl.vddc <
 			    adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[i].v)
@@ -5841,30 +5828,22 @@ static int si_upload_ulv_state(struct am
 
 static int si_upload_smc_data(struct amdgpu_device *adev)
 {
-	struct amdgpu_crtc *amdgpu_crtc = NULL;
-	int i;
+	const struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
 	u32 crtc_index = 0;
 	u32 mclk_change_block_cp_min = 0;
 	u32 mclk_change_block_cp_max = 0;
 
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (adev->pm.dpm.new_active_crtcs & (1 << i)) {
-			amdgpu_crtc = adev->mode_info.crtcs[i];
-			break;
-		}
-	}
-
 	/* When a display is plugged in, program these so that the SMC
 	 * performs MCLK switching when it doesn't cause flickering.
 	 * When no display is plugged in, there is no need to restrict
 	 * MCLK switching, so program them to zero.
 	 */
-	if (adev->pm.dpm.new_active_crtc_count && amdgpu_crtc) {
-		crtc_index = amdgpu_crtc->crtc_id;
+	if (cfg->num_display) {
+		crtc_index = cfg->crtc_index;
 
-		if (amdgpu_crtc->line_time) {
-			mclk_change_block_cp_min = 200 / amdgpu_crtc->line_time;
-			mclk_change_block_cp_max = 100 / amdgpu_crtc->line_time;
+		if (cfg->line_time_in_us) {
+			mclk_change_block_cp_min = 200 / cfg->line_time_in_us;
+			mclk_change_block_cp_max = 100 / cfg->line_time_in_us;
 		}
 	}
 
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1568,16 +1568,7 @@ static void pp_pm_compute_clocks(void *h
 	struct amdgpu_device *adev = hwmgr->adev;
 
 	if (!adev->dc_enabled) {
-		amdgpu_dpm_get_active_displays(adev);
-		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-		adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-		/* we have issues with mclk switching with
-		 * refresh rates over 120 hz on the non-DC code.
-		 */
-		if (adev->pm.pm_display_cfg.vrefresh > 120)
-			adev->pm.pm_display_cfg.min_vblank_time = 0;
-
+		amdgpu_dpm_get_display_cfg(adev);
 		pp_display_configuration_change(handle,
 						&adev->pm.pm_display_cfg);
 	}


Patches currently in stable-queue which might be from rosenp@gmail.com are

queue-6.1/drm-amdgpu-clarify-dc-checks.patch
queue-6.1/drm-amd-pm-use-pm_display_cfg-in-legacy-dpm-v2.patch
queue-6.1/drm-amdgpu-use-proper-dc-check-in-amdgpu_display_supported_domains.patch
queue-6.1/drm-amd-display-add-pixel_clock-to-amd_pp_display_configuration.patch
