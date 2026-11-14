Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CAD606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgiaNyRB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E7C10E1D3;
	Sat, 14 Nov 2026 23:09:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D25710E1D3;
 Sat, 14 Nov 2026 23:09:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF7EB61CF2;
 Sat, 14 Nov 2026 23:09:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794697758;
 b=z30LGqOXSimqpdbZomPUs3oUMP2zWua61K3JY9+LNWHgEILf8pWyId5oopg3QjXQGrRz
 DQ/oAdvdWjedEwwu64aNvKgvoYLFVBt2Z0JMGLuzv0hX6tRos/b3oiykoInKCh9IDFtO9
 5PEX9AhhIhb5yMzBG9jc36Nof9FOa0kA0tugdSG82085pKpXuj82hjnTmiWj8PCe42yeB
 UcIDEj99yzfkjaxFie/QmDvFgEV+ONLrRpKUQm81x7FWAjt208rfwUmxG9i194QIIAgbM
 vem+ds398zAtvwlJkFkaKP0uo/DbbVkz/l4qgOiTmPBhzRbG7vRIwpTNCTnxzwlAJKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794697758;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=G8S4/Rd0o2di5Uc8fNtiBF/zq4PTH0sEt4SYSqV7eh0=;
 b=Qaea8+vBBKnhFVjGxVOHFjVtHeZwWDn262n1G4XAcMrvuv4CZo1AMfVwCIVzmSzWxI7d
 cKkizlvQl7mdlJKk22twrpUc+TV4ZruqrrWaFUaN/76tier5sXrKWy1qXLzO4kcqxbLN7
 iwrZBA3neO7BB3LDwP3U4fL0oGoYoCkTQn/nKIHd2CoLK/j5XxoSwtKIM0lPfVzf79238
 e+b9AGhP3vI+ZkFy/R4+N++mj96cpr9Qkk4XMbVrXioB5zyiAJqo/pstcFPtiiooywCYf
 BH6tOsw6QZd8LVNidyyJNzguPYoDjpTbFdX2oN1oTRGeJFDpeir2FwJSy4ZjxCcXRQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 914E41F000C9;
 Sat, 14 Nov 2026 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794697758;
 bh=G8S4/Rd0o2di5Uc8fNtiBF/zq4PTH0sEt4SYSqV7eh0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=CgiaNyRB0t7OS2+E7ClyoI9QKpf4vHvcSBUVeECcuRsx47kXfa/uDdRwwRBwbMRBU
 jlfx3Ip4qfzf9TwaxXMG0eu7S0BUQXPPxhMlmANzStZS6JPPBqH7qOsO5jE/rBpeuQ
 4rWfAIrWxM6H7XFMjpNRhPn6+ho8O/K+SxKyKhLySC9xn8d5nRVtVZm846W7nsNWC2
 7X3R3dyyeT6kJciL6emnWO5MfWvj1/VDaofgytu3Bpp34fClQDLTmHucCRZvpEqIge
 JAPQ889vNilGdwPufKYCK5rIiytizAPuhyOGxGhQp+NTdCPFTsqfn2IPV6kbqT+rO3
 dKSRZEOujT5Fw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4C8F749ECB;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Sat, 14 Nov 2026 23:09:16 +0000
Subject: [PATCH 5/8] drm/amd/display: Pass the sink to the FreeSync and
 stream timing helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-amdgpu-modes-four-v1-5-f11e2a6cd407@hsal.es>
References: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
In-Reply-To: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17945; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=B4klbZMkoqbHogPDICxIKScPI4dweX8IN8nagdpfQmo=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn68kjjmzHF60zUVxUifub1KG2pn3jsvEZp+wpN51
 3fjrlPCG6U6SlkYxLgYZMUUWXRveDKwTJw8M6fo+RKYOaxMIEMYuDgFYCLT2RkZusUquz02TU+8
 XHTVpa3fcmGux2FHlnkrfjydeqZzgfv9jYwMr2Tj67c6ai+58+VGi6PO6vpt+0UudZ9yu7/nhce
 VQx5HGQFpuU0e
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Content-Transfer-Encoding: 7bit
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

