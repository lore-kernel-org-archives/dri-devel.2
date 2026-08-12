Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD9C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E89B10EFF1;
	Wed, 12 Aug 2026 13:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZI2e93Sb";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9606210EFF1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:49:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 61A0E4E411D8;
 Wed, 12 Aug 2026 13:49:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 370EC6045E;
 Wed, 12 Aug 2026 13:49:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7877911C4CF20; 
 Wed, 12 Aug 2026 15:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786542544; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=08Cvdu455qyI71ZuY0qUC3Zlxk0P2phkXGwNgfHBJZc=;
 b=ZI2e93Sb0dajO8b9ljvRsLMtgYvm/V69p7OEYbjgsF4wadQRjUkqed1q7ymrrwOiybONDp
 JObfSje61wheP99t0IeFEA9Ua1aKUNxXgu4nlLqlgP/nf9Mkx+b6BTTTS2NTJny63I/7VR
 EKpXW/JGeHqicTz+Fii59v0MdLUXGWTkTEMV3AjUfgMtvOmJlED3qT6rYYphrTjcj9Y9ln
 ObtIgINIAXjay3XsPHj/L/xNcYB5yWxcFVunQmNDQcdNivgAtH70H7iL9LOtDLj1leAbPM
 aMjztFinghcO84h5O4yL1jBlkTdk2tkRsriDG+4ycY74llVz6pV8uDqfLVnnhg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Aug 2026 15:42:45 +0200
Subject: [PATCH 05/12] drm/bridge: ti-sn65dsi83: select DRM_PANEL_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-drm-bridge-drm_panel-cleanup-v1-5-0d86734e908a@bootlin.com>
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

This driver uses the drm_panel_bridge API and not the drm_panel API so it
should select DRM_PANEL_BRIDGE and not DRM_PANEL.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index d46aa2eb01b5..03f52dcbba6f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -461,7 +461,7 @@ config DRM_TI_SN65DSI83
 	depends on OF
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
-	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select DRM_MIPI_DSI
 	help
 	  Texas Instruments SN65DSI83 and SN65DSI84 DSI to LVDS Bridge driver

-- 
2.55.0

