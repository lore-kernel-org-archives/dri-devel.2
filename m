Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38794C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9769210EFFF;
	Wed, 12 Aug 2026 13:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DK/6qcFn";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107ED10EFFD
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:49:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D01BF4E411D9;
 Wed, 12 Aug 2026 13:49:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A56EC6045E;
 Wed, 12 Aug 2026 13:49:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3F2911C4CF22; 
 Wed, 12 Aug 2026 15:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786542565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DZrsqlO7Z2m63LTqlcNQFMmMQKIr5meaGdOVL2O3i00=;
 b=DK/6qcFneyyMV4+JvC2nS4a662yPmOhi+pXw72BMEUwjdFm8CQ7vgdp33TVxYK27FUvia2
 7P3T8T2nFE5cYOxHfJBFe1Sv0e2BxvJJs7WtDqlqp/eKAsrZbjbp76TGIaeaDYgc1xC8Q7
 nTQEs7AKKibDfxD7AhJcjC3ScNJo6VnTz5cYGMxRxcyHEqVNBMNWehJD2tsOF7pxwTIRml
 4lAU4p7c7pIHUGWkFsMQ5CInJae3scDRl/y8/ieHFmJ3L0xf+atJpQs6npTGPcpakqf3hT
 1NCTZPZearLatZz/lc7v4nM/ju1aXWBidvs8O0wS5jl2MgudZnPwCMISDHk3rQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Aug 2026 15:42:50 +0200
Subject: [PATCH 10/12] drm/bridge: tc358767: select DRM_PANEL_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-drm-bridge-drm_panel-cleanup-v1-10-0d86734e908a@bootlin.com>
References: <20260812-drm-bridge-drm_panel-cleanup-v1-0-0d86734e908a@bootlin.com>
In-Reply-To: <20260812-drm-bridge-drm_panel-cleanup-v1-0-0d86734e908a@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

This driver uses a mixture of drm_panel and drm_panel_bridge APIs, but the
Kconfig symbol only selects DRM_PANEL.

Select DRM_PANEL_BRIDGE instead, which in turn depends on DRM_PANEL.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 7874d3b1e760..8eaaa3282062 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -399,7 +399,7 @@ config DRM_TOSHIBA_TC358767
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
 	select DRM_MIPI_DSI
-	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	help
 	  Toshiba TC358767 eDP bridge chip driver.
 

-- 
2.55.0

