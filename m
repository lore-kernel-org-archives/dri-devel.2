Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92BBC79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04F010EA3C;
	Tue,  8 Sep 2026 07:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="aDAFj4hp";
	dkim-atps=neutral
X-Greylist: delayed 5854 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 11:52:52 UTC
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7808310E7B6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:52:52 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdlnG5W8fz2hl;
 Mon,  7 Sep 2026 13:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1788781970;
 bh=D1pSM86rIzxqNVYpPYuzveYIC0zPnHexxjocqXZTpH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aDAFj4hp80TaiAHf7Ag1+lasWUwmW4r1rpn5aowjP4cTSlpPBi+tzHbbhpe0qT10G
 ZdllgYKxSgASV48ZN4AH4W86yVa0jOum03fwXCGCvZSs+LParipKnHkORjXcE1IGRX
 +H0potcLhivRN0ljfUrpBImMy6xs5u5fQxUP4FL00IoI0erI4bJdbMnyHvSjChtpZF
 ebs3Fk1cVwrwoseZl7ucMK1I+YqOoTGBj3IirIi5pWa3EY+0XXUj85HxqbU7pu5wsz
 mzx5rZnd1O2xIBYwRJc8r9V3EZcU7AoXYwNwftmeZR81aaWWeWJT21sAB100+lVmK4
 p4y8ypgy5A8kQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hdlnG0P3yz1pL; Mon,  7 Sep 2026 13:52:50 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/amd/display: support HDMI 1.4 3D modes on HDMI
 connectors
Date: Mon,  7 Sep 2026 13:52:27 +0200
Message-ID: <20260907115229.64477-2-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907115229.64477-1-adrian.betschart@cinemaone.ch>
References: <20260907115229.64477-1-adrian.betschart@cinemaone.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

Allow the stereo modes drm_edid derives from a sink's HDMI VSDB on
HDMI connectors, and drive them the way a 2D stream is driven: the
source (compositor or media player) lays both views out in the frame
itself - side by side, top and bottom, or the doubled frame-packing
timing with the 45-line active space between the eyes - and the only
3D-specific output is the HDMI vendor infoframe that tells the sink
how the frame is laid out.

Keep the DC timing at TIMING_3D_FORMAT_NONE for all of them. Any DC
stereo timing format, including the SW_PACKED variants, makes the
hardware treat the surface as two views: the pipe is split and both
view addresses point at the same surface, so the whole frame ends up
in each half of the output. The new vsif_3d_format stream field
carries the layout to mod_build_hf_vsif_infopacket() instead, so the
VSIF is right and stays right when the freesync code rebuilds it for
ALLM.

Frame packing needs the doubled CRTC timing; pass CRTC_STEREO_DOUBLE
wherever amdgpu_dm recomputes the CRTC fields itself.

Limit stereo_allowed to native HDMI connectors: on the DP-to-HDMI
converter paths link validation rejects the 3D timings.

Tested on a Radeon RX 7600 (DCN 3.2.1) driving a JVC DLA-RS4100
projector through an HDFury VRROOM, with Kodi rendering the packed
frames: frame packing, top-and-bottom and side-by-side at
1920x1080p24, RGB 12 bpc, all engage the projector's 3D mode with
correct per-eye geometry and eye assignment (checked with per-eye
test patterns through shutter glasses).

Two paths in create_stream_for_sink() would otherwise replace what the
mode carries: decide_crtc_timing_for_drm_display_mode() copies the
native CRTC timing over a mode with matching clock and totals or when
scaling is on, which for frame packing is the doubled timing, and
amdgpu_dm_is_freesync_video_mode() can match a stereo mode whose base
timing equals the FreeSync base mode and swap in the 2D mode, dropping
the 3D flags. A stereo mode keeps its own CRTC timing and is never a
FreeSync video mode; KUnit cases cover both.

Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 54 ++++++++++++-
 .../tests/amdgpu_dm_connector_test.c          | 80 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  7 ++
 .../display/modules/info_packet/info_packet.c |  3 +
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0e71ba498..aa3f47632 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -851,6 +851,25 @@ STATIC_IFN_KUNIT bool adjust_colour_depth_from_display_info(
 }
 EXPORT_IF_KUNIT(adjust_colour_depth_from_display_info);
 
+/*
+ * 3D layout to announce in the HDMI vendor infoframe for a DRM 3D mode. The
+ * stream timing itself stays 2D (see fill_stream_properties_from_drm_display_mode).
+ */
+static enum dc_timing_3d_format amdgpu_dm_vsif_3d_format(unsigned int mode_flags)
+{
+	switch (mode_flags & DRM_MODE_FLAG_3D_MASK) {
+	case DRM_MODE_FLAG_3D_FRAME_PACKING:
+		return TIMING_3D_FORMAT_SW_FRAME_PACKING;
+	case DRM_MODE_FLAG_3D_TOP_AND_BOTTOM:
+		return TIMING_3D_FORMAT_TB_SW_PACKED;
+	case DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF:
+	case DRM_MODE_FLAG_3D_SIDE_BY_SIDE_FULL:
+		return TIMING_3D_FORMAT_SBS_SW_PACKED;
+	default:
+		return TIMING_3D_FORMAT_NONE;
+	}
+}
+
 STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
