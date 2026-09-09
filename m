Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF33C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7ED10F26E;
	Wed,  9 Sep 2026 20:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="OSLZ1Pns";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 09 Sep 2026 20:05:35 UTC
Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46E210E57F
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:05:35 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=3xBxnjBhziVXcwVHkmcYSv0+f/Vew5xWxclwpFprSyQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788984333; v=1; x=1789589133;
 b=OSLZ1Pns1t/J6fIS4HAuEtboHsa5INSFV8KVkETeXJORU+gA8+euwJ2b2NxMzo/0oie6l29W
 B6gSo1rIOv7A7Bt2HU8QXZj8zvVogHxWYDarFFBBBADVwKcEiOVcNK/Tz1ElN2WfGDiC82p2ZzK
 grj2A2RcsTePK/Xo88ImLIQw=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 2deb3a81c0726452;
 Wed, 09 Sep 2026 19:59:26 +0000
X-Mizu-Trace-ID: 2deb3a81c0726452
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: amd-gfx@lists.freedesktop.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Alan Liu <HaoPing.Liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: only allow freesync on a VRR_ENABLED crtc
Date: Wed,  9 Sep 2026 12:59:05 -0700
Message-ID: <20260909195906.3584191-1-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.55.0
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

VRR-capable sinks set allow_freesync even with VRR_ENABLED=0, letting
FPO stretch frames during UCLK switches. On a Navi 33 driving 4K120
through a DP-HDMI PCON, a 40fps compositor limiter then runs at 37fps.
This surfaced after commit d49086491bcb ("drm/amd/display: Adjust
freesync pcon whitelist").

Allow frame stretching only for VRR_STATE_ACTIVE_VARIABLE. Store the
proposed permission in the private DC state so TEST_ONLY and failed
checks cannot change the shared stream. Apply changed permissions at
commit and force full DC validation, including native DP and eDP.

Fixes: 7eaef1163b82 ("drm/amd/display: set allow_freesync parameter in DM")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +++
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  6 ++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  9 ++++--
 .../dml21_wrapper/dml21_translation_helper.c  |  9 ++++--
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 .../resource/dcn32/dcn32_resource_helpers.c   | 10 ++++--
 10 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f49cc198fb0d..09c088b878bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3835,6 +3835,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 	unsigned long flags;
 	u32 target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
+	bool allow_freesync = acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
 	bool cursor_update = false;
 	bool pflip_present = false;
 	bool immediate_flip = false;
@@ -4146,6 +4147,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
+		if (acrtc_state->update_type == UPDATE_TYPE_FULL &&
+		    allow_freesync != acrtc_state->stream->allow_freesync)
+			bundle->stream_update.allow_freesync = &allow_freesync;
 		update_planes_and_stream_adapter(dm->dc,
 					 acrtc_state->update_type,
 					 planes_count,
@@ -5413,6 +5417,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	struct dc_stream_state *new_stream;
 	struct amdgpu_device *adev = dm->adev;
 	int ret = 0;
+	bool allow_freesync, old_allow_freesync;
 
 	/*
 	 * TODO Move this code into dm_crtc_atomic_check once we get rid of dc_validation_set
@@ -5668,6 +5673,27 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	amdgpu_dm_get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
+	allow_freesync = dm_new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
+	old_allow_freesync = dm_old_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
+
+	/* Keep the proposed FreeSync permission in the private DC state. */
+	if (dm_new_crtc_state->stream != dm_old_crtc_state->stream ||
+	    old_allow_freesync != allow_freesync) {
+		ret = dm_atomic_get_state(state, &dm_state);
+		if (ret)
+			goto fail;
+
+		if (!dc_state_set_stream_allow_freesync(dm_state->context,
+							dm_new_crtc_state->stream,
+							allow_freesync)) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		/* DML must re-evaluate FPO when the permission changes. */
+		*lock_and_validation_needed = true;
+	}
+
 	return ret;
 
 fail:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 281c6cec9f4b..9f40064d13c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -253,7 +253,6 @@ void amdgpu_dm_update_freesync_state_on_stream(
 	new_crtc_state->vrr_infopacket = vrr_infopacket;
 
 	new_stream->vrr_infopacket = vrr_infopacket;
-	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
 	/*
 	 * HDMI ALLM: when Gaming-VRR is active (VRR_EN=1) and the sink
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ebbd81995c38..6064cc992d91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3175,6 +3175,10 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
 		if (stream_update->mst_bw_update)
 			su_flags->bits.mst_bw = 1;
 
+		if (stream_update->allow_freesync &&
+		    *stream_update->allow_freesync != stream_update->stream->allow_freesync)
+			su_flags->bits.fams_changed = 1;
+
 		if (stream_update->stream->freesync_on_desktop &&
 			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 1e4fe2f941ca..382858b6c1da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -425,6 +425,7 @@ enum dc_status dc_state_add_stream(
 	}
 
 	state->streams[state->stream_count] = stream;
+	state->stream_status[state->stream_count].allow_freesync_valid = false;
 	dc_stream_retain(stream);
 	state->stream_count++;
 
@@ -746,6 +747,36 @@ struct dc_stream_status *dc_state_get_stream_status(
 	return status.stream_count > 0 ? status.stream_status[0] : NULL;
 }
 
+bool dc_state_get_stream_allow_freesync(const struct dc_state *state,
+					const struct dc_stream_state *stream)
+{
+	unsigned int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		if (state->streams[i] == stream &&
+		    state->stream_status[i].allow_freesync_valid)
+			return state->stream_status[i].allow_freesync;
+	}
+
+	return stream->allow_freesync;
+}
+
+bool dc_state_set_stream_allow_freesync(struct dc_state *state,
+					const struct dc_stream_state *stream, bool allow_freesync)
+{
+	unsigned int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		if (state->streams[i] == stream) {
+			state->stream_status[i].allow_freesync = allow_freesync;
+			state->stream_status[i].allow_freesync_valid = true;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 enum mall_stream_type dc_state_get_pipe_subvp_type(const struct dc_state *state,
 		const struct pipe_ctx *pipe_ctx)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
index acf461225e9d..40ad063cec09 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
@@ -81,4 +81,10 @@ struct dc_get_status_options;
 enum dc_status dc_state_get_status(struct dc_state_status *status,
 	const struct dc_get_status_options *options);
 
+bool dc_state_get_stream_allow_freesync(const struct dc_state *state,
+					const struct dc_stream_state *stream);
+
+bool dc_state_set_stream_allow_freesync(struct dc_state *state,
+					const struct dc_stream_state *stream, bool allow_freesync);
+
 #endif /* _DC_STATE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 934ae381e730..14d8da9f15e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -62,6 +62,9 @@ struct dc_stream_status {
 	bool is_abm_supported;
 	struct mall_stream_config mall_stream_config;
 	bool fpo_in_use;
+	/* Proposed permission for validation, without modifying the stream. */
+	bool allow_freesync;
+	bool allow_freesync_valid;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b5bd1358fdfd..a816e47153ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -844,7 +844,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 			continue;
 
 		if (dc_state_get_pipe_subvp_type(context, drr_pipe) == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
-				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable || drr_pipe->stream->vrr_active_fixed)) {
+				(dc_state_get_stream_allow_freesync(context, drr_pipe->stream) ||
+				 drr_pipe->stream->vrr_active_variable ||
+				 drr_pipe->stream->vrr_active_fixed)) {
 			drr_found = true;
 			break;
 		}
@@ -3444,7 +3446,10 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
 				uint32_t height = subvp_high_refresh_list.res[i].height;
 
 				if (dcn32_check_native_scaling_for_res(pipe, width, height)) {
-					if ((context->stream_count == 1 && !pipe->stream->allow_freesync) || context->stream_count > 1) {
+					if ((context->stream_count == 1 &&
+					     !dc_state_get_stream_allow_freesync(context,
+										 pipe->stream)) ||
+					    context->stream_count > 1) {
 						allow = true;
 						break;
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 3c25de54d55b..031f90955b95 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -125,6 +125,7 @@ static unsigned int calc_vblank_nom_lines(const struct dc_stream_state *stream,
 }
 
 static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
+		const struct dc_state *context,
 		struct dc_stream_state *stream,
 		struct pipe_ctx *otg_master_pipe,
 		struct dml2_context *dml_ctx)
@@ -166,7 +167,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->drr_config.enabled = stream->ignore_msa_timing_param;
 	timing->drr_config.drr_active_variable = stream->vrr_active_variable;
 	timing->drr_config.drr_active_fixed = stream->vrr_active_fixed;
-	timing->drr_config.disallowed = !stream->allow_freesync;
+	timing->drr_config.disallowed = !dc_state_get_stream_allow_freesync(context, stream);
 
 	/* limit min refresh rate to DC cap */
 	min_hardware_refresh_in_uhz = stream->timing.min_refresh_in_uhz;
@@ -923,6 +924,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 	struct dml2_display_cfg *dml_dispcfg = &dml_ctx->v21.display_config;
 	unsigned int plane_count = 0;
 	struct pipe_ctx *otg_master_pipe;
+	struct dml2_timing_cfg *timing;
 
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
 
@@ -952,7 +954,10 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
-		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], otg_master_pipe, dml_ctx);
+		timing = &dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing;
+		populate_dml21_timing_config_from_stream_state(timing, context,
+							       context->streams[stream_index],
+							       otg_master_pipe, dml_ctx);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], otg_master_pipe);
 		populate_dml21_writeback_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].writeback, context->streams[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index dbb8bb7fc20d..5333c4cc9eba 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2152,7 +2152,7 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
 	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(context))
 		return false;
 
