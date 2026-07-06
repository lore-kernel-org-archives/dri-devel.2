Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4F1C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B8C10F421;
	Thu,  9 Jul 2026 07:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="BTK/S7uM";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599E110E61B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:54:38 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260706134551euoutp0109b524aa04985f740e2e16003759e0a8~-t1Se3fVc0918609186euoutp01F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:45:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260706134551euoutp0109b524aa04985f740e2e16003759e0a8~-t1Se3fVc0918609186euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1783345551;
 bh=7Tnqp7NX2sPJcSn5DR6DaCoNFsVVLxuwyLMZ+Y77pnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BTK/S7uMHV44pj4JNLJ1Qg9wgk2yvzQWov6jbu8cQGTiJXxjDd9dOHhUwEJCfcGfR
 8Yag3dXaNtGE4Jkmo1ntjXr5hcCJikjhEUvzFeqI5+LLvdryN5owDQ6Q1zk/O7UhXk
 Wc5+vBGOFi30Rr541P6Cg/vKTA7Cf/Q7wyIPBMS8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260706134550eucas1p2610b0e626d3ea286304d68e6cfa5e968~-t1Rtskgr3192531925eucas1p2g;
 Mon,  6 Jul 2026 13:45:50 +0000 (GMT)
Received: from AMDC4670.local (unknown [106.120.77.38]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260706134550eusmtip11015791588316a3275e24e5c2dcb47ae~-t1RGo3kn0593605936eusmtip1C;
 Mon,  6 Jul 2026 13:45:50 +0000 (GMT)
From: Jan Niedziolka <j.niedziolka@samsung.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 k.tegowski@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.fijalko@samsung.com, bartlomiej.k@samsung.com, Jan Niedziolka
 <j.niedziolka@samsung.com>
Subject: [PATCH 1/3] gpu/drm: Remove unused *dev parameter from
 drm_mode_destroy function
Date: Mon,  6 Jul 2026 15:34:39 +0200
Message-ID: <20260706134515.3369960-2-j.niedziolka@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706134515.3369960-1-j.niedziolka@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260706134550eucas1p2610b0e626d3ea286304d68e6cfa5e968
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260706134550eucas1p2610b0e626d3ea286304d68e6cfa5e968
X-EPHeader: CA
X-CMS-RootMailID: 20260706134550eucas1p2610b0e626d3ea286304d68e6cfa5e968
References: <20260706134515.3369960-1-j.niedziolka@samsung.com>
 <CGME20260706134550eucas1p2610b0e626d3ea286304d68e6cfa5e968@eucas1p2.samsung.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Get rid of unused 'struct drm_device *dev' parameter from drm_mode_destroy()
prototype and definition.
Keep drm_mode_destroy() comment up to date - remove unnecessary *dev record.
Also, fix all drm_mode_destroy() calls where *dev argument is used.

Fixes: 0e691bc73026 ("drm: Remove use of drm_mode_object")
Signed-off-by: Jan Niedziolka <j.niedziolka@samsung.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++--
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c |  2 +-
 drivers/gpu/drm/drm_client_modeset.c                |  8 ++++----
 drivers/gpu/drm/drm_connector.c                     |  2 +-
 drivers/gpu/drm/drm_crtc.c                          |  2 +-
 drivers/gpu/drm/drm_crtc_helper.c                   |  2 +-
 drivers/gpu/drm/drm_edid.c                          |  8 ++++----
 drivers/gpu/drm/drm_modes.c                         | 11 +++++------
 drivers/gpu/drm/gma500/psb_intel_sdvo.c             |  3 +--
 drivers/gpu/drm/i915/display/intel_panel.c          |  4 ++--
 drivers/gpu/drm/msm/dsi/dsi_host.c                  |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c         |  2 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c           |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c               |  2 +-
 include/drm/drm_modes.h                             |  2 +-
 16 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97ab1e83b318..b919efd8f42b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8562,7 +8562,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	stream = create_validate_stream_for_sink(connector, test_mode,
 						 to_dm_connector_state(connector->state),
 						 NULL);
-	drm_mode_destroy(connector->dev, test_mode);
+	drm_mode_destroy(test_mode);
 	if (stream) {
 		dc_stream_release(stream);
 		result = MODE_OK;
@@ -9217,7 +9217,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 			drm_mode_probed_add(&aconnector->base, new_mode);
 			new_modes_count += 1;
 		} else
-			drm_mode_destroy(aconnector->base.dev, new_mode);
+			drm_mode_destroy(new_mode);
 	}
  out:
 	return new_modes_count;
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 36c07b71fe04..b971f2bcfa26 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1913,7 +1913,7 @@ cdns_mhdp_bridge_atomic_destroy_state(struct drm_bridge *bridge,
 	cdns_mhdp_state = to_cdns_mhdp_bridge_state(state);
 
 	if (cdns_mhdp_state->current_mode) {
-		drm_mode_destroy(bridge->dev, cdns_mhdp_state->current_mode);
+		drm_mode_destroy(cdns_mhdp_state->current_mode);
 		cdns_mhdp_state->current_mode = NULL;
 	}
 
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..66f17a386198 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -79,7 +79,7 @@ static void drm_client_modeset_release(struct drm_client_dev *client)
 	drm_client_for_each_modeset(modeset, client) {
 		int i;
 
-		drm_mode_destroy(client->dev, modeset->mode);
+		drm_mode_destroy(modeset->mode);
 		modeset->mode = NULL;
 		modeset->fb = NULL;
 
@@ -272,7 +272,7 @@ static void mode_replace(struct drm_device *dev,
 			 const struct drm_display_mode **dst,
 			 const struct drm_display_mode *src)
 {
-	drm_mode_destroy(dev, (struct drm_display_mode *)*dst);
+	drm_mode_destroy((struct drm_display_mode *)*dst);
 
 	*dst = src ? drm_mode_duplicate(dev, src) : NULL;
 }
@@ -367,7 +367,7 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 		if (!modes[i])
 			can_clone = false;
 	}
-	drm_mode_destroy(dev, dmt_mode);
+	drm_mode_destroy(dmt_mode);
 
 	if (can_clone) {
 		drm_dbg_kms(dev, "can clone using 1024x768\n");
@@ -913,7 +913,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 				break;
 			}
 
-			drm_mode_destroy(dev, modeset->mode);
+			drm_mode_destroy(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
 			if (!modeset->mode) {
 				ret = -ENOMEM;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3fa4d2082cd7..6825cd4e9001 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -706,7 +706,7 @@ static void drm_mode_remove(struct drm_connector *connector,
 			    struct drm_display_mode *mode)
 {
 	list_del(&mode->head);
-	drm_mode_destroy(connector->dev, mode);
+	drm_mode_destroy(mode);
 }
 
 /**
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..22039a553a24 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -897,7 +897,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		}
 	}
 	kfree(connector_set);
-	drm_mode_destroy(dev, mode);
+	drm_mode_destroy(mode);
 
 	/* In case we need to retry... */
 	connector_set = NULL;
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 4a8cfe046e4a..084417791a28 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -421,7 +421,7 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 
 	/* FIXME: add subpixel order */
 done:
-	drm_mode_destroy(dev, adjusted_mode);
+	drm_mode_destroy(adjusted_mode);
 	if (!ret) {
 		crtc->enabled = saved_enabled;
 		drm_mode_copy(&crtc->mode, &saved_mode);
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 404208bf23a6..7f456e9c27a5 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3361,7 +3361,7 @@ drm_gtf2_mode(struct drm_device *dev,
 		return NULL;
 
 	if (drm_mode_hsync(mode) > drm_gtf2_hbreak(drm_edid)) {
-		drm_mode_destroy(dev, mode);
+		drm_mode_destroy(mode);
 		mode = drm_gtf_mode_complex(dev, hsize, vsize,
 					    vrefresh_rate, 0, 0,
 					    drm_gtf2_m(drm_edid),
@@ -3777,7 +3777,7 @@ static int drm_gtf_modes_for_range(struct drm_connector *connector,
 		drm_mode_fixup_1366x768(newmode);
 		if (!mode_in_range(newmode, drm_edid, timing) ||
 		    !valid_inferred_mode(connector, newmode)) {
-			drm_mode_destroy(dev, newmode);
+			drm_mode_destroy(newmode);
 			continue;
 		}
 
@@ -3806,7 +3806,7 @@ static int drm_gtf2_modes_for_range(struct drm_connector *connector,
 		drm_mode_fixup_1366x768(newmode);
 		if (!mode_in_range(newmode, drm_edid, timing) ||
 		    !valid_inferred_mode(connector, newmode)) {
-			drm_mode_destroy(dev, newmode);
+			drm_mode_destroy(newmode);
 			continue;
 		}
 
@@ -3836,7 +3836,7 @@ static int drm_cvt_modes_for_range(struct drm_connector *connector,
 		drm_mode_fixup_1366x768(newmode);
 		if (!mode_in_range(newmode, drm_edid, timing) ||
 		    !valid_inferred_mode(connector, newmode)) {
-			drm_mode_destroy(dev, newmode);
+			drm_mode_destroy(newmode);
 			continue;
 		}
 
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 3f8e025fd6d9..175bf3eef14b 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -85,12 +85,11 @@ EXPORT_SYMBOL(drm_mode_create);
 
 /**
  * drm_mode_destroy - remove a mode
- * @dev: DRM device
  * @mode: mode to remove
  *
- * Release @mode's unique ID, then free it @mode structure itself using kfree.
+ * Free @mode structure using kfree.
  */
-void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode)
+void drm_mode_destroy(struct drm_display_mode *mode)
 {
 	if (!mode)
 		return;
@@ -591,7 +590,7 @@ struct drm_display_mode *drm_analog_tv_mode(struct drm_device *dev,
 	return mode;
 
 err_free_mode:
-	drm_mode_destroy(dev, mode);
+	drm_mode_destroy(mode);
 	return NULL;
 }
 EXPORT_SYMBOL(drm_analog_tv_mode);
@@ -1819,7 +1818,7 @@ void drm_mode_prune_invalid(struct drm_device *dev,
 				drm_dbg_kms(dev, "Rejected mode: " DRM_MODE_FMT " (%s)\n",
 					    DRM_MODE_ARG(mode), drm_get_mode_status_name(mode->status));
 			}
-			drm_mode_destroy(dev, mode);
+			drm_mode_destroy(mode);
 		}
 	}
 }
@@ -1924,7 +1923,7 @@ void drm_connector_list_update(struct drm_connector *connector)
 			}
 
 			list_del(&pmode->head);
-			drm_mode_destroy(connector->dev, pmode);
+			drm_mode_destroy(pmode);
 			break;
 		}
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 3ca11aad569d..a834252a7774 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -1787,8 +1787,7 @@ static void psb_intel_sdvo_enc_destroy(struct drm_encoder *encoder)
 	struct psb_intel_sdvo *psb_intel_sdvo = to_psb_intel_sdvo(encoder);
 
 	if (psb_intel_sdvo->sdvo_lvds_fixed_mode != NULL)
-		drm_mode_destroy(encoder->dev,
-				 psb_intel_sdvo->sdvo_lvds_fixed_mode);
+		drm_mode_destroy(psb_intel_sdvo->sdvo_lvds_fixed_mode);
 
 	i2c_del_adapter(&psb_intel_sdvo->ddc);
 	gma_encoder_destroy(encoder);
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 20c548eea6da..b4b87e794917 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -309,7 +309,7 @@ static void intel_panel_destroy_probed_modes(struct intel_connector *connector)
 			    connector->base.base.id, connector->base.name,
 			    DRM_MODE_ARG(mode));
 		list_del(&mode->head);
-		drm_mode_destroy(display->drm, mode);
+		drm_mode_destroy(mode);
 	}
 }
 
@@ -466,7 +466,7 @@ void intel_panel_fini(struct intel_connector *connector)
 
 	list_for_each_entry_safe(fixed_mode, next, &panel->fixed_modes, head) {
 		list_del(&fixed_mode->head);
-		drm_mode_destroy(connector->base.dev, fixed_mode);
+		drm_mode_destroy(fixed_mode);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 982abaaac00d..f62033eee5c9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2579,7 +2579,7 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
 	if (msm_host->mode) {
-		drm_mode_destroy(msm_host->dev, msm_host->mode);
+		drm_mode_destroy(msm_host->mode);
 		msm_host->mode = NULL;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 364227f5456f..4b820e3d08f7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1185,7 +1185,7 @@ nv50_mstc_get_modes(struct drm_connector *connector)
 		connector->display_info.bpc = 8;
 
 	if (mstc->native)
-		drm_mode_destroy(mstc->connector.dev, mstc->native);
+		drm_mode_destroy(mstc->native);
 	mstc->native = nouveau_conn_native_mode(&mstc->connector);
 	return ret;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b0b0ad9a0c24..755a5d31aae0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -969,7 +969,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* destroy the native mode, the attached monitor could have changed.
 	 */
 	if (nv_connector->native_mode) {
-		drm_mode_destroy(dev, nv_connector->native_mode);
+		drm_mode_destroy(nv_connector->native_mode);
 		nv_connector->native_mode = NULL;
 	}
 
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 727766444d63..547fbef0dbb6 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -337,7 +337,7 @@ static void kunit_action_drm_mode_destroy(void *ptr)
 {
 	struct drm_display_mode *mode = ptr;
 
-	drm_mode_destroy(NULL, mode);
+	drm_mode_destroy(mode);
 }
 
 /**
diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 8e4e5fc9d3c5..fbe5c2382983 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -782,7 +782,7 @@ static int vbox_fill_modes(struct drm_connector *connector, u32 max_x,
 	dev = vbox_connector->base.dev;
 	list_for_each_entry_safe(mode, iterator, &connector->modes, head) {
 		list_del(&mode->head);
-		drm_mode_destroy(dev, mode);
+		drm_mode_destroy(mode);
 	}
 
 	return drm_helper_probe_single_connector_modes(connector, max_x, max_y);
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index b9bb92e4b029..b1d1ecb15f02 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -453,7 +453,7 @@ struct drm_connector;
 struct drm_cmdline_mode;
 
 struct drm_display_mode *drm_mode_create(struct drm_device *dev);
-void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode);
+void drm_mode_destroy(struct drm_display_mode *mode);
 void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 			       const struct drm_display_mode *in);
 int drm_mode_convert_umode(struct drm_device *dev,
-- 
2.43.0

