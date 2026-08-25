Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC03C61DB4
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D672010E9BF;
	Tue, 25 Aug 2026 10:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZzU7Ztrm";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245CC10E9BF
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:12:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EDBF01A1818;
 Tue, 25 Aug 2026 10:12:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B8E9E604C4;
 Tue, 25 Aug 2026 10:12:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1776B11C7A3CE; 
 Tue, 25 Aug 2026 12:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787652741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HfLgCP9BrA4i7iLKUb9N1FJ/Z1qGVbl29CRvT7j6NoE=;
 b=ZzU7ZtrmpWe4vaI0mjOq7D6BvlYz+9+DcplLmtKquNDyT140TUoqA7FiNOps5XlaLxCio8
 sqQObWRAJ0igAV+Ofk9KJPBVlQKejS/a7I6uWQ8r96XoZs8UipiHQVeHfD/pPXLJHdKRiw
 qzLUkxzlSmKlkUe87Co1LZEMq+ip+TckbiPFeWQI9guXyKjcc/3+s11L1rPKz5KEH6qfJ0
 cGOYWXOPatzKEmpQxzQWceNx3uEW29u1/EP2X4UJhnXAgxkme6pDVT1H7Jo2KGoaBja1Sj
 qIgCvctOJT9pTBKlH7kDTpyhtQauVw5j9xAaKmqMYR6uLLYHEVhm0NpS3JQw3g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 25 Aug 2026 12:09:45 +0200
Subject: [PATCH v2 12/12] drm/bridge: ssd2825: select DRM_PANEL_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-drm-bridge-drm_panel-cleanup-v2-12-c6c88ba7ffd2@bootlin.com>
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
In-Reply-To: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
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
 Svyatoslav Ryhel <clamor95@gmail.com>
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

Cc: Svyatoslav Ryhel <clamor95@gmail.com>
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

