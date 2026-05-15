Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ACDCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 21:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F7910E0D1;
	Fri, 15 May 2026 21:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="E8ebA2fK";
	dkim-atps=neutral
X-Greylist: delayed 369 seconds by postgrey-1.36 at gabe;
 Fri, 15 May 2026 21:51:04 UTC
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D71210E0D1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 21:51:04 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1CBF726DA5;
 Fri, 15 May 2026 23:45:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8iJf4IhH47ap; Fri, 15 May 2026 23:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1778881501; bh=iW7rNRh2ArJWOxm9/fuOocPIaTFuDAFc1tz6G/PVRKU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=E8ebA2fKtVSaNL0rEz7ShcoMVK4gKwc9LXzR6+iJrOUfWQxHSY5mRWCsKKPZk10ql
 hvjs8JXTwf6+LRC8bZ+wSdNWbYZc3Ul0JRYDysYpCVtrd9GV5n9RgobxFxiQ+PvgG1
 jSTOWM47cxhvaHqs0+qJvBfibqbhC6NfcdG8m3BpEwwFXveRmc3WYi4kUPeaToXQcW
 ulCmCsLo/tYVNvRypFy5+5UXJgoSNMVfv5tvGBpRJbfTi/nCIXA7/6bmZrgjdv4aQT
 7TkFztGKk10lxKcqsnL0HnBvl17FoDxgGIUnqbqrfRIJ4E93m5q8EP1cLAQwOAQvCl
 voErUk+8UcplA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 16 May 2026 03:14:30 +0530
Subject: [PATCH RESEND v2 1/2] drm/bridge: samsung-dsim: enable MFLUSH_VS
 for Exynos 7870 DSIM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-exynos-dsim-fixes-v2-1-db9bf96ae641@disroot.org>
References: <20260516-exynos-dsim-fixes-v2-0-db9bf96ae641@disroot.org>
In-Reply-To: <20260516-exynos-dsim-fixes-v2-0-db9bf96ae641@disroot.org>
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
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

Commit a36c533ad3e1 ("drm/bridge: samsung-dsim: Always flush display
FIFO on vsync pulse") intends to enable FIFO flushing at v-sync pulse by
not setting the active-low MFLUSH_VS bit.

However, in Exynos 7870 DSIM, the MFLUSH_VS bit is active-high. There is
no publicly available documentation to the best of my knowledge, but
downstream kernel code [1] supports this claim. Enable the bit for
Exynos 7870.

Cc: stable@vger.kernel.org # v6.17 and later
Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/a3762bb1761ae/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#L699 [1]
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 1d85e706c74b9..70f8946ad3b24 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1089,6 +1089,13 @@ static int samsung_dsim_init_link(struct samsung_dsim *dsi)
 			reg |= DSIM_HBP_DISABLE_MODE;
 		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_NO_HSA)
 			reg |= DSIM_HSA_DISABLE_MODE;
+
+		/*
+		 * For some hardware types, DSIM_MFLUSH_VS bit needs to be
+		 * enabled explicitly.
+		 */
+		if (dsi->plat_data->hw_type == DSIM_TYPE_EXYNOS7870)
+			reg |= DSIM_MFLUSH_VS;
 	}
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

-- 
2.53.0

