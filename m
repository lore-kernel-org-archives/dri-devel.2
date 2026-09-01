Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3F0C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1320910EE39;
	Tue,  1 Sep 2026 18:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g/1nQ/19";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618C210EE29
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288647;
 bh=BAVvQD/OYJFSVikOMEpkXJX6KCpXHOl4cE1A14fg7sI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=g/1nQ/19FI8qMQMsk9TPW9ynbu0mqig+TqNGDDRAw/k24c6FZok7fnunDPNoLmHgh
 0cx5f+PWo6cAPTpSF+2OrPQZo5RUEHo/2i1d+A9RHTUzHm+befbSV1BkoZp6qnpEIg
 pi4juQIqA1C27pWAWTojnLpVpzR1quSuIha/16TI55yQ4VvzjXk/zn+E+RgjWDoqCF
 McnvO81p9oSn7ttudROkCJr+BFIFsug1/RxsE25zKQ7OZ1n5uCm3WVb5zy5DsWAcqV
 tWjrJTYCUf122fJw0re+8XFmroW7eUziqIDPHqEzKUrkoMPYNyKV/m6EmLJ+7dsrx8
 aK/uWiAXh1wLA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 00CD917E14D2;
 Tue, 01 Sep 2026 20:50:47 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:32 +0300
Subject: [PATCH v11 08/74] drm/display: scdc-helper: Add macro for
 connector-prefixed debug messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-8-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>
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

Introduce the drm_scdc_dbg() wrapper over drm_dbg_kms() to help getting
rid of the boilerplate around prefixing the debug messages with the
connector information.

Acked-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index d00da20862fc..1e7c41d4f926 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -58,6 +58,10 @@
 
 #define SCDC_I2C_SLAVE_ADDRESS 0x54
 
+#define drm_scdc_dbg(connector, fmt, ...)					\
+	drm_dbg_kms((connector)->dev, "[CONNECTOR:%d:%s] " fmt,			\
+		    (connector)->base.id, (connector)->name, ##__VA_ARGS__)
+
 static const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)
 {
 	switch (rate) {
@@ -193,9 +197,7 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector)
 
 	ret = drm_scdc_readb(connector->ddc, SCDC_SCRAMBLER_STATUS, &status);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to read scrambling status: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to read scrambling status: %d\n", ret);
 		return false;
 	}
 
@@ -223,9 +225,7 @@ bool drm_scdc_set_scrambling(struct drm_connector *connector,
 
 	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to read TMDS config: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
 		return false;
 	}
 
@@ -236,9 +236,7 @@ bool drm_scdc_set_scrambling(struct drm_connector *connector,
 
 	ret = drm_scdc_writeb(connector->ddc, SCDC_TMDS_CONFIG, config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to enable scrambling: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to enable scrambling: %d\n", ret);
 		return false;
 	}
 
@@ -283,9 +281,7 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 
 	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to read TMDS config: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
 		return false;
 	}
 
@@ -296,9 +292,7 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 
 	ret = drm_scdc_writeb(connector->ddc, SCDC_TMDS_CONFIG, config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to set TMDS clock ratio: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to set TMDS clock ratio: %d\n", ret);
 		return false;
 	}
 

-- 
2.55.0

