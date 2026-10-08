Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB3CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B516610E752;
	Thu,  8 Oct 2026 07:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="P519o/up";
	dkim-atps=neutral
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54FC10E752
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1791444273; bh=R454WeZIZx0fGBpfO5iMULnx8b+XzjR8Ok5RQcB8RTc=;
 h=From:To:Cc:Subject:Date;
 b=P519o/upraRlw8GwrAYHJofOy3EcZ2lOgkVeZxjiLpU9TZq1jxOmkeFk32KVy7Lx4
 j6vBki/5tXiKsbqZnq8jJu8hqPRVLpteCmNAbsx+gOT7cD1hb5FGMASqh/yPptAnT0
 18T2VKKIXCtMo+nDWD2hBy3JKrpA+DL9Ga5FA6Nk=
Received: from localhost.localdomain ([116.128.244.169])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 4428A614; Thu, 08 Oct 2026 15:17:02 +0800
X-QQ-mid: xmsmtpt1791443822t0oj1sozp
Message-ID: <tencent_3F4F1469A115C5112FD7CA3CC4A9CF6F6C07@qq.com>
X-QQ-XMAILINFO: MpYZqmNm/7vMf3GiqJ+kHOJuLpcOSc6M+xpzqjWmbsKM/BqgvyDuGg7xW/GR33
 6ZG1JnDHTixk7j3Mj5vxdul1kx37G9WjGBsZAmPBoc0ZPHQB24ZXAnFTGtcvkvXZBud/MHBlmsrW
 ATVssq3w1p4OaR/XqVRCApPP/k9TIV1oUqEHVo65M363Xe98Jxm3pdyb1+A+DFZ4u8KHuDdOd9Hx
 0mQKm+TLyWEwPBbUCdogJHXIVoBGDt8tDz+G69pxsI2P+bnOEdp7Z98uIJM9h3AqT7qEDu7GZ0/X
 y8eG7sQt2DapiKv0lC0Wux/V3BSX/bmp86fX5SgNBQKjNYrRxJuIuaZ8s7PB22oKR55bc97nmX16
 4LEa4UqK/o6dpvkEmGdAU487jKzQ8v5GPE5mov2LPZCT6zKBEPXpcbLK+HQPbVk8GTUqf+kJExFM
 tmcPj8yKwOa4HcJ06vylrzQDYIjD9LcIhFGQlmzXetC+gi7/T/7k3rgmd7v2qtQFmrQe5mm/ozq3
 qG+mw2g9J3sZP2HamInRtAdy6XTUfFqDxqHhk/lVSGzjlEY3nQleBqfCZOZmq8WOlPHPXDsEMId8
 QJ+NlHrwWmSyxYcHxqWPbMMM5otSqox+o1Cj75odHjmbkXJbbPCoW30xtqIRRZKfkAvZQ3yd4vRh
 BBxEFY2ERAECZYznZOyh7MwXPg7kJ+vvxj6meNoQm+Q/VYtScgLsmrwDxW3aTpv312TN0yQ6K8CV
 Z6FenOEARhY5fu1wHl/yH30R36Gm3iQPN0x75sUB2aFtZ9MHBnwb/BeTLKNMksdPXg81aHUiimmr
 2GxWjDInqQpjI8d28vod9UrvKbC0JPYON+7GZEgksmPgfTMqfP2OqfL9zk4mpVs//USA9QD2K3LP
 fOeAS9Js7W7og9EpsQDNAt9meRLqcnkyoWo8lOoBTBmGECTcd4TiKMcS/QRYxdM3PHNhRNQP6AW8
 K22NIwwtJjJUO6KuEhytqA8782xTe4P7bZqRg+cgsxCKZyXuFymFzSxI0jESBd/Mnh39U8PIsQQY
 d1sD87dAy27rQE++bv
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: 2564278112@qq.com
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Mario Limonciello <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ray Wu <ray.wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Lu Yao <yaolu@kylinos.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/amd/display: Snapshot dm_crtc_state->stream before use
Date: Thu,  8 Oct 2026 15:16:59 +0800
X-OQ-MSGID: <20261008071700.552056-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Wang Jiang <jiangwang@kylinos.cn>

