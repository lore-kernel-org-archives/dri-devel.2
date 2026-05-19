Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A16CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F6110EC3A;
	Tue, 19 May 2026 10:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OybRVAMD";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5175A10EC3A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 38F554E42CF3;
 Tue, 19 May 2026 10:39:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0D027606E9;
 Tue, 19 May 2026 10:39:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A921107E8AF0; 
 Tue, 19 May 2026 12:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=p0IuXkiCS7FheF9fCBR2Egdn9vM94EkW7JUn03rjXhw=;
 b=OybRVAMD2dO5fEMHg+Ev8VfZfB393AXUj4FLlrljUsRJQHHiiYj7MDk4ipxam8JTFP3FA9
 RzFONZ9yfdIjX5nSYrHKQnXZUGVIQn+JV/DhU6LHPyYaHtlLzHyaZfNBYcxztckjpV1nJf
 TeHsEwUkb+CjPlqEnpnmy6iNdp7cmk1ALITCy007I4oDe+DbuO1a61Dy1Z99RS6bCTO3FG
 ElClQJttBn+xNYstMVLugFy1HT1e5m8fe1HfWIHJ/Tnn7qgotdFzqHjycPdWfIP3OVJgfR
 zjPJ+OVWtlL0Ok3zVm4eea64LzTmD9WDrIFgS0ek2oNtEErgdoKz0HiIS4gVqw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:39 +0200
Subject: [PATCH 22/37] drm/bridge: initialize chain_node list head on
 detach and attach errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-22-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
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

When a bridge is detached it is removed from the encoder bridge_chain list,
but the bridge::chain_node list head is not cleared. This is going to be
problematic with the upcoming hotplug bridge support because if a bridge is
detached from the encoder chain but not yet removed, when later detaching
it the encoder code may think it is still attached, thus trying to detach
it twice.

Avoid this by clearing the list head on detach, so there's a clear and
simple way to know when a bridge is not attached anymore.

Do the same in the error management code in drm_bridge_attach(), so that
chain_node is always empty [as in list_empty()] when it is not
(yet|anymore) in the bridge chain.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 657f6609d7b1..7f2d1a81d730 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -598,7 +598,7 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->dev = NULL;
 	bridge->encoder = NULL;
 	mutex_lock(&encoder->bridge_chain_mutex);
-	list_del(&bridge->chain_node);
+	list_del_init(&bridge->chain_node);
 	mutex_unlock(&encoder->bridge_chain_mutex);
 
 	if (ret != -EPROBE_DEFER)
@@ -629,7 +629,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
-	list_del(&bridge->chain_node);
+	list_del_init(&bridge->chain_node);
 	bridge->dev = NULL;
 	drm_bridge_put(bridge);
 }

-- 
2.54.0

