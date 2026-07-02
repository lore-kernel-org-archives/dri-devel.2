Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEAEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977AA10F4CA;
	Thu,  2 Jul 2026 16:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="f3kBIMvR";
	dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2060B10F4E3;
 Thu,  2 Jul 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783009479; bh=zG8rpmucwjAT6hcOAc5A+i2dxGNSPOxeaaWxsVd0ypY=;
 h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
 b=f3kBIMvRDu2o9LULnMqk2dSGCDkUjatYo0IKbrV7DRWJkSBQZCg0gCJSVuWeNaMsC
 xMiRX3efrg1sSPB2+RTOW7X7jlDuUsvS7+8N9o1b2gEwrPp7m0NLeLjsWS54ea6iaQ
 QI1h6G7WNxLkOgmi3ilBQhja2Nr+WXCzTSFBtLGqkAt/Oi9r9J9fnch5jjB1ihe8Tf
 VaqlIP5E5nrEwXpzWwu9/XglfIOSv3Px3NKbxvzUexM1kxS+M8wRXbr+xwbLu7bSvH
 4TgZ1hgh+O/bjeTZsYv0DbTMQDRrsKkU9VFngpYuIZ9BZ/fAiMK4GCqNfEY/jUwqHP
 tqAK7Py84Vyxw==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4grhzq56NmzDp;
 Thu, 02 Jul 2026 18:24:39 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 02 Jul 2026 18:24:39 +0200
Message-ID: <d91e87c93748bdec5e0d99a384d688346aeb43fc.1783009338.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/5] drm/amd/display/amdgpu_dm: show error names
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
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

Convert printk() args that log error numbers to log the names.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 40 +++++++++----------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 +++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 12 +++---
 3 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b97ceabe6173..a95086c3969a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6802,7 +6802,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret) {
-		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
+		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed: %pe\n", ERR_PTR(ret));
 		goto fail;
 	}
 
@@ -6817,7 +6817,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
 		if (IS_ERR(new_crtc_state)) {
-			drm_dbg_atomic(dev, "drm_atomic_get_crtc_state() failed\n");
+			drm_dbg_atomic(dev, "drm_atomic_get_crtc_state() failed: %pe\n", new_crtc_state);
 			ret = PTR_ERR(new_crtc_state);
 			goto fail;
 		}
@@ -6837,7 +6837,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
 				ret = add_affected_mst_dsc_crtcs(state, crtc);
 				if (ret) {
-					drm_dbg_atomic(dev, "add_affected_mst_dsc_crtcs() failed\n");
+					drm_dbg_atomic(dev, "add_affected_mst_dsc_crtcs() failed: %pe\n", ERR_PTR(ret));
 					goto fail;
 				}
 			}
