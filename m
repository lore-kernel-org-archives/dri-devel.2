Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345CAF99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F67710F076;
	Thu, 23 Apr 2026 10:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n4j8PS8u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E1110F076
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C2FB43A4D;
 Thu, 23 Apr 2026 10:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99647C2BCAF;
 Thu, 23 Apr 2026 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939571;
 bh=ZIHjtboUMcG8n86q30LejpxnIIUcq5ovACG8rAG+ahg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=n4j8PS8uEt16Cp3zBdOtZ1ZfdVDii2B61/fgUWTsEYGWBgjV45+iOeocR8fRWz3SS
 /IpQ3dZBi0FY37Yem+Mv60lGSeNTLWrc0suIM9hVdyrMHb/fWbkYyK/ARpAR83/hSc
 3P9pAlt0IkDzJQMe16fTi7CVzvXXdGuslwsEQwuDhx+eT5nRr1r735Y98h5mJ5FGo5
 AfGefYpO52Xs8A/H4Mngh7EOlmgY9zj7yoYdnd2rOix6hPSzS9Odq+YLhdYJosIEL7
 nQJZHQmDjbwQggm42xJxQan9iGfVM42/T6aeih0o/DKgt/kv8S1MBD6XBDBGto4YxN
 ACMiUptco4P3A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:34 +0200
Subject: [PATCH v2 21/28] drm/atomic_state_helper: Provide
 atomic_compare_state helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-21-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16230; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZIHjtboUMcG8n86q30LejpxnIIUcq5ovACG8rAG+ahg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP34IVpoRmrTn81qFjY9jMhcGvti1xbLumJP8Ye+cH
 9kNXCfSOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE3qQz1mlW+tS7R7uKXj0v
 fb/lgrTy8YmvtwouZ88+aVj5M7Bc4GTqgQTtpzZ6atz/tLfKJggYMtbXPYhIdzaPMGV3CThiri/
 k9rR2flqS2eLVX6UvLDAIFn3sEtthH/cvWznz0tPrr96H5QMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Now that we have introduced some new infrastructure to compare state
instances, provide helpers for the default states.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_sro_helper.c | 240 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c            |  16 +++
 include/drm/drm_atomic_sro_helper.h     |  28 ++++
 3 files changed, 284 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/drm_atomic_sro_helper.c
index b6411bfdba78..153c09a58430 100644
--- a/drivers/gpu/drm/drm_atomic_sro_helper.c
+++ b/drivers/gpu/drm/drm_atomic_sro_helper.c
@@ -5,10 +5,11 @@
 #include <drm/drm_atomic_sro_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 
 #include <linux/gfp.h>
@@ -404,10 +405,249 @@ int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
 
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_helper_sro_readout_state);
 
