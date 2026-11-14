Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734EB606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljYVFWv5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C11210E412;
	Sat, 14 Nov 2026 23:09:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4BC10E097;
 Sat, 14 Nov 2026 23:09:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACC434607C;
 Sat, 14 Nov 2026 23:09:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794697757;
 b=Dt9JvrgQttCxk8rJb0L//IR5ljcY2mylHNtiiM6fT6F4txVH2MMmis5oLN6k/uqVHeqn
 8UC4exTaBsyMk2OTORR3F+carBksEPgr749t/a7dOHoiFyKlXtpZajJfTSnNRyYeuOu6B
 rZCtaDlUpdLylXbjgTEr7kAhWuICJtEzuvoRPtyXWfTI3BmPwhq4C/xETTPHSrycFHNYS
 FIdMPhFwwXK1edR8g/n8miSs1w07JUcwtKHZ4kQBC35Yd+HsdSz/u0ga4AMdDpOxrsvHK
 otXRotlgxjCd5KkS2APPLywb9OvnN+e4wYajsLFqJoKF2/b+XIk1CG3aC97/zoA5EVQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794697757;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=R/8zAodhlbJD/d+uXfe85VLUlA+MAtmTujiyuxwBgJM=;
 b=RIt8yQ8cIvrrjRGuwUDF5QJoyZMYip50pSKH5dw9nFGQmXkklxtnRWwMyVZw3sO0s9aZ
 zYRfHxqXhM+5QHB+VGBKy3Hsi/T3nami4qOYeSCJ1Usjbk/wPshk10TCBRkZLPO12hGZU
 cyjOlTu/6BCphY2fbyHGcq86jFzPDtJkef/bgGzxOoD/BhxW1kbLVVVKY4gJsWkOKfvMP
 NJXRrFAVQXSAj3btNmMIQmlJZw2EJ4nVLl/4BBJOhkXpDgOZmDRJjIxfqOTN4kLBpKElL
 koSA5oBg7TeFACY81x8rV35QBdO4e0eP9rJs0GQR8HkDQfe0GoXDTNUg7BdPv/S3xkg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9426B1F000CA;
 Sat, 14 Nov 2026 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794697757;
 bh=R/8zAodhlbJD/d+uXfe85VLUlA+MAtmTujiyuxwBgJM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ljYVFWv5TxDyTMJ8knJ0Ht/zyrxWhN0IulTLOHCj118z+4S+RFM+yB01a0LUhgYbk
 jEZgAmtJ/ENe2Z5/0ONYE1OrrmQkO3MJ0xOotbMnfOqdzTsRxpVodXU203YGH5GPBo
 +WEdg21vo0bIIprvXlRmedhNLlXuJ7MEMDc8RCxWI21PF0URTnWEPbaWP+ebni4tJe
 Njg5QhFn9qGNBKP62cQeqhTepfwqrtyKlthmxOaTqfjP4qPYyPvPjYpSrAdwy1+NnV
 WaQa8FWQKyRPrfu7G6eQyYA2mIXu9p3suuQUOg/bRCo8rf5mpA0M8a2HOlP8vV7pjB
 Ebr5Iy2A0oc7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 61F7F49ECF;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Sat, 14 Nov 2026 23:09:17 +0000
Subject: [PATCH 6/8] drm/amd/display: Pick the FreeSync video config for
 the new stream's sink
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-amdgpu-modes-four-v1-6-f11e2a6cd407@hsal.es>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8860; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=K1OqMu2z0cS5OKNcUtjzHIpeJClxFpuOC0WXXrEQz9E=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn68kohk5o4VXfumTEz13P3WF+8ET+c9+HZjSlaK6
 tf/00KeLzPsKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgIlEnWJkeP8mqlkg4E+P
 yuL2PQd1Ep7/mz7PS2vxkd5dnpqrq282rGRk2N11vlpwVeRHpYz9NgEOR9wYN90VWZL0pfGMRIU
 bm1cBAwCzxEzp
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

dm_update_crtc_state() picks the fixed refresh config for a FreeSync
video mode in its first pass, while it removes the old stream, and
create_stream_for_sink() picks that mode's timing in the second pass,
for the new stream's sink. The two answers agree only because neither
lookup depends on the sink yet. An upcoming patch makes them depend on
it, and atomic_check doesn't hold mode_config.mutex, so a hotplug can
swap dc_sink between the two passes

Move the choice to dm_set_freesync_video_config(), called whenever a
stream is added, and ask about new_stream->sink. A CRTC that the commit
turns off no longer gets the fixed config

A DPMS off commit now only clears the fixed config, and the DPMS on
commit, which adds the stream again, sets it. Before, the DPMS on
commit inherited it through the duplicated CRTC state. A CRTC turned on
straight into a FreeSync video mode now gets the fixed config too, which
the old code never set

This only applies with the amdgpu.freesync_video=1 module parameter,
which is off by default

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Before this patch, a CRTC turned on straight into a FreeSync video mode
never got the fixed refresh config, since the first pass sets it only
in a commit with an old stream. That looks like a bug from commit
6f59f229f8ed ("drm/amd/display: Skip modeset for front porch change"),
but I haven't confirmed it on hardware. Was leaving it unset intended?
If not, I can split the fix out into its own patch with a Fixes tag

