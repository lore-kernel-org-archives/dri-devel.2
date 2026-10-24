Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D092606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=DwVKWf+J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A260510E661;
	Sat, 24 Oct 2026 22:59:13 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9643710E367;
 Sat, 24 Oct 2026 16:33:53 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jBlnr02JYzKnD2;
 Sat, 24 Oct 2026 18:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792859632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1q4PEJ9Ha8yWvuIOTCB6Gv/7mKOEEFzQYswHidxd2A=;
 b=DwVKWf+J2Gpv46E4apgmk77QEzRsi3uP2vXOJvYFQ3v0AKm0yrvDw4zMnkdmnTcqHSGYTn
 GGZvG3Gctn27el7bTJ/tQ3QZMnmRmHONieUi+o7J2QyBYpohd4V8/+2ya7x/q/rSYe3Tup
 N0QyORRbMguCuQQMEtQZB69KiUlNpC/RKzV4iYkqmIZN4k0dHcqjOij4hlVi3/5BwxhT2k
 DDEE6tCbvyHHfqVBrU/Ruxls6QIxabAbsHXrKFtkAtAW5k4JOwAVMUPvv3rfJGHPte5rjU
 J9ChtaY1kBrMjGH0aL7N+BIRKDeNSIFvHcgxaxB4hBFHx2wnQN+cKsTdKaLCMg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com,
 "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: Add KUnit tests for the eDP/LVDS
 native mode fallback
Date: Sat, 24 Oct 2026 17:33:47 +0100
Message-ID: <20261024163347.2413649-3-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024163347.2413649-1-hugo@hsal.es>
References: <74c73b6f-a6b3-4652-8da1-b5c46ae58809@amd.com>
 <20261024163347.2413649-1-hugo@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBlnr02JYzKnD2
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Leave only a scaled mode in connector->modes and put the larger native
mode in the encoder, as a size-limited probe does. On eDP and LVDS,
create_stream_for_sink() must build a stream with the native timing and
the scaled mode as its source size. On HDMI it must keep the first mode
in the list as the timing

When the list also has a mode of the native size with a different
timing, eDP must use that mode and not the encoder's copy

The fallback must stay off when the list has a preferred mode, without
an EDID, and when the encoder's copy has no clock

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../tests/amdgpu_dm_connector_test.c          | 226 +++++++++++++++++-
 1 file changed, 224 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index d291ae40ca1d0..af71ca660bfea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4181,7 +4181,8 @@ struct dm_test_stream_ctx {
 	struct drm_display_mode *mode;
 };
 
-static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
+static struct dm_test_stream_ctx *
+dm_test_stream_ctx_alloc_type(struct kunit *test, int connector_type)
 {
 	struct dm_test_stream_ctx *ctx;
 	struct device *dev;
@@ -4202,7 +4203,7 @@ static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
 	KUNIT_ASSERT_EQ(test,
 		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
 				    &dm_test_connector_funcs,
-				    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
+				    connector_type, NULL), 0);
 
 	ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
@@ -4229,6 +4230,11 @@ static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
 	return ctx;
 }
 