The suspend/resume path releases the DC streams and clears
dm_crtc_state->stream (dm_destroy_cached_state()) while an atomic commit
can still be in flight.  A commit that races with it therefore observes
the member becoming NULL after it has already been NULL checked, and
dereferences it again for every plane or stream update.  The fbdev
damage worker is one such commit: it is queued by the console and runs
after the workqueues are thawed during resume, which is exactly when the
display manager is tearing down and rebuilding its cached state.

Observed with the amdgpu DKMS module:

  BUG: unable to handle page fault for address: 0000000000006490
  RIP: amdgpu_dm_atomic_commit_tail+0x14c3/0x3cb0 [amdgpu_pro]
  Workqueue: events drm_fb_helper_damage_work
  Kernel panic - not syncing: amdgpu-pro 0000:04:00.0: unrecoverable failure

0x6490 is offsetof(struct dc_stream_state, abm_level), i.e. the stream
pointer read as NULL right before

  acrtc_state->stream->abm_level = acrtc_state->abm_level;

Take a single snapshot of dm_crtc_state->stream in
amdgpu_dm_commit_planes() and amdgpu_dm_enable_self_refresh(), check it
before use, and use the same snapshot for the connector stream update in
amdgpu_dm_atomic_commit_tail(), skipping the update when no stream is
attached.

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 112 ++++++++++++------
 1 file changed, 73 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 91fdf3de7202..c4c8904fea42 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3696,10 +3696,21 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 					  const struct dm_crtc_state *acrtc_state,
 					  const u64 current_ts)
 {
-	struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
-	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
-	struct amdgpu_dm_connector *aconn =
-		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
+	struct dc_stream_state *stream = acrtc_state->stream;
+	struct psr_settings *psr;
+	struct replay_settings *pr;
+	struct amdgpu_dm_connector *aconn;
+
+	/*
+	 * The stream can be cleared concurrently by the system suspend/resume
+	 * path, so make sure the snapshot we are about to dereference is valid.
+	 */
+	if (!stream || !stream->link)
+		return;
+
+	psr = &stream->link->psr_settings;
+	pr = &stream->link->replay_settings;
+	aconn = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
 	/* Decrement skip count when SR is enabled and we're doing fast updates. */
 	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
@@ -3720,10 +3731,10 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 		 */
 		if (acrtc_attach->dm_irq_params.allow_sr_entry &&
 			(current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
-			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
+			amdgpu_dm_psr_set_event(dm, stream, false,
 				psr_event_hw_programming, false);
 
-			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
+			amdgpu_dm_replay_set_event(dm, stream, false,
 				replay_event_hw_programming, false);
 		}
 	} else {
@@ -3799,6 +3810,15 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(new_pcrtc_state);
 	struct dm_crtc_state *dm_old_crtc_state =
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
+	/*
+	 * Take a single snapshot of the stream pointer and use it everywhere
+	 * below. dm_crtc_state->stream can be cleared concurrently, e.g. by the
+	 * system suspend/resume path (dm_destroy_cached_state()), so re-reading
+	 * the member after a NULL check can observe NULL and crash while writing
+	 * dc_stream_state members (see the NULL write at
+	 * offsetof(struct dc_stream_state, abm_level)).
+	 */
+	struct dc_stream_state *stream = acrtc_state->stream;
 	int planes_count = 0, vpos, hpos;
 	unsigned long flags;
 	u32 target_vblank, last_flip_vblank;
@@ -3836,12 +3856,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 	    dm_old_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE) {
 		struct dc_cursor_position cursor_position = {0};
 
-		if (!dc_stream_set_cursor_position(acrtc_state->stream,
+		if (!dc_stream_set_cursor_position(stream,
 						   &cursor_position))
 			drm_err(dev, "DC failed to disable native cursor\n");
 
 		bundle->stream_update.cursor_position =
-				&acrtc_state->stream->cursor_position;
+				&stream->cursor_position;
 	}
 
 	if (acrtc_state->active_planes == 0 &&
@@ -3919,12 +3939,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
-		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
-		    acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
+		if (stream->link->psr_settings.psr_feature_enabled ||
+		    stream->link->replay_settings.replay_feature_enabled) {
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
-					    acrtc_state->stream->link->psr_settings.psr_version ==
+					    stream->link->psr_settings.psr_version ==
 					    DC_PSR_VERSION_SU_1,
 					    &dirty_rects_changed);
 
@@ -3935,14 +3955,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			 * amdgpu_dm_crtc_vblank_control_worker() if user
 			 * pause the video during the PSR-SU was disabled.
 			 */
-			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
+			if (stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
 			    acrtc_attach->dm_irq_params.allow_sr_entry &&
 			    dirty_rects_changed) {
 				mutex_lock(&dm->dc_lock);
-				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
+				stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
 				timestamp_ns;
 				dc_exit_ips_for_hw_access(dm->dc);
-				amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
+				amdgpu_dm_psr_set_event(dm, stream, true,
 					psr_event_hw_programming, true);
 				mutex_unlock(&dm->dc_lock);
 			}
@@ -3985,7 +4005,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			amdgpu_dm_update_freesync_state_on_stream(
 				dm,
 				acrtc_state,
-				acrtc_state->stream,
+				stream,
 				dc_plane,
 				bundle->flip_addrs[planes_count].flip_timestamp_in_us);
 
@@ -4038,10 +4058,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			usleep_range(1000, 1100);
 		}
 
-		if (acrtc_state->stream) {
+		if (stream) {
 			if (acrtc_state->freesync_vrr_info_changed)
 				bundle->stream_update.vrr_infopacket =
-					&acrtc_state->stream->vrr_infopacket;
+					&stream->vrr_infopacket;
 		}
 	}
 
@@ -4063,7 +4083,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 
 	/* Update the planes if changed or disable if we don't have any. */
 	if ((planes_count || acrtc_state->active_planes == 0) &&
-		acrtc_state->stream) {
+		stream) {
 		/*
 		 * If PSR or idle optimizations are enabled then flush out
 		 * any pending work before hardware programming.
@@ -4071,10 +4091,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		if (dm->vblank_control_workqueue)
 			flush_workqueue(dm->vblank_control_workqueue);
 
-		bundle->stream_update.stream = acrtc_state->stream;
+		bundle->stream_update.stream = stream;
 		if (new_pcrtc_state->mode_changed) {
-			bundle->stream_update.src = acrtc_state->stream->src;
-			bundle->stream_update.dst = acrtc_state->stream->dst;
+			bundle->stream_update.src = stream->src;
+			bundle->stream_update.dst = stream->dst;
 		}
 
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -4083,18 +4103,18 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			 * already modified the stream in place.
 			 */
 			bundle->stream_update.gamut_remap =
-				&acrtc_state->stream->gamut_remap_matrix;
+				&stream->gamut_remap_matrix;
 			bundle->stream_update.output_csc_transform =
-				&acrtc_state->stream->csc_color_matrix;
+				&stream->csc_color_matrix;
 			bundle->stream_update.out_transfer_func =
-				&acrtc_state->stream->out_transfer_func;
+				&stream->out_transfer_func;
 			bundle->stream_update.lut3d_func =
-				(struct dc_3dlut *) acrtc_state->stream->lut3d_func;
+				(struct dc_3dlut *) stream->lut3d_func;
 			bundle->stream_update.func_shaper =
-				(struct dc_transfer_func *) acrtc_state->stream->func_shaper;
+				(struct dc_transfer_func *) stream->func_shaper;
 		}
 
-		acrtc_state->stream->abm_level = acrtc_state->abm_level;
+		stream->abm_level = acrtc_state->abm_level;
 		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
@@ -4106,7 +4126,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		if (amdgpu_dm_is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 			dc_stream_adjust_vmin_vmax(
-				dm->dc, acrtc_state->stream,
+				dm->dc, stream,
 				&acrtc_attach->dm_irq_params.vrr_params.adjust);
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
@@ -4114,7 +4134,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		update_planes_and_stream_adapter(dm->dc,
 					 acrtc_state->update_type,
 					 planes_count,
-					 acrtc_state->stream,
+					 stream,
 					 &bundle->stream_update,
 					 bundle->surface_updates);
 		updated_planes_and_streams = true;
@@ -5045,6 +5065,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
+		struct dc_stream_state *stream = NULL;
 		bool abm_changed, hdr_changed, scaling_changed, output_color_space_changed = false;
 
 		memset(&stream_update, 0, sizeof(stream_update));
@@ -5065,6 +5086,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 							     dm_old_con_state);
 
 		if ((new_con_state->hdmi.broadcast_rgb != old_con_state->hdmi.broadcast_rgb) &&
+			dm_old_crtc_state->stream && dm_new_crtc_state->stream &&
 			(dm_old_crtc_state->stream->output_color_space !=
 				amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_state)))
 			output_color_space_changed = true;
@@ -5078,24 +5100,36 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		if (!scaling_changed && !abm_changed && !hdr_changed && !output_color_space_changed)
 			continue;
 
-		stream_update.stream = dm_new_crtc_state->stream;
+		/*
+		 * Take a snapshot of the stream pointer once. The member can be
+		 * cleared concurrently by the system suspend/resume path
+		 * (dm_destroy_cached_state()), so re-reading it after this point
+		 * can observe NULL and crash.
+		 */
+		stream = dm_new_crtc_state->stream;
+		if (!stream) {
+			drm_dbg_state(dev, "No stream attached to CRTC, skipping stream update\n");
+			continue;
+		}
+
+		stream_update.stream = stream;
 		if (scaling_changed) {
 			amdgpu_dm_update_stream_scaling_settings(dev, &dm_new_con_state->base.crtc->mode,
-					dm_new_con_state, dm_new_crtc_state->stream);
+					dm_new_con_state, stream);
 
-			stream_update.src = dm_new_crtc_state->stream->src;
-			stream_update.dst = dm_new_crtc_state->stream->dst;
+			stream_update.src = stream->src;
+			stream_update.dst = stream->dst;
 		}
 
 		if (output_color_space_changed) {
-			dm_new_crtc_state->stream->output_color_space
-				= amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_state);
+			stream->output_color_space
+				= amdgpu_dm_get_output_color_space(&stream->timing, new_con_state);
 
-			stream_update.output_color_space = &dm_new_crtc_state->stream->output_color_space;
+			stream_update.output_color_space = &stream->output_color_space;
 		}
 
 		if (abm_changed) {
-			dm_new_crtc_state->stream->abm_level = dm_new_crtc_state->abm_level;
+			stream->abm_level = dm_new_crtc_state->abm_level;
 
 			stream_update.abm_level = &dm_new_crtc_state->abm_level;
 		}
@@ -5105,7 +5139,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 			stream_update.hdr_static_metadata = &hdr_packet;
 		}
 
-		status = dc_stream_get_status(dm_new_crtc_state->stream);
+		status = dc_stream_get_status(stream);
 
 		if (WARN_ON(!status))
 			continue;
@@ -5133,7 +5167,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		dc_update_planes_and_stream(dm->dc,
 					    dummy_updates,
 					    status->plane_count,
-					    dm_new_crtc_state->stream,
+					    stream,
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
-- 
2.25.1

