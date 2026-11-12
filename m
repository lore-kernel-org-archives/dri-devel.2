Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A3606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YynLZdWV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E107710FEEA;
	Thu, 12 Nov 2026 01:44:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2768110EB11;
 Thu, 12 Nov 2026 01:43:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D0936373A;
 Thu, 12 Nov 2026 01:43:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794447832;
 b=DfEU/df9Gb9xBfkm43x3Z2Xxfqe1jn2WM4u0pG+XRpgA+VeCd5fw2FXqBN1un14/zLk7
 A04faaQCP/4VaZPSpSy3oZKkRSK045ehZsdHpMHA3DV++34S5A1uCm7v2HTatfk1IyIGr
 U7a//O+iZNdTLsDo/A2o8HSJdpezDLxiGvZpIw6AylTnvAOGD3FiFC/ls4j51b9YvqwOd
 98wSoliAV1mi5EiDWm197GrrYRHzC3IXGBzws8EcHVAkkb1Jdf3AuiBk+eJw4jDrtNDCX
 SkkH1rkWs/x93Gih7bRJW0JHd111S0vDFGfR/w4DsLRsDhqQHfn2fmePaPqf8vLQWfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794447832;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=L5tf1/s9iKQNhb+4DGq0HEktvNPoLXRrCErcYFrWVnM=;
 b=svi84yoFgjxt2/wqups/DFTyuS0F8o1/ecl1qKbnooFXP/eRpUdM1acEkU5IoD9g17yO
 1YQ6wgSSFYLJX2CmqNDvy6OHU7z6oEVn97s1tY+72C4Gt68yAveYpn0gmIJD/v/Fx3EcG
 4C28UfeKgg591dDlD6rlbZv6CotrmuLq8YW+6GIMqL/NCTSzRu61/5KKfGybAf9ns2I4e
 UmYf2ONk9Yy/GCT/3Ot8xEWGtE9cE57zPu5BJJpsflNp7+pmkVEZutzqEZxMprTohePks
 kwuyQZpNLwpXqQX4E8UEpaKia8to03JBm1PrCQaJRNSMFKkDz/aPl62+NQddaIGXsVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A7D4E1F00A0D;
 Thu, 12 Nov 2026 01:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447832;
 bh=L5tf1/s9iKQNhb+4DGq0HEktvNPoLXRrCErcYFrWVnM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=YynLZdWVOrsba4kBcklhkoZHKQCqyleikYoYdqzaRXa07Z5uB3zB07wBvi+IirAKA
 zCItYlkAjPbBPORkKeF9ewbN3a/DTIHFgf/5rjvOK+cMpOxukG6cqE7lENOccUAV5w
 UaTq4f+059+63e/TNygMINx04OvB5BduJfH6nu3kGHWudrnDQq/Ho5jfLINuTMIo51
 jT4v0hqaHlb/ykiEwvuTiZWap6wJsCGTnat2k5X0+Q5svz4UsWH49v8qScsbzcOdGT
 KqRLltOMPfrh3SO2/6aM1Liv6dxLVBuBygDbAYgeZVhCdqdyQrW/FkXT3s5ZAH9wpw
 NHrHvZFcOQHdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 30976491CE;
 Thu, 12 Nov 2026 01:43:49 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 12 Nov 2026 11:43:38 +1000
Subject: [PATCH 03/19] drm/amd/display: Take struct dc in public DSC
 compute helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-amdgpu-dc-cleanup-v1-3-0fae41718ad2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9476; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=KleHrsn8jn4Xkzu0KD5D+9d34cBgi8hCZwvwMZjdwA4=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9RnOXJX+F56mjVpZLj8cC8d9xmzugcCU7L1kR
 vYlk072WcyJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavUZzgAKCRAMdPNZecSG
 vuJrD/9+LX6pwxfc0yhSLYbwSmMBPF/txBJbP95EbOIu4Nl5GGHx/MNyscz5Uy7KIHtVqZvtfkC
 QOmVK+D+ehMdhYhzSOGGT8yvPmquIcaUFP7l/L3kAm6lQFldrZJCBIAOa9ihn4hH9g60vZ8g2j4
 ZSovwJpHZXhYNElmZMd1CNH2pA1ScowNRvAn/j0EtzRpelGMllIkYrYpNhdI+94Tq0K3CbPiGgS
 t4cfW86ZJhewJLVYUS0/coGIXu5G8u5tFer0HOp9vW8rbCHuszJ51Dg9DalP4eAahh+w5PS/j61
 PMDSJnNlrPP+sDaT1E/o0B3CGBfL8aS3fBHDIgzaaJCHwKPN1ZMZd77FpczS0b621UMOWQV6MUF
 zLL1bGCgic6gcfJDsLtwywoWPFjjo84i+Jb9vv8qAVVZzAQNc1RGwJ5S+4ssnhRPilqkHxWzl/F
 EXOvE4qZXqMpwk4jm+VFgtbmgyd6KkayOaIxzxh76uaXmFq0wr84nAhCEfQQsldkEdw4UhCZotT
 hwbdOtSv6tkj59TYxRgVarmY6ykW3NUEN4u1iW7p1Gm0c53qLGNZNrbJD8LI6/+7tD1pKQKxZX3
 BxPfBg9KeF9mkX+GWb7WjwXb+gZJQPnsZxcHQzATRBD17gk0jsv9rK/8xl0X78ER7jAggiZzxSJ
 pw8zioAjuOP97kg==
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

