Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC4FC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7D210E2ED;
	Tue, 15 Sep 2026 16:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="A5MjBa5c";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9189D10E2ED
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:47:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3DD3E1A0809;
 Tue, 15 Sep 2026 16:46:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 10D56602B0;
 Tue, 15 Sep 2026 16:46:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 355F411C7B005; 
 Tue, 15 Sep 2026 18:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789490813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jLOehHTQ/WXK8R/pVOQvKNT+LOYuNe8gT3lU0A2hNAI=;
 b=A5MjBa5cR9xc2yipHATr8nuVDYZYmVEir4RubUZZzc0QE8clih0wrwgx1gGvy8EDWJ4tWm
 B+Zc7NM4P8Qt61MddUfsvLLLiRhwE3IRq6+3eXT6dZCaYPpEPI7RXU2GR1t61bMCmb3L3+
 rLvvE090VNz8Q4+LkoOqC6UgFcf8Wlot6/TFNV56h7xP6zsvKKTho7tYmKZJo5bhfIx/X9
 qfQTVwsBkza4aqwobgpsD+lLYE78XcaG2IFSelVRcLwJqAClOErG8DtlOVPmZjWdMGT4w6
 fVyalGWv7mVTDJIC+j9Fcg5Lko4QEGnbuqGAqc12NOK7kveR+kJb3XbVCGeWGg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 15 Sep 2026 18:46:15 +0200
Subject: [PATCH v4 2/9] drm/bridge: ti-dlpc3433: don't depend on DRM_PANEL,
 select DRM_PANEL_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-bridge-drm_panel-cleanup-v4-2-30401d9406f3@bootlin.com>
References: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
In-Reply-To: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Christopher Vollo <chris@renewoutreach.org>
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

This driver does not use the drm_panel APIs at all, so no need to select
DRM_PANEL.

But it uses devm_drm_of_get_bridge(), which is enabled by DRM_PANEL_BRIDGE.

Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Christopher Vollo <chris@renewoutreach.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a402f8c5b321..c98f62b23b1d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -428,9 +428,10 @@ config DRM_TOSHIBA_TC358775
 
 config DRM_TI_DLPC3433
 	tristate "TI DLPC3433 Display controller"
-	depends on DRM && DRM_PANEL
+	depends on DRM
 	depends on OF
 	select DRM_MIPI_DSI
+	select DRM_PANEL_BRIDGE
 	help
 	  TI DLPC3433 is a MIPI DSI based display controller bridge
 	  for processing high resolution DMD based projectors.

-- 
2.55.0

