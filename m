Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740DF10AB82D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8E510EB69;
	Thu, 26 Mar 2026 23:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YxVCSMAM";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B7C10EB69
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:50 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c739d32b72cso1037361a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568870; x=1775173670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
 b=YxVCSMAMa5WpEsxTFYENjZ6HjUu4wwKmjr8Z3h2S8sGC+mJUa3v0b82kgIXG0bEJHw
 HD/vAad5TLX2ZoFLZsf+SkGPvRZMcWzT2o7iO9GTvog9vFK9cUs1jJEmSjI+FDVNpGnK
 FNWMqIlcSidMY31aCpwAR+EC7PNuO2BvD7W1bnIVDh/hSUx4byw7uWlLSuZgGpCYv1t7
 TA0duyrHXngVaTMoXNf/wcpuc3INcyHaMkIixRokSUybtE1wUlvo9t0+FeAWxk029C9j
 cFNVQNeudehg/iVcgHUAI0nHx9Z3nfOIIq8Ntn9AFpJ/MI6AdhSPPkNk3Rx7XAId2w4A
 Awdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568870; x=1775173670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9pCNIYnvbijot8BuXxZwdBSIjs5gTuAaUWfD7Zd1qpw=;
 b=kOLlU8BAcBuxgA0yCHIo+qUiePouhdF2tQirq2SoTQnjVkTK0wdg0lGwcfNbv6XNyy
 aP+mF9pGAhbP3o45pTXoYjnHcSu9veCWy7UvCBIqnGAHaCDEhoS0ay/k9yndeCnaGobB
 Vp6HAca0EGh80ZTaMlOfzpRNr4UK/s1O4bXZKrK5INB/SzUAzknkJ92DyubyjHCyLPzw
 +MPl0i+e188Hx5LVYp1XtBXb4x0dT1icoOOOFd/1g3GPrjzcCaeB8AH+t0dFvQU6R3hT
 ZlrZ+/BbAAuVPLWDsl4t+VfPxKR8Re7aRVQp/x2YvT8rAVSq84zPOIWPCDyTUjh1HKdu
 jthg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXHczzJG9aRYg1Yheq7Gj3X3rKBw78gBrLNrmzyywFIQQMfbyXNVT9+OPqBXn27nH/4gHakJMZjrE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzVagKA4oBwrbcfiksSNANBU8R9PuLIy/ObW2MgRAz4QagYYpf
 yF/ZqhCzkeYFgdv7JYwm2KwGUxqXkKvI+2s9wqQVwWrR6jN5rq1NABUF
X-Gm-Gg: ATEYQzzllO9CnKDwWlZuGb61fx3cE/oTlgO8X/XsO0fXVMyWVzSAgq330stAtmG9e5P
 tkJ0F+yflyKqa+0M++TXiu825wgiz+o/61Zi1vkxDw0Y4+7UE1J6Rr7xZqlZMaUMLpHlGjEB8fE
 5Wag0RMaOMqFf+0GyZ1FYkW+e5sFd9cqcbmocN4Cc3BPqNV6CAujQYJdzvJCcNahKfRsHxrTdhE
 KaIjVxv/T+QIDdwBjnFU2ZbA8VBRIg4CRglDJe1gYif1PgM44zzPoITZtElZ/JArZwwD3KRVYLO
 Doydu8liwKrSm3ev25HP26//TIQ4krDBEFLrNzl/mPp1TMvL3QIyWFJNwlSGamtZ0nft6Ei0kbT
 +a/16SRQ1WBQHFrWFyMibyHsNZ1dvXE69MyMyk4lukJr8CLbenPHZZEcdYu5LuqtvKIsNkyK4sg
 sWdlw8+yD5DB5037iPBn5PS/76NZUQibULTq1pjXEyZiZdzq8Qht63om6m7/SXR8yklQ==
X-Received: by 2002:a05:6300:210e:b0:398:919a:ddf5 with SMTP id
 adf61e73a8af0-39c878d5394mr525263637.24.1774568870090; 
 Thu, 26 Mar 2026 16:47:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 7/9] drm/amd/display: Adjust DCE 8-10 clock,
 don't overclock by 15%
Date: Thu, 26 Mar 2026 16:47:14 -0700
Message-ID: <20260326234716.16723-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
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