An upcoming patch has atomic_check use the mode copies only for the sink
they were taken from. atomic_check doesn't hold mode_config.mutex, and a
hotplug can swap dc_sink at any time, so the check has to use the sink of
the stream it builds rather than read dc_sink again

Have amdgpu_dm_is_freesync_video_mode(),
amdgpu_dm_get_highest_refresh_rate_mode() and
fill_stream_properties_from_drm_display_mode() take that sink as an
argument. create_stream_for_sink() passes the sink it builds the stream
for, the probe paths pass the connector's sink, and
dm_update_crtc_state() passes dc_sink for now

Nothing reads the argument yet. No functional change

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  5 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 24 ++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  7 +++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 46 +++++++++++-----------
 4 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33c73ca9cff14..d67384eba1553 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5666,10 +5666,11 @@ STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			goto skip_modeset;
 		} else if (amdgpu_freesync_vid_mode && aconnector &&
 			   amdgpu_dm_is_freesync_video_mode(&new_crtc_state->mode,
-						  aconnector)) {
+						  aconnector, aconnector->dc_sink)) {
 			struct drm_display_mode *high_mode;
 
-			high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false);
+			high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false,
+									    aconnector->dc_sink);
 			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
 				amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 491965266b786..bddab6a462563 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -879,6 +879,7 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
 	const struct drm_connector *connector,
+	const struct dc_sink *sink,
 	const struct drm_connector_state *connector_state,
 	const struct dc_stream_state *old_stream,
 	int requested_bpc,
@@ -949,7 +950,7 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 		timing_out->hdmi_vic = hv_frame.vic;
 	}
 
-	if (aconnector && amdgpu_dm_is_freesync_video_mode(mode_in, aconnector)) {
+	if (aconnector && amdgpu_dm_is_freesync_video_mode(mode_in, aconnector, sink)) {
 		timing_out->h_addressable = mode_in->hdisplay;
 		timing_out->h_total = mode_in->htotal;
 		timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
@@ -1208,7 +1209,7 @@ amdgpu_dm_probed_freesync_vid_base_listed(struct list_head *modes,
  */
 struct drm_display_mode *
 amdgpu_dm_get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
-		bool use_probed_modes)
+		bool use_probed_modes, const struct dc_sink *sink)
 {
 	struct drm_display_mode *m_pref;
 	struct list_head *list_head = use_probed_modes ?
@@ -1241,12 +1242,13 @@ amdgpu_dm_get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 EXPORT_IF_KUNIT(amdgpu_dm_get_highest_refresh_rate_mode);
 
 bool amdgpu_dm_is_freesync_video_mode(const struct drm_display_mode *mode,
-		struct amdgpu_dm_connector *aconnector)
+		struct amdgpu_dm_connector *aconnector,
+		const struct dc_sink *sink)
 {
 	struct drm_display_mode *high_mode;
 	int timing_diff;
 
-	high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false);
+	high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false, sink);
 	if (!high_mode || !mode)
 		return false;
 
@@ -1724,9 +1726,10 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	if (aconnector && preferred_mode) {
 		recalculate_timing = amdgpu_freesync_vid_mode &&
-				 amdgpu_dm_is_freesync_video_mode(&mode, aconnector);
+				 amdgpu_dm_is_freesync_video_mode(&mode, aconnector, sink);
 		if (recalculate_timing) {
-			freesync_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false);
+			freesync_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector,
+										false, sink);
 			drm_mode_copy(&saved_mode, &mode);
 			saved_mode.picture_aspect_ratio = mode.picture_aspect_ratio;
 			drm_mode_copy(&mode, freesync_mode);
@@ -1748,11 +1751,11 @@ create_stream_for_sink(struct drm_connector *connector,
 	 */
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
-			stream, &mode, connector, con_state, NULL,
+			stream, &mode, connector, sink, con_state, NULL,
 			requested_bpc, requested_encoding, is_hdmi_ep);
 	else
 		fill_stream_properties_from_drm_display_mode(
-			stream, &mode, connector, con_state, old_stream,
+			stream, &mode, connector, sink, con_state, old_stream,
 			requested_bpc, requested_encoding, is_hdmi_ep);
 
 	/* The rest isn't needed for writeback connectors */
