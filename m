Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCr9vJC2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E5B10FEF9;
	Thu, 12 Nov 2026 01:44:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D223410EB18;
 Thu, 12 Nov 2026 01:43:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C7AD42B31;
 Thu, 12 Nov 2026 01:43:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794447833;
 b=QuiT8quFeWXSDlm2Kb2jT/Y3nPgqKi0+S0Hh5EjVI72yOXhWA7JZDb+dMbPRRxx1D/Uw
 ExJR7RN0BJSZeukZjwHPEf1FFU7pi07IRei6Gb7rKi+q0IdxQCKoXSRaokUzH0hzVNr0F
 pOQg0yhHQjSdtlDu7BxrPBAxvtolaXOUEB0nvHkd0MHQBPBOPUpzqFfg/mob2oj1MAqrc
 jtATauG2jfvxziirIwihosK4vMWZh6mtkVgM4NKT8AjfQk03QZcg70+OE3GVsqzQ5xXqy
 aj8v/xCOekic/itQ5QXio2VlAdN+n77sWBr2Ayb63JLmBZRPTlHPj59iiI/8Ts0vYfg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794447833;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=GgsScT7I/wv1jYXBRn5T67bK5a4g+KWHbbbEvhtQpgs=;
 b=WNfdpoQaKwcPhsX/tPpkPCTd2A/+c6pSkb2z7Obos9fciLxEFr8CPu44Dw8nHUVxZV+S
 qwsdY+k801jhY4odVDch2Y6wfN9agUSGKrRWSDp1njeGbBdXUQzQ0M+73PbO3ZKYectB/
 WpyK13jdNw0wgOE1KqpUeVu9t//tOLyh0w1rIKB/EbjrREf5bTRQh10PxmmxKayD4uN55
 ej1uttSMHiey2tNz4w2XkTOSxlemJBujKyExUyqZnzpcaBZVkI513BLXyjZCB+yikXyLK
 zLAjXLvldhhyScfHwH3xRqyO36kQr2CLTaHLiNOnMtmvjeo/DYxuXvg2Gz8667cH5mA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 717921F00A0B;
 Thu, 12 Nov 2026 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447833;
 bh=GgsScT7I/wv1jYXBRn5T67bK5a4g+KWHbbbEvhtQpgs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ZCr9vJC2/dtCxsl272z5ER0yX69vbM8DIZ9PAHDb6whGbLZ5ukScqUfXGGp4Eytwa
 FPn39H9Qc5T9674kIb8sHfofDaKkrrAx4pd89jYodYTL6ICZOIMCGuQNp+NR+enVeR
 ZeiNDGhd9nqWwMAewJzpFZMmbbAt0VtmKHpxbaCbnBQj/YD+iw7qfF09H9g6mfFRvC
 OKss0MEAS9jJ2SyQmNMNoYjDD3/ro/8hJKRkgcgas1qWVZ7xBLQPLSgr0VGe9SDv7C
 iGFUHypKfDOm5gfdYA4B/wsshWQOJSaIAgZHQwYwadkhF9iWPOk/4Ve2Tklp+SWnrK
 Lzf9+JLSzXcDg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7DB34491DE;
 Thu, 12 Nov 2026 01:43:49 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 12 Nov 2026 11:43:42 +1000
Subject: [PATCH 07/19] drm/amd/display/amdgpu_dm: Use DC accessors in
 connector paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-amdgpu-dc-cleanup-v1-7-0fae41718ad2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4391; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=XTIIHiOnjMHCG5jY2T56nvBjguOobjHoCmTeWhbu+lc=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9RnPunn4hjYbppDS1Nvx5anerfgLD+Jss3zyh
 68O5WbSgWKJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavUZzwAKCRAMdPNZecSG
 vpQkEACgb6WoAmQYrBiOBxSZWKFJM7YGLkRMEb2A68JpF8u1SsNBGCakfNg8zsErn4IKqJDws3E
 91YXgnNvhZEc5mI0QvGCLBFyEytoZDXvPUVhbeECqvZ5PkHziChbpjSurnXW58YfrOPXtWiwB2n
 FDuai8SnVt/nACFxF5xRq1h/7lTiIZMF1S0E5RXthicIzk9Ku02KdXKs4usv5O1++46z3Qy0gJY
 oI/GdmZgI2cGjY3Ok9T9lXX+sGzs4A6WRpnuv1gJhlMaBPLF29YNedztHIRUWBxPwWvCmoyOc5V
 yycXUPyQZhIC8P0uNhJSY4IB7k3iPpogwn5MEPtgqcbeJcQ8h15S6TlNor33iGVSuelea/0xR5i
 mo0gS1SDM/W9EwfOYM+tM889SFGkgcVz+p3vr/cGYQPmd5XE9mWcGxGZt73g6mPAIkmlUfi8MZC
 JfCtPULI9fjjlMvs3bBDdYhFkmitHnpzGEjFFvRWPywFnloCROkfJQRFHmVM2HbxQJ/H3Qx+kQo
 ERhUoRUszVuG/yrfvSX9h7RheSLHyDMWcnqc2N8NDNhCFjkcf0CYEqjwiTkCC0Mt2t74Am1kxly
 sQ4Gylb38Kyztsj371Kg1Kj5Tttxz8UfG9g/MrEmQGK7T8WHojROZ6GyFk6TMq4lTGMk1Of+kPL
 DQoZLfQGSGCmbiA==
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
layer in amdgpu_dm_connector.c, including the link_service encoding
format query (dc_link_dp_get_encoding_format), link array iteration
(dc_get_link_at_index), the FBC compressor checks and the debug and
caps reads in the DSC policy paths.

