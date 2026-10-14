Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB33CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA03112162;
	Thu, 15 Oct 2026 07:56:53 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAB710FFD8;
 Wed, 14 Oct 2026 22:30:48 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j4mBG6Jw6zMlDm;
 Thu, 15 Oct 2026 00:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792017046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iH6VgiGj5KrB23VvD5r/W6aj7P6EbpDpdOeMlYANEW8=;
 b=m8V6J7tuZz+jCiDBwrq1wUb0NwR+l7hMxFKi5VUDHJ52vz+ZKV6WhvFDdlqnShja/l0M0h
 gghMMqza4Nbs/S5NE8FwCvfMSRsOSyaALAOfjf5CVfBDoIq61343ltIbO3eKOf7rrV4hhB
 LeDJBFamz18VvmtQFTjOmwyWI8hYkFAIx+A7ympaL1kmMqDsDA7o5u3GGh1v3UiYT1G4C+
 QBqT/kQE6JPgOPXwie8BGbfD6b1ofEpcvoTvCvUnbnoD/j+cTfbED4WAPFmzPuo1N8+sU8
 PWqKYUJSg6/jWSfON9N+Vg+RiA/RFmnbB3xAKMn2Bf1z4/jHDuA6SmSxabdTGg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 2/2] drm/amd/display: Add KUnit tests for the eDP/LVDS native
 mode fallback
Date: Wed, 14 Oct 2026 23:30:41 +0100
Message-ID: <20261014223041.171317-3-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014223041.171317-1-hugo@hsal.es>
References: <20261014223041.171317-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j4mBG6Jw6zMlDm
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Leave only a scaled mode in connector->modes and put the larger native
mode in the encoder, as a size-limited probe does. On eDP and LVDS,
create_stream_for_sink() must build a stream with the native timing and
the scaled mode as its source size. On HDMI it must keep the first mode
in the list as the timing

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../tests/amdgpu_dm_connector_test.c          | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 56fd133bc..55e2c3849 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4547,6 +4547,115 @@ static void dm_test_create_stream_hdmi_vsif(struct kunit *test)
 	dc_sink_release(sink);
 }
 
+/*
+ * Build a stream after a probe with size limits below the native mode, such as
+ * fbdev emulation's. That probe leaves only a 1920x1200 scaled mode in the
+ * connector's mode list, while the encoder keeps the 3840x2400 native mode
+ */
+static struct dc_stream_state *
+dm_test_native_mode_pruned_stream(struct kunit *test, int connector_type)
+{
+	static const u8 edid[EDID_LENGTH];
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct amdgpu_encoder *aenc;
+	struct dc_stream_state *stream;
+	struct drm_display_mode *native;
+
+	ctx->aconnector->base.connector_type = connector_type;
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
+	dm_test_stream_add_mode(test, ctx, 0);
+	ctx->dm_state->scaling = RMX_FULL;
+
+	ctx->aconnector->drm_edid = drm_edid_alloc(edid, sizeof(edid));
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->drm_edid);
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	drm_edid_free(ctx->aconnector->drm_edid);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	return stream;
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
+		dm_test_native_mode_pruned_stream(test, DRM_MODE_CONNECTOR_eDP);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
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
+		dm_test_native_mode_pruned_stream(test, DRM_MODE_CONNECTOR_LVDS);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
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
+	struct dc_stream_state *stream =
+		dm_test_native_mode_pruned_stream(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 1200);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
+	dc_stream_release(stream);
+}
+
 /* Tests for amdgpu_dm_connector_detect() */
 
 /*
@@ -10246,6 +10355,9 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_create_stream_dp_vsc_colorimetry),
 	KUNIT_CASE(dm_test_create_stream_dp_colorimetry_quirk),
 	KUNIT_CASE(dm_test_create_stream_hdmi_vsif),
+	KUNIT_CASE(dm_test_create_stream_native_mode_pruned_edp),
+	KUNIT_CASE(dm_test_create_stream_native_mode_pruned_lvds),
+	KUNIT_CASE(dm_test_create_stream_native_mode_pruned_hdmi),
 	/* amdgpu_dm_connector_detect */
 	KUNIT_CASE(dm_test_detect_force_on),
 	KUNIT_CASE(dm_test_detect_force_on_digital),
-- 
2.55.0