@@ -3282,7 +3285,7 @@ STATIC_IFN_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	 * with lower resolution than the highest refresh rate supported.
 	 */
 
-	m = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, true);
+	m = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, true, aconnector->dc_sink);
 	if (!m)
 		return 0;
 
@@ -4152,7 +4155,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				 */
 				if (!amdgpu_dm_connector->max_vfreq) {
 					struct drm_display_mode *brr_mode =
-						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector, true);
+						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector,
+											true, sink);
 
 					if (brr_mode)
 						amdgpu_dm_connector->max_vfreq =
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index ee8d7eabd7c13..7f475403ad220 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -34,6 +34,7 @@ struct amdgpu_encoder;
 struct amdgpu_i2c_adapter;
 struct dc_crtc_timing;
 struct dc_link;
+struct dc_sink;
 enum signal_type;
 struct dc_state;
 struct dc_stream_state;
@@ -124,7 +125,8 @@ void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
 				    struct dc_stream_state *stream);
 
 bool amdgpu_dm_is_freesync_video_mode(const struct drm_display_mode *mode,
-			    struct amdgpu_dm_connector *aconnector);
+			    struct amdgpu_dm_connector *aconnector,
+			    const struct dc_sink *sink);
 
 int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
 			 struct dc_info_packet *out);
@@ -135,7 +137,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 
 struct drm_display_mode *
 amdgpu_dm_get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
-			      bool use_probed_modes);
+			      bool use_probed_modes, const struct dc_sink *sink);
 
 struct amdgpu_i2c_adapter *
 amdgpu_dm_create_i2c(struct ddc_service *ddc_service, bool oem);
@@ -191,6 +193,7 @@ void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
 	const struct drm_connector *connector,
+	const struct dc_sink *sink,
 	const struct drm_connector_state *connector_state,
 	const struct dc_stream_state *old_stream,
 	int requested_bpc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 49e85aec3c665..832fce79f8acd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2407,7 +2407,7 @@ static void dm_test_highest_refresh_writeback_null(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
-	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false));
+	KUNIT_EXPECT_NULL(test, amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false, NULL));
 }
 
 /**
@@ -2424,7 +2424,7 @@ static void dm_test_highest_refresh_cached_base(struct kunit *test)
 	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
 	aconnector->freesync_vid_base.clock = 148500;
 
-	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false),
+	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false, NULL),
 			    &aconnector->freesync_vid_base);
 }
 
@@ -2453,7 +2453,7 @@ static void dm_test_highest_refresh_preferred_mode(struct kunit *test)
 	mode->vtotal = 1125;
 	list_add_tail(&mode->head, &aconnector->base.modes);
 
-	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false),
+	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false, NULL),
 			    mode);
 }
 
@@ -2525,7 +2525,7 @@ static void dm_test_highest_refresh_probed_skips_copy(struct kunit *test)
 				     2720, 1481, 241500, DRM_MODE_TYPE_PREFERRED);
 
 	KUNIT_EXPECT_PTR_EQ(test,
-			    amdgpu_dm_get_highest_refresh_rate_mode(aconnector, true),
+			    amdgpu_dm_get_highest_refresh_rate_mode(aconnector, true, NULL),
 			    mode);
 }
 
@@ -2850,7 +2850,7 @@ static void dm_test_is_freesync_video_mode_null_mode(struct kunit *test)
 	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
 	aconnector->freesync_vid_base.clock = 148500;
 
-	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_freesync_video_mode(NULL, aconnector));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_freesync_video_mode(NULL, aconnector, NULL));
 }
 
 /**
@@ -2887,7 +2887,7 @@ static void dm_test_is_freesync_video_mode_match(struct kunit *test)
 	candidate.vsync_end = 1089;
 	candidate.vtotal = 1125;
 
-	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector, NULL));
 }
 
 /**
@@ -2916,7 +2916,7 @@ static void dm_test_is_freesync_video_mode_no_match(struct kunit *test)
 	candidate.htotal = 1650;
 	candidate.vtotal = 750;
 
-	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector, NULL));
 }
 
 /* Tests for amdgpu_dm_update_cacp_caps() */
