Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F57606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fay9OMhv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1289010FEF0;
	Thu, 12 Nov 2026 01:44:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5016910FED9;
 Thu, 12 Nov 2026 01:43:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9308F60E11;
 Thu, 12 Nov 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794447837;
 b=PG6GzkkHOILRX6TjfDGFX5n0FWwwga/tpejrtNpKOTbVwQwXGy+MFBVYptoqp4RIGtxA
 vh31LMjE5NkZr5Pxvj3bZJraNP7kxcl8v2pKMnuxQitm+qeWwxJ29XU3m+u0QRTMfiOt5
 TVZcOhz+Nln09PMCIkAP2DoziaAwqssGsY8fXBqdUmfFqHEjMleiFhaCie4iLHdkKJ3Iv
 ownU0d0AMQvB1IAIiTsALG6HziE84G6RGjmuy52Uk/rVCpMeA4I5Sku0LLLQW69/BZGRu
 CTjs4Fgs7+G+Nj4xmIGletm4mFPFBYmajCdAGJWo9s4zm7HUqhdPOxe/1Rs3Toz8D8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794447837;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=cvkdaaF5+jAlzK3s3OBmGqC4K6rvMXUle1Lq7Ce2+Mg=;
 b=TJlps3xJ3nSIlu0cAJ6xWmWiZoCnPjxERe6N0KW6yW7pSnRS2FPis4HWPfKKlOsS0nnB
 +zSn+cMXhFWVxHyGYPrrKd75egnzD50XrBH05p7suNPX1mKO17MnIRhYPTqCBVjPyhDwi
 J63luHL3aRo/9tZ/QOEUxKtbG3L0s3dBHrfzOpR5zfhdOIQvQG3beu/GicU/XL4MTVgmT
 PIIKLr6jQ3mkOMR/UUa6BwyEHrtsirceb6GsXhmV6VG9DUNlC7UA+DhR1j/7MTjdGde9l
 Q1LkxWsXS/8ia4W3pHx6n58U3KkDL7nrwT2anIqwxpnUQMJYtryFvBdLJnFnJteKJAA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BE8D61F00A0B;
 Thu, 12 Nov 2026 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447837;
 bh=cvkdaaF5+jAlzK3s3OBmGqC4K6rvMXUle1Lq7Ce2+Mg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fay9OMhvdP6wdgTifmlEFhw1n0myZAMv9l0wtPf7rUGgEDawZ+XBdagvxhFxm4aQn
 lM5XrrdKbp7NvFe30SkcfPYZCJonEDtCFpPhzcbqXZi0q9cPmzBVYBARbLmsES9kYx
 0MYnjLb7kS7UoOtkJAkzgWkCIXj9mg0p6s65XM6uwllbJCO6EmLL8fxCapyv1b4e2m
 MSZIhFXf7+FWxSxklkQHA0wJE4biCHlVud1XOdivb3oRfWJI1lPEJnlZ5yXMWiWvmT
 g7OrHM4StSr8IfaQREa9MoZcyyy69ZxHahUyj8MuIFgU3rTzREsqiPJbFhkHR778oI
 8W/fWExHgzNsQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 281FC491FE;
 Thu, 12 Nov 2026 01:43:50 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 12 Nov 2026 11:43:50 +1000
Subject: [PATCH 15/19] drm/amd/display: Add dc_force_max_dramclk for the DP
 compliance workaround
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-amdgpu-dc-cleanup-v1-15-0fae41718ad2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5999; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=oxGfusjNFZadXwTyytZ61lMqTjT74yVsnVzM9eucT3E=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9RnQLYIF3OTV2w21pGcXUATeHPs5WlsS5JwE8
 yQ6T9efB0mJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavUZ0AAKCRAMdPNZecSG
 vlQjD/40pq0Ho9P9867n7acS6MUkBe5/KXys4AV+gxQ8aCKOw7dGdCagXbyA2lG8gyTqUyBYPde
 F+44vLbf+YDpdDvyY0yCwWeHJFi4U9cj7Ji/r2mP0l4X+eYmS0lXi8HVoXxk1kqhPHxwMtLeyhI
 OyFClodbO3l01CnRz9/bJ2Onqq7d20JuNawAPsoAxzdW629sh4xsBAXRmFYjcf7M2D/eftMYVH/
 JVvuO6vh1GN0zVQKirjAOxlOd0F3F4ZI0WtzyQ5pswJAU81gfSRC6vmIQfEtuCJkZmLjdIhg+Mw
 OOO5TA3VVG9Yr6C/WtMrEX9IC96a4drKAtehVy6r31WV1azL2y9qv9t8pxrgHhNZP4/sBPIxwYn
 TnPtbim2VsdSihMzStl5nCFKVXBNg8Aocy/PIvGC/qGseJswYfoiMrZrq+H9e3r4vopSTXiB8ww
 /eIGBA5eZriKRRTt1nvOIIBLo6VpNfscZO7s0kdeY7DPUNnD82+ikMrXkXgArohTFcRKn/wFr4I
 WjNedBcoWGmKxBj7tBnyh0S7xLzqYrxhGZ30+yNKzvqbAzSyH0MfeHCWiRIN6WUxwW8HrxgF5kP
 hgqTmbiCV8QKVUzkNvQTuUF0kyBlKIKLCV5vY81pAS4ttnTgcQNL7nAMWcMwJeTR8PNn3cFl+i6
 ghdIKONH56NxkHg==
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