+static bool drm_atomic_helper_fb_compare(struct drm_printer *p,
+					 struct drm_framebuffer *expected,
+					 struct drm_framebuffer *actual)
+{
+	unsigned int i;
+	bool ret = true;
+
+	STATE_CHECK_FORMAT_INFO(ret, p, "framebuffer", expected, actual, format);
+
+	for (i = 0; i < expected->format->num_planes; i++) {
+		STATE_CHECK_U32(ret, p, "framebuffer", expected, actual, pitches[i]);
+		STATE_CHECK_U32(ret, p, "framebuffer", expected, actual, offsets[i]);
+	}
+
+	STATE_CHECK_U64(ret, p, "framebuffer", expected, actual, modifier);
+	STATE_CHECK_U32(ret, p, "framebuffer", expected, actual, width);
+	STATE_CHECK_U32(ret, p, "framebuffer", expected, actual, height);
+	STATE_CHECK_S32_X(ret, p, "framebuffer", expected, actual, flags);
+
+	return ret;
+}
+
+/**
+ * drm_atomic_helper_plane_compare_state - default &drm_plane_funcs.atomic_sro_compare_state hook
+ * @plane: the plane being compared
+ * @p: printer for reporting mismatches
+ * @expected: the committed &struct drm_plane_state
+ * @actual: the &struct drm_plane_state read out from hardware
+ *
+ * Compares the base &struct drm_plane_state fields of @actual to
+ * @expected and reports any mismatches through @p. Drivers subclassing
+ * the plane state should call this first, then compare their own fields.
+ *
+ * RETURNS:
+ *
+ * True if the states are identical, false otherwise.
+ */
+bool drm_atomic_helper_plane_compare_state(struct drm_plane *plane,
+					   struct drm_printer *p,
+					   struct drm_plane_state *expected,
+					   struct drm_plane_state *actual)
+{
+	bool ret = true;
+
+	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, plane);
+	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, crtc);
+
+	if (expected->fb && actual->fb) {
+		if (!drm_atomic_helper_fb_compare(p, expected->fb, actual->fb))
+			ret = false;
+	} else if (!(!expected->fb && !actual->fb)) {
+		drm_atomic_helper_print_state_mismatch(p,
+						       plane->name,
+						       "fb",
+						       "expected framebuffer is %s, got %s",
+						       expected->fb ? "non-NULL" : "NULL",
+						       actual->fb ? "non-NULL" : "NULL");
+		ret = false;
+	}
+
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, crtc_x);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, crtc_y);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, crtc_w);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, crtc_h);
+	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_x);
+	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_y);
+	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_w);
+	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_h);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, hotspot_x);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, hotspot_y);
+	STATE_CHECK_U16(ret, p, plane->name, expected, actual, alpha);
+	STATE_CHECK_U16(ret, p, plane->name, expected, actual, pixel_blend_mode);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, rotation);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, zpos);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, normalized_zpos);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_encoding);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_range);
+
+	// TODO: damage clips
+
+	STATE_CHECK_BOOL(ret, p, plane->name, expected, actual, ignore_damage_clips);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.x1);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.x2);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.y1);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.y2);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.x1);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.x2);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.y1);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.y2);
+	STATE_CHECK_BOOL(ret, p, plane->name, expected, actual, visible);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, scaling_filter);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_helper_plane_compare_state);
+
+/**
+ * drm_atomic_helper_crtc_compare_state - default &drm_crtc_funcs.atomic_sro_compare_state hook
+ * @crtc: the CRTC being compared
+ * @p: printer for reporting mismatches
+ * @expected: the committed &struct drm_crtc_state
+ * @actual: the &struct drm_crtc_state read out from hardware
+ *
+ * Compares the base &struct drm_crtc_state fields of @actual to
+ * @expected and reports any mismatches through @p. Drivers subclassing
+ * the CRTC state should call this first, then compare their own fields.
+ *
+ * RETURNS:
+ *
+ * True if the states are identical, false otherwise.
+ */
+bool drm_atomic_helper_crtc_compare_state(struct drm_crtc *crtc,
+					  struct drm_printer *p,
+					  struct drm_crtc_state *expected,
+					  struct drm_crtc_state *actual)
+{
+	bool ret = true;
+
+	STATE_CHECK_PTR(ret, p, crtc->name, expected, actual, crtc);
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, enable);
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, active);
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, no_vblank);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, plane_mask);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, connector_mask);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, encoder_mask);
+
+	STATE_CHECK_DISPLAY_MODE(ret, p, crtc->name, expected, actual, mode);
+	STATE_CHECK_DISPLAY_MODE(ret, p, crtc->name, expected, actual, adjusted_mode);
+	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, mode_blob);
+	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, degamma_lut);
+	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, ctm);
+	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, gamma_lut);
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, vrr_enabled);
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, self_refresh_active);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, scaling_filter);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_helper_crtc_compare_state);
+
+/**
+ * drm_atomic_helper_connector_compare_state - default &drm_connector_funcs.atomic_sro_compare_state hook
+ * @conn: the connector being compared
+ * @p: printer for reporting mismatches
+ * @expected: the committed &struct drm_connector_state
+ * @actual: the &struct drm_connector_state read out from hardware
+ *
+ * Compares the base &struct drm_connector_state fields of @actual to
+ * @expected and reports any mismatches through @p. Drivers subclassing
+ * the connector state should call this first, then compare their own
+ * fields.
+ *
+ * RETURNS:
+ *
+ * True if the states are identical, false otherwise.
+ */
+bool drm_atomic_helper_connector_compare_state(struct drm_connector *conn,
+					       struct drm_printer *p,
+					       struct drm_connector_state *expected,
+					       struct drm_connector_state *actual)
+{
+	bool ret = true;
+
+	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, connector);
+	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, crtc);
+	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, best_encoder);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, link_status);
+
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.select_subconnector);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.subconnector);
+
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, self_refresh_aware);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, picture_aspect_ratio);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, content_type);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdcp_content_type);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, scaling_mode);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, content_protection);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, colorspace);
+
+	/*
+	 * NOTE: We can't check max_bpc and max_requested_bpc because it
+	 * will typically come from userspace and we can't read it out
+	 * from the hardware.
+	 */
+
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, privacy_screen_sw_state);
+	STATE_CHECK_PROPERTY_BLOB(ret, p, conn->name, expected, actual, hdr_output_metadata);
+
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.broadcast_rgb);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.avi.set);
+	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.avi.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.hdr_drm.set);
+	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.hdr_drm.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.spd.set);
+	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.spd.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.hdmi.set);
+	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.hdmi.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.is_limited_range);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.output_bpc);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.output_format);
+	STATE_CHECK_U64(ret, p, conn->name, expected, actual, hdmi.tmds_char_rate);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_compare_state);
+
+/**
+ * drm_atomic_helper_bridge_compare_state - default &drm_bridge_funcs.atomic_sro_compare_state hook
+ * @bridge: the bridge being compared
+ * @p: printer for reporting mismatches
+ * @expected: the committed &struct drm_bridge_state
+ * @actual: the &struct drm_bridge_state read out from hardware
+ *
+ * Compares the base &struct drm_bridge_state fields of @actual to
+ * @expected and reports any mismatches through @p. Drivers subclassing
+ * the bridge state should call this first, then compare their own
+ * fields.
+ *
+ * RETURNS:
+ *
+ * True if the states are identical, false otherwise.
+ */
+bool drm_atomic_helper_bridge_compare_state(struct drm_bridge *bridge,
+					    struct drm_printer *p,
+					    struct drm_bridge_state *expected,
+					    struct drm_bridge_state *actual)
+{
+	bool ret = true;
+
+	STATE_CHECK_PTR(ret, p, bridge->name, expected, actual, bridge);
+	STATE_CHECK_U32_X(ret, p, bridge->name, expected, actual, input_bus_cfg.format);
+	STATE_CHECK_U32_X(ret, p, bridge->name, expected, actual, input_bus_cfg.flags);
+	STATE_CHECK_U32_X(ret, p, bridge->name, expected, actual, output_bus_cfg.format);
+	STATE_CHECK_U32_X(ret, p, bridge->name, expected, actual, output_bus_cfg.flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_helper_bridge_compare_state);
+
 /**
  * drm_atomic_helper_print_state_mismatch - report a state comparison mismatch
  * @p: printer to report through
  * @name: human-readable name of the object (e.g. plane or CRTC name)
  * @field: name of the mismatching field
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6621d80f5252..e0f91e445dbb 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -563,10 +563,25 @@ drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
 	}
 
 	return 0;
 }
 
+static bool drm_bridge_atomic_compare_priv_state(struct drm_private_obj *obj,
+						 struct drm_printer *p,
+						 struct drm_private_state *a,
+						 struct drm_private_state *b)
+{
+	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
+	struct drm_bridge_state *state_a = drm_priv_to_bridge_state(a);
+	struct drm_bridge_state *state_b = drm_priv_to_bridge_state(b);
+
+	if (bridge->funcs->atomic_sro_compare_state)
+		return bridge->funcs->atomic_sro_compare_state(bridge, p, state_a, state_b);
+	else
+		return false;
+}
+
 static void
 drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 				   const struct drm_private_state *s)
 {
 	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
@@ -591,10 +606,11 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
 };
 
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
+	.atomic_sro_compare_state = drm_bridge_atomic_compare_priv_state,
 	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
diff --git a/include/drm/drm_atomic_sro_helper.h b/include/drm/drm_atomic_sro_helper.h
index db5d62ac0db9..e7bc4816c743 100644
--- a/include/drm/drm_atomic_sro_helper.h
+++ b/include/drm/drm_atomic_sro_helper.h
@@ -4,11 +4,19 @@
 #define DRM_ATOMIC_SRO_HELPER_H_
 
 #include <linux/string_choices.h>
 
 struct drm_atomic_sro_state;
+struct drm_bridge;
+struct drm_bridge_state;
+struct drm_connector;
+struct drm_connector_state;
+struct drm_crtc;
+struct drm_crtc_state;
 struct drm_device;
+struct drm_plane;
+struct drm_plane_state;
 struct drm_printer;
 
 int
 drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
 					   struct drm_atomic_sro_state *state);
@@ -26,10 +34,30 @@ drm_atomic_helper_sro_readout_private_objs_state(struct drm_device *dev,
 						 struct drm_atomic_sro_state *state);
 struct drm_atomic_sro_state *
 drm_atomic_helper_sro_build_state(struct drm_device *dev);
 int drm_atomic_helper_sro_readout_state(struct drm_device *dev);
 
+bool drm_atomic_helper_connector_compare_state(struct drm_connector *connector,
+					       struct drm_printer *p,
+					       struct drm_connector_state *expected,
+					       struct drm_connector_state *actual);
+
+bool drm_atomic_helper_crtc_compare_state(struct drm_crtc *crtc,
+					  struct drm_printer *p,
+					  struct drm_crtc_state *expected,
+					  struct drm_crtc_state *actual);
+
+bool drm_atomic_helper_plane_compare_state(struct drm_plane *plane,
+					   struct drm_printer *p,
+					   struct drm_plane_state *expected,
+					   struct drm_plane_state *actual);
+
+bool drm_atomic_helper_bridge_compare_state(struct drm_bridge *bridge,
+					    struct drm_printer *p,
+					    struct drm_bridge_state *expected,
+					    struct drm_bridge_state *actual);
+
 void __printf(4, 5)
 drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
 				       const char *name,
 				       const char *field,
 				       const char *format, ...);

-- 
2.53.0

