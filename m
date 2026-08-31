Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF2C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9851D10E98F;
	Mon, 31 Aug 2026 16:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Wo41OvVG";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4532F10E98F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:14:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0DF694E41480;
 Mon, 31 Aug 2026 16:14:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D557C60231;
 Mon, 31 Aug 2026 16:14:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 365C411C78AC8; 
 Mon, 31 Aug 2026 18:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788192882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ISxahuzTjK18RJ7tFfdhN8vFdhO6CrMv3QE+PhwTL3Y=;
 b=Wo41OvVGEcv3xdnykSNc1LxmCpmPYDBCUxtOEhOTAd6vR4P2qN1Y+Vw/z/Yldc78HY7mg/
 JOOq3j+zqCdKVP63u6xLj91kXxDre5jCbBPPOyRwDxmTk3hlU7BgMXhVvlgJDZLvowmX0h
 uWzoRANkYHOtBYdLPaH+6Vrcl14ePvTNymrZqfDg+X8j6miY9h01MKnb14jNU7avllFpAL
 TO9pbqdQH0aH3u/iwCuQlMWnBve7+fni5UBdFgwP2Djkfmk2awTI4HK9IrhJ+51i/ujZxu
 Xx1cH2xpLdqojXHmDfz0GezsqvOxzKzmAtrM4EjkdVjEUxxhegF2CiO2cH8XgA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 31 Aug 2026 18:13:36 +0200
Subject: [PATCH v3 10/13] drm/bridge: tc358767: select DRM_PANEL_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-bridge-drm_panel-cleanup-v3-10-50efd8168b3e@bootlin.com>
References: <20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com>
In-Reply-To: <20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com>
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
 Maoyi Xie <maoyixie.tju@gmail.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Andrey Gusakov <andrey.gusakov@cogentembedded.com>
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

This driver uses devm_drm_of_get_bridge(), which is enabled by
DRM_PANEL_BRIDGE.

Leave the 'select DRM_PANEL' because it is needed for drm_panel_put() which
the driver uses.

Cc: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index e2ee76899468..a4bc1b5401c0 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -400,6 +400,7 @@ config DRM_TOSHIBA_TC358767
 	select REGMAP_I2C
 	select DRM_MIPI_DSI
 	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	help
 	  Toshiba TC358767 eDP bridge chip driver.
 

-- 
2.55.0

