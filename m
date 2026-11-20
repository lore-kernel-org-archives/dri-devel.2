Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8F60A2603
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vq3mFtj7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91716112A0F;
	Fri, 20 Nov 2026 12:59:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57F689CB3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22882629CE;
 Fri, 20 Nov 2026 12:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0671F00ADF;
 Fri, 20 Nov 2026 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179403;
 bh=/5y6CO1Gk7DTqQJ3pt6p0yaAvBnJsIcH9/KhFkpLPME=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Vq3mFtj7q0M2VKqiaKgOB7C4VO+Qj29YQUENX/xyaZNCjadSAWuThyAyhmVAX8MPF
 aRycUEq5zMv8VCwNEZ0A1v1bbkuHx0MwBUz15cUQhwULIRgO1ZQUXwGPqz/vvgJwOX
 CpjqyrpPJwKTxPE0xfEPPEdtRfYIGxH1+VaqlU45vUMDD3OjEvQmsZbiWMXC9hCMvh
 0wDv7DGcSmS+jBhPlZQiAsJlI+6Ys5tpcgNmVz5h51+VJP21n/M81gYb/yBEfep4Nr
 q1f1iNGowlrMcyucTxiSJGTdYyDPmHrafgBYMmUCUFwQKWYDL8Zq4wG+usRGg/V+qm
 TdUnOH6onlmCg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:16 +0100
Subject: [PATCH v9 24/42] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-24-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=26438; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Bt8Y/YDn9hDYvYKDycKRuTVf5Mn1awzMHdX8oB2c9mg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzrpdS5oPtG2+OuW7elqG+pUAXrkv+l8evp+s07qv4
 5nBJ1fNjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRhlDG+lqfL/1qQbOlo0X/
 qGx/P7HqI0fEy46THb6m3lrzkyqCf8X1ud44xvpIRzqNJVvT6vlixoZnp8oWvnDaGat7tedQ73O
 uAzfKvrduS9z+1uLi1Uup93zFtk7fsNnsdzDbo19rTPwcuqsA
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
 drivers/gpu/drm/drm_atomic_state_readout_helper.c | 391 ++++++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c                      |  16 +
 include/drm/drm_atomic_state_readout_helper.h     |  28 ++
 include/drm/drm_bridge.h                          |   5 +-
 include/drm/drm_connector.h                       |   5 +-
 include/drm/drm_crtc.h                            |   5 +-
 include/drm/drm_plane.h                           |   5 +-
 7 files changed, 451 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
index 80eb467baefc..d39d8e40f894 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
@@ -6,10 +6,11 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -936,10 +937,400 @@ void drm_atomic_helper_sro_install_state(struct drm_atomic_sro_state *state)
 		state->private_objs[i].ptr = NULL;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_sro_install_state);
 
