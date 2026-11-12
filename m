Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DE606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNwjDTsU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174B310FEF1;
	Thu, 12 Nov 2026 01:44:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655F510FEDB;
 Thu, 12 Nov 2026 01:43:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B5F74352A;
 Thu, 12 Nov 2026 01:43:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794447838;
 b=xscaQj1SwozCpDiOdTyZGgQ/h74hHcm+TzAVRwwpwaTetAlGZckWgWYMVsWvY/YijaB6
 OfF2x87ZIXO3PEZv7oAQSihb2+Dj51YIv0cCgl0P+f32Mk102zQNGNH2WdYtMIo4nmspB
 YGCDFTElYuTaUWjF3cZuQue/qPYerhUUuVGQQ9QRsXws0Tl5TFZJpYwc3nB7LF+8fv8cM
 0+wKFkcrjcW6aWanQQNM6i/B5r8qTFsOvpIziL8sLwPacwybV20Yq+/mwaeIx1gZimE1P
 J9ftOcagZfaTPLnc9WvbWqebfEVX35f2bdB3vYEEem4svQUwmThQnC5uHcy2fhyTClA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794447838;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=5LAdIBtLMU+eNrRFipj80nOx/1vVFfRQQoBWOxnBLXk=;
 b=He0BmS3XHp15kSvjEbDC0jZPKtul+dy8yH1zBGl7s81tbgTyp4tcZQar1LzhSuacpqpS
 nsqx6QuUuTG2uP4a+s3rDg7Y7MuetBSnC8WMJNA4nenRqk/rkIFw/nCxTlzNQLQ9LPlxa
 9oWJNiPlDeVoQSAVjYkhF8bbWvb0PFPXr1Ghnp4BHCWG/AO2FiqnQpomigjunWqSm9ycw
 eF2bzgL8gP+uSIN3xSnUJ9DUq/X7xv2fj1uZTlYW12sk3fHvIZqn/pUcrt9KScL4yo2W9
 fkcOzokfL2nMhvEz97lyd6EgXwcDNrtSmbTaYF6F8SoRWbwY7d38dwiISByuCLNDvOA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A28121F00A14;
 Thu, 12 Nov 2026 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447838;
 bh=5LAdIBtLMU+eNrRFipj80nOx/1vVFfRQQoBWOxnBLXk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=BNwjDTsUdJ+XAE8LPMgXN/hnmWhOcVKpswip4Xh4+57bNbvO9rgrZ16HwY2UPd3aV
 wVTKooUZ8IIbCzQdGQX/06/lE5IuQTrwM/vHU+MpszKZrL0geKtt2ETEi/F4DM4Crc
 SiSoB8MS4S5Tr+q3LXyaUkKqj2IXct5sSNtpUC96x41Fxf1+Kv4WkKXfjsOHVs9c1J
 tY6kgZ60gy5/P9RdDDUUMQVZSBVISMKwKSlaprYiLAdji9JkbIwD/H0rPBi96la7ua
 LwFNjP2B/aWHjVyqiKMEASFsYbAbWZL4h6KMW4s1oQiFoF6x9Z3CuMB9CJgWVeLIi9
 92taRg1F+IO3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A486B491E6;
 Thu, 12 Nov 2026 01:43:49 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 12 Nov 2026 11:43:44 +1000
