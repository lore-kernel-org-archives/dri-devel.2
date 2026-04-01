Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F910F9311
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECBC10EB78;
	Wed,  1 Apr 2026 00:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bzBFSz6A";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABA910EB00
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:40 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso6814868eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003979; x=1775608779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f7Ntg2BX3ujyAv43r3p8dJoIwxn/3R/KWzzyEF1YhY=;
 b=bzBFSz6AVLvVvmfpr/LKgUqERV7ccoRLnVScyD/VLn7trqQC/0l7sIEMoUpgoIAmLf
 GcuK+YBlgjSsYs0o80TIkk4EFbll5ur9MMdAjsgVEbqpwFqZP1l1ijYaG2gFSW/qmy6P
 N+bYG9iYmYaLGq645YdE7YkiNJAULoVfHJmL2pOCbE3VS/C0r44WA+TXqo9fkr9DlJoe
 peBPEgGLnYT2pYYxjwm6/cn8qaiLYabrC8bt1xMxE38C9FZ9SCrfgwWz94WgVSNLvAz2
 pyd8ZnSexm2dHm3sk9GUlX78qNxDLhcFj35I6gjwSHlMeUfTDuZdSzeBKbp1d5lTXka0
 NYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003979; x=1775608779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8f7Ntg2BX3ujyAv43r3p8dJoIwxn/3R/KWzzyEF1YhY=;
 b=PF6+A7fogE8SXzXyjwwes6Z+TbFQ/m8+wNzNvVp+rnA0fIzQltPhG+NbMGD1pmfzM6
 IZLs5/47Qgp8NQmxXbCvW4D1O4ALe6PHJS48gkkL5IMXlxdmYryINL515Vkdtr8qXukv
 NYrOilMPnA0KHnFw9bOqCPxiayOTTpgDpNusrBO+2axJwkxJGOCvvRIayHUOmH4yEpB/
 nrXvYiij5rUT2qW4Rm8FvEXXufXN3kqnYtgt5ubfaGGdqS4LEzd6oHTYFzq3iZeBlYkh
 p+7k1f5KkGg8ygvT40kUvmkdBwxVM7YqNHWd34ufawkBF0NfDhugMMf277iGGw9Eozhw
 Zc1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBJgCuxZn2KoUAK0qJ0I8FucEDMwTfr86nld14ymW1AfqN6wlTt6TXNobFqFUM0gqd0JUxgVMVkSc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkqFQFDlXxvOT9a7ElVS5iHnT12CIWUkXS5E2dPo7slvI5nH8v
 H0aRT/clurLv98KhToGVD6WtaxtpBRnqDdmcIj/xTI/+1X7fvnJAD1Nl
X-Gm-Gg: ATEYQzwSFDtny/uIjopWh5UbpcJjQgbifrCNzV9T4hV2mwpt+GtXJlTz8licdRF2vLN
 vhl3vl9QXROKhA+DSeSGhaWRTqgz+htCwOVH5MAtFMQVmYhi7o6cxIqRQnA0MHBTz35GFBd3WS2
 BYMOmVvGTpBsUhXG3kwOgxa+xa+1y6yhAzFIa7YtmmYpQ7XOMrOKjD5lQmERZRYyHrAhcd8RlOB
 NuCD6zGXFFKmuKnw2HCacaFObeuPiibZ2zRPT3Ix9PnCVBdnViqaKvafhYd08boTRMSeLveklwX
 ysotzpUwQb/aSE7+OPT4W0egBtyB/1S/C4z38R+32p/TObDdr40O8vhdzPWOnQa/gDhCu/pY7Dy
 GQQzU8EfY50/DWZnXh/DsTAUR0QfWFgsIxhqTxivlu52aW/u+4EEP2eGjx4kehT7hASUHwE93mO
 retjwHy/bRl9URXch/jQX/ApeYBjw9BPJQlgH0h9kNl9kX9Xt/mlJpiG0vPjtmyXrfMw==
X-Received: by 2002:a05:7300:5707:b0:2c7:3a7:c7b1 with SMTP id
 5a478bee46e88-2c930b80368mr875953eec.1.1775003979256; 
 Tue, 31 Mar 2026 17:39:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 06/10] drm/amd/display: Fix DCE 6.0 and 6.4 PLL
 programming.
Date: Tue, 31 Mar 2026 17:39:04 -0700
Message-ID: <20260401003908.3438-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 35222b5934ec8d762473592ece98659baf6bc48e ]

Apparently, both DCE 6.0 and 6.4 have 3 PLLs, but PLL0 can only
be used for DP. Make sure to initialize the correct amount of PLLs
in DC for these DCE versions and use PLL0 only for DP.

Also, on DCE 6.0 and 6.4, the PLL0 needs to be powered on at
initialization as opposed to DCE 6.1 and 7.x which use a different
clock source for DFS.

The following functions were used as reference from the	old
radeon driver implementation of	DCE 6.x:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 34 +++++++++++--------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index a2e100aa3cba..5dbe89d9b72d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -245,6 +245,11 @@ int dce_set_clock(
 	pxl_clk_params.target_pixel_clock_100hz = requested_clk_khz * 10;
 	pxl_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
 
+	/* DCE 6.0, DCE 6.4: engine clock is the same as PLL0 */
+	if (clk_mgr_base->ctx->dce_version == DCE_VERSION_6_0 ||
+	    clk_mgr_base->ctx->dce_version == DCE_VERSION_6_4)
+		pxl_clk_params.pll_id = CLOCK_SOURCE_ID_PLL0;
+
 	if (clk_mgr_dce->dfs_bypass_active)
 		pxl_clk_params.flags.SET_DISPCLK_DFS_BYPASS = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index c4d7fa60d654..978c024c97ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -374,7 +374,7 @@ static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
 		.num_stream_encoder = 6,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 6,
 };
 
@@ -390,7 +390,7 @@ static const struct resource_caps res_cap_64 = {
 		.num_timing_generator = 2,
 		.num_audio = 2,
 		.num_stream_encoder = 2,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 2,
 };
 
@@ -990,21 +990,24 @@ static bool dce60_construct(
 
 	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
 
+		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
 		pool->base.clock_sources[1] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
 		pool->base.clk_src_count = 2;
 
 	} else {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
 
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
-		pool->base.clk_src_count = 1;
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+		pool->base.clock_sources[1] =
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
+		pool->base.clk_src_count = 2;
 	}
 
 	if (pool->base.dp_clock_source == NULL) {
@@ -1382,21 +1385,24 @@ static bool dce64_construct(
 
 	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
 
+		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
 		pool->base.clock_sources[1] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
 		pool->base.clk_src_count = 2;
 
 	} else {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
 
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
-		pool->base.clk_src_count = 1;
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+		pool->base.clock_sources[1] =
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
+		pool->base.clk_src_count = 2;
 	}
 
 	if (pool->base.dp_clock_source == NULL) {
-- 
2.53.0

