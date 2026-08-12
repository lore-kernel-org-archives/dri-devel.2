Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4395BC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A131E10EFFE;
	Wed, 12 Aug 2026 13:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GD1ikoVy";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1330210EFFE
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:49:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D68254E411D7;
 Wed, 12 Aug 2026 13:49:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC2556045E;
 Wed, 12 Aug 2026 13:49:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1DC9B11C4CF26; 
 Wed, 12 Aug 2026 15:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786542572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=13uxCshRvBeCtGTD2cJ0HXO2IVu+PXjLc3uc3PdFdEg=;
 b=GD1ikoVyD4W3iBui5euesL550fnwHjoFyMpbRvOcICsQw79Z07q0LcbASpIKz5JyL4D+sZ
 uT30i2SQyESyg4hWiLX373n5ec5BxmOhZzwzlgB1srXXJDF7oakzjQtALzS0mljrKpNmLw
 NLyRMoyqQix8u0U6xY1Z1qzFshyeJlRC5w0zbYPC0LHsi8Nm/G1VTe/6414LN3lQZ+yhzA
 QMbaFUBJgB3QmakiMn9aaw1xP7TWvXxfRHEzzv+8BPN+9NQeCbVOAAlncHSsO56oaM6oYe
 yiixELP6KWV/invka94+GJMHWJbRquKwPkimWt6tuqqR5t8kvnyeEoS1jfZ77w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Aug 2026 15:42:52 +0200
Subject: [PATCH 12/12] drm/bridge: ssd2825: select DRM_PANEL_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-drm-bridge-drm_panel-cleanup-v1-12-0d86734e908a@bootlin.com>
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
index afcc5cce88cb..02c41ec2587f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -350,7 +350,7 @@ config DRM_SOLOMON_SSD2825
 	depends on SPI_MASTER && OF
 	select DRM_MIPI_DSI
 	select DRM_KMS_HELPER
-	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	help
 	  Say Y here if you want support for the Solomon SSD2825 RGB/DSI
 	  SPI bridge driver.

-- 
2.55.0

