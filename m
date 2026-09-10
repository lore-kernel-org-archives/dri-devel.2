Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C0C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8379C10F531;
	Fri, 11 Sep 2026 07:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="vaeAadkt";
	dkim-atps=neutral
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D84A10E27F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:56:52 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hgn363twqzHqd;
 Thu, 10 Sep 2026 20:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1789066610;
 bh=79untcTBsMIh0N42cp6pQROVUMP4JU0DTMgmss7VSJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vaeAadktJowWe+S26ivlP6ydI3jCWGFQTkyc3tM9VdKDAJmcphttPR3bj6AwXTxoN
 vh84MZtGZxMziRHJ7MHdUmbKv4h598k5xsRr1rxelMWiidvdHPXrjYPnZ3m173hh4b
 SCST2iUwlMz0mMR628DxPZSi2XrjSTngu8fk4b0O4AfgCSeySoF3T1oKH7whFIj919
 utNNUwQ9atIyRjCRh1zeLxv3JrzB6+tVuLSD/yh+5IPe2E/t1DbxUFLYKW8fckVVKv
 GgDavr38ZGkVIoFJ9Huq6vrZmLzezX9J/h2ahVwYWSwsb1omnqSSdafmsPlm36Zo89
 7lbjihjYx9sEg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hgn344h4gzngl; Thu, 10 Sep 2026 20:56:48 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Satyajit Roy <sroy14@alum.utk.edu>, Alex Hung <alex.hung@amd.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Default HDMI RGB output to limited range
 on CTA modes
Date: Thu, 10 Sep 2026 20:56:48 +0200
Message-ID: <20260910185648.75182-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910181517.68781-1-adrian.betschart@cinemaone.ch>
References: <20260910181517.68781-1-adrian.betschart@cinemaone.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

With the Broadcast RGB property at Automatic, amdgpu_dm_get_output_color_space()
selects COLOR_SPACE_SRGB for RGB output, so DC neither compresses the pixels
nor, without a QS-capable sink, signals full range in the AVI InfoFrame. A sink
that follows CTA-861 treats the default quantization of a CTA video format as
limited and expands 16-235 to 0-255: everything below 16 is crushed to black,
everything above 235 clips.

Follow the CTA-861 default for Automatic instead, as the DRM HDMI state helper
(hdmi_is_limited_range()) and i915 do: limited range on an HDMI sink for CTA
modes other than 640x480, full range elsewhere. Full and Limited keep their
explicit meaning. The same rule applies to the BT.2020 RGB branch. With
commit a56a50074 ("drm/amd/display: Propagate HDMI RGB quantization
selectability") the AVI InfoFrame then carries the matching Q value on
sinks that support selection.

Measured on a Radeon RX 7600 (DCN 3.2.1) driving a JVC DLA-RS4100 at
1920x1080p24 RGB 12 bpc: the sink reports the signal as limited range while
the picture shows crushed shadows; rendering limited range in the client makes
it match a reference source.

The KUnit fixtures that reach amdgpu_dm_get_output_color_space() now carry
a connector, since Automatic reads its display_info, and five cases cover
the new rule.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5796
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude Code:claude-fable-5-1
---
Changes in v2:
- KUnit: give the AUTO test states a connector (the new rule reads
  connector->display_info.is_hdmi) and add cases for Automatic on an HDMI
  CTA mode, on VIC 1, on a non-HDMI sink, for Full on a CTA mode, and for
  BT.2020 RGB. Reported by the Sashiko review.

 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  22 +++-
 .../tests/amdgpu_dm_connector_test.c          | 120 ++++++++++++++++++
 2 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0b446133e..13cbe099c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -734,6 +734,24 @@ get_aspect_ratio(const struct drm_display_mode *mode_in)
 }
 EXPORT_IF_KUNIT(get_aspect_ratio);
 
+/*
+ * CTA-861 5.1: RGB video formats default to limited range except 640x480 (VIC 1).
+ * With Broadcast RGB left at Automatic follow that default, as i915 does.
+ */
+static bool rgb_output_is_limited_range(const struct dc_crtc_timing *dc_crtc_timing,
+					const struct drm_connector_state *connector_state)
+{
+	switch (connector_state->hdmi.broadcast_rgb) {
+	case DRM_HDMI_BROADCAST_RGB_FULL:
+		return false;
+	case DRM_HDMI_BROADCAST_RGB_LIMITED:
+		return true;
+	default:
+		return connector_state->connector->display_info.is_hdmi &&
+		       dc_crtc_timing->vic > 1;
+	}
+}
+
 enum dc_color_space
 amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 				 const struct drm_connector_state *connector_state)
@@ -759,7 +777,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 	case DRM_MODE_COLORIMETRY_BT2020_RGB:
 	case DRM_MODE_COLORIMETRY_BT2020_YCC:
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
-			if (connector_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state))
 				color_space = COLOR_SPACE_2020_RGB_LIMITEDRANGE;
 			else
 				color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
@@ -771,7 +789,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 	default:
 		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
 			color_space = COLOR_SPACE_SRGB;