@@ -6854,7 +6854,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
 		if (ret) {
-			drm_dbg_atomic(dev, "amdgpu_dm_verify_lut_sizes() failed\n");
+			drm_dbg_atomic(dev, "amdgpu_dm_verify_lut_sizes() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -6863,13 +6863,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		ret = drm_atomic_add_affected_connectors(state, crtc);
 		if (ret) {
-			drm_dbg_atomic(dev, "drm_atomic_add_affected_connectors() failed\n");
+			drm_dbg_atomic(dev, "drm_atomic_add_affected_connectors() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret) {
-			drm_dbg_atomic(dev, "drm_atomic_add_affected_planes() failed\n");
+			drm_dbg_atomic(dev, "drm_atomic_add_affected_planes() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -6908,7 +6908,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 			if (IS_ERR(new_plane_state)) {
 				ret = PTR_ERR(new_plane_state);
-				drm_dbg_atomic(dev, "new_plane_state is BAD\n");
+				drm_dbg_atomic(dev, "new_plane_state is BAD: %pe\n", new_plane_state);
 				goto fail;
 			}
 		}
@@ -6922,7 +6922,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	 */
 	ret = drm_atomic_normalize_zpos(dev, state);
 	if (ret) {
-		drm_dbg(dev, "drm_atomic_normalize_zpos() failed\n");
+		drm_dbg(dev, "drm_atomic_normalize_zpos() failed: %pe\n", ERR_PTR(ret));
 		goto fail;
 	}
 
@@ -6936,7 +6936,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
 					      &dm_new_crtc_state->cursor_mode);
 		if (ret) {
-			drm_dbg(dev, "Failed to determine cursor mode\n");
+			drm_dbg(dev, "Failed to determine cursor mode: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -6968,7 +6968,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    &lock_and_validation_needed,
 					    &is_top_most_overlay);
 		if (ret) {
-			drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
+			drm_dbg_atomic(dev, "dm_update_plane_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 	}
@@ -6981,7 +6981,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   false,
 					   &lock_and_validation_needed);
 		if (ret) {
-			drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() failed\n");
+			drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 	}
@@ -6994,7 +6994,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   true,
 					   &lock_and_validation_needed);
 		if (ret) {
-			drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() failed\n");
+			drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 	}
@@ -7008,7 +7008,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    &lock_and_validation_needed,
 					    &is_top_most_overlay);
 		if (ret) {
-			drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
+			drm_dbg_atomic(dev, "dm_update_plane_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 	}
@@ -7024,7 +7024,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	/* Run this here since we want to validate the streams we created */
 	ret = drm_atomic_helper_check_planes(dev, state);
 	if (ret) {
-		drm_dbg_atomic(dev, "drm_atomic_helper_check_planes() failed\n");
+		drm_dbg_atomic(dev, "drm_atomic_helper_check_planes() failed: %pe\n", ERR_PTR(ret));
 		goto fail;
 	}
 
@@ -7162,13 +7162,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	if (lock_and_validation_needed) {
 		ret = dm_atomic_get_state(state, &dm_state);
 		if (ret) {
-			drm_dbg_atomic(dev, "dm_atomic_get_state() failed\n");
+			drm_dbg_atomic(dev, "dm_atomic_get_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
 		ret = do_aquire_global_lock(dev, state);
 		if (ret) {
-			drm_dbg_atomic(dev, "do_aquire_global_lock() failed\n");
+			drm_dbg_atomic(dev, "do_aquire_global_lock() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -7176,7 +7176,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (dc_resource_is_dsc_encoding_supported(dc)) {
 			ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 			if (ret) {
-				drm_dbg_atomic(dev, "MST_DSC compute_mst_dsc_configs_for_state() failed\n");
+				drm_dbg_atomic(dev, "MST_DSC compute_mst_dsc_configs_for_state() failed: %pe\n", ERR_PTR(ret));
 				ret = -EINVAL;
 				goto fail;
 			}
@@ -7185,7 +7185,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
 		if (ret) {
-			drm_dbg_atomic(dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
+			drm_dbg_atomic(dev, "dm_update_mst_vcpi_slots_for_dsc() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -7197,7 +7197,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 */
 		ret = drm_dp_mst_atomic_check(state);
 		if (ret) {
-			drm_dbg_atomic(dev, "MST drm_dp_mst_atomic_check() failed\n");
+			drm_dbg_atomic(dev, "MST drm_dp_mst_atomic_check() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
 		}
 		status = dc_validate_global_state(dc, dm_state->context, DC_VALIDATE_MODE_ONLY);
@@ -7286,7 +7286,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
 		drm_dbg_atomic(dev, "Atomic check stopped due to signal.\n");
 	else
-		drm_dbg_atomic(dev, "Atomic check failed with err: %d\n", ret);
+		drm_dbg_atomic(dev, "Atomic check failed: %pe\n", ERR_PTR(ret));
 
 	trace_amdgpu_dm_atomic_check_finish(state, ret);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 204b4641f07d..a12da0b60065 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -374,7 +374,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(s
 
 	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
 	if (ret)
-		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned error: %d\n", ret);
+		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned error: %pe\n", ERR_PTR(ret));
 
 	return ret;
 }
@@ -415,7 +415,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
 	/* TODO: This seems wrong because there is no DCC plane on GFX12. */
 	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
 	if (ret)
-		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned error: %d\n", ret);
+		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned: %pe\n", ERR_PTR(ret));
 
 	return ret;
 }
@@ -975,13 +975,15 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
 	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
-		drm_err(adev_to_drm(adev), "fail to reserve bo (%d)\n", r);
+		drm_err(adev_to_drm(adev), "fail to reserve bo: %pe\n", ERR_PTR(r));
 		return r;
 	}
 
 	r = dma_resv_reserve_fences(rbo->tbo.base.resv, TTM_NUM_MOVE_FENCES);
-	if (r)
+	if (r) {
+		drm_err(adev_to_drm(adev), "reserving fence slot failed: %pe\n", ERR_PTR(r));
 		goto error_unlock;
+	}
 
 	if (plane->type != DRM_PLANE_TYPE_CURSOR)
 		domain = amdgpu_display_supported_domains(adev, rbo->flags);
@@ -992,13 +994,13 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
+			DRM_ERROR("Failed to pin framebuffer: %pe\n", ERR_PTR(r));
 		goto error_unlock;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
 	if (unlikely(r != 0)) {
-		DRM_ERROR("%p bind failed\n", rbo);
+		DRM_ERROR("%p bind failed: %pe\n", rbo, ERR_PTR(r));
 		goto error_unpin;
 	}
 
@@ -1058,7 +1060,7 @@ static void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
 	r = amdgpu_bo_reserve(rbo, false);
 	if (unlikely(r)) {
-		DRM_ERROR("failed to reserve rbo before unpin\n");
+		DRM_ERROR("failed to reserve rbo before unpin: %pe\n", ERR_PTR(r));
 		return;
 	}
 
@@ -1861,8 +1863,8 @@ dm_plane_init_colorops(struct drm_plane *plane)
 	if (dc->ctx->dce_version >= DCN_VERSION_3_0) {
 		ret = amdgpu_dm_initialize_default_pipeline(plane, &pipelines[len]);
 		if (ret) {
-			drm_err(plane->dev, "Failed to create color pipeline for plane %d: %d\n",
-				plane->base.id, ret);
+			drm_err(plane->dev, "Failed to create color pipeline for plane %d: %pe\n",
+				plane->base.id, ERR_PTR(ret));
 			goto out;
 		}
 		len++;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 0bf82e46f773..a69657213ce0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -107,13 +107,15 @@ static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector
 
 	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
-		drm_err(adev_to_drm(adev), "fail to reserve bo (%d)\n", r);
+		drm_err(adev_to_drm(adev), "fail to reserve bo: %pe\n", ERR_PTR(r));
 		return r;
 	}
 
 	r = dma_resv_reserve_fences(rbo->tbo.base.resv, TTM_NUM_MOVE_FENCES);
-	if (r)
+	if (r) {
+		drm_err(adev_to_drm(adev), "reserving fence slot failed: %pe\n", ERR_PTR(r));
 		goto error_unlock;
+	}
 
 	domain = amdgpu_display_supported_domains(adev, rbo->flags);
 
@@ -121,13 +123,13 @@ static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
+			DRM_ERROR("Failed to pin framebuffer: %pe\n", ERR_PTR(r));
 		goto error_unlock;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
 	if (unlikely(r != 0)) {
-		DRM_ERROR("%p bind failed\n", rbo);
+		DRM_ERROR("%p bind failed: %pe\n", rbo, ERR_PTR(r));
 		goto error_unpin;
 	}
 
@@ -159,7 +161,7 @@ static void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 	rbo = gem_to_amdgpu_bo(job->fb->obj[0]);
 	r = amdgpu_bo_reserve(rbo, false);
 	if (unlikely(r)) {
-		DRM_ERROR("failed to reserve rbo before unpin\n");
+		DRM_ERROR("failed to reserve rbo before unpin: %pe\n", ERR_PTR(r));
 		return;
 	}
 
-- 
2.47.3