dm_set_freesync_video_config() reads new_stream->sink, which
dc_stream_state marks deprecated. The stream holds the only reference
to the sink it was built for, and keeping a second one in dm_crtc_state
would need its own retain and release on duplicate and destroy. I can
do that, or have amdgpu_dm_create_validate_stream_for_sink() return the
sink, if you'd rather not read the field
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 39 +++++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  3 ++
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 58 ++++++++++++++++++++++
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d67384eba1553..706a63b93ef6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5516,6 +5516,33 @@ STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(do_aquire_global_lock);
 
+/*
+ * Use the fixed refresh config for a FreeSync video mode other than its base.
+ * create_stream_for_sink() picked @new_stream's timing for new_stream->sink,
+ * so decide for that sink too, even if a hotplug swapped dc_sink after the
+ * old stream was built. dc_stream_state marks sink deprecated, but
+ * dm_update_crtc_state() keeps no other record of the sink the stream was
+ * built for
+ */
+STATIC_IFN_KUNIT void
+dm_set_freesync_video_config(struct amdgpu_dm_connector *aconnector,
+			     struct dm_crtc_state *dm_new_crtc_state,
+			     const struct dc_stream_state *new_stream)
+{
+	const struct drm_display_mode *mode = &dm_new_crtc_state->base.mode;
+	struct drm_display_mode *high_mode;
+
+	if (!amdgpu_freesync_vid_mode ||
+	    !amdgpu_dm_is_freesync_video_mode(mode, aconnector, new_stream->sink))
+		return;
+
+	high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false,
+							    new_stream->sink);
+	if (high_mode && !drm_mode_equal(mode, high_mode))
+		amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
+}
+EXPORT_IF_KUNIT(dm_set_freesync_video_config);
+
 STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 					  struct drm_atomic_commit *state,
 					  struct drm_crtc *crtc,
@@ -5664,15 +5691,6 @@ STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
 
 			goto skip_modeset;
-		} else if (amdgpu_freesync_vid_mode && aconnector &&
-			   amdgpu_dm_is_freesync_video_mode(&new_crtc_state->mode,
-						  aconnector, aconnector->dc_sink)) {
-			struct drm_display_mode *high_mode;
-
-			high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false,
-									    aconnector->dc_sink);
-			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
-				amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -5735,6 +5753,9 @@ STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			}
 
 			*needs_dc_state_realloc = true;
+
+			dm_set_freesync_video_config(aconnector, dm_new_crtc_state,
+						     new_stream);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 97a74178513a9..926f1794d24e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1286,6 +1286,9 @@ void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
 int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
 int do_aquire_global_lock(struct drm_device *dev,
 			  struct drm_atomic_commit *state);
+void dm_set_freesync_video_config(struct amdgpu_dm_connector *aconnector,
+				  struct dm_crtc_state *dm_new_crtc_state,
+				  const struct dc_stream_state *new_stream);
 int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			 struct drm_atomic_commit *state,
 			 struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index b9272b28f53c7..fab6df40ed989 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3213,6 +3213,63 @@ static void dm_test_aquire_global_lock_waits_commit(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/**
+ * dm_test_freesync_video_config_no_old_stream - Test the fixed config needs no old stream
+ * @test: The KUnit test context
+ *
+ * A DPMS off commit clears the fixed refresh config while it removes the old
+ * stream, so the DPMS on commit has no old stream and starts from an inactive
+ * config. A 50 Hz FreeSync video mode of a 1080p60 base must get the fixed
+ * config back from the new stream alone, and the base itself must not get it
+ */
+static void dm_test_freesync_video_config_no_old_stream(struct kunit *test)
+{
+	uint saved_vid_mode = amdgpu_freesync_vid_mode;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *base, *mode;
+	struct dm_crtc_state *crtc_state;
+	struct dc_stream_state *stream;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	base = &aconnector->freesync_vid_base;
+	base->clock = 148500;
+	base->hdisplay = 1920;
+	base->hsync_start = 2008;
+	base->hsync_end = 2052;
+	base->htotal = 2200;
+	base->vdisplay = 1080;
+	base->vsync_start = 1084;
+	base->vsync_end = 1089;
+	base->vtotal = 1125;
+
+	crtc_state->freesync_config.state = VRR_STATE_INACTIVE;
+	mode = &crtc_state->base.mode;
+	drm_mode_copy(mode, base);
+
+	amdgpu_freesync_vid_mode = 1;
+
+	dm_set_freesync_video_config(aconnector, crtc_state, stream);
+	KUNIT_EXPECT_EQ(test, (int)crtc_state->freesync_config.state,
+			(int)VRR_STATE_INACTIVE);
+
+	mode->vsync_start += 225;
+	mode->vsync_end += 225;
+	mode->vtotal += 225;
+	dm_set_freesync_video_config(aconnector, crtc_state, stream);
+	KUNIT_EXPECT_EQ(test, (int)crtc_state->freesync_config.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+	KUNIT_EXPECT_EQ(test, crtc_state->freesync_config.fixed_refresh_in_uhz, 50000000U);
+
+	amdgpu_freesync_vid_mode = saved_vid_mode;
+}
+
 /**
  * dm_test_update_crtc_state_unchanged - Test unchanged state needs no validation
  * @test: The KUnit test context
@@ -5359,6 +5416,7 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_aquire_global_lock_no_crtc),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
+	KUNIT_CASE(dm_test_freesync_video_config_no_old_stream),
 	KUNIT_CASE(dm_test_update_crtc_state_unchanged),
 	KUNIT_CASE(dm_test_update_plane_state_detached),
 	KUNIT_CASE(dm_test_mod_power_update_streams_empty),

-- 
2.56.0


