Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E25CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBE710F64A;
	Thu,  1 Oct 2026 12:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uKqwpUTx";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F74B10F64A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:43:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 738BD1A24DD;
 Thu,  1 Oct 2026 12:43:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2C5A160341;
 Thu,  1 Oct 2026 12:43:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B20031032809F; 
 Thu,  1 Oct 2026 14:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790858630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=d8sRHCj1LfeaitArGCptBNg5yIjIKKLU8Yc9pqpZHp8=;
 b=uKqwpUTxeMSVETp8oi2R2qfYX3XikeUsnqq6J6anFGUgYa0FuvoZkeKx3hY5Sx2qrYcPHH
 Js5oT13YMmnmZvKP83HPQIdRLekLXWkwgb5yFixpjBmh0/Fc+qJpqTdIGpVj5I251YMCWx
 Lw0V2VSRgJ6hwfFwu3zEbOCr/EbfOiGX3M5tonBIXjJftpVfZmlAPki2k4AyMWuStB9hrs
 LuHYY8vNXRPVMAxmyaKjivrL6T9L8pHpgJi8twn24DOQiRUdj5ac1hF8zt2IXnsjEzoOCa
 cpITW9wSrIBWoPhGuFE+YJAjH44ioVtKFeGk/lC0C/S7gvmqFAV3q459WcQI2w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 01 Oct 2026 14:42:34 +0200
Subject: [PATCH RFC v2 12/24] drm/bridge: shutdown and cleanup on bridge unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-drm-bridge-hotplug-v2-12-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
In-Reply-To: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

With the upcoming support for DRM bridge hot(un)plugging, bridges can be
removed at any time. When this happens, shutdown the pipeline and detach
from the encoder chain the bridge being removed along with all the
following ones.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 2a112ed69e20..c0a2f7f1ce62 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -509,9 +509,17 @@ EXPORT_SYMBOL(devm_drm_bridge_add);
  * it won't be found by users via of_drm_find_and_get_bridge(), and add it
  * to the lingering bridge list, to keep track of it until its allocated
  * memory is eventually freed.
+ *
+ * If the bridge was attached, also shutdown CRTCs and detach this bridge
+ * and the following ones.
  */
 void drm_bridge_remove(struct drm_bridge *bridge)
 {
+	if (bridge->encoder) {
+		drm_atomic_shutdown(bridge->dev);
+		drm_encoder_cleanup_from(bridge->encoder, bridge);
+	}
+
 	mutex_lock(&bridge_lock);
 	list_move_tail(&bridge->list, &bridge_lingering_list);
 	mutex_unlock(&bridge_lock);

-- 
2.55.0