@@ -4183,7 +4183,7 @@ static void dm_test_fill_stream_borders_zeroed(struct kunit *test)
 	timing->v_border_bottom = 8;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->h_border_left, 0);
@@ -4205,7 +4205,7 @@ static void dm_test_fill_stream_rgb_defaults(struct kunit *test)
 	struct dc_crtc_timing *timing = &ctx->stream->timing;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding, (int)PIXEL_ENCODING_RGB);
@@ -4232,7 +4232,7 @@ static void dm_test_fill_stream_sync_polarity_positive(struct kunit *test)
 	ctx->mode->flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 1);
@@ -4252,7 +4252,7 @@ static void dm_test_fill_stream_sync_polarity_negative(struct kunit *test)
 	ctx->mode->flags = 0;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 0);
@@ -4282,7 +4282,7 @@ static void dm_test_fill_stream_inherits_old_stream(struct kunit *test)
 	ctx->mode->flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, old_stream, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, old_stream, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->vic, 16);
@@ -4313,7 +4313,7 @@ static void dm_test_fill_stream_timing_from_crtc(struct kunit *test)
 	ctx->mode->crtc_clock = 148500;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->h_addressable, 1920);
@@ -4341,7 +4341,7 @@ static void dm_test_fill_stream_color_depth_requested_bpc(struct kunit *test)
 	ctx->aconnector->base.display_info.bpc = 12;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 10,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 10,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
@@ -4359,7 +4359,7 @@ static void dm_test_fill_stream_content_type(struct kunit *test)
 	ctx->conn_state->content_type = DRM_MODE_CONTENT_TYPE_GRAPHICS;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)ctx->stream->content_type,
@@ -4378,7 +4378,7 @@ static void dm_test_fill_stream_aspect_ratio(struct kunit *test)
 	ctx->mode->picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->aspect_ratio,
@@ -4399,7 +4399,7 @@ static void dm_test_fill_stream_encoding_from_caller_ycbcr420(struct kunit *test
 	struct dc_crtc_timing *timing = &ctx->stream->timing;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_YCBCR420, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding,
@@ -4418,7 +4418,7 @@ static void dm_test_fill_stream_encoding_from_caller_ycbcr422(struct kunit *test
 	struct dc_crtc_timing *timing = &ctx->stream->timing;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_YCBCR422, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding,
@@ -4437,7 +4437,7 @@ static void dm_test_fill_stream_encoding_from_caller_ycbcr444(struct kunit *test
 	struct dc_crtc_timing *timing = &ctx->stream->timing;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_YCBCR444, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding,
@@ -4462,7 +4462,7 @@ static void dm_test_fill_stream_hdmi_ep_clamps_depth(struct kunit *test)
 	ctx->mode->crtc_clock = 148500;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 10,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 10,
 		PIXEL_ENCODING_RGB, true);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
@@ -4486,7 +4486,7 @@ static void dm_test_fill_stream_non_hdmi_ep_keeps_depth(struct kunit *test)
 	ctx->mode->crtc_clock = 148500;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 10,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 10,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
@@ -4520,7 +4520,7 @@ static void dm_test_fill_stream_hdmi_infoframe(struct kunit *test)
 	ctx->stream->signal = SIGNAL_TYPE_HDMI_TYPE_A;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, old_stream, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, old_stream, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	/* The HDMI block overwrote the old stream's VIC of 99 with the AVI code. */
@@ -4561,7 +4561,7 @@ static void dm_test_fill_stream_freesync_video(struct kunit *test)
 	ctx->mode->vtotal = 1125;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		&ctx->aconnector->base, NULL, ctx->conn_state, NULL, 8,
 		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->h_addressable, 1920);

-- 
2.56.0


