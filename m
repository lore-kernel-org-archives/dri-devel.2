Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED69ACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A78410F5B4;
	Fri, 26 Jun 2026 12:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aPIQ09xX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A5210E37B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782475476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoiLuEs0fQtrDpOnJCVPBtcdDOUnvxJak86sNNFtqns=;
 b=aPIQ09xX2xVXavY6rTHxp70vo8B682K795/QvlqfQ4q9tde4kmmVACECh+rXs4UbpJJAZw
 C3BQN/nQTfxPsnxI+jNGPlj4XERNaD5e4z9bBYGYPKzgIoi8k+InlBXT+7RfvZOfbHfHqY
 fYH5h8zLPVxRMeczQIOwDQHKXebAp2c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-k9aloJxIMIiBFEeXM26gPw-1; Fri,
 26 Jun 2026 08:04:32 -0400
X-MC-Unique: k9aloJxIMIiBFEeXM26gPw-1
X-Mimecast-MFC-AGG-ID: k9aloJxIMIiBFEeXM26gPw_1782475467
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF9D319560AD; Fri, 26 Jun 2026 12:04:25 +0000 (UTC)
Received: from [192.168.1.153] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABA2618005B0; Fri, 26 Jun 2026 12:04:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 26 Jun 2026 14:03:24 +0200
Subject: [PATCH 2/5] drm/bridge/panel: hold a reference to the wrapped
 panel
MIME-Version: 1.0
Message-Id: <20260626-drm_refcount_wiring-v1-2-cca1a7b3bdef@redhat.com>
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
In-Reply-To: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Linus Walleij <linusw@kernel.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, Jingoo Han <jingoohan1@gmail.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Alison Wang <alison.wang@nxp.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782475410; l=2189;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=k0Fp+8sQr3zfg5u2HHCF4cWKSffOLMXWCbveTegHWXU=;
 b=KRKEPwGIFR+fYjRsq4WpccAKc6oAuWaZ3suxw8Sgu5kRbJ0u4ST8AVVBZZ+YsbxFZk3NnrCwV
 M9fcWkBozA3C3IvwVpPUaw76p6L3npppMomWLgUB+8td46HP2LrfqmC
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eRgpVR7VBmGVYKeciXLUmdKyINNGdOO5NCtpYB06VzU_1782475467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

drm_panel_bridge_add_typed() stores a pointer to the drm_panel it
wraps, but never acquires a reference to it. If the panel device
goes away while a panel_bridge still exists, the dangling pointer can
be dereferenced through panel_bridge->panel.

Acquire a reference in drm_panel_bridge_add_typed() with drm_panel_get()
and release it in each teardown path.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/bridge/panel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 4978ec98a0828..6b98ad19508df 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -294,7 +294,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 		return (void *)panel_bridge;
 
 	panel_bridge->connector_type = connector_type;
-	panel_bridge->panel = panel;
+	panel_bridge->panel = drm_panel_get(panel);
 
 	panel_bridge->bridge.of_node = panel->dev->of_node;
 	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
@@ -316,6 +316,7 @@ EXPORT_SYMBOL(drm_panel_bridge_add_typed);
 void drm_panel_bridge_remove(struct drm_bridge *bridge)
 {
 	struct panel_bridge *panel_bridge;
+	struct drm_panel *panel;
 
 	if (!bridge)
 		return;
@@ -326,10 +327,12 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
 	}
 
 	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	panel = panel_bridge->panel;
 
 	drm_bridge_remove(bridge);
 	/* TODO remove this after reworking panel_bridge lifetime */
-	devm_drm_put_bridge(panel_bridge->panel->dev, bridge);
+	devm_drm_put_bridge(panel->dev, bridge);
+	drm_panel_put(panel);
 }
 EXPORT_SYMBOL(drm_panel_bridge_remove);
 
@@ -357,11 +360,14 @@ EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
 	struct drm_bridge *bridge = *(struct drm_bridge **)res;
+	struct panel_bridge *panel_bridge;
 
 	if (!bridge)
 		return;
 
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
 	drm_bridge_remove(bridge);
+	drm_panel_put(panel_bridge->panel);
 }
 
 /**

-- 
2.54.0