@@ -887,7 +906,15 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	 */
 	timing_out->pixel_encoding = requested_encoding;
 
+	/*
+	 * The source packs both views into the frame itself (side-by-side,
+	 * top-and-bottom, or the doubled frame-packing timing), so the display
+	 * core scans it out as a plain 2D stream and only the HDMI vendor
+	 * infoframe tells the sink how the frame is laid out. Any DC stereo
+	 * timing format would make the hardware treat the surface as two views.
+	 */
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
+	stream->vsif_3d_format = amdgpu_dm_vsif_3d_format(mode_in->flags);
 	timing_out->display_color_depth = amdgpu_dm_convert_color_depth_from_display_info(
 		connector,
 		(timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420),
@@ -992,6 +1019,15 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
 {
+	/*
+	 * A stereo mode has to go out at its own timing: frame packing's CRTC
+	 * timing is the doubled one, and a side-by-side or top-and-bottom mode
+	 * scaled to the native timing would announce a layout the sink cannot
+	 * pair with what it receives.
+	 */
+	if (drm_mode->flags & DRM_MODE_FLAG_3D_MASK)
+		return;
+
 	if (scale_enabled || (
 	    native_mode->clock == drm_mode->clock &&
 	    native_mode->htotal == drm_mode->htotal &&
@@ -1120,6 +1156,10 @@ bool amdgpu_dm_is_freesync_video_mode(const struct drm_display_mode *mode,
 	if (!high_mode || !mode)
 		return false;
 
+	/* a stereo mode is never one of the inserted FreeSync video modes */
+	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
+		return false;
+
 	timing_diff = high_mode->vtotal - mode->vtotal;
 
 	if (high_mode->clock == 0 || high_mode->clock != mode->clock ||
@@ -1451,6 +1491,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct dc_sink *sink = NULL;
 
 	drm_mode_init(&mode, drm_mode);
+	/* frame packing scans out both views plus the active space in one frame */
+	if (mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING)
+		drm_mode_set_crtcinfo(&mode, CRTC_STEREO_DOUBLE);
 	memset(&saved_mode, 0, sizeof(saved_mode));
 
 	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
@@ -1530,7 +1573,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	}
 
 	if (recalculate_timing)
-		drm_mode_set_crtcinfo(&saved_mode, 0);
+		drm_mode_set_crtcinfo(&saved_mode,
+				      (saved_mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING) ?
+				      CRTC_STEREO_DOUBLE : 0);
 
 	/*
 	 * If scaling is enabled and refresh rate didn't change
@@ -2449,7 +2494,9 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	if (!test_mode)
 		goto fail;
 
-	drm_mode_set_crtcinfo(test_mode, 0);
+	drm_mode_set_crtcinfo(test_mode,
+			      (test_mode->flags & DRM_MODE_FLAG_3D_FRAME_PACKING) ?
+			      CRTC_STEREO_DOUBLE : 0);
 
 	stream = amdgpu_dm_create_validate_stream_for_sink(connector, test_mode,
 						 to_dm_connector_state(connector->state),
@@ -3143,7 +3190,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->dc_link = link;
 	aconnector->base.interlace_allowed = false;
 	aconnector->base.doublescan_allowed = false;
-	aconnector->base.stereo_allowed = false;
+	/* HDMI 1.4 3D only; DP-to-HDMI converters reject the timings in link validation */
+	aconnector->base.stereo_allowed = connector_type == DRM_MODE_CONNECTOR_HDMIA;
 	aconnector->base.dpms = DRM_MODE_DPMS_OFF;
 	aconnector->hpd.hpd = AMDGPU_HPD_NONE; /* not used */
 	aconnector->audio_inst = -1;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 76334fb84..396e91013 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1430,6 +1430,46 @@ static void dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 0);
 }
 
+/**
+ * dm_test_decide_crtc_timing_keeps_stereo_mode - A stereo mode keeps its own CRTC timing
+ * @test: The KUnit test context
+ */
+static void dm_test_decide_crtc_timing_keeps_stereo_mode(struct kunit *test)
+{
+	struct drm_display_mode drm_mode = {};
+	struct drm_display_mode native_mode = {};
+
+	/* The native mode is the 2D twin of the frame-packed one: same base timing ... */
+	native_mode.clock = 74250;
+	native_mode.htotal = 2750;
+	native_mode.vtotal = 1125;
+	native_mode.crtc_clock = 74250;
+	native_mode.crtc_hdisplay = 1920;
+	native_mode.crtc_vdisplay = 1080;
+	native_mode.crtc_htotal = 2750;
+	native_mode.crtc_vtotal = 1125;
+
+	/* ... so it matches, but the stereo mode's CRTC timing is the doubled one and must stay */
+	drm_mode.clock = 74250;
+	drm_mode.hdisplay = 1920;
+	drm_mode.vdisplay = 1080;
+	drm_mode.hsync_start = 2558;
+	drm_mode.hsync_end = 2602;
+	drm_mode.htotal = 2750;
+	drm_mode.vsync_start = 1084;
+	drm_mode.vsync_end = 1089;
+	drm_mode.vtotal = 1125;
+	drm_mode.flags = DRM_MODE_FLAG_3D_FRAME_PACKING;
+	drm_mode_set_crtcinfo(&drm_mode, CRTC_STEREO_DOUBLE);
+	KUNIT_ASSERT_EQ(test, drm_mode.crtc_vdisplay, 2205);
+
+	decide_crtc_timing_for_drm_display_mode(&drm_mode, &native_mode, false);
+
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_vdisplay, 2205);
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_vtotal, 2250);
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_clock, 148500);
+}
+
 /* Tests for amdgpu_dm_connector_funcs_reset() */
 
 static const struct drm_connector_funcs dm_test_connector_funcs = {
@@ -2293,6 +2333,44 @@ static void dm_test_is_freesync_video_mode_match(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector));
 }
 