Subject: [PATCH 09/19] drm/amd/display/amdgpu_dm: Use DC accessors in
 debugfs paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-amdgpu-dc-cleanup-v1-9-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20611;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=teTvwAJBoooONFPtPUVVYPA5nnxZ+ozX7no2u7o4vqw=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9RnP4KY6lRk2A0hjk/vO4GW7BF3PeBIfWRsrw
 gol5nFLHO6JAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavUZzwAKCRAMdPNZecSG
 vnwjD/9uvlOaftz4+KAFAnIIZY/P0skCmW6jyL9C8CugXKIl7JJFd9aPAdBnYmcKVcAfKuIliQJ
 HfCHucLH1HjblSB407wMJiFV3RtSSfZjV+uwSw8FvRF+Bd8K85YP1CRwbKZCfGlsYvY7wK/qx/y
 pp/qkstT5XRZ80bqnba8vtHcLiaaydatJgtct646qbX8YNwuE6egc3kqpA1ctpA//PxLyriv2Kd
 wg/b6pV6cmj54qYINmA41gcbj7nQhvomJgs1JGzPxWVm2EOZeoQXekGlhQdHAsu35NFhtBNyT/P
 5jYUi0EMLSRqWoA0dUKpZSSn21V0vWbNXQjlgKGzaTDOQEb9SSnQl7A2AAQDPU4BKHxLaSu2Ozs
 NlwD1nt2ZjzJutUQehpMG0Goq4LjPfP8xsLkwxfPeXOohzKmkwHwq82PZ1rYuPZqy2VNZ2WoIRY
 Qy6X28cWvrje04dYrFMtqib+QePBMe6fIjjW8eTrbt+87MN1f2XAa1ZNoyo+/c9HRRMfGZrBzke
 98zPdv/w9WY1bY0PRouOKzt1xH/g99bXmLnd88tZn6GcaQ8j3Ux1gLwZs0ZuvHmEdB+yi7Kn0iV
 o3H7HzlFTDyWlkyb/zyvL7gFrHV24WXvzQA6JizmCAVXeylrWng43YX4Jc+XSzlO6mKJwOEnvkR
 S+fj9ai/h567ggQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

Replace direct struct dc member dereferences with the DC accessor
layer in amdgpu_dm_debugfs.c: dmub context access, current_state and
pipe enumeration, IPS config/idle optimization reads, PSR/Panel
Replay residency queries, hwss state dumps (dc_log_hw_state,
dc_get_dcc_en_bits), the SubVP query and the debug option writes.

Add a purpose-specific setter for the eDP hotplug detection mode
(dc_set_allow_edp_hotplug_detection) instead of writing through
dc->config.

Part of making struct dc private to DC.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 123 ++++++++++-----------
 drivers/gpu/drm/amd/display/dc/core/dc_accessors.c |   6 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   7 ++
 3 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 68356cb8e4de..fddb47a32fb9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1028,9 +1028,9 @@ static int replay_capability_show(struct seq_file *m, void *data)
 		struct dc *dc = link->ctx->dc;
 
 		sink_support_replay = amdgpu_dm_link_supports_replay(link, aconnector);
-		if (dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub)
+		if (dc_get_ctx(dc)->dmub_srv && dc_get_ctx(dc)->dmub_srv->dmub)
 			driver_support_replay =
-				(bool)dc->ctx->dmub_srv->dmub->feature_caps.replay_supported;
+				(bool)dc_get_ctx(dc)->dmub_srv->dmub->feature_caps.replay_supported;
 	}
 
 	seq_printf(m, "Sink support: %s\n", str_yes_no(sink_support_replay));
@@ -1295,7 +1295,7 @@ static int max_downscale_src_width_show(struct seq_file *m, void *unused)
 	if (!link)
 		return -ENODEV;
 
-	seq_printf(m, "%d\n", link->dc->debug.max_downscale_src_width);
+	seq_printf(m, "%d\n", dc_get_debug_options(link->dc)->max_downscale_src_width);
 
 	return 0;
 }
@@ -1313,7 +1313,7 @@ static int odm_combine_segments_show(struct seq_file *m, void *unused)
 	int i, segments = -EOPNOTSUPP;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == link)
 			break;
@@ -1594,7 +1594,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -1696,7 +1696,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -1780,7 +1780,7 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -1880,7 +1880,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -1964,7 +1964,7 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2064,7 +2064,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2144,7 +2144,7 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2241,7 +2241,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2319,7 +2319,7 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2373,7 +2373,7 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2442,7 +2442,7 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2511,7 +2511,7 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
 		    pipe_ctx->stream->link == aconnector->dc_link &&
 		    pipe_ctx->stream->sink &&
