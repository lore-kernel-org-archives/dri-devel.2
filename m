Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F05210AB834
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C5F10EB9A;
	Thu, 26 Mar 2026 23:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBlCoUK5";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFBB10EB2C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:46 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c73a5473bbdso668488a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568866; x=1775173666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=RBlCoUK5QVe8RVKoz1rCHG3QX+g6kpL+NVJ896uf3toRqAMMkqHa7LfQtms8jSsHld
 UiaLs3VfUz7jD38OATTEfoUw6cpHeFSCaSfMcJ/yznDmgWekkf5l5EveZU55e5Hjvv64
 DNwSYtf9x3JFkU9cuGYZAohz/G5KZOlQy0NGBoO+r/AyDbgPwhqp/rIMA6hi4CRFJ+yK
 V2xnSVF1bCLplcJlvm+fZ1CKhMUYBNyeIXD3OI2imMCRTsAMWw1NuS+6w+yOTvT22NyF
 RFNvdY76mwuGJ8jWxrJMvBo5n2e3itxKOjVv+Xbr8CjO8NfdycN1dfqqj43s+tBEmriO
 Tyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568866; x=1775173666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=aLQYcvnnqM7LDTPeLMmQswoqnAKlK1AzdInrMELuyY3/m23UcGHRWkPsCRA8B/vA3r
 d5Y3Hsgz3GTrJMEModFH0XxwwDu5oi9VdBZNLtch5oWPrbXdNkS7mU7gXID34ouzWV6V
 ZGxnta8s9xY1Mr1NYogWf4n6gddrpLN9iAx0eyuT2j1tgc68TCz7IbxfLPUf5KDhd4ak
 JTeoTt+wcD3GfMeU0vKkFMbmiejRdy7/Hal2hQCMMALPjO4Ym9L1/SchsgfoJKR/S/hl
 vYGoVpZoJ1U3NE09PwDDsfYxX9gTaJzRCP0oBDIvr2O85/8gzem5kleYXk7T7kgQhR0/
 98ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVocmhPfK2DwMn0mAzhq5XNiLxSnzFp1JYM+glPmFbguZBUW2xqhOhubbIj2DqsgjyDhRGWGcbFdR4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywv7f6xvXdYt9Grses5SIW9eLjGRs3tzklD7OT/PtFH/eTi76gY
 MQ53H6OriDrxYd2znlt5CmFumHzoMhWmqrUyiZ7vnx56zDyRbHmBgzKF
X-Gm-Gg: ATEYQzzfgLV9BZ+vuVVMYxVYh8ET7SwgkfzPSECTGtYqrcjNSPyWWIpG+SBtjPYw6Ix
 +7J9EyzcApha6haMpBJKI+8V3Lsr3em6gBvC5HPgXnIVpbOx5qAbXYjd1OFTlwr6DE8pCT0gXMS
 GLRrmMBAWpymqv+Sf6J/CaYDM+aYmeQ1AeVMS0EgnX9VXVCshP41OyWhvSJ8W3lyrm5m7CgaOgU
 xF9hl0OIfyfTkTFfF6dim2dcGWjACI+Z1yZ5ANS65dN7wAi5VcDGSG5Qfol6NCwRtoJ+tJmNXco
 9hCLS4XCQ5M3X7EAu8x6jIaDzwUETf2lzEEGApsiuNrkjfTBFf7g5C8fZcuOZbUhfo681RXNyHX
 lL5xD/wuFVos8DO5QN0IfDwMvHxi5NtrGJZJeCFoB7hbHbTv5Lb5q2NYfjCTE24anqZggVodyMQ
 B67Fw0DYJZEkqu8zQ8EG7zHBiZLDssdewAfTt87inogSnSnYdY0TdLvA0=
X-Received: by 2002:a05:6a21:6d97:b0:398:b16f:703e with SMTP id
 adf61e73a8af0-39c87abf84fmr507549637.40.1774568866039; 
 Thu, 26 Mar 2026 16:47:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:45 -0700 (PDT)
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
Subject: [PATCH for 6.12 5/9] drm/amd/display: Keep PLL0 running on DCE 6.0
 and 6.4
Date: Thu, 26 Mar 2026 16:47:12 -0700
Message-ID: <20260326234716.16723-6-rosenp@gmail.com>
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

