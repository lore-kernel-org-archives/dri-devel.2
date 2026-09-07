Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7F9C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239EC10EA4D;
	Tue,  8 Sep 2026 07:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="oD/6lwNf";
	dkim-atps=neutral
X-Greylist: delayed 491 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 10:15:23 UTC
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3248B10E753
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:15:23 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdjR538Wmzq8b;
 Mon,  7 Sep 2026 12:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1788775617;
 bh=zkVn1mTqiQPg1HIrNqylrZy//1NdkfS7RjgFs8gMWv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oD/6lwNfqVL3f/74v0o7mz99bym3DwgddTtoYJ/+t3ZJNowUJpVxAE/gv16AtUQ1B
 ru9qgrgoDujfLhlelGSrwB0XLU9ToEwPdGKte/NUSECL5UywCc6Ic0OLLC2hzU+hDS
 jw6wUxQW847FB6sqdUdzZLyFJVkuoWSOMnUAAjpXKhGVkcFkC49tGhc3gCUX3tHBgn
 YFS30yp6Q9f6bPZuBpS7PjKIgmJey3mfzkU3e1/9QgLX9aM3vNRvKXzA9Kc5ddDxfi
 pGN7lCEebuO6Kede5/+zwgRx2r5xbZLdtFhZePADXj2mQci0iVjrmRL8Yzotb2KXLA
 LKzf2O+e0Y5yQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hdjR45MHXzYr2; Mon,  7 Sep 2026 12:06:56 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/amd/display: support HDMI 1.4 3D modes on HDMI
 connectors
Date: Mon,  7 Sep 2026 12:06:24 +0200
Message-ID: <20260907100626.54465-2-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
References: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
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

Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 41 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  7 ++++
 .../display/modules/info_packet/info_packet.c |  3 ++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0e71ba498..7a2beb175 100644
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
@@ -1451,6 +1478,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct dc_sink *sink = NULL;
 
 	drm_mode_init(&mode, drm_mode);
+	/* frame packing scans out both views plus the active space in one frame */
+	if (mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING)
+		drm_mode_set_crtcinfo(&mode, CRTC_STEREO_DOUBLE);
 	memset(&saved_mode, 0, sizeof(saved_mode));
 
 	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
@@ -1530,7 +1560,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	}
 
 	if (recalculate_timing)
-		drm_mode_set_crtcinfo(&saved_mode, 0);
+		drm_mode_set_crtcinfo(&saved_mode,
+				      (saved_mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING) ?
+				      CRTC_STEREO_DOUBLE : 0);
 
 	/*
 	 * If scaling is enabled and refresh rate didn't change
@@ -2449,7 +2481,9 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 	if (!test_mode)
 		goto fail;
 
-	drm_mode_set_crtcinfo(test_mode, 0);
+	drm_mode_set_crtcinfo(test_mode,
+			      (test_mode->flags & DRM_MODE_FLAG_3D_FRAME_PACKING) ?
+			      CRTC_STEREO_DOUBLE : 0);
 
 	stream = amdgpu_dm_create_validate_stream_for_sink(connector, test_mode,
 						 to_dm_connector_state(connector->state),
@@ -3143,7 +3177,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->dc_link = link;
 	aconnector->base.interlace_allowed = false;
 	aconnector->base.doublescan_allowed = false;
-	aconnector->base.stereo_allowed = false;
+	/* HDMI 1.4 3D only; DP-to-HDMI converters reject the timings in link validation */
+	aconnector->base.stereo_allowed = connector_type == DRM_MODE_CONNECTOR_HDMIA;
 	aconnector->base.dpms = DRM_MODE_DPMS_OFF;
 	aconnector->hpd.hpd = AMDGPU_HPD_NONE; /* not used */
 	aconnector->audio_inst = -1;
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

