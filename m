Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED13210F9313
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 00:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D27810EB00;
	Wed,  1 Apr 2026 00:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9P5ziqi";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FA110EB2C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:38 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso5251219eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003978; x=1775608778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=C9P5ziqi3GGQvlORl+Ko0RX6eFmn/QOtAJo8qQnqHIK/v9vazmX4mGxMMmYA/98EIc
 5e8h+RQcqDGUxI3B+iG4bwVsL2GOOUeJuoYYZd/++Yf0lfMaKK6JOhjgN8hH9QPlwasm
 jUcYf9d8M4mzYI6tj08WmWhHswmhOrDtMbzfhPfvVB2r0R7zEWxSarDS9Ymr8ggkR4Or
 gT4VRMc83GKH4JVOIVvbNEjXs0jsfSz7JBLnv3NAALvxpL9T69fhU6YF7z/MQSkGdEt4
 3b4QK2VmWOdYsrLyQgtJylQp+EOEArGNoiWpQJfC6Ry7Tw73VIKJj+BAtEJJ2FgdvOWN
 PRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003978; x=1775608778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=V8R3Uh6i0wb49JQAkmBYROnTbPnkeSvLcvfr2oyOq/z9CJ20FuDewY7ZT9qK88gQxd
 SL90WPJDSr5gXHwIuD7nmeVrWwt7IlBmNdg/VROyPzIwHHrHvW+2QwGhsWBNjnp1u+56
 Zwl8mtaEAsWRiSSuIbdS8JvNZB9iTBBtmWG4+SeRrT2l3MSJcSTozWeBoiztqrgXyk2o
 mPdKpKmHZHmgWYcFzxijWmD4TLF9EGcIFFAMpICRAErjKatNALM5eAMfVpLZdH4/w9Jq
 ZaEGrrEgfPHvVycu3EF5XMKkefI+SYpkwsEwswCpDAyiWXSbWbMet9f93Mr648BHOux9
 +DcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6TCOD8GrvZCzkTDdUpa7jHzLY1xqrQx7bu1b3+/yEF3Gu63AbEaFHSapE/pr2aoOpmUn/JbrRtg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDzT9fraSPlfXMgQccSs9CHJWfA0bsVHNffMMQ3NPLtLK26YLf
 ZS5rN12HK4h0NoWfkCzKb7DEFcdSZ1cCzzVTxnnFRdIYdPYRCOVuU1fG
X-Gm-Gg: ATEYQzwrT7rgbrI2r27Eb55XFccj4ioye3vQpNBDLWZT5+kAFd7RoXNs0qbQGtP8c0z
 TcOPU+KqSNYpGrN7h9hFGN8MitidtL6U+fQkgfpqp+pTnkmdyTj26zKLzFACMIv4Wc+9HYjTOIx
 mW1tSx3LM+vnVuWGUlWz7rzMTeKffIA5yE+iohVEpYwk09wOxlErLUZMjzhuxDhxOnuJd068biX
 tzrrhm03NeSwbVcz6MxYicB/0JdyDF8D1pl95udZgc/ycDVyFj5Mtp0vDP3SQ9Oz0TDpE5GTxfQ
 ewVkbckaN3gVB1vSSHzY7/eOxN9O323Uks9ueO1jOfn7giWOgCK+zwl8H2/Vucgj6WOzToG8ayG
 1RJY38dHXpNJYwstRw60xSzvy4O1SmwhFpr8Cvq+jtj6wXIbn1ayoHUZnZ8p9B8DwI61eq35TFI
 LRLJRBLYGpuqwFK7u3jBjCQXaua7e6CpVVpjpQ+aA16Ly56fxlAhFfNk4H3NG4cvj2kw==
X-Received: by 2002:a05:7300:cc1b:b0:2c4:a862:2368 with SMTP id
 5a478bee46e88-2c930c76802mr929306eec.2.1775003977555; 
 Tue, 31 Mar 2026 17:39:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:37 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 05/10] drm/amd/display: Keep PLL0 running on DCE
 6.0 and 6.4
Date: Tue, 31 Mar 2026 17:39:03 -0700
Message-ID: <20260401003908.3438-6-rosenp@gmail.com>
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

[ Upstream commit 0449726b58ea64ec96b95f95944f0a3650204059 ]

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 7886a2a55caf..c4d7fa60d654 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -889,7 +889,16 @@ static bool dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-- 
2.53.0

