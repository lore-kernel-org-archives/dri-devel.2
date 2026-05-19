Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C2BCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8381110EC3D;
	Tue, 19 May 2026 10:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QLmUQNf7";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F09E10EC3D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2191F1A362A;
 Tue, 19 May 2026 10:39:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9A7E606E9;
 Tue, 19 May 2026 10:39:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD79F107E8AF9; 
 Tue, 19 May 2026 12:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187193; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nrcKi47WYQp5yx8o26i5BI9HVOuq7uN7+XfvO362VYk=;
 b=QLmUQNf7MbkIWl1kuqlHzQfsuyJO71uIlJ1t92LXPPLZqQ0VmSYsUDG1xpnpTVaC8HBP1I
 mkQgOveyFqhCocgfdvpiHsk8KsXpGv+PcrxOkBBrwcNa5xyo3o5NWvgKGrSr1w6COOWuTk
 oriZI0xKXoiNN9rPWtlWkeYDCdtvwBd4dXK9vzO/vyYTwvuVr1ZN2zoA7d6SXFphbQVJFu
 Rwi5paf4tLAWI3RGp5ug1t++EZnlANi6YB+Wrvo24k4+T1SsErx2hx3JXkafeUT36dbkVG
 p8tjoLD3I67aS/5PK3wpXFUTegM3Aw7TB81/apSDm5ub/1+O/8lXr1EGDLqTRQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:42 +0200
Subject: [PATCH 25/37] drm/bridge: shutdown and cleanup on bridge unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-25-45e2bdb3dfb4@bootlin.com>
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

With the upcoming support for DRM bridge hot(un)plugging, bridges can be
removed at any time withotu tearing down the entire card. When this
happens, shutdown the pipeline and detach from the encoder chain the bridge
being removed along with all the following ones.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 7f2d1a81d730..d45fb74ec8c2 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -462,9 +462,17 @@ EXPORT_SYMBOL(devm_drm_bridge_add);
  * it won't be found by users via of_drm_find_and_get_bridge(), and add it
  * to the lingering bridge list, to keep track of it until its allocated
  * memory is eventually freed.
+ *
+ * If the bridge is attached, also disable the active output and detach
+ * this bridge and the following ones.
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
2.54.0