The DP compliance test pattern workaround in
dm_helpers_dp_handle_test_pattern_request() reached into the clock
manager (dc_get_clk_mgr) to read the softmax memory clock limits and
to invoke the clock update. Move the whole sequence into DC as
dc_force_max_dramclk() and drop the dc_get_clk_mgr accessor; no code
outside DC references struct clk_mgr anymore.

Part of making the struct dc sub-structures opaque outside DC.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 10 +---------
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 23 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_accessors.c |  5 -----
 drivers/gpu/drm/amd/display/dc/inc/dc.h            |  8 ++++++--
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b5b3269f3d97..542f9c4cb7e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1559,7 +1559,6 @@ bool dm_helpers_dp_handle_test_pattern_request(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_device *dev = aconnector->base.dev;
 	struct dc_state *dc_state = dc_get_current_state(ctx->dc);
-	struct clk_mgr *clk_mgr = dc_get_clk_mgr(ctx->dc);
 	int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -1661,14 +1660,7 @@ bool dm_helpers_dp_handle_test_pattern_request(
 	pipe_ctx->stream->test_pattern.color_space = test_pattern_color_space;
 
 	/* Temp W/A for compliance test failure */
-	dc_state->bw_ctx.bw.dcn.clk.p_state_change_support = false;
-	dc_state->bw_ctx.bw.dcn.clk.dramclk_khz = clk_mgr->dc_mode_softmax_enabled ?
-		clk_mgr->bw_params->dc_mode_softmax_memclk : clk_mgr->bw_params->max_memclk_mhz;
-	dc_state->bw_ctx.bw.dcn.clk.idle_dramclk_khz = dc_state->bw_ctx.bw.dcn.clk.dramclk_khz;
-	dc_get_clk_mgr(ctx->dc)->funcs->update_clocks(
-			dc_get_clk_mgr(ctx->dc),
-			dc_state,
-			false);
+	dc_force_max_dramclk(ctx->dc, dc_state);
 
 	dc_link_dp_set_test_pattern(
 		(struct dc_link *) link,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index c4f703980d1e..4543b0b0f993 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -732,7 +732,6 @@ static void dm_test_idle_worker_enabled_runs_body(struct kunit *test)
 	dc_get_ctx(adev->dm.dc)->logger = logger;
 	/* dc_allow() only flips the flag when clk_mgr and apply() are present. */
 	dc_test_set_clk_mgr(adev->dm.dc, dm_kunit_alloc_clk_mgr(test));
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_get_clk_mgr(adev->dm.dc));
 	dc_test_hwss(adev->dm.dc)->apply_idle_power_optimizations = dm_test_idle_apply_flip;
 
 	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8344d821d2e8..15379b186a91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7357,6 +7357,29 @@ void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
 }
 
+/**
+ * dc_force_max_dramclk() - raise the memory clock for DP compliance tests
+ * @dc: Current DC state
+ * @context: The state whose clocks are programmed
+ *
+ * Temporary workaround for DP compliance test failures: disallow p-state
+ * switching for the given state, raise the memory clock to the maximum
+ * supported level and apply the resulting clocks immediately.
+ */
+void dc_force_max_dramclk(struct dc *dc, struct dc_state *context)
+{
+	context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	context->bw_ctx.bw.dcn.clk.dramclk_khz =
+			dc->clk_mgr->dc_mode_softmax_enabled ?
+			dc->clk_mgr->bw_params->dc_mode_softmax_memclk :
+			dc->clk_mgr->bw_params->max_memclk_mhz;
+	context->bw_ctx.bw.dcn.clk.idle_dramclk_khz =
+			context->bw_ctx.bw.dcn.clk.dramclk_khz;
+
+	if (dc->clk_mgr && dc->clk_mgr->funcs->update_clocks)
+		dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, context, false);
+}
+
 /**
  * dc_get_power_profile_for_dc_state() - extracts power profile from dc state
  *
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c b/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
index 23aced5d5eef..9e8dffadfaec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_accessors.c
@@ -94,11 +94,6 @@ struct resource_pool *dc_get_res_pool(const struct dc *dc)
 }
 EXPORT_IF_KUNIT(dc_get_res_pool);
 
-struct clk_mgr *dc_get_clk_mgr(struct dc *dc)
-{
-	return dc->clk_mgr;
-}
-EXPORT_IF_KUNIT(dc_get_clk_mgr);
 
 bool dc_get_dcc_compression_cap(const struct dc *dc,
 		const struct dc_dcc_surface_param *input,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc.h b/drivers/gpu/drm/amd/display/dc/inc/dc.h
index d20180a449d5..1cb97c7b6c16 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc.h
@@ -2382,8 +2382,12 @@ bool dc_is_idle_optimizations_allowed(const struct dc *dc);
  */
 struct resource_pool *dc_get_res_pool(const struct dc *dc);
 
-/* The clock manager. Interim accessor. */
-struct clk_mgr *dc_get_clk_mgr(struct dc *dc);
+/*
+ * Temporary workaround for DP compliance test failures: disallow p-state
+ * switching for the given state, raise the memory clock to the maximum
+ * supported level and apply the resulting clocks immediately.
+ */
+void dc_force_max_dramclk(struct dc *dc, struct dc_state *context);
 
 /*
  * Query DCC compression support for a surface.

-- 
2.56.0