@@ -2701,15 +2701,15 @@ static int ips_status_show(struct seq_file *m, void *unused)
 	struct dc *dc = adev->dm.dc;
 	struct dc_dmub_srv *dc_dmub_srv;
 
-	seq_printf(m, "IPS config: %d\n", dc->config.disable_ips);
-	seq_printf(m, "Idle optimization: %d\n", dc->idle_optimizations_allowed);
+	seq_printf(m, "IPS config: %d\n", dc_get_config(dc)->disable_ips);
+	seq_printf(m, "Idle optimization: %d\n", dc_is_idle_optimizations_allowed(dc));
 
 	if (adev->dm.idle_workqueue) {
 		seq_printf(m, "Idle workqueue - enabled: %d\n", adev->dm.idle_workqueue->enable);
 		seq_printf(m, "Idle workqueue - running: %d\n", adev->dm.idle_workqueue->running);
 	}
 
-	dc_dmub_srv = dc->ctx->dmub_srv;
+	dc_dmub_srv = dc_get_ctx(dc)->dmub_srv;
 	if (dc_dmub_srv && dc_dmub_srv->dmub) {
 		uint32_t rcg_count, ips1_count, ips2_count;
 		volatile const struct dmub_shared_state_ips_fw *ips_fw =
@@ -2752,7 +2752,7 @@ static int ips_residency_show(struct seq_file *m, void *unused)
 	mutex_lock(&adev->dm.dc_lock);
 
 	mode = IPS_RESIDENCY__IPS1_RCG;
-	if (!dc_dmub_srv_ips_query_residency_info(dc->ctx, panel_inst, &info, mode)) {
+	if (!dc_dmub_srv_ips_query_residency_info(dc_get_ctx(dc), panel_inst, &info, mode)) {
 		seq_printf(m, "ISP query failed\n");
 	} else {
 		unsigned int pct, frac;
@@ -2785,7 +2785,7 @@ static int ips_residency_cntl_set(void *data, u64 val)
 	int ret = 0;
 
 	mutex_lock(&adev->dm.dc_lock);
-	if (!dc_dmub_srv_ips_residency_cntl(dc->ctx, panel_inst, !!val))
+	if (!dc_dmub_srv_ips_residency_cntl(dc_get_ctx(dc), panel_inst, !!val))
 		ret = -EIO;
 	mutex_unlock(&adev->dm.dc_lock);
 
@@ -3231,7 +3231,7 @@ static int replay_get_state(void *data, u64 *val)
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	if (dc->idle_optimizations_allowed) {
+	if (dc_is_idle_optimizations_allowed(dc)) {
 		dc_allow_idle_optimizations(dc, false);
 		reallow_idle = true;
 	}
@@ -3263,12 +3263,12 @@ static int replay_set_residency(void *data, u64 val)
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	if (dc->idle_optimizations_allowed) {
+	if (dc_is_idle_optimizations_allowed(dc)) {
 		dc_allow_idle_optimizations(dc, false);
 		reallow_idle = true;
 	}
 
-	link->dc->link_srv->edp_replay_residency(link, &residency, is_start, PR_RESIDENCY_MODE_PHY);
+	dc_link_edp_replay_residency(link, &residency, is_start, PR_RESIDENCY_MODE_PHY);
 
 	if (reallow_idle)
 		dc_allow_idle_optimizations(dc, true);
@@ -3292,12 +3292,12 @@ static int replay_get_residency(void *data, u64 *val)
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	if (dc->idle_optimizations_allowed) {
+	if (dc_is_idle_optimizations_allowed(dc)) {
 		dc_allow_idle_optimizations(dc, false);
 		reallow_idle = true;
 	}
 
-	link->dc->link_srv->edp_replay_residency(link, &residency, false, PR_RESIDENCY_MODE_PHY);
+	dc_link_edp_replay_residency(link, &residency, false, PR_RESIDENCY_MODE_PHY);
 
 	if (reallow_idle)
 		dc_allow_idle_optimizations(dc, true);
@@ -3323,7 +3323,7 @@ static int psr_get(void *data, u64 *val)
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	if (dc->idle_optimizations_allowed) {
+	if (dc_is_idle_optimizations_allowed(dc)) {
 		dc_allow_idle_optimizations(dc, false);
 		reallow_idle = true;
 	}
@@ -3354,12 +3354,12 @@ static int psr_read_residency(void *data, u64 *val)
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	if (dc->idle_optimizations_allowed) {
+	if (dc_is_idle_optimizations_allowed(dc)) {
 		dc_allow_idle_optimizations(dc, false);
 		reallow_idle = true;
 	}
 
-	link->dc->link_srv->edp_get_psr_residency(link, &residency, PSR_RESIDENCY_MODE_PHY);
+	dc_link_edp_get_psr_residency(link, &residency, PSR_RESIDENCY_MODE_PHY);
 
 	if (reallow_idle)
 		dc_allow_idle_optimizations(dc, true);
@@ -3379,7 +3379,7 @@ static int allow_edp_hotplug_detection_get(void *data, u64 *val)
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	*val = adev->dm.dc->config.allow_edp_hotplug_detection;
+	*val = dc_get_config(adev->dm.dc)->allow_edp_hotplug_detection;
 
 	return 0;
 }
@@ -3392,7 +3392,7 @@ static int allow_edp_hotplug_detection_set(void *data, u64 val)
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	adev->dm.dc->config.allow_edp_hotplug_detection = (uint32_t) val;
+	dc_set_allow_edp_hotplug_detection(adev->dm.dc, (enum dc_hpd_enable_select)val);
 
 	return 0;
 }
@@ -3532,10 +3532,10 @@ static int dmub_trace_mask_set(void *data, u64 val)
 	u32 res;
 	int i;
 
-	if (!adev->dm.dc || !adev->dm.dc->ctx || !adev->dm.dc->ctx->dmub_srv)
+	if (!adev->dm.dc || !dc_get_ctx(adev->dm.dc) || !dc_get_ctx(adev->dm.dc)->dmub_srv)
 		return -EINVAL;
 
-	dc_dmub_srv = adev->dm.dc->ctx->dmub_srv;
+	dc_dmub_srv = dc_get_ctx(adev->dm.dc)->dmub_srv;
 	srv = dc_dmub_srv->dmub;
 	if (!srv || !srv->fw_version)
 		return -EINVAL;
@@ -3558,7 +3558,8 @@ static int dmub_trace_mask_set(void *data, u64 val)
 			break;
 		}
 
-		if (!dc_wake_and_execute_gpint(adev->dm.dc->ctx, cmd, res, NULL, DM_DMUB_WAIT_TYPE_WAIT))
+		if (!dc_wake_and_execute_gpint(dc_get_ctx(adev->dm.dc), cmd, res,
+					      NULL, DM_DMUB_WAIT_TYPE_WAIT))
 			return -EIO;
 
 		usleep_range(100, 1000);
@@ -3581,10 +3582,10 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 	u64 res = 0;
 	int i = 0;
 
-	if (!adev->dm.dc || !adev->dm.dc->ctx || !adev->dm.dc->ctx->dmub_srv)
+	if (!adev->dm.dc || !dc_get_ctx(adev->dm.dc) || !dc_get_ctx(adev->dm.dc)->dmub_srv)
 		return -EINVAL;
 
-	dc_dmub_srv = adev->dm.dc->ctx->dmub_srv;
+	dc_dmub_srv = dc_get_ctx(adev->dm.dc)->dmub_srv;
 	srv = dc_dmub_srv->dmub;
 	if (!srv || !srv->fw_version)
 		return -EINVAL;
@@ -3592,7 +3593,9 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 	while (i < 4) {
 		uint32_t response;
 
-		if (!dc_wake_and_execute_gpint(adev->dm.dc->ctx, cmd, 0, &response, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		if (!dc_wake_and_execute_gpint(dc_get_ctx(adev->dm.dc), cmd, 0,
+					      &response,
+					      DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
 			return -EIO;
 
 		raw = response;
@@ -3715,12 +3718,12 @@ static int cacp_ace_curve_area_show(struct seq_file *m, void *unused)
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	if (dc->idle_optimizations_allowed) {
+	if (dc_is_idle_optimizations_allowed(dc)) {
 		dc_allow_idle_optimizations(dc, false);
 		reallow_idle = true;
 	}
 
-	if (!dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd,
+	if (!dc_wake_and_execute_dmub_cmd(dc_get_ctx(dc), &cmd,
 					  DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY) ||
 	    cmd.cacp_get_ace_curve_area.header.ret_status)
 		ret = -EIO;
@@ -4243,11 +4246,9 @@ static ssize_t dtn_log_read(
 	if (!buf || !size)
 		return -EINVAL;
 
-	if (!dc->hwss.log_hw_state)
+	if (!dc_log_hw_state(dc, &log_ctx))
 		return 0;
 
-	dc->hwss.log_hw_state(dc, &log_ctx);
-
 	if (*pos < log_ctx.pos) {
 		size_t to_copy = log_ctx.pos - *pos;
 
@@ -4281,8 +4282,7 @@ static ssize_t dtn_log_write(
 	if (size == 0)
 		return 0;
 
-	if (dc->hwss.log_hw_state)
-		dc->hwss.log_hw_state(dc, NULL);
+	dc_log_hw_state(dc, NULL);
 
 	return size;
 }
@@ -4459,18 +4459,17 @@ static int capabilities_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct dc *dc = adev->dm.dc;
-	bool mall_supported = dc->caps.mall_size_total;
-	bool subvp_supported = dc->caps.subvp_fw_processing_delay_us;
+	bool mall_supported = dc_get_caps(dc)->mall_size_total;
+	bool subvp_supported = dc_get_caps(dc)->subvp_fw_processing_delay_us;
 	unsigned int mall_in_use = false;
 	unsigned int subvp_in_use = false;
 
-	struct hubbub *hubbub = dc->res_pool->hubbub;
+	struct hubbub *hubbub = dc_get_res_pool(dc)->hubbub;
 
 	if (hubbub && hubbub->funcs->get_mall_en)
 		hubbub->funcs->get_mall_en(hubbub, &mall_in_use);
 
-	if (dc->cap_funcs.get_subvp_en)
-		subvp_in_use = dc->cap_funcs.get_subvp_en(dc, dc->current_state);
+	subvp_in_use = dc_get_subvp_en(dc, dc_get_current_state(dc));
 
 	seq_printf(m, "mall supported: %s, enabled: %s\n",
 			   mall_supported ? "yes" : "no", mall_in_use ? "yes" : "no");
@@ -4490,7 +4489,7 @@ static int dp_force_sst_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
 
-	adev->dm.dc->debug.set_mst_en_for_sst = val;
+	dc_get_debug_options_mutable(adev->dm.dc)->set_mst_en_for_sst = val;
 
 	return 0;
 }
@@ -4499,7 +4498,7 @@ static int dp_force_sst_get(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = data;
 
-	*val = adev->dm.dc->debug.set_mst_en_for_sst;
+	*val = dc_get_debug_options(adev->dm.dc)->set_mst_en_for_sst;
 
 	return 0;
 }
@@ -4514,7 +4513,7 @@ static int dp_ignore_cable_id_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
 
-	adev->dm.dc->debug.ignore_cable_id = val;
+	dc_get_debug_options_mutable(adev->dm.dc)->ignore_cable_id = val;
 
 	return 0;
 }
@@ -4523,7 +4522,7 @@ static int dp_ignore_cable_id_get(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = data;
 
-	*val = adev->dm.dc->debug.ignore_cable_id;
+	*val = dc_get_debug_options(adev->dm.dc)->ignore_cable_id;
 
 	return 0;
 }
@@ -4538,7 +4537,7 @@ static int visual_confirm_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
 
-	adev->dm.dc->debug.visual_confirm = (enum visual_confirm)val;
+	dc_get_debug_options_mutable(adev->dm.dc)->visual_confirm = (enum visual_confirm)val;
 
 	return 0;
 }
@@ -4551,7 +4550,7 @@ static int visual_confirm_get(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = data;
 
-	*val = adev->dm.dc->debug.visual_confirm;
+	*val = dc_get_debug_options(adev->dm.dc)->visual_confirm;
 
 	return 0;
 }
@@ -4570,9 +4569,9 @@ static int skip_detection_link_training_set(void *data, u64 val)
 	struct amdgpu_device *adev = data;
 
 	if (val == 0)
-		adev->dm.dc->debug.skip_detection_link_training = false;
+		dc_get_debug_options_mutable(adev->dm.dc)->skip_detection_link_training = false;
 	else
-		adev->dm.dc->debug.skip_detection_link_training = true;
+		dc_get_debug_options_mutable(adev->dm.dc)->skip_detection_link_training = true;
 
 	return 0;
 }
@@ -4585,7 +4584,7 @@ static int skip_detection_link_training_get(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = data;
 
-	*val = adev->dm.dc->debug.skip_detection_link_training;
+	*val = dc_get_debug_options(adev->dm.dc)->skip_detection_link_training;
 
 	return 0;
 }
@@ -4610,7 +4609,7 @@ static ssize_t dcc_en_bits_read(
 	const uint32_t rd_buf_size = 32;
 	uint32_t result = 0;
 	int offset = 0;
-	int num_pipes = dc->res_pool->pipe_count;
+	int num_pipes = dc_get_res_pool(dc)->pipe_count;
 	int *dcc_en_bits;
 	int i, r;
 
@@ -4618,13 +4617,11 @@ static ssize_t dcc_en_bits_read(
 	if (!dcc_en_bits)
 		return -ENOMEM;
 
-	if (!dc->hwss.get_dcc_en_bits) {
+	if (!dc_get_dcc_en_bits(dc, dcc_en_bits)) {
 		kfree(dcc_en_bits);
 		return 0;
 	}
 
-	dc->hwss.get_dcc_en_bits(dc, dcc_en_bits);
-
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 	if (!rd_buf) {
 		kfree(dcc_en_bits);
@@ -4714,7 +4711,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_disable_hpd", 0644, root, adev,
 				   &disable_hpd_ops);
 
-	if (adev->dm.dc->caps.ips_support) {
+	if (dc_get_caps(adev->dm.dc)->ips_support) {
 		debugfs_create_file_unsafe("amdgpu_dm_ips_status", 0644, root, adev,
 					   &ips_status_fops);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c b/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
index 15a203fbae81..2803471d7333 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
@@ -57,6 +57,12 @@ const struct dc_config *dc_get_config(const struct dc *dc)
 	return &dc->config;
 }
 
+void dc_set_allow_edp_hotplug_detection(struct dc *dc,
+		enum dc_hpd_enable_select hpd_select)
+{
+	dc->config.allow_edp_hotplug_detection = hpd_select;
+}
+
 const struct dc_debug_options *dc_get_debug_options(const struct dc *dc)
 {
 	return &dc->debug;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9592a95544ea..082435846ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2488,6 +2488,13 @@ const struct dc_caps *dc_get_caps(const struct dc *dc);
 /* Configuration captured at dc_create() time. Read-only. */
 const struct dc_config *dc_get_config(const struct dc *dc);
 
+/*
+ * Select which eDP connectors get hotplug detection enabled; see
+ * enum dc_hpd_enable_select. Runtime configurable (debugfs).
+ */
+void dc_set_allow_edp_hotplug_detection(struct dc *dc,
+		enum dc_hpd_enable_select hpd_select);
+
 /* Debug overrides (module parameters, debugfs). Read-only view. */
 const struct dc_debug_options *dc_get_debug_options(const struct dc *dc);
 

-- 
2.56.0