+static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
+{
+	return dm_test_stream_ctx_alloc_type(test, DRM_MODE_CONNECTOR_DisplayPort);
+}
+
 /**
  * dm_test_create_stream_fake_sink_success - Test a stream is built from a fake sink
  * @test: The KUnit test context
@@ -4547,6 +4553,215 @@ static void dm_test_create_stream_hdmi_vsif(struct kunit *test)
 	dc_sink_release(sink);
 }
 
+enum dm_test_native {
+	/*
+	 * The list also keeps a 3840x2400 mode at half the native clock, as if
+	 * mode_valid had rejected the native timing and no limit applied
+	 */
+	DM_TEST_NATIVE_LISTED = BIT(0),
+	/* The scaled mode is the preferred one */
+	DM_TEST_NATIVE_PREFERRED = BIT(1),
+	DM_TEST_NATIVE_NO_CLOCK = BIT(2),
+	DM_TEST_NATIVE_NO_EDID = BIT(3),
+};
+
+/*
+ * Build a stream after a probe with size limits below the native mode, such as
+ * fbdev emulation's. That probe leaves only a 1920x1200 scaled mode in the
+ * connector's mode list, while the encoder keeps the 3840x2400 native mode.
+ * @flags is a mask of enum dm_test_native
+ */
+static struct dc_stream_state *
+dm_test_native_mode_stream(struct kunit *test, int connector_type, unsigned int flags)
+{
+	static const u8 edid[EDID_LENGTH];
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc_type(test, connector_type);
+	struct amdgpu_encoder *aenc;
+	struct dc_stream_state *stream;
+	struct drm_display_mode *native;
+
+	aenc = drmm_kzalloc(ctx->drm, sizeof(*aenc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aenc);
+	KUNIT_ASSERT_EQ(test, drmm_encoder_init(ctx->drm, &aenc->base, NULL,
+						DRM_MODE_ENCODER_TMDS, NULL), 0);
+	KUNIT_ASSERT_EQ(test, drm_connector_attach_encoder(&ctx->aconnector->base, &aenc->base), 0);
+
+	native = &aenc->native_mode;
+	native->clock = 592500;
+	native->hdisplay = 3840;
+	native->hsync_start = 3888;
+	native->hsync_end = 3920;
+	native->htotal = 4000;
+	native->vdisplay = 2400;
+	native->vsync_start = 2403;
+	native->vsync_end = 2409;
+	native->vtotal = 2469;
+	/* Cached by the first, unlimited probe */
+	drm_mode_copy(&ctx->aconnector->freesync_vid_base, native);
+
+	drm_mode_copy(ctx->mode, native);
+	ctx->mode->hdisplay = 1920;
+	ctx->mode->vdisplay = 1200;
+	drm_mode_set_crtcinfo(ctx->mode, CRTC_INTERLACE_HALVE_V);
+	dm_test_stream_add_mode(test, ctx, flags & DM_TEST_NATIVE_PREFERRED ?
+				DRM_MODE_TYPE_PREFERRED : 0);
+
+	/* After the scaled mode, so that taking the first mode can't pass */
+	if (flags & DM_TEST_NATIVE_LISTED) {
+		struct drm_display_mode *listed = drm_mode_duplicate(ctx->drm, ctx->mode);
+
+		KUNIT_ASSERT_NOT_NULL(test, listed);
+		listed->hdisplay = native->hdisplay;
+		listed->vdisplay = native->vdisplay;
+		listed->clock /= 2;
+		drm_mode_set_crtcinfo(listed, CRTC_INTERLACE_HALVE_V);
+		list_add_tail(&listed->head, &ctx->aconnector->base.modes);
+	}
+	ctx->dm_state->scaling = RMX_FULL;
+
+	if (flags & DM_TEST_NATIVE_NO_CLOCK)
+		native->clock = 0;
+	if (!(flags & DM_TEST_NATIVE_NO_EDID)) {
+		ctx->aconnector->drm_edid = drm_edid_alloc(edid, sizeof(edid));
+		KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->drm_edid);
+	}
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	drm_edid_free(ctx->aconnector->drm_edid);
+	ctx->aconnector->drm_edid = NULL;
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	return stream;
+}
+
+/* Expect the stream to be driven with the 1920x1200 mode left in the list */
+static void dm_test_expect_first_mode(struct kunit *test, struct dc_stream_state *stream)
+{
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 1200);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_native_mode_pruned_edp - Test eDP gets native timing
+ * @test: The KUnit test context
+ *
+ * The scaled mode must still be driven with the panel's native timing, kept in
+ * the encoder
+ */
+static void dm_test_create_stream_native_mode_pruned_edp(struct kunit *test)
+{
+	struct dc_stream_state *stream =
+		dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.pix_clk_100hz, 5925000);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_native_mode_pruned_lvds - Test LVDS gets native timing
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_native_mode_pruned_lvds(struct kunit *test)
+{
+	struct dc_stream_state *stream =
+		dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_LVDS, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.pix_clk_100hz, 5925000);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_native_mode_pruned_hdmi - Test HDMI uses the first mode
+ * @test: The KUnit test context
+ *
+ * On a connector that is not a panel, mode_valid may have dropped the native
+ * mode, so the first mode left in the list must drive the timing
+ */
+static void dm_test_create_stream_native_mode_pruned_hdmi(struct kunit *test)
+{
+	dm_test_expect_first_mode(test,
+				  dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_HDMIA, 0));
+}
+
+/**
+ * dm_test_create_stream_native_size_listed_edp - Test eDP prefers a listed mode
+ * @test: The KUnit test context
+ *
+ * When the mode list still has a mode of the native size, that mode's timing
+ * must drive the panel instead of the encoder's copy, which mode_valid may
+ * have rejected
+ */
+static void dm_test_create_stream_native_size_listed_edp(struct kunit *test)
+{
+	struct dc_stream_state *stream =
+		dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
+					   DM_TEST_NATIVE_LISTED);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.pix_clk_100hz, 2962500);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_native_preferred_edp - Test a listed preferred mode
+ * wins on eDP
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_native_preferred_edp(struct kunit *test)
+{
+	dm_test_expect_first_mode(test,
+				  dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
+							     DM_TEST_NATIVE_LISTED |
+							     DM_TEST_NATIVE_PREFERRED));
+}
+
+/**
+ * dm_test_create_stream_native_mode_no_clock_edp - Test an empty native mode
+ * isn't used
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_get_native_mode() zeroes the clock and then copies only a
+ * preferred mode at the head of probed_modes. When there is none, the size
+ * left in the encoder is stale and must not pick a listed mode
+ */
+static void dm_test_create_stream_native_mode_no_clock_edp(struct kunit *test)
+{
+	dm_test_expect_first_mode(test,
+				  dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
+							     DM_TEST_NATIVE_LISTED |
+							     DM_TEST_NATIVE_NO_CLOCK));
+}
+
+/**
+ * dm_test_create_stream_native_mode_no_edid_edp - Test the fallback needs an
+ * EDID
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_native_mode_no_edid_edp(struct kunit *test)
+{
+	dm_test_expect_first_mode(test,
+				  dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
+							     DM_TEST_NATIVE_LISTED |
+							     DM_TEST_NATIVE_NO_EDID));
+}
+
 /* Tests for amdgpu_dm_connector_detect() */
 
 /*
@@ -10248,6 +10463,13 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_create_stream_dp_vsc_colorimetry),
 	KUNIT_CASE(dm_test_create_stream_dp_colorimetry_quirk),
 	KUNIT_CASE(dm_test_create_stream_hdmi_vsif),
+	KUNIT_CASE(dm_test_create_stream_native_mode_pruned_edp),
+	KUNIT_CASE(dm_test_create_stream_native_mode_pruned_lvds),
+	KUNIT_CASE(dm_test_create_stream_native_mode_pruned_hdmi),
+	KUNIT_CASE(dm_test_create_stream_native_size_listed_edp),
+	KUNIT_CASE(dm_test_create_stream_native_preferred_edp),
+	KUNIT_CASE(dm_test_create_stream_native_mode_no_clock_edp),
+	KUNIT_CASE(dm_test_create_stream_native_mode_no_edid_edp),
 	/* amdgpu_dm_connector_detect */
 	KUNIT_CASE(dm_test_detect_force_on),
 	KUNIT_CASE(dm_test_detect_force_on_digital),
-- 
2.55.0

