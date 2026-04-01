Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED610F9312
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8651510EB69;
	Wed,  1 Apr 2026 00:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huSUokih";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC67410EB69
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:41 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c6f5574d3cso261138eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003981; x=1775608781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
 b=huSUokihWpPlBubc/oPgD6pTy9A/7F7r6t0n5xpCYlVpoptH+E2MvyJwZjBR0PDJ7z
 rxj1n7JSfaTuXAmeZ4110aNsHWKa2iwHCW4DlFiw4mMG6waS/LFiRD9LlOlS3gaxFrTn
 hwhbtopLI7h9lD22ohTxRX+lBiJDFVeO/Xt4cE3Pq0OGvrAPqfr8dbfRTibe4wxIwOHT
 Uwefornr/ZgWUlbD07inAXArWcATb2r0VMD9pNIePs/rWVIkY5x4VY7lDBjaEj9n0NPO
 jK0bBPLl2Opq1Tl07lkG4fog8VMZmH3i4ngdSlIPTMb7HkvcEm1MUS7KlMJHY2/TA4xB
 UX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003981; x=1775608781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
 b=YZGwg3hm5zMz3VcPp/SjogdZCikV15rIYyOwZebosa4of7JMKhVuPj5AGJD0403mrc
 TF3J0WMv7a/4aCikp9lGKxoHpsd8OOJ8u3jqR3svfZaID4/ZKrIH6USK0TN1WNaxWARu
 wxuRpUCBwHkkkHdccxtUtFKe9Y0oioxWsNYu8zPI4bjwpGvfRxKjKpGnrxFzwvfEbGA9
 RA1S3b4QRFvaRNUPcQ3JTWUpJY3r/aHwDf+ktOb7zFWlx2V9J2nxZySe6o7wgQHLFinF
 4QNc+jMc399cJH8RodltA6HYSAIqAESxHwA853KHYCYhvtOhBjn0MaOwXJBiLdLXm8GF
 mg8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxXiA7G8OVdTkj5B1sW5YuteZeiEmY8TMhIZ5k2xp5ZQhynFE7F6/DB8QK4HXl8OG3hN8ji6Zj9ss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf2fe0mk/6IUYxVOeMMBmbbhY/65Vw1cqeCrvkjtVncXr1jOAy
 yMmoxZbRXnda72epV58dNl97vf4J50h0kPPgPIAUIasPQlPE7l214aRa
X-Gm-Gg: ATEYQzxZonqXKl38vATyytHL0LSVO5tA5XvXATGyLlAw9DDjus/UkwJWJM0QgJGVqxc
 6ImiMG4UWiUlpA9mIHrYqD03C6tIPuf5M5lGuZ7exU4k6JGCe2z5jkQ9bBuxTvVF0BoAOxL1tP1
 Azk8lnUevcbnQqJN71jM4wYct6XPT6j3QoGYaq2b+KkmY1tdKybf2R24rNygKi3ukDoP2lvtyhJ
 /XqZ9MDhWrRV4xaceLrOPHKQhvjXM8pRZI/f+xITysa9W/IonE96JXEZIbZ0DR54lXSDQTuxEnn
 RnjW6vTahMfDpIrcgLKmXxaLWlLBtK3+4K9JAYA76UIfoHFUboXRUX7r8MaWDlVb2NNr6najBzn
 psKZhQf7poxw2W5yCcUq6HjhogsWziay/9SMRuM2fbu7WdhBWayNQKFCn5kaIytaAhOw5K78nh9
 CRZP3T1gSuKQ6e5wKIYnBZLg1SeXQ+ms2B6CfWfT+1P4gYMeKsaWjQr4U=
X-Received: by 2002:a05:7301:fa0a:b0:2be:17b1:e49f with SMTP id
 5a478bee46e88-2c7baf442a2mr2983559eec.4.1775003981000; 
 Tue, 31 Mar 2026 17:39:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:40 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 07/10] drm/amd/display: Adjust DCE 8-10 clock,
 don't overclock by 15%
Date: Tue, 31 Mar 2026 17:39:05 -0700
Message-ID: <20260401003908.3438-8-rosenp@gmail.com>
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

[ Upstream commit 1ae45b5d4f371af8ae51a3827d0ec9fe27eeb867 ]

Adjust the nominal (and performance) clocks for DCE 8-10,
and set them to 625 MHz, which is the value used by the legacy
display code in amdgpu_atombios_get_clock_info.

This was tested with Hawaii, Tonga and Fiji.
These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 8-10 which
are already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also	adds a check to	make sure
not to exceed the maximum DCE 8-10 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 5dbe89d9b72d..6131ede2db7a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -72,9 +72,9 @@ static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
 /* ClocksStateLow */
 { .display_clk_khz = 352000, .pixel_clk_khz = 330000},
 /* ClocksStateNominal */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
 /* ClocksStatePerformance */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
 
 int dentist_get_divider_from_did(int did)
 {
@@ -403,11 +403,9 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
-- 
2.53.0

