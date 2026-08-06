Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C589C5ACD8
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A6410E373;
	Thu,  6 Aug 2026 17:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RI9OHvEv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F83810E361
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035745;
 bh=z3MvIWasYELAai6HO3er+8XiHnoakmXomvsc7NcTsdk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RI9OHvEvhVNX9locRwSkziAadcxYiqTyGBD6spHUiqTTGhnV9AGVKXv3invUW9QB0
 JU9ps3D4b9XSQcZ9Fe3RQuPR/t4gV+LQ64Yoagqy06KPqbU3fZxjxpSh+UXlwsRTVG
 wQXlCF2zycM6LNydLeKffrZw3bgrG2BqPD+l0F8LExAGg79JpPPi5yleNbDpt0xQas
 lvj31PJG0u2Ai5u7dVIn8oFbfcrAEQeA2/2Z/vtmsvUSSQgvV6IeaFzKLQzmlmLJZ+
 T6RKagkVyaSpVJqFQiJDASjideJEVrUjO3vUxgPVXhDVr0pWQYeAFHbL0q9fqOkUdO
 gu/MxIC8JGYCw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 954E017E107E;
 Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id F34ED480031; Thu, 06 Aug 2026 19:02:24 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:11 +0200
Subject: [PATCH v11 05/21] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-5-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=z3MvIWasYELAai6HO3er+8XiHnoakmXomvsc7NcTsdk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viBW6sz1S0JiZrIACnfpwmyyq09ddK444
 lv/NdCZw4Ct/4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qa+JwP/jmE3uFPI8XGt2YYAv04xx6V8D36pd/Cq4rb96Jgt5SrU/fz9MI8bc54IZoPSHea3sG
 TnXmqpwxnnVP3WZ+J8s6puJPBPF92tSwtmDbdEOeZIwMscYs5miNOXvVBMxbaIbsoQdj+hZp3qJ
 RN4A7WpYppvTJC4MSfAvDYP9s6ubZeiQo8hyux5F7ZCxlTqAYSYYyAv/sMYoFxEmsw/6mgcrXlY
 SfLnoFSDKjKiLJgnohF3ouJWVDeM0uPeQJrNgxrPCk5HaIFbajP1B4/bndDKiKVZdsEuSm8FA4K
 bUZwIqi+k9ajw6yc1Xc3Sk2AUKtp8pW/ejNKDU1JtBgpVDhsOGZg2yMMO/wWGAHhjuqj/sJ+5Kc
 m40N70Ex2rk+4n8/PZ8VEL8BdSI6S/vLAfx42oufkZNwbZQAOlk6EToHDVWdGi0FD1I6uwrpjD/
 X9Ce4LNFA/0fLqY5zV7VL2XsO+ZOjxA2oM98UGQ3ffZ+xLLiCbP6iNDKMp6so69r6eLGFPh8Hfs
 AuLtrYVRw9obu2fnZqZRBk8Tu+AontANWZKRYOGXYUIAIutbDSKTBFMA5WXMc1RhCo9f22Zx7UU
 ScZxr2EcTou/eJCX7QwZ6pjMkfmuoHYv4SPnSgGGMIQlWBmPfszWuUHhmW4c+zjm6lQOG86n/DG
 A0pWmKMnjJvHe35aJqsIuMg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 52e3b37259a6..b1856418f441 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2040,10 +2040,13 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->pixel_mode = plat_data->pixel_mode;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
-	mutex_init(&dp->irq_lock);
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
 
+	ret = devm_mutex_init(dev, &dp->irq_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
 		return ERR_CAST(res);

-- 
2.53.0

