Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825E10F9311
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FEA10EB2D;
	Wed,  1 Apr 2026 00:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tB2B+0J+";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B021A10EB2C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:36 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so12339478eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003976; x=1775608776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYskpQzDXhxM4+9VM9RgZDo2+o/dM3+zNnNFKoGgds4=;
 b=tB2B+0J+LLgv7+v4n/ZFEXTp824+JDr3GjsKflPg59NvIGxHhGhJhYNFH1ChpkVzSG
 szxazt922eGEjqkx8AukMOz416JUk8lJuk7FhNcadg6AnYYnhx98QtocEM+2h7PTWjiy
 6DDrF4m6+bv1IaxUWNa1zwXaj+kUslwiGKFR8g6A7dBpHohgwKBkVM3Pe2vxqfI1w5v5
 Dc327DUYcZ+X/8DmoYVvFiAui7cQ4JD8T/6vM2Nx6NRZ6AJF3OMGaQWM7T0/7bvT9Fep
 VO9LywTEfktqmGbeuMIiG+rO3U7MLmFck3VRm40RsZ3thBBJfrsO2M4hfFSPYB/5Rqzj
 ii5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003976; x=1775608776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYskpQzDXhxM4+9VM9RgZDo2+o/dM3+zNnNFKoGgds4=;
 b=E/eKoDf3DLCisVTMR4Gw01Iq1Vp8A7wqzKiWpNd++gpYclfd765ckiMUWrxQLiz7sR
 jZbc2lPkjzFZ34rAlzb4xS1RVosES43QSOfrvWSn77D2TV9lHb/iReZZKxWQMwGcRjvO
 V+zmAJKWBFakfArgelFvyhZ1V721E5EB5DAMK2J+iSoN3hTmF5WaV2N1Ri1UgDpzD3PR
 bu6oRvi4dh8MgU3z40zgjnvqlWKahAl1EMMYzKOxxPtFZ/WQKdM2zkcakMlKS3MMB4FK
 AKd37jqkewbc40eQ/w2pTNBS2Yx7U60s30NdIfiRQUuIV48C/ozi9Jo0+a0K8w6nCSJ3
 L2wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwr6JREI2jbBNz+/3RROGy7E7WgB/SOI0Z1l6NgOq7EDNXDuIQK8PHMi9unC1XY+sJ8mUJuqSFFyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHLMoKXz0Ge8hjbjooPZfYIG4BbbSp4eUVjPQr76DVeNDLHCOQ
 b7ret/oUJUwIQOGyKZ2wp1XLZoJte7vK3QDKIaogQXYpHjhoLmp/AefE
X-Gm-Gg: ATEYQzzGHhMoUVq1o1MSOX3zOo10ntULdzGulW/ZrFzkc96IUOpUEkDQirOyIHw8n3W
 6G27CI7C53pYRsJu6kqv8cVzBJBPuH3ho1W+A+EvgaNzddaJpa2zfK1+6dfaBlz6Uif4cdraS6V
 xd715yR2eU0eoRUlYh0/cjWFjSUht4lc7qvHlXWmc0uif4mk9hNWDuAiVwpxlyceMexVLx0ZtmI
 NeNZPDsMIES70pNMsdIaDfa23GoqLBdHfMHPwhOCRO8z9WTmYR18dUmZS5T+n1ToNQpmvZT6Hvn
 vwNg7cthDgV5hhvH+/s4fjQAo0ZYl4vOAbx/krpJOVGYdUYdWHoPUbwWLRvgjC3Cv97b6kbNmVY
 3Lyitt3RJYeNA00OzeStO7IzNTQkW5ZTc2VtJI6bGXrxa56kUcJd9TWsOf88SaEphufOXJrIvMb
 ecAjiFNz5us37fvvpso6d6VM2Qs2Q+ZScnrgZDiC9nKSu7K7uW+Umx0u0=
X-Received: by 2002:a05:7300:ed0e:b0:2b9:80c1:bb5 with SMTP id
 5a478bee46e88-2c9337a0ef3mr1033986eec.33.1775003975796; 
 Tue, 31 Mar 2026 17:39:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:35 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 04/10] drm/amd/display: Reject modes with too high
 pixel clock on DCE6-10
Date: Tue, 31 Mar 2026 17:39:02 -0700
Message-ID: <20260401003908.3438-5-rosenp@gmail.com>
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

[ Upstream commit 118800b0797a046adaa2a8e9dee9b971b78802a7 ]

Reject modes with a pixel clock higher than the maximum display
clock. Use 400 MHz as a fallback value when the maximum display
clock is not known. Pixel clocks that are higher than the display
clock just won't work and are not supported.

With the addition of the YUV422	fallback, DC can now accidentally
select a mode requiring higher pixel clock than actually supported
when the DP version supports the required bandwidth but the clock
is otherwise too high for the display engine. DCE 6-10 don't
support these modes but they don't have a bandwidth calculation
to reject them properly.

Fixes: db291ed1732e ("drm/amd/display: Add fallback path for YCBCR422")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  3 +++
 .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  5 +++++
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c  | 10 +++++++++-
 .../amd/display/dc/resource/dce100/dce100_resource.c   | 10 +++++++++-
 .../drm/amd/display/dc/resource/dce80/dce80_resource.c | 10 +++++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index b268c367c27c..a2e100aa3cba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -460,6 +460,9 @@ void dce_clk_mgr_construct(
 		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
 	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
 
+	base->clks.max_supported_dispclk_khz =
+		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+
 	dce_clock_read_integrated_info(clk_mgr);
 	dce_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index a39641a0ff09..69dd80d9f738 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -147,6 +147,8 @@ void dce60_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_internal *clk_mgr)
 {
+	struct clk_mgr *base = &clk_mgr->base;
+
 	dce_clk_mgr_construct(ctx, clk_mgr);
 
 	memcpy(clk_mgr->max_clks_by_state,
@@ -157,5 +159,8 @@ void dce60_clk_mgr_construct(
 	clk_mgr->clk_mgr_shift = &disp_clk_shift;
 	clk_mgr->clk_mgr_mask = &disp_clk_mask;
 	clk_mgr->base.funcs = &dce60_funcs;
+
+	base->clks.max_supported_dispclk_khz =
+		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 8db9f7514466..7886a2a55caf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -34,6 +34,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce60/irq_service_dce60.h"
 #include "dce110/dce110_timing_generator.h"
@@ -870,10 +871,17 @@ static bool dce60_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 53a5f4cb648c..6717ed84a032 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -29,6 +29,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
@@ -843,10 +844,17 @@ static bool dce100_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a73d3c6ef425..af4a45718c7c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -32,6 +32,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce80/irq_service_dce80.h"
 #include "dce110/dce110_timing_generator.h"
@@ -876,10 +877,17 @@ static bool dce80_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
-- 
2.53.0

