Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71735CCA463
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4574910F4D5;
	Thu, 15 Oct 2026 15:10:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799B610F080
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60CEA43A62;
 Thu, 15 Oct 2026 15:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717E1F000C5;
 Thu, 15 Oct 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077020;
 bh=UcKlz9bwKO5IX5iiFLS+0sYNB22HD+y3zysh2hBQXlA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=m2IuSuxsFihtNoSo/76xhccavr6/aTroJtbiDmwCHQvBB4ilpp1Hw03KJyTHoV5ZQ
 9mIjgYjH867WZGONAtMcINTAiVtORc+5saC82g79dCZSXBYfsxm3X+8WtXyLyIHdR7
 lci55XkbFvDGEhDs/Y38Dp0EZ/ayLOj/6Y7UxSk/CNoW+3euHSNL3OvIKTBJaDcRou
 V+8sGjuvDzfPu7RB7GIwWd8Mc9w5cNzlBHJU1Trwrr/T/8xReWsY+ByyXYNoy4nlOu
 W8vqJc9V6mJQ9dPFY2qSrGmNA1Prq5vrhH5EKdtq0RORQQpy97Gx9k5P8vpb6gFCv7
 K0dSvcFH+7GtA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:10 +0200
Subject: [PATCH v6 18/28] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-18-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19656; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SNC8NUmpk2lldplMhWMimhc45FMOu65FPYy1iP6LLss=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3ky6V/J9Pa9rYEf+I9tCldq6ydrzk3Us9fLnf2b2y
 FvBrPSkYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkog9jw/mP08UnHZDKinz9
 5rJdw5tJ/9c4P/qx0VXgyN1nWWYc5mpnVVX3zLeqZLzwd10Ly81KDsb6fGUlpUXelZfvqTy+dlj
 /74G0bzumcovtPS8Q+Gv9/Mtv/v+qyc1iO/TEnbG6KdnaI6wbAA==
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
 include/drm/drm_bridge.h                |   5 +-
 include/drm/drm_connector.h             |   5 +-
 include/drm/drm_crtc.h                  |   5 +-
 include/drm/drm_plane.h                 |   5 +-
 7 files changed, 300 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/drm_atomic_sro_helper.c
index 692a5a24d762..46a733e4dcce 100644
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
@@ -406,10 +407,249 @@ int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
 
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
index b2ff06796af0..c7c188ef8949 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -612,10 +612,25 @@ drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
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
@@ -640,10 +655,11 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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
index 71340978ce7c..d7c996e729ea 100644
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
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 73934fe3f513..fcccd8f6403d 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -317,11 +317,14 @@ struct drm_bridge_funcs {
 	 * Compares two &struct drm_bridge_state instances and reports
 	 * any mismatches through @p.
 	 *
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_bridge_compare_state() first for the base
+	 * state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
 	 * be left unassigned otherwise.
 	 *
 	 * RETURNS:
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 60fa286922b2..876fdb9f32e4 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1907,11 +1907,14 @@ struct drm_connector_funcs {
 	 * Compares two &struct drm_connector_state instances and
 	 * reports any mismatches through @p.
 	 *
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_connector_compare_state() first for the
+	 * base state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
 	 * be left unassigned otherwise.
 	 *
 	 * RETURNS:
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index bf5198c46ef3..f4656dd8de72 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -736,11 +736,14 @@ struct drm_crtc_funcs {
 	 * Compares two &struct drm_crtc_state instances and reports
 	 * any mismatches through @p.
 	 *
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_crtc_compare_state() first for the base
+	 * state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
 	 * be left unassigned otherwise.
 	 *
 	 * RETURNS:
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index f066fd8e1098..6e0690d7111e 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -488,11 +488,14 @@ struct drm_plane_funcs {
 	 * Compares two &struct drm_plane_state instances and reports
 	 * any mismatches through @p.
 	 *
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_plane_compare_state() first for the base
+	 * state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
 	 * be left unassigned otherwise.
 	 *
 	 * RETURNS:

-- 
2.55.0

