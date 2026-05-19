Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764CECD5BA8
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB36B10E3C2;
	Tue, 19 May 2026 10:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZY2oKp7d";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FEB10EC34
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 14285C2B9E5;
 Tue, 19 May 2026 10:40:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DCF30606E9;
 Tue, 19 May 2026 10:39:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4CC8B107E8ABA; 
 Tue, 19 May 2026 12:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NREKLKfWOcPRruTk5u0cJPgt+kQBoWF03bP7a1G1JZo=;
 b=ZY2oKp7d30FIAIsJ9UVTUw/DX/O0NjcbXa3fMn7sYbGqoKkfw8V8Gtvos/MoJAFuuVJYKP
 TKsj2pDmWvT+qQpu+9gDAqH/tpbRJhXKmvetb8u9z+noBIrC5R5lYvCk1nF0RGcqudysQW
 Y/5bESKfLXeK4oYOy4oKRwt5G/hLOVzRW0BjPPoNVfpz6rFR3in5KYMwIrFhQGGYO20k+H
 bFU4OA4HYSLDx3hNYeTZmWgtL59yCE8/HzBthzAyyHV2z0I81/FFgUCAHmNtOhA8HqNbyG
 Fx1g52AXRG6YrYoLPjzvBgRn45+0MAZCQ6T8Bl7PQ+Q9nPm09LWymqCve/wG8g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:35 +0200
Subject: [PATCH 18/37] drm/bridge: samsung-dsim: remove the panel_bridge on
 host_detach
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-18-45e2bdb3dfb4@bootlin.com>
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

In preparation for DRM bridge hot-plugging, we need to handle the dynamic
lifetime of the following bridge in case the samsung-dsim is always present
and the following bridge (next_bridge) is hot-unplugged.

Based on the 'if (!IS_ERR(panel))' check in samsung_dsim_host_attach(), the
next_bridge could be A) a panel bridge created by this driver via
devm_drm_panel_bridge_add() or B) a pre-existing bridge obtained via
of_drm_find_and_get_bridge().

For case B) we need to put that reference when the next_bridge is removed,
which is already handled by calling drm_bridge_clear_and_put() in
samsung_dsim_host_detach() and in the samsung_dsim_host_attach() error
management code.

In case A) we additionally have to remove the panel bridge. Currently it is
created by devm_drm_panel_bridge_add(), which adds two devm actions with
the refcounted panel bridge:

 - drm_bridge_put_void() via devm_drm_bridge_alloc() on panel->dev
 - devm_drm_panel_bridge_release() via devm_drm_panel_bridge_add_typed()
   on the consumer device (samsung-dsim)

The first action is OK: being tied to panel->dev it will happen when the
panel is unplugged.

The second action is bound to the consumer device, so the devm semantics is
not useful here when introducing hotplug. Indeed we need to drop the
next_bridge in samsung_dsim_host_detach() anyway, before the driver .remove
function, in order to support {add, {attach, detach} x N, remove} hotplug
event sequences.

Thus move to the non-devm drm_panel_bridge_add() along with the matching
drm_panel_bridge_remove(), so the lifetime of the panel-bridge is tied to
the host_attach/host_detach cycle and not the whole samsung-dsim device
lifetime.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

In a previous discussion with Maxime he mentioned a plan to make every
drm_panel always have a wrapping bridge. With that done, all the code
handling the panel and adding the panel_bridge would become useless here
(and in many other places) and could be entirely removed. This patch is a
temporary solution until that happens. The best pointer I could find to
that discussion is [0], but there might be more recent material I could not
find at the moment.

[0] https://lore.kernel.org/lkml/20250218-faithful-white-magpie-da9ac9@houat/
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 17 ++++++++++++++---
 include/drm/bridge/samsung-dsim.h     |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 5b799619e07e..2af287221e22 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1951,14 +1951,16 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	if (!remote)
 		return -ENODEV;
 
+	dsi->panel_bridge_added = false;
 	panel = of_drm_find_panel(remote);
 	if (!IS_ERR(panel)) {
-		next_bridge = devm_drm_panel_bridge_add(dev, panel);
+		next_bridge = drm_panel_bridge_add(panel);
 		if (IS_ERR(next_bridge)) {
 			ret = PTR_ERR(next_bridge);
 			next_bridge = NULL; // Inhibit the cleanup action on an ERR_PTR
 		} else {
 			drm_bridge_get(next_bridge);
+			dsi->panel_bridge_added = true;
 		}
 	} else {
 		next_bridge = of_drm_find_and_get_bridge(remote);
@@ -1989,7 +1991,7 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO)) {
 		ret = samsung_dsim_register_te_irq(dsi, &device->dev);
 		if (ret)
-			goto err_remove_bridge;
+			goto err_remove_panel_bridge;
 	}
 
 	// The next bridge can be used by host_ops->attach
@@ -2011,8 +2013,12 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
 	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO))
 		samsung_dsim_unregister_te_irq(dsi);
-err_remove_bridge:
+err_remove_panel_bridge:
 	drm_bridge_remove(&dsi->bridge);
+	if (dsi->panel_bridge_added) {
+		drm_panel_bridge_remove(next_bridge);
+		dsi->panel_bridge_added = false;
+	}
 	return ret;
 }
 
@@ -2022,6 +2028,11 @@ static int samsung_dsim_host_detach(struct mipi_dsi_host *host,
 	struct samsung_dsim *dsi = host_to_dsi(host);
 	const struct samsung_dsim_plat_data *pdata = dsi->plat_data;
 
+	if (dsi->panel_bridge_added) {
+		drm_panel_bridge_remove(dsi->bridge.next_bridge);
+		dsi->panel_bridge_added = false;
+	}
+
 	if (pdata->host_ops && pdata->host_ops->detach)
 		pdata->host_ops->detach(dsi, device);
 
diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
index 03005e474704..3620f7aa9394 100644
--- a/include/drm/bridge/samsung-dsim.h
+++ b/include/drm/bridge/samsung-dsim.h
@@ -131,6 +131,8 @@ struct samsung_dsim {
 	const struct samsung_dsim_plat_data *plat_data;
 
 	void *priv;
+
+	bool panel_bridge_added; /* true iff next_bridge is a panel_bridge we created */
 };
 
 extern int samsung_dsim_probe(struct platform_device *pdev);

-- 
2.54.0