+/**
+ * dm_test_is_freesync_video_mode_rejects_stereo - A stereo mode with matching timing returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_is_freesync_video_mode_rejects_stereo(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode candidate = {};
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	/* Cached high mode acts as reference */
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	aconnector->freesync_vid_base.clock = 148500;
+	aconnector->freesync_vid_base.hdisplay = 1920;
+	aconnector->freesync_vid_base.vdisplay = 1080;
+	aconnector->freesync_vid_base.hsync_start = 2008;
+	aconnector->freesync_vid_base.hsync_end = 2052;
+	aconnector->freesync_vid_base.htotal = 2200;
+	aconnector->freesync_vid_base.vsync_start = 1084;
+	aconnector->freesync_vid_base.vsync_end = 1089;
+	aconnector->freesync_vid_base.vtotal = 1125;
+
+	candidate.clock = 148500;
+	candidate.hdisplay = 1920;
+	candidate.vdisplay = 1080;
+	candidate.hsync_start = 2008;
+	candidate.hsync_end = 2052;
+	candidate.htotal = 2200;
+	candidate.vsync_start = 1084;
+	candidate.vsync_end = 1089;
+	candidate.vtotal = 1125;
+	candidate.flags = DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector));
+}
+
 /**
  * dm_test_is_freesync_video_mode_no_match - Test mismatched mode returns false
  * @test: The KUnit test context
@@ -8468,6 +8546,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_decide_crtc_timing_matching_mode),
 	KUNIT_CASE(dm_test_decide_crtc_timing_no_copy),
 	KUNIT_CASE(dm_test_decide_crtc_timing_no_crtc_clock),
+	KUNIT_CASE(dm_test_decide_crtc_timing_keeps_stereo_mode),
 	/* amdgpu_dm_connector_funcs_reset */
 	KUNIT_CASE(dm_test_funcs_reset_sets_defaults),
 	KUNIT_CASE(dm_test_funcs_reset_edp_abm_level),
@@ -8521,6 +8600,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_is_freesync_video_mode_null_mode),
 	KUNIT_CASE(dm_test_is_freesync_video_mode_match),
 	KUNIT_CASE(dm_test_is_freesync_video_mode_no_match),
+	KUNIT_CASE(dm_test_is_freesync_video_mode_rejects_stereo),
 	/* update_subconnector_property */
 	KUNIT_CASE(dm_test_update_subconnector_dp_with_sink),
 	KUNIT_CASE(dm_test_update_subconnector_dp_no_sink),
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 934ae381e..e6fd75b87 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -235,6 +235,13 @@ struct dc_stream_state {
 
 	enum view_3d_format view_format;
 
+	/**
+	 * @vsif_3d_format: 3D layout announced in the HDMI vendor infoframe when
+	 * the source packs both views into the frame itself and the timing is
+	 * therefore left at TIMING_3D_FORMAT_NONE.
+	 */
+	enum dc_timing_3d_format vsif_3d_format;
+
 	bool use_vsc_sdp_for_colorimetry;
 	bool ignore_msa_timing_param;
 
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 32b697f46..13478b8bd 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -536,6 +536,9 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		format = stream->timing.timing_3d_format;
 		if (stream->view_format == VIEW_3D_FORMAT_NONE)
 			format = TIMING_3D_FORMAT_NONE;
+		/* a 2D scanout of a frame the source packed itself */
+		if (format == TIMING_3D_FORMAT_NONE)
+			format = stream->vsif_3d_format;
 
 		if (stream->timing.hdmi_vic != 0
 				&& stream->timing.h_total >= 3840
-- 
2.43.0