Part of making struct dc private to DC.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d334391bcbae..134d08207a14 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -266,7 +266,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 	struct drm_display_mode *mode;
 	unsigned long max_size = 0;
 
-	if (adev->dm.dc->fbc_compressor == NULL)
+	if (!dc_is_fbc_compressor_available(adev->dm.dc))
 		return;
 
 	if (aconn->dc_link->connector_signal != SIGNAL_TYPE_EDP)
@@ -289,7 +289,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 		if (r)
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize FBC\n");
 		else {
-			adev->dm.dc->ctx->fbc_gpu_addr = compressor->gpu_addr;
+			dc_set_fbc_gpu_addr(adev->dm.dc, compressor->gpu_addr);
 			drm_info(adev_to_drm(adev), "DM: FBC alloc %lu\n", max_size*4);
 		}
 
@@ -1230,7 +1230,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 		edp_min_bpp_x16 = edp_max_bpp_x16;
 
 	if (dc_dsc_compute_bandwidth_range(dc,
-				dc->debug.dsc_min_slice_height_override,
+				dc_get_debug_options(dc)->dsc_min_slice_height_override,
 				edp_min_bpp_x16, edp_max_bpp_x16,
 				dsc_caps,
 				&stream->timing,
@@ -1303,7 +1303,8 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 
 	if (sink->sink_signal == SIGNAL_TYPE_EDP &&
 	    !aconnector->dc_link->panel_config.dsc.disable_dsc_edp &&
-	    dc->caps.edp_dsc_support && aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE) {
+	    dc_get_caps(dc)->edp_dsc_support &&
+	    aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE) {
 
 		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
 
@@ -3190,15 +3191,13 @@ STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connect
 	struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
 	struct drm_encoder *encoder;
 	const struct drm_edid *drm_edid = amdgpu_dm_connector->drm_edid;
-	struct dc_link_settings *verified_link_cap = &dc_link->verified_link_cap;
-	const struct dc *dc = dc_link->dc;
 
 	encoder = amdgpu_dm_connector_to_encoder(connector);
 
 	if (!drm_edid) {
 		amdgpu_dm_connector->num_modes =
 				drm_add_modes_noedid(connector, 640, 480);
-		if (dc->link_srv->dp_get_encoding_format(verified_link_cap) == DP_128b_132b_ENCODING)
+		if (dc_link_dp_get_encoding_format(dc_link) == DP_128b_132b_ENCODING)
 			amdgpu_dm_connector->num_modes +=
 				drm_add_modes_noedid(connector, 1920, 1080);
 
@@ -3249,7 +3248,7 @@ void hdmi_frl_status_polling_work(struct work_struct *work)
 	/* Defer to the next cycle rather than block on a busy dc_lock. */
 	if (mutex_trylock(&dm->dc_lock)) {
 		for (int i = 0; i < MAX_LINKS; i++) {
-			dc_link = dc->links[i];
+			dc_link = dc_get_link_at_index(dc, i);
 
 			if (!dc_link || !dc_link->local_sink)
 				continue;
@@ -4027,13 +4026,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	/* Handle MCCS */
 	if (do_mccs) {
-		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+		dm_helpers_read_mccs_caps(dc_get_ctx(adev->dm.dc),
+					 amdgpu_dm_connector->dc_link, sink);
 
 		if (sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)
 			freesync_capable = false;
 
 		if (sink->mccs_caps.freesync_supported && freesync_capable)
-			dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+			dm_helpers_mccs_vcp_set(dc_get_ctx(adev->dm.dc),
+					  amdgpu_dm_connector->dc_link, sink);
 	}
 
 update:

-- 
2.56.0


