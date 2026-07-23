Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22997C531D6
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B235A10EF27;
	Thu, 23 Jul 2026 01:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JJldB6FD";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECC610EF09
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784770518;
 bh=T7Fb3/FvJZGQaNLv0cZ3OdL0hvfbtlb8F+Z2Tu/MECM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JJldB6FDZOpnrHrMHzt5pJZIgqAx46gX+IUnEZ2WsB2faFqcDV8QSz6FhyivZIlZW
 Ib9VHvUVeMtk+au5DxAwrER7aLOGuCeskSbq1ad+UkhFmkxhUAUyDajdWaLPfvESG5
 rLVp9HQbr6UnXeOqRiEmZltcagUbOSQj4w3T/nEE0QaLDn+NQkw6du1L+tXtFmL0P9
 /J8UjfSjZzFqfDtODTrgg1L2kAMyK27dtMTfOvbpyObI5rOYZRt5DLZ5W9AnCCqwYn
 8rbWP3MD26zrEaYWxZdTN4UHPum7koUr0wNSprb32t3PsrepjBCZG1cJnm++NFVhiY
 U6ChBQZRq9ghA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C979E17E1274;
 Thu, 23 Jul 2026 03:35:18 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 23 Jul 2026 04:35:13 +0300
Subject: [PATCH v9 24/61] drm/rockchip: dw_hdmi_qp: Fix NULL deref in PM
 ops on incomplete bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-dw-hdmi-qp-scramb-v9-24-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
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

The system-sleep PM callbacks fetch the driver state via
dev_get_drvdata() and dereference it unconditionally.  However, they can
run while the device is not fully bound.  If the system suspends before
the component framework invokes the bind callback (e.g. during a
deferred probe waiting for the VOP), dev_get_drvdata() returns NULL.
Moreover, if dw_hdmi_qp_bind() fails, drvdata is already set but
hdmi->hdmi is left holding an error pointer.

In either case dw_hdmi_qp_rockchip_resume() dereferences an invalid
pointer, causing a kernel panic; the suspend path is equally affected.

Guard both callbacks against NULL checks, and reset hdmi->hdmi to NULL
when dw_hdmi_qp_bind() fails so the guards are effective.
hdmi->ctrl_ops is assigned before platform_set_drvdata(), so it is safe
to use whenever drvdata is non-NULL.

Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260702151550.8E14D1F000E9@smtp.kernel.org/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c4cf68d79d5..7c9d26d79664 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -686,9 +686,12 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	platform_set_drvdata(pdev, hdmi);
 
 	hdmi->hdmi = dw_hdmi_qp_bind(pdev, encoder, &plat_data);
-	if (IS_ERR(hdmi->hdmi))
-		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),
+	if (IS_ERR(hdmi->hdmi)) {
+		ret = PTR_ERR(hdmi->hdmi);
+		hdmi->hdmi = NULL;
+		return dev_err_probe(hdmi->dev, ret,
 				     "Failed to bind dw-hdmi-qp");
+	}
 
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector))
@@ -726,7 +729,8 @@ static int __maybe_unused dw_hdmi_qp_rockchip_suspend(struct device *dev)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_get_drvdata(dev);
 
-	dw_hdmi_qp_suspend(dev, hdmi->hdmi);
+	if (hdmi && hdmi->hdmi)
+		dw_hdmi_qp_suspend(dev, hdmi->hdmi);
 
 	return 0;
 }
@@ -735,12 +739,15 @@ static int __maybe_unused dw_hdmi_qp_rockchip_resume(struct device *dev)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_get_drvdata(dev);
 
-	hdmi->ctrl_ops->io_init(hdmi);
+	if (hdmi) {
+		hdmi->ctrl_ops->io_init(hdmi);
 
-	dw_hdmi_qp_resume(dev, hdmi->hdmi);
+		if (hdmi->hdmi)
+			dw_hdmi_qp_resume(dev, hdmi->hdmi);
 
-	if (hdmi->encoder.encoder.dev)
-		drm_helper_hpd_irq_event(hdmi->encoder.encoder.dev);
+		if (hdmi->encoder.encoder.dev)
+			drm_helper_hpd_irq_event(hdmi->encoder.encoder.dev);
+	}
 
 	return 0;
 }

-- 
2.55.0

