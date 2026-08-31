Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CECCC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4D810E983;
	Mon, 31 Aug 2026 16:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FR7pSAw3";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B103410E9B7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:14:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 765F34E4147F;
 Mon, 31 Aug 2026 16:14:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4B79D60231;
 Mon, 31 Aug 2026 16:14:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7C4C11C78B96; 
 Mon, 31 Aug 2026 18:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788192870; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=KFZJXXgYdCr9ds72bxFai8tqjuyxbSx97ZErPoRpupQ=;
 b=FR7pSAw3yYsMNNdtfhn80qFA/veCkiLzVk5QVs0P14d+ciM0g8Rjr47pqeA6TDpWajrzSb
 bqMLcFRLgH+K0PSf63drHab9wgnK9HBqicDeLvyqIBXOjlLqoTaHTBFQGQ2Tj3crzSJShn
 zONdOnpqiDbHCtEeevJadx1axwqQ5/2dhghbZUeU9TtllMMSKv1bpkzQforKs6kT3Eajis
 ozYSPL609+gHzUTODzCXDF37GDW6k9h5uGxVQd5x+STdTwC5TPk0SO/Ca4xbxAQMpv54vY
 Sewgh+0UBVsptvenFdJhkXphx+vJBm6cAw1gThftM7R+gTDMfT2GBP98an9h1w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 31 Aug 2026 18:13:33 +0200
Subject: [PATCH v3 07/13] drm/bridge: parade-ps8622: select
 DRM_PANEL_BRIDGE, not DRM_PANEL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-bridge-drm_panel-cleanup-v3-7-50efd8168b3e@bootlin.com>
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
 Vincent Palatin <vpalatin@chromium.org>
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

Cc: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index b11c8705c5c9..85a9bd53001c 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -276,7 +276,7 @@ config DRM_OF_DISPLAY_MODE_BRIDGE
 config DRM_PARADE_PS8622
 	tristate "Parade eDP/LVDS bridge"
 	depends on OF
-	select DRM_PANEL
+	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select BACKLIGHT_CLASS_DEVICE
 	help

-- 
2.55.0