-	if (!context->streams[0]->allow_freesync)
+	if (!dc_state_get_stream_allow_freesync(context, context->streams[0]))
 		return false;
 
 	if (context->streams[0]->vrr_active_variable && (dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE))
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index 602a0e4e5dc0..a86d3111703f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -579,7 +579,7 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(fpo_candidate_stream, fpo_vactive_margin_us, refresh_rate))
 		return NULL;
 
-	if (!fpo_candidate_stream->allow_freesync)
+	if (!dc_state_get_stream_allow_freesync(context, fpo_candidate_stream))
 		return NULL;
 
 	if (fpo_candidate_stream->vrr_active_variable &&
@@ -673,7 +673,9 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 				non_subvp_pipes++;
 				drr_psr_capable = (drr_psr_capable || dcn32_is_psr_capable(pipe));
 				if (pipe->stream->ignore_msa_timing_param &&
-						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
+				    (dc_state_get_stream_allow_freesync(context, pipe->stream) ||
+				     pipe->stream->vrr_active_variable ||
+				     pipe->stream->vrr_active_fixed)) {
 					drr_pipe_found = true;
 				}
 			}
@@ -734,7 +736,9 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 				non_subvp_pipes++;
 				vblank_psr_capable = (vblank_psr_capable || dcn32_is_psr_capable(pipe));
 				if (pipe->stream->ignore_msa_timing_param &&
-						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
+				    (dc_state_get_stream_allow_freesync(context, pipe->stream) ||
+				     pipe->stream->vrr_active_variable ||
+				     pipe->stream->vrr_active_fixed)) {
 					drr_pipe_found = true;
 				}
 			}
-- 
2.55.0