+static bool drm_atomic_helper_fb_compare(struct drm_printer *p,
+					 struct drm_framebuffer *expected,
+					 struct drm_framebuffer *actual)
+{
+	unsigned int i;
+	bool ret = true;
+
+	STATE_CHECK_FORMAT_INFO(ret, p, "framebuffer", expected, actual, format);
+
+	/*
+	 * A framebuffer reconstructed from the hardware only covers the
+	 * part of the buffer that is scanned out, and its per-plane
+	 * offsets are baked into the DMA base address: the buffer
+	 * geometry and the offsets can't be read back and aren't
+	 * compared. The scanned out geometry is still checked through
+	 * the source and destination rectangles of the plane state.
+	 */
+	for (i = 0; i < expected->format->num_planes; i++)
+		STATE_CHECK_U32(ret, p, "framebuffer", expected, actual, pitches[i]);
+
+	STATE_CHECK_U64(ret, p, "framebuffer", expected, actual, modifier);
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
+
+	/*
+	 * NOTE: We can't check src_x and src_y: the source offsets are
+	 * baked into the DMA base address and cannot be read back.
+	 */
+	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_w);
+	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_h);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, hotspot_x);
+	STATE_CHECK_S32(ret, p, plane->name, expected, actual, hotspot_y);
+	STATE_CHECK_U16(ret, p, plane->name, expected, actual, alpha);
+	STATE_CHECK_U16(ret, p, plane->name, expected, actual, pixel_blend_mode);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, rotation);
+
+	/*
+	 * When the zpos are normalized, the zpos property is a
+	 * userspace request turned into normalized_zpos during
+	 * atomic_check, and the hardware only stores the normalized
+	 * result. Otherwise, the driver programs the zpos property
+	 * directly and normalized_zpos isn't updated.
+	 */
+	if (plane->dev->mode_config.normalize_zpos)
+		STATE_CHECK_U32(ret, p, plane->name, expected, actual, normalized_zpos);
+	else
+		STATE_CHECK_U32(ret, p, plane->name, expected, actual, zpos);
+
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_encoding);
+	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_range);
+
+	/*
+	 * NOTE: We can't check fb_damage_clips and ignore_damage_clips
+	 * because they are transient, per-commit software fields that
+	 * are reset when the state is duplicated and never stored in
+	 * the hardware.
+	 */
+
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
+	/*
+	 * Both active, compare everything. enable is only checked at
+	 * this point: a DPMS off commit keeps enable set while the
+	 * hardware, and thus the readout, reports an inactive CRTC.
+	 */
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, enable);
+
+	/* Both active, compare everything. */
+	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, no_vblank);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, plane_mask);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, connector_mask);
+	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, encoder_mask);
+
+	STATE_CHECK_DISPLAY_MODE(ret, p, crtc->name, expected, actual, mode);
+	STATE_CHECK_DISPLAY_MODE(ret, p, crtc->name, expected, actual, adjusted_mode);
+
+	/*
+	 * NOTE: We can't check mode_blob: its payload also carries the
+	 * mode type and name, and neither can be reconstructed from the
+	 * hardware. The modes themselves are covered by the checks
+	 * above.
+	 */
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
+
+	/*
+	 * Both unbound, the routing and the negotiated properties are
+	 * meaningless: a disabled connector keeps the values it was
+	 * last enabled with, while a state read out from a disabled
+	 * pipeline is pristine.
+	 */
+	if (!expected->crtc && !actual->crtc)
+		return ret;
+
+	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, crtc);
+
+	/*
+	 * One bound and the other unbound, that's a mismatch, and the
+	 * negotiated properties of the unbound one are meaningless.
+	 */
+	if (!expected->crtc || !actual->crtc)
+		return false;
+
+	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, best_encoder);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, link_status);
+
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.select_subconnector);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.subconnector);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.margins.left);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.margins.right);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.margins.top);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.margins.bottom);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.legacy_mode);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.mode);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.brightness);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.contrast);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.flicker_reduction);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.overscan);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.saturation);
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.hue);
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
+	 * NOTE: We can't check max_bpc, max_requested_bpc,
+	 * color_format or hdmi.broadcast_rgb because they are
+	 * userspace requests negotiated during atomic_check into
+	 * output_bpc, output_format and hdmi.is_limited_range. The
+	 * hardware only stores the negotiated result.
+	 */
+
+	STATE_CHECK_U32(ret, p, conn->name, expected, actual, privacy_screen_sw_state);
+
+	/*
+	 * NOTE: We can't check hdr_output_metadata: it's a userspace
+	 * request, and the hardware only stores the resulting HDR
+	 * infoframe, compared below.
+	 */
+
+	/*
+	 * NOTE: The infoframe payloads are only compared when the
+	 * infoframe is enabled in both states: the disabled ones keep
+	 * stale data from earlier commits around in the expected
+	 * state, while the readout state is pristine.
+	 */
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.avi.set);
+	if (expected->hdmi.infoframes.avi.set && actual->hdmi.infoframes.avi.set)
+		STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.avi.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.hdr_drm.set);
+	if (expected->hdmi.infoframes.hdr_drm.set && actual->hdmi.infoframes.hdr_drm.set)
+		STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.hdr_drm.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.spd.set);
+	if (expected->hdmi.infoframes.spd.set && actual->hdmi.infoframes.spd.set)
+		STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.spd.data);
+	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.hdmi.set);
+	if (expected->hdmi.infoframes.hdmi.set && actual->hdmi.infoframes.hdmi.set)
+		STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infoframes.hdmi.data);
+
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
+ * The compared fields are the format and the flags of both the input
+ * and the output &struct drm_bus_cfg. @expected holds what
+ * drm_atomic_bridge_chain_check() computed, so the
+ * &drm_bridge_funcs.atomic_sro_readout_state implementation that
+ * filled @actual is expected to reproduce those values, which depend
+ * on the order in which each of them is determined.
+ *
+ * During a regular atomic check, the bus formats are negotiated from
+ * the last bridge to the first one, and the bus flags are propagated
+ * in the same direction: the output flags of a bridge are those of the
+ * input of the next element in the chain. During the readout, the
+ * bridges are however visited from the first to the last one, so the
+ * state of the previous bridge is available but the state of the next
+ * one is not. A readout implementation is thus expected to:
+ *
+ * - Report the input and output formats the hardware is configured
+ *   with, or the ones the format negotiation would have selected if
+ *   the hardware doesn't store them. A bridge that doesn't implement
+ *   &drm_bridge_funcs.atomic_get_input_bus_fmts reports
+ *   MEDIA_BUS_FMT_FIXED as its input format.
+ *
+ * - Report the input flags the hardware is configured with. If it
+ *   doesn't store them, they can be taken from the output flags of the
+ *   previous bridge if it was read out, from the CRTC state for the
+ *   first bridge, or from the same source as
+ *   &drm_bridge_timings.input_bus_flags if the bridge sets them
+ *   statically in &drm_bridge_funcs.atomic_check.
+ *
+ * - Report the output flags the hardware produces. They can't be
+ *   copied from the next bridge, which hasn't been read out yet. They
+ *   should be read from the hardware when it stores them. The last
+ *   bridge of a chain can use &drm_display_info.bus_flags, and a
+ *   bridge forwarding its signals unmodified can use its own input
+ *   flags, which is what the default flag propagation of the atomic
+ *   check does.
+ *
+ * - Apply the same adjustments its &drm_bridge_funcs.atomic_check
+ *   implementation does to the flags, since @expected includes them.
+ *
+ * Since the output flags are compared too, an output flag a bridge
+ * can't actually read, or guesses incorrectly, shows up as a mismatch.
+ * Likewise, hardware that can only store a flag as one of two values
+ * can't report that a flag was left unset in @expected. Drivers
+ * hitting that limitation can provide their own
+ * &drm_bridge_funcs.atomic_sro_compare_state implementation that
+ * ignores the flags the hardware can't report.
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
index fe9b535d02bd..0d0c39cdc775 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -635,10 +635,25 @@ drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
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
 drm_bridge_atomic_install_priv_state(struct drm_private_obj *obj,
 				     struct drm_private_state *priv_state)
 {
 	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
@@ -699,10 +714,11 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 	.atomic_print_state = drm_bridge_atomic_print_priv_state,
 };
 
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
+	.atomic_sro_compare_state = drm_bridge_atomic_compare_priv_state,
 	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
 	.atomic_sro_install_state = drm_bridge_atomic_install_priv_state,
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
index 603fe13a732e..6125ea668fa8 100644
--- a/include/drm/drm_atomic_state_readout_helper.h
+++ b/include/drm/drm_atomic_state_readout_helper.h
@@ -5,11 +5,19 @@
 
 #include <linux/string_choices.h>
 
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
 
 int
 drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
 					   struct drm_atomic_sro_state *state,
@@ -34,10 +42,30 @@ struct drm_atomic_sro_state *
 drm_atomic_helper_sro_build_state(struct drm_device *dev,
 				  struct drm_atomic_commit *commit);
 int drm_atomic_helper_sro_readout_state(struct drm_device *dev);
 void drm_atomic_helper_sro_install_state(struct drm_atomic_sro_state *state);
 
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
index d812e809ae81..a74407ee5a9c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -360,11 +360,14 @@ struct drm_bridge_funcs {
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
index 495c9a806d6c..dd00659c5c4d 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1913,11 +1913,14 @@ struct drm_connector_funcs {
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
index 5a94fdb0f7c0..4f1a99626fca 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -747,11 +747,14 @@ struct drm_crtc_funcs {
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
index d7af4b58ab31..f0c44afac016 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -494,11 +494,14 @@ struct drm_plane_funcs {
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
2.56.1