-			if (connector_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state))
 				color_space = COLOR_SPACE_SRGB_LIMITED;
 		/*
 		 * 27030khz is the separation point between HDTV and SDTV
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 6e70d7213..64ad47403 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -412,7 +412,9 @@ static void dm_test_output_color_space_default_rgb_full(struct kunit *test)
 {
 	struct dc_crtc_timing timing = {};
 	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 
+	state.connector = connector;
 	timing.pixel_encoding = PIXEL_ENCODING_RGB;
 	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
 	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
@@ -562,7 +564,9 @@ static void dm_test_output_color_space_bt2020_rgb(struct kunit *test)
 {
 	struct dc_crtc_timing timing = {};
 	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 
+	state.connector = connector;
 	timing.pixel_encoding = PIXEL_ENCODING_RGB;
 	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
 
@@ -587,6 +591,110 @@ static void dm_test_output_color_space_bt2020_rgb_limited(struct kunit *test)
 			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
 }
 
+/**
+ * dm_test_output_color_space_default_rgb_auto_hdmi_cta - Automatic follows the CTA-861 default
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_default_rgb_auto_hdmi_cta(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+
+	connector->display_info.is_hdmi = true;
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	timing.vic = 32;
+	state.connector = connector;
+	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_SRGB_LIMITED);
+}
+
+/**
+ * dm_test_output_color_space_default_rgb_auto_hdmi_vga - 640x480 (VIC 1) stays full range
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_default_rgb_auto_hdmi_vga(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+
+	connector->display_info.is_hdmi = true;
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	timing.vic = 1;
+	state.connector = connector;
+	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_SRGB);
+}
+
+/**
+ * dm_test_output_color_space_default_rgb_auto_dp_cta - Automatic on a non-HDMI sink is full range
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_default_rgb_auto_dp_cta(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	timing.vic = 32;
+	state.connector = connector;
+	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_SRGB);
+}
+
+/**
+ * dm_test_output_color_space_default_rgb_full_hdmi_cta - Full overrides the CTA-861 default
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_default_rgb_full_hdmi_cta(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+
+	connector->display_info.is_hdmi = true;
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	timing.vic = 32;
+	state.connector = connector;
+	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_FULL;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_SRGB);
+}
+
+/**
+ * dm_test_output_color_space_bt2020_rgb_auto_hdmi_cta - BT.2020 RGB follows the same default
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_rgb_auto_hdmi_cta(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+
+	connector->display_info.is_hdmi = true;
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	timing.vic = 32;
+	state.connector = connector;
+	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
+	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
+}
+
 /**
  * dm_test_output_color_space_bt2020_ycc - Test Output color space bt2020 ycc
  * @test: The KUnit test context
@@ -650,7 +758,9 @@ static void dm_test_output_color_space_bt2020_ycc_rgb_encoding(struct kunit *tes
 {
 	struct dc_crtc_timing timing = {};
 	struct drm_connector_state state = {};
+	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 
+	state.connector = connector;
 	timing.pixel_encoding = PIXEL_ENCODING_RGB;
 	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_YCC;
 
@@ -3594,6 +3704,7 @@ static struct dm_test_fill_ctx *dm_test_fill_ctx_alloc(struct kunit *test)
 
 	ctx->conn_state = drmm_kzalloc(ctx->drm, sizeof(*ctx->conn_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
+	ctx->conn_state->connector = &ctx->aconnector->base;
 	ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
 	ctx->mode = kunit_kzalloc(test, sizeof(*ctx->mode), GFP_KERNEL);
@@ -4063,6 +4174,7 @@ static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
 
 	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
+	ctx->dm_state->base.connector = &ctx->aconnector->base;
 	ctx->dm_state->scaling = RMX_OFF;
 
 	ctx->mode = kunit_kzalloc(test, sizeof(*ctx->mode), GFP_KERNEL);
@@ -6818,6 +6930,7 @@ dm_test_cvs_ctx_alloc(struct kunit *test, int connector_type)
 
 	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
+	ctx->dm_state->base.connector = &ctx->aconnector->base;
 	ctx->dm_state->base.max_requested_bpc = 4;
 
 	ctx->mode = kunit_kzalloc(test, sizeof(*ctx->mode), GFP_KERNEL);
@@ -6872,6 +6985,7 @@ static void dm_test_create_validate_stream_writeback(struct kunit *test)
 
 	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	dm_state->base.connector = &wbcon->base.base;
 	dm_state->scaling = RMX_OFF;
 
 	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
@@ -7120,6 +7234,7 @@ static struct dm_test_cvs_dc *dm_test_cvs_dc_alloc(struct kunit *test)
 
 	c->dm_state = kunit_kzalloc(test, sizeof(*c->dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, c->dm_state);
+	c->dm_state->base.connector = &c->aconnector->base;
 	c->dm_state->base.max_requested_bpc = 8;
 	c->dm_state->scaling = RMX_OFF;
 
@@ -8940,6 +9055,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_output_color_space_oprgb),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_limited),
+	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_hdmi_cta),
+	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_hdmi_vga),
+	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_dp_cta),
+	KUNIT_CASE(dm_test_output_color_space_default_rgb_full_hdmi_cta),
+	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_auto_hdmi_cta),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc),
 	KUNIT_CASE(dm_test_output_color_space_default_ycbcr709_y_only),
 	KUNIT_CASE(dm_test_output_color_space_default_ycbcr601),
-- 
2.55.0

