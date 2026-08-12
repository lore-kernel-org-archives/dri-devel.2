Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E23EC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD75A10EFEC;
	Wed, 12 Aug 2026 13:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JBtTsBlo";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7E310EFEC
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:48:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 181394E411D8;
 Wed, 12 Aug 2026 13:48:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB4956045E;
 Wed, 12 Aug 2026 13:48:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E133F11C4CE61; 
 Wed, 12 Aug 2026 15:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786542522; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LnLjMcyxtTgcxT9/mrP9cH1jxHSYaloUZXEd7jbMjTU=;
 b=JBtTsBloePrSWOrpNjzwUSq3m/ObV554fF7cjccRmKiPoxz8pZEj4Pp7SRUQQhtyrqWRV/
 8i+8C/pQF3W1d3QgOY40QjjwB8AXPf2+XWWQ+NvAr6VoU6vSumuF4nCQINUmryOpWvEw5G
 zZc48iyvAAeJl0MpdCbEyn6Wx/tol2xcBk3gnLlYOfEULnED9zxLsZmwEKyESwCJSpK1Ff
 5bNYGgYGiglpROKY6SRxQkRayJAEB3c4J4w/CNt0FQcASuj6Vj3gGUN4v3pq9LvdzFmj0P
 TkqX/wGaAWELyONbIuRF1tiIEiLkoC0QmT74NVHdcuO4Hai+d/NI80SGp8oe9Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Aug 2026 15:42:42 +0200
Subject: [PATCH 02/12] drm/bridge: tc358764: don't select unused DRM_PANEL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-drm-bridge-drm_panel-cleanup-v1-2-0d86734e908a@bootlin.com>
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

This driver does not use the drm_panel APIs at all, so no need to select
DRM_PANEL.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a999e57d0cc1..958b4f687d4d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -388,7 +388,6 @@ config DRM_TOSHIBA_TC358764
 	depends on OF
 	select DRM_MIPI_DSI
 	select DRM_KMS_HELPER
-	select DRM_PANEL
 	help
 	  Toshiba TC358764 DSI/LVDS bridge driver.
 

-- 
2.55.0

