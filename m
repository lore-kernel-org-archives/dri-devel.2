Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C0CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF59710E774;
	Thu, 11 Jun 2026 13:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eiwdcB1V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816E010E774;
 Thu, 11 Jun 2026 13:01:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4618343CD6;
 Thu, 11 Jun 2026 13:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2B51F00899;
 Thu, 11 Jun 2026 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781182910;
 bh=meJ1afBorEUNqejpXl9IdpFcRhnoq1YC3B4Naj940b8=;
 h=From:To:Cc:Subject:Date;
 b=eiwdcB1VPLBtfoLVjijtaF0gae0TMfChxNlrnRhr38Y2C6g/PvmFdCgvxXwvEjYPs
 Rtsj1luq96zgwOM89VA/3U/9/Lz2qN3aHxxdTyaik/FJZD+G03VDfWrYyw6hOQDynO
 alQT7ABXCBa/4Bw85OHIww8OdysIofwHCpiVd5iPGKvs7YAUrtEg9xB3+ixybfjm71
 D95E62l3LJVv19sc/74YWm2B6TOnsyEl1Q7Ys4V1P5VJh+u26lYQRVV6iUT7W6eNrg
 BndAOCVj8TK+3xeFyQv9IZz0YAXIjoppCWR0YArLto1vJArFUyKAFFgrwmlXU8Mp+l
 7aQjvCvFGbfIg==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 James Lin <pinglei.lin@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>,
 Dillon Varone <Dillon.Varone@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Hung <alex.hung@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: avoid large stack allocation in
 commit_planes_do_stream_update_sequence
Date: Thu, 11 Jun 2026 15:01:19 +0200
Message-Id: <20260611130141.3387920-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

The function has two arrays on the stack to hold temporary dsc_optc_config
and dsc_config objects. The combination blows through common stack frame
warning limits in combination with the other local variables:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4070:22: error: stack frame size (1352) exceeds limit
      (1280) in 'commit_planes_do_stream_update_sequence' [-Werror,-Wframe-larger-than]

Since neither array is initialized or used outside of the
add_link_update_dsc_config_sequence() function, there is no actual
need to keep each element around.

Replace the arrays with a single instance each to reduce the stack usage
to less than half.

Fixes: 9f49d3cd7e71 ("drm/amd/display: Implement block sequencing infrastructure for modular hardware operations.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bcdbf3471039..72762c4fa392 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4077,8 +4077,6 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 {
 	int j;
 	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
-	struct dsc_config dsc_cfgs[MAX_PIPES];
-	struct dsc_optc_config dsc_optc_cfgs[MAX_PIPES];
 	unsigned int dsc_cfg_index = 0;
 	*num_steps = 0; // Initialize to 0
 
@@ -4150,11 +4148,13 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 
 			if (stream_update->dsc_config)
 				if (dsc_cfg_index < MAX_PIPES) {
+					struct dsc_config dsc_cfg;
+					struct dsc_optc_config dsc_optc_cfg;
+
 					add_link_update_dsc_config_sequence(&seq_state,
 						pipe_ctx,
-						&dsc_cfgs[dsc_cfg_index],
-						&dsc_optc_cfgs[dsc_cfg_index]);
-					dsc_cfg_index++;
+						&dsc_cfg,
+						&dsc_optc_cfg);
 				}
 
 			if (stream_update->mst_bw_update) {
-- 
2.39.5

