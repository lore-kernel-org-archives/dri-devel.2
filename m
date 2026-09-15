Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D9C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC6F10E2F1;
	Tue, 15 Sep 2026 20:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SaGt7GlK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568E110E27F;
 Tue, 15 Sep 2026 20:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0697A42E4C;
 Tue, 15 Sep 2026 20:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BC21F000FF;
 Tue, 15 Sep 2026 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789503331;
 bh=7xIDUGhUaQFKlbg3Apspt5hxOSorJ/OVsw0WLd304Mw=;
 h=From:To:Cc:Subject:Date;
 b=SaGt7GlKFHXDGMGzIp0iNcYeH8JagWOQMK7cGgwIcAwsc4pBIcpWYNRTqVhRsmcMn
 Kmf/SiB5F8i2FeGvZnneb0up3WLutaTCHq6iSnlOvi/ze3Jz+aCxfd9In0vloAdWKk
 kx7LK/Y5Cp8RwR482OoTtxfPXC3PxnrveVOTAGQYvFsyMK+99xjdHGmQVPPB9pGCYg
 rA1IRM8w99PqP7Uzu92Er/BpPJtvt90aqaGXt7IBZw6s843NM7PR+qgkfCe3oW42T+
 zxp9anE+aixFHRSp9C/MzEhA61/6WBtgOXZuTJslAa4gbzWhwMs8iqPP1tD6t521dN
 +PN0bYe27XEMw==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix unused function warnings
Date: Tue, 15 Sep 2026 22:14:28 +0200
Message-ID: <20260915201525.3530491-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

When CONFIG_DRM_AMD_DC_DCE is disabled, most functions insde dce110_hwseq.c
are no longer referenced, causing a lot of warnings such as

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3510:13: error: 'dce110_enable_analog_link_output' defined but not used [-Werror=unused-function]
 3510 | static void dce110_enable_analog_link_output(
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3391:13: error: 'dce110_set_cursor_attribute' defined but not used [-Werror=unused-function]
 3391 | static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)

Replace the #ifdef with an IS_ENABLED() check that leads to an empty function
in this configuration, so the compiler can eliminate the unused functions
and not complain about it.

Fixes: cd2cfe4d1504 ("drm/amd/display: gate DCE ASIC code behind CONFIG_DRM_AMD_DC_DCE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This still leaves an unused empty function, not sure how much harder
we should try. Maybe the file should just be built conditionally?
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 817f2bf736f4..a334e10eb1cd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3618,7 +3618,6 @@ void dce110_disable_link_output(struct dc_link *link,
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCE)
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -3685,9 +3684,8 @@ static const struct hwseq_private_funcs dce110_private_funcs = {
 
 void dce110_hw_sequencer_construct(struct dc *dc)
 {
-	dc->hwss = dce110_funcs;
-	dc->hwseq->funcs = dce110_private_funcs;
+	if (IS_ENABLED(CONFIG_DRM_AMD_DC_DCE)) {
+		dc->hwss = dce110_funcs;
+		dc->hwseq->funcs = dce110_private_funcs;
+	}
 }
-
-#endif /* CONFIG_DRM_AMD_DC_DCE */
-
-- 
2.53.0

