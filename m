Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFFBD6AB16
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE9F10F290;
	Thu,  2 Apr 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q2jFrVmh";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F2610F290
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 21:03:29 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso10901615e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775163807; x=1775768607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JgKnlABbU2+gqs54PTBh9GtjrgevTzoXvn7hgNc1m2g=;
 b=q2jFrVmhs2gJ8wS2TAYe9rubdY3PPeVhOGwfiiP8VUUO76/TLtf1qGcY42jWhnPo3f
 XV2MBF+yA9iHZKPQaUAOJIbbRNvKKm+txjHpQFn96xjgONM0666gmqDz/yt7XNgXAthe
 w8PM4b9mXxH4JOUGo4CEo3pk046ljMOBCo/+cOMT576h6QTruKZ52DfipkHdwKX0k6CY
 l9YWehcZZRqnUdnEEUcwUtARuqskc7TSbHdwfyEsUpKuMyEgQdyvM3QJodnWESQWtLYF
 7J6D/y+VFoYuty4iinhn/EQL7D/XagsFcWpFAHnLazYmbKP72FrDTSlF7mlQfU9srVCD
 u39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775163807; x=1775768607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JgKnlABbU2+gqs54PTBh9GtjrgevTzoXvn7hgNc1m2g=;
 b=MDyMa+jH0OC3LeisjIl/cF+IVxP8c29TM0GXKErdeLsA1WXjOSl2kdUGvPei2yqXKV
 fsK2aJe3qFRRa0n/6RqCqwPFc5bc+qlDdu3ML7+wIdU2C65QlCGDeiBZayRomWx3tBOC
 3u9Yb7w0va8o4+xV/W7DvsJH0kRF5BHYDhsFW1oEI7ZapiOaZctvWSL5PDC4KMjq6xJl
 13SqGayAycuHjX1JeW8MISPb0fHwQH1wMPAh9w0YQ6bf2g3JZ7NDSgSx4V5ijJzB/RV6
 4Xr1bYkvDQ68WChkmsDGfcs772J26Q3eZtNmNr+U7rH7MeqUXxp7uw1locbAMpSMsuVg
 xTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNU4z7KcideC0fjrlcI1k7lBdRINf9FBYzi4Aoe3xNzFIiHnVkUVgo0R8cJZGLDxZFrduPgEnK7G4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmpGKtEGcIJyaJFpbeq/kJh8AxshAPUITZU82yKixWRn97K9Q3
 KOpedRQKj+xjuaImH3YV9nsM3x9X55jYRZgHXGPylI0geh65/mEwkM6L
X-Gm-Gg: ATEYQzxSjOSCwMrqRQJuv/SJa99g2Zr8ZfU5lq/bHlXGDi8xQYJgbEcOscUh24PwodF
 ILBz+Vz0U2bmDnfvf4k0xuqq7SBAm6rcE9HEJEHgqBBnLTqhsIFqJ7g65Q5BZ8KlClhlWkD4Qeq
 gAL79CAH/qUr5+1znPPFlMWD+leRy3SWxs9QrOZWtAXx9hgSpuup77FkCiShn+9oN9AjJycLlVX
 B+hnXArvsQab/Wlsd3bBRt8w8SdKn/I2DuHBJxlAC4z/rxbIACpC4gKx3+e3/1K5zI1SAj25v22
 FPB/WZ9UoCDbkrXl+HTftaH+L5IClug3Gw2xTyXIby8MTBiaJTM5GOsGV1d5eZOElUqISqPHuFx
 K8ZQawdXPZpBvkCZd2+1ZAyebJd7Koz57XMvO2KU5bJy6ciRtNwgOFyL30wCdVsdEfS5jClsqT6
 fXLB7LFNsyrULMzd1NoRL0vntlIcUd/UJuSjih6DiYm0VzJHktVqLOcMkdm95sal65noAWcS9HF
 SzGiiwolKAUOPFYOARDhY5+flJCBeqzzsZYXGiQjs20dH1R+V8=
X-Received: by 2002:a05:600c:c8d:b0:485:4eaf:eb54 with SMTP id
 5b1f17b1804b1-48899793093mr7680225e9.20.1775163807304; 
 Thu, 02 Apr 2026 14:03:27 -0700 (PDT)
Received: from osama..
 (ipservice-092-208-105-189.092.208.pools.vodafone-ip.de. [92.208.105.189])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e832585sm409547925e9.6.2026.04.02.14.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:03:26 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, Kees Cook <kees@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-mipi-dsi: Fix bridge leak when host attach
 fails
Date: Thu,  2 Apr 2026 23:00:48 +0200
Message-ID: <20260402210054.42074-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

dw_mipi_dsi_host_attach() and dw_mipi_dsi2_host_attach() call
drm_bridge_add() before pdata->host_ops->attach(). If attach fails,
the bridge stayed registered without drm_bridge_remove(), leaking the
bridge reference and leaving the device on the global bridge list.

On failure, undo in the same order as host_detach(): for dw-mipi-dsi,
drm_of_panel_bridge_remove() then drm_bridge_remove(); for dw-mipi-dsi2,
drm_bridge_remove() then drm_of_panel_bridge_remove().

Fixes: 90910a651123 ("drm/bridge/synopsys: dsi: add ability to have glue-specific attach and detach")
Fixes: 0d6d86253fef ("drm/bridge/synopsys: Add MIPI DSI2 host controller bridge")
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c  | 7 ++++++-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index ca4dea226f4b..ffa169c2de73 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -345,10 +345,15 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(pdata->priv_data, device);
 		if (ret < 0)
-			return ret;
+			goto err_remove_bridge;
 	}
 
 	return 0;
+
+err_remove_bridge:
+	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
+	drm_bridge_remove(&dsi->bridge);
+	return ret;
 }
 
 static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index e6eaf9fd0251..d7c922d8841c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -540,10 +540,15 @@ static int dw_mipi_dsi2_host_attach(struct mipi_dsi_host *host,
 	if (pdata->host_ops && pdata->host_ops->attach) {
 		ret = pdata->host_ops->attach(pdata->priv_data, device);
 		if (ret < 0)
-			return ret;
+			goto err_remove_bridge;
 	}
 
 	return 0;
+
+err_remove_bridge:
+	drm_bridge_remove(&dsi2->bridge);
+	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
+	return ret;
 }
 
 static int dw_mipi_dsi2_host_detach(struct mipi_dsi_host *host,
-- 
2.43.0

