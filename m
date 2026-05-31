Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A68CD6E5C
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF724112AFA;
	Sun, 31 May 2026 11:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X86rgM8g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E92F112AEC;
 Sun, 31 May 2026 11:49:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8683B437DA;
 Sun, 31 May 2026 11:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128531F00898;
 Sun, 31 May 2026 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228161;
 bh=7j3xREiz6TaZFynKoDNbPly5H4/Z68zaoFZKyJzNWGc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X86rgM8glaK/9j6LwXMfZhMG2JQB+jwmKo0yjN8SOWnJWgOTlGgips4JAq8aCYDJk
 lxH/avYeJwiPTPHoIcd35lbV0P7kygAF7dme+qEb+Ip6F0WyPvgWVHRp0FRFQOeNNd
 cVdpbrtB8NUgmT2978Pjto7gWYDHvXT+kwCzmCeXuRZTa3ECIOqmSHy0lmX6nzweqt
 mHH9kMr2X3pSPo1M/JXbzlWaURQ/0kJSr5GznEKWT/+eUjv992mcWZC2tDh1zJIcKF
 FDtLagahIqEaoe+//cPY+rD+O1+vN+xBarEbRMCwKT4MWnLR+DzJrzWYZ3molwlE3Q
 P8Hzmd/Ggzy4A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 09/11] drm/amd/display: Drop brightness caching in amdgpu_dm
Date: Sun, 31 May 2026 06:49:06 -0500
Message-ID: <20260531114908.1693426-10-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531114908.1693426-1-superm1@kernel.org>
References: <20260531114908.1693426-1-superm1@kernel.org>
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

[Why]
Brightness caching isn't necessary when the core is changing brightness
as part of the connector state.

[How]
Drop all brightness and actual brightness caching

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 ++-----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 13 ----
 2 files changed, 5 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 55c3838f7ec8..62161d7f7994 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3732,12 +3732,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		mutex_unlock(&dm->dc_lock);
 
-		/* set the backlight after a reset */
-		for (i = 0; i < dm->num_of_edps; i++) {
-			if (dm->backlight_dev[i])
-				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
-		}
-
 		return 0;
 	}
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
@@ -5350,10 +5344,8 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		if (aconnector->bl_idx != bl_idx)
 			continue;
 
-		/* if connector is off, save the brightness for next time it's on */
+		/* if connector is off, DRM core will restore it next time it's on */
 		if (!aconnector->base.encoder) {
-			dm->brightness[bl_idx] = user_brightness;
-			dm->actual_brightness[bl_idx] = 0;
 			return;
 		}
 	}
@@ -5361,11 +5353,10 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
 	caps = &dm->backlight_caps[bl_idx];
 
-	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
 	if (bl_idx == 0)
-		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
-	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
+		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, user_brightness);
+	brightness = convert_brightness_from_user(caps, user_brightness);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
 	/* Apply brightness quirk */
@@ -5407,9 +5398,6 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		dc_allow_idle_optimizations(dm->dc, true);
 
 	mutex_unlock(&dm->dc_lock);
-
-	if (rc)
-		dm->actual_brightness[bl_idx] = user_brightness;
 }
 
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
@@ -5457,7 +5445,7 @@ static int amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i, ret;
+	int i;
 
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (bd == dm->backlight_dev[i])
@@ -5466,11 +5454,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 	if (i >= AMDGPU_DM_MAX_NUM_EDP)
 		i = 0;
 
-	ret = amdgpu_dm_backlight_get_level(dm, i);
-	if (ret < 0)
-		return dm->brightness[i];
-
-	return ret;
+	return amdgpu_dm_backlight_get_level(dm, i);
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
@@ -5488,8 +5472,6 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
 	int min, max;
-	int real_brightness;
-	int init_brightness;
 	int r;
 
 	if (aconnector->bl_idx == -1)
@@ -5515,8 +5497,6 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	} else
 		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
-	init_brightness = props.brightness;
-
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
 		drm_info(drm, "Using custom brightness curve\n");
 		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
@@ -5530,7 +5510,6 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	dm->backlight_dev[aconnector->bl_idx] =
 		backlight_device_register(bl_name, aconnector->base.kdev, dm,
 					  &amdgpu_dm_backlight_ops, &props);
-	dm->brightness[aconnector->bl_idx] = props.brightness;
 
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
 		r = PTR_ERR(dm->backlight_dev[aconnector->bl_idx]);
@@ -5539,18 +5518,6 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		return r;
 	}
 
-	/*
-	 * dm->brightness[x] can be inconsistent just after startup until
-	 * ops.get_brightness is called.
-	 */
-	real_brightness =
-		amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
-
-	if (real_brightness != init_brightness) {
-		dm->actual_brightness[aconnector->bl_idx] = real_brightness;
-		dm->brightness[aconnector->bl_idx] = real_brightness;
-	}
-
 	/* Link the registered backlight device to the DRM connector. If
 	 * drm_backlight_alloc() failed earlier in init_helper,
 	 * aconnector->base.backlight is NULL and drm_backlight_link() is a
@@ -10665,7 +10632,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
-	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -10785,7 +10751,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
-			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -10838,18 +10803,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		}
 	}
 
-	/* During boot up and resume the DC layer will reset the panel brightness
-	 * to fix a flicker issue.
-	 * It will cause the dm->actual_brightness is not the current panel brightness
-	 * level. (the dm->brightness is the correct panel level)
-	 * So we set the backlight level with dm->brightness value after set mode
-	 */
-	if (set_backlight_level) {
-		for (i = 0; i < dm->num_of_edps; i++) {
-			if (dm->backlight_dev[i])
-				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
-		}
-	}
 }
 
 static void dm_set_writeback(struct amdgpu_display_manager *dm,
@@ -11355,13 +11308,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
-	/* restore the backlight level */
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (dm->backlight_dev[i] &&
-		    (dm->actual_brightness[i] != dm->brightness[i]))
-			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
-	}
-
 	/*
 	 * send vblank event on all events not handled in flip and
 	 * mark consumed event for drm_atomic_helper_commit_hw_done
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1ab066859d9e..952bfea0d8dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -648,19 +648,6 @@ struct amdgpu_display_manager {
 	struct completion dmub_aux_transfer_done;
 	struct workqueue_struct *delayed_hpd_wq;
 
-	/**
-	 * @brightness:
-	 *
-	 * cached backlight values.
-	 */
-	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
-	/**
-	 * @actual_brightness:
-	 *
-	 * last successfully applied backlight values.
-	 */
-	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
-
 	/**
 	 * @aux_hpd_discon_quirk:
 	 *
-- 
2.54.0