dc_dsc_compute_bandwidth_range() and dc_dsc_compute_config() took a
display_stream_compressor pointer that every caller fetched with
dc->res_pool->dscs[0]. The implementations immediately derive the dc
from dsc->ctx->dc anyway, so take struct dc directly and let DC pick
the DSC engine internally.

This removes all res_pool->dscs[0] dereferences from amdgpu_dm and is
a step towards not exposing struct dc outside DC.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 12 ++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 14 +++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dsc.h                 |  4 ++--
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c             | 17 +++++++++++++++--
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index dee06fefdd1d..d334391bcbae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1229,7 +1229,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 	if (edp_max_bpp_x16 < edp_min_bpp_x16)
 		edp_min_bpp_x16 = edp_max_bpp_x16;
 
-	if (dc_dsc_compute_bandwidth_range(dc->res_pool->dscs[0],
+	if (dc_dsc_compute_bandwidth_range(dc,
 				dc->debug.dsc_min_slice_height_override,
 				edp_min_bpp_x16, edp_max_bpp_x16,
 				dsc_caps,
@@ -1238,7 +1238,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 				&bw_range)) {
 
 		if (bw_range.max_kbps < link_bw_in_kbps) {
-			if (dc_dsc_compute_config(dc->res_pool->dscs[0],
+			if (dc_dsc_compute_config(dc,
 					dsc_caps,
 					&dsc_options,
 					0,
@@ -1253,7 +1253,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 		}
 	}
 
-	if (dc_dsc_compute_config(dc->res_pool->dscs[0],
+	if (dc_dsc_compute_config(dc,
 				dsc_caps,
 				&dsc_options,
 				link_bw_in_kbps,
@@ -1309,7 +1309,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 
 	} else if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
 		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
-			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+			if (dc_dsc_compute_config(dc,
 						dsc_caps,
 						&dsc_options,
 						link_bandwidth_kbps,
@@ -1339,7 +1339,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 			if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
 					max_supported_bw_in_kbps > 0 &&
 					dsc_max_supported_bw_in_kbps > 0)
-				if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+				if (dc_dsc_compute_config(dc,
 						dsc_caps,
 						&dsc_options,
 						dsc_max_supported_bw_in_kbps,
@@ -1368,7 +1368,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 
 		if ((timing_bw_in_kbps > link_bandwidth_kbps && dsc_sink_bw_in_kbps > 0) ||
 		    (dsc_policy.enable_dsc_when_not_needed || dsc_options.force_dsc_when_not_needed)) {
-			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
+			if (dc_dsc_compute_config(dc,
 					dsc_caps,
 					&dsc_options,
 					dsc_sink_bw_in_kbps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5697645ef7cc..a3877ef767ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -980,7 +980,7 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 
 		memset(&params[i].timing->dsc_cfg, 0, sizeof(params[i].timing->dsc_cfg));
 		if (vars[i + k].dsc_enabled && dc_dsc_compute_config(
-					params[i].sink->ctx->dc->res_pool->dscs[0],
+					params[i].sink->ctx->dc,
 					&params[i].sink->dsc_caps.dsc_dec_caps,
 					&dsc_options,
 					0,
@@ -1033,7 +1033,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 
 	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
 	dc_dsc_compute_config(
-			param.sink->ctx->dc->res_pool->dscs[0],
+			param.sink->ctx->dc,
 			&param.sink->dsc_caps.dsc_dec_caps,
 			&dsc_options,
 			(int) kbps, param.timing,
@@ -1278,7 +1278,7 @@ static void build_frl_mst_dsc_params(struct amdgpu_dm_connector *aconnector,
 			stream->sink->edid_caps.panel_patch.max_dsc_target_bpp_limit * 16;
 
 	if (dc_dsc_compute_config(
-			stream->sink->ctx->dc->res_pool->dscs[0],
+			stream->sink->ctx->dc,
 			&stream->sink->dsc_caps.dsc_dec_caps,
 			&dsc_options,
 			frl_conv_dsc_bw_in_kbps,
@@ -1398,7 +1398,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 				stream->sink->dsc_caps.dsc_dec_caps.is_frl)
 			build_frl_mst_dsc_params(aconnector, stream, &dsc_policy, &params[count], frl_conv_dsc_bw_in_kbps);
 		if (!dc_dsc_compute_bandwidth_range(
-				stream->sink->ctx->dc->res_pool->dscs[0],
+				stream->sink->ctx->dc,
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
 				min_target_bpp_x16,
 				max_target_bpp_x16,
@@ -1651,7 +1651,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 
 	for (i = 0; i < dc_state->stream_count; i++) {
 		stream = dc_state->streams[i];
-		res_pool = stream->ctx->dc->res_pool;
+		res_pool = dc_get_res_pool(stream->ctx->dc);
 
 		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
 			continue;
@@ -1943,7 +1943,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 	bool is_dsc_possible;
 
 	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
-	is_dsc_possible = dc_dsc_compute_bandwidth_range(stream->sink->ctx->dc->res_pool->dscs[0],
+	is_dsc_possible = dc_dsc_compute_bandwidth_range(stream->sink->ctx->dc,
 							 stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
 							 dsc_policy.min_target_bpp * 16,
 							 dsc_policy.max_target_bpp * 16,
@@ -2108,7 +2108,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 		/*Confirm if we can obtain dsc config*/
 		dc_dsc_get_default_config_option(stream->link->dc, &dsc_options);
 		dsc_options.max_target_bpp_limit_override_x16 = aconnector->base.display_info.max_dsc_bpp * 16;
-		if (dc_dsc_compute_config(stream->sink->ctx->dc->res_pool->dscs[0],
+		if (dc_dsc_compute_config(stream->sink->ctx->dc,
 				&stream->sink->dsc_caps.dsc_dec_caps,
 				&dsc_options,
 				end_to_end_bw_in_kbps,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index de169ed3b3b7..7e1a5cd6d2aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -77,7 +77,7 @@ bool dc_dsc_parse_dsc_edid(const struct dc *dc,
 		struct dsc_dec_dpcd_caps *dsc_sink_caps);
 
 bool dc_dsc_compute_bandwidth_range(
-		const struct display_stream_compressor *dsc,
+		const struct dc *dc,
 		uint32_t dsc_min_slice_height_override,
 		uint32_t min_bpp_x16,
 		uint32_t max_bpp_x16,
@@ -87,7 +87,7 @@ bool dc_dsc_compute_bandwidth_range(
 		struct dc_dsc_bw_range *range);
 
 bool dc_dsc_compute_config(
-		const struct display_stream_compressor *dsc,
+		const struct dc *dc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_dsc_config_options *options,
 		uint32_t target_bandwidth_kbps,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 45ef1f745c7d..56db43d1b072 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -924,7 +924,7 @@ bool dc_dsc_parse_dsc_edid(const struct dc *dc, const struct dc_edid_caps *edid_
  * If DSC is not possible, leave '*range' untouched.
  */
 bool dc_dsc_compute_bandwidth_range(
-		const struct display_stream_compressor *dsc,
+		const struct dc *dc,
 		uint32_t dsc_min_slice_height_override,
 		uint32_t min_bpp_x16,
 		uint32_t max_bpp_x16,
@@ -939,6 +939,12 @@ bool dc_dsc_compute_bandwidth_range(
 	struct dsc_enc_caps dsc_common_caps;
 	struct dc_dsc_config config = {0};
 	struct dc_dsc_config_options options = {0};
+	const struct display_stream_compressor *dsc;
+
+	if (!dc || !dc->res_pool)
+		return false;
+
+	dsc = dc->res_pool->dscs[0];
 
 	options.dsc_min_slice_height_override = dsc_min_slice_height_override;
 	options.max_target_bpp_limit_override_x16 = max_bpp_x16;
@@ -2020,7 +2026,7 @@ static bool setup_dsc_config(
 }
 
 bool dc_dsc_compute_config(
-		const struct display_stream_compressor *dsc,
+		const struct dc *dc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_dsc_config_options *options,
 		uint32_t target_bandwidth_kbps,
@@ -2031,6 +2037,13 @@ bool dc_dsc_compute_config(
 	bool is_dsc_possible = false;
 	struct dsc_enc_caps dsc_enc_caps;
 	unsigned int min_dsc_slice_count;
+	const struct display_stream_compressor *dsc;
+
+	if (!dc || !dc->res_pool)
+		return false;
+
+	dsc = dc->res_pool->dscs[0];
+
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
 	min_dsc_slice_count = get_min_dsc_slice_count_for_odm(dsc, &dsc_enc_caps, timing);

-- 
2.56.0


