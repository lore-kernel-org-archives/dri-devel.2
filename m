Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40989606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=assQ76H0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E12210FFD3;
	Thu, 29 Oct 2026 07:36:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA08310FFEA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 209EF60210;
 Thu, 29 Oct 2026 07:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE951F01825;
 Thu, 29 Oct 2026 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259343;
 bh=FOgxIsqnIgvsfkz7ykhr2J56Ut5qqc9pACxxHfRh8DE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=assQ76H089lFyYDDAlYT8vEhtw10a7noyG9lIYcMBBAvMjF+bNYmXhtwYT3gtKk/D
 7u1GNCJm6bGy1nmRsLuNbi/c33XWMJgYPFHg4I0VMJJcennEYdfAijo4HcEoOajYXo
 XG+LUQ3eCIkTggtw12O7XrEMb98SBr4TCbMEEheOD0G6t7jnr42KYYeFlYxCvBGKWn
 BYJHCQZqTjaFaCIHve+oSZvnFdueCS0EvyaRmQS0DJNA1rVwDd/DP68hpg5x9wgA8Y
 p5MaIP+i1JU6tTYhawsshSI9e2bqxwg2AhOPakjq/Qj0zLbSzoHVuO2YFB5gnNA7T+
 wrmd/eV5kuqVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:12 +0100
Subject: [PATCH v7 22/34] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-22-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18877; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lBWa39gVYjlp4pSES/gNMULivJpVxGBVgcXzDjePNRk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn0LyvywzP/XiRsTbC0Scja+jvZ4NIPT1LLcqlpgm
 lz4rHv+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiJ0IZGyb0a51rvDQl74+/
 YNPtjSwmqvWLi+NYZZOvqfb0XUg/+byHseCQvGLEWVYLBqklJ6zlGBsmvGaObAmZvTNhy9P8pdv
 lJ9r+c3ViC1ufWsZbO+3Pv6l87U+OT9a9ulNgyWOPPa5cZscA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that we have introduced some new infrastructure to compare state
instances, provide helpers for the default states.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_readout_helper.c | 263 ++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c                      |  16 ++
 include/drm/drm_atomic_state_readout_helper.h     |  28 +++
 include/drm/drm_bridge.h                          |   5 +-
 include/drm/drm_connector.h                       |   5 +-
 include/drm/drm_crtc.h                            |   5 +-
 include/drm/drm_plane.h                           |   5 +-
 7 files changed, 323 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
index 33f0f78c9b26..c4089afbc946 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
@@ -9,4 +9,5 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
@@ -681,4 +682,266 @@ int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
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
+	/* Both disabled, geometry is meaningless. */
+	if (!expected->fb && !actual->fb)
+		return ret;
+
+	/* One enabled and the other disabled, that's a mismatch. */
+	if (!expected->fb || !actual->fb) {
+		drm_atomic_helper_print_state_mismatch(p,
+						       plane->name,
+						       "fb",
+						       "expected framebuffer is %s, got %s",
+						       expected->fb ? "non-NULL" : "NULL",
+						       actual->fb ? "non-NULL" : "NULL");
+		return false;
+	}
+
+	/* Both enabled, compare framebuffer and geometry. */
+	if (!drm_atomic_helper_fb_compare(p, expected->fb, actual->fb))
+		ret = false;
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
+	STATE_CHECK_PROPERTY_BLOB(ret, p, plane->name, expected, actual, fb_damage_clips);
+	STATE_CHECK_BOOL(ret, p, plane->name, expected, actual, ignore_damage_clips);
+	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, color_pipeline);
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
+
+	/* Both inactive, mode and properties are meaningless. */
+	if (!expected->active && !actual->active)
+		return ret;
+
+	/* One active and the other inactive, that's a mismatch. */
+	if (!expected->active || !actual->active)
+		return false;
+
+	/* Both active, compare everything. */
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
+	STATE_CHECK_U64(ret, p, crtc->name, expected, actual, background_color);
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
+	 * NOTE: We can't check max_bpc, max_requested_bpc and
+	 * color_format because they are userspace requests negotiated
+	 * during atomic_check into output_bpc and output_format. The
+	 * hardware only stores the negotiated result.
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
+	/*
+	 * hdmi.scrambler_needed is derived from hdmi.tmds_char_rate, so
+	 * comparing tmds_char_rate already covers it.
+	 */
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
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1c16e637b97e..45a34bbb8f14 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -630,4 +630,19 @@ drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
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
@@ -658,4 +673,5 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
+	.atomic_sro_compare_state = drm_bridge_atomic_compare_priv_state,
 	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
index d4e941ab7452..2dd871787837 100644
--- a/include/drm/drm_atomic_state_readout_helper.h
+++ b/include/drm/drm_atomic_state_readout_helper.h
@@ -8,5 +8,13 @@
 struct drm_atomic_commit;
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
 
@@ -36,4 +44,24 @@ drm_atomic_helper_sro_build_state(struct drm_device *dev,
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
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 030467e2cb1e..436dfffb25ad 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -325,5 +325,8 @@ struct drm_bridge_funcs {
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_bridge_compare_state() first for the base
+	 * state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3892a20a6cca..6d10b9543a78 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1915,5 +1915,8 @@ struct drm_connector_funcs {
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_connector_compare_state() first for the
+	 * base state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index e5662ddb61fb..a327d858c465 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -744,5 +744,8 @@ struct drm_crtc_funcs {
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_crtc_compare_state() first for the base
+	 * state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 0a18d26eb397..05d73102fef4 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -496,5 +496,8 @@ struct drm_plane_funcs {
 	 * It is called after blocking commits to verify that the
 	 * committed state matches what can be read back from the
-	 * hardware.
+	 * hardware. Drivers subclassing the state should implement this
+	 * to compare their driver-private fields, calling
+	 * drm_atomic_helper_plane_compare_state() first for the base
+	 * state fields.
 	 *
 	 * This hook is mandatory for drivers implementing SRO, but can

-- 
2.55.0

