Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1DEC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E670B10E0F2;
	Sun,  9 Aug 2026 08:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="JY4v5OMr";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D897410E0F2
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:28:21 +0000 (UTC)
Received: from mail01.layka.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A863742B7B;
 Sun, 09 Aug 2026 10:28:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdd-XtsM1l3B; Sun,  9 Aug 2026 10:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1786264099; bh=KkCb88jpb3D1kBUtynsLp4Zj81VOJWY1vhwCs7mKWUQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JY4v5OMrLxpPHP7l7QywxqzjAeSxTspZqScFRu4EJK4V6S6t/AuLIQ9RRSj5fEI0x
 jubozgpW5qQjOkumZ3F2xx0revjNE1GPvLL/xSsqg9OI8i6N5s2ezTO0cL50cyeXl3
 bBzcNXcEIg8GaQqvdXgMAXkHwimK8S4AGNImPKIJ8olKKp4JFtwUt9uQ6tHpyQRE3N
 XUE+IB0f9vbPU6aLbKO8YrTqrBMXzZ2b18AsSG7yAsOSUAeOiTTnoV8FL/oFJ0g2it
 SsmzNvrAQBND4+yX/weFlmLD2vfH0UldbN86SBcMqYRW958Ij+rv3uX8HUUL4MiN5G
 WOFJ6xPgQ2Slg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 09 Aug 2026 13:57:41 +0530
Subject: [PATCH v4 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS for
 Exynos 7870 DSIM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-exynos-dsim-fixes-v4-1-ca67c51e61b7@disroot.org>
References: <20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org>
In-Reply-To: <20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org>
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
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

Fixes: a36c533ad3e1 ("drm/bridge: samsung-dsim: Always flush display FIFO on vsync pulse")
Cc: stable@vger.kernel.org # v6.17 and later
Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/a3762bb1761ae/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#L699 [1]
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 25ab475309e8..fc42acc6b9ef 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1089,6 +1089,13 @@ static int samsung_dsim_init_link(struct samsung_dsim *dsi)
 			reg |= DSIM_HBP_DISABLE_MODE;
 		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_NO_HSA)
 			reg |= DSIM_HSA_DISABLE_MODE;
+
+		/*
+		 * For some hardware types, DSIM_MFLUSH_VS bit needs to be
+		 * enabled as its active-high.
+		 */
+		if (dsi->plat_data->hw_type == DSIM_TYPE_EXYNOS7870)
+			reg |= DSIM_MFLUSH_VS;
 	}
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

-- 
2.54.0

