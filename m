Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2BBC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF9410E279;
	Thu,  6 Aug 2026 00:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aygFU4mT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FAC310F03C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785976751;
 bh=0LdXuxOKKs318XAl4WSr1g2oS54qVCij4xOtaVQvuVc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aygFU4mTDp+1SH72m5Ofw2/O47G50wrn7yD2XKs/A11vSoSMZZMo/JMa1h4R8wbYZ
 rFRQfjV3usR/Z6jIrCfrGVS3SuuNE94hUVy8Umvvt5fUuzT+cRJOyVmf+4A1/AiS4v
 lebHUUGFOUpT3em/h19j99wAWTPBMD70QsRCwjYeYtKLxKVRvOZIVdfQQpmh5PINwA
 o1W8Y8xO7FVHgjkuFuAUvmj0E1ru8xfeqGpKE3BE4FwWu1T47uikEfnZwA65LWP+By
 f8TzwWcfEJ6el8PKldIcGu+VPN2EPNNaPOZMyqbMM5NBnw6hWltFXZjz81IW9LB6YL
 6HEVpwbMWleEg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 310AF17E07B6;
 Thu, 06 Aug 2026 02:39:11 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 8DE08480031; Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 02:39:11 +0200
Subject: [PATCH v10 05/21] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v10-5-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
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
 bh=0LdXuxOKKs318XAl4WSr1g2oS54qVCij4xOtaVQvuVc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpz163sM+axQnALjM17B31DOPMOywcgc+uEE
 MIxnCsxa0zQK4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqc9etAAoJENju1/PI
 O/qaLkQP/3yDnfT+ooSc0Fwcb/3ddyFGyD/pZJVslRSQJiX2xlE8WwBwQ1/Mid9Uk7D+ra0WSJX
 sfI2jj24o9TYu8sA8k2EUVqu+r+aaMMdJArzS+O8O/sruf5t/HbjaItaEiRn6wa42M8abA9x+IE
 six14RXAw8wm0wCCH8JAUVSqfOVqew1yH59XlWr1SMmrTNYTSbcP99d6wShkKruCB/Df//eG73f
 Hf0tYk6oVcvV3tbPC5Tspp8qYSWGv11gKy0Ta+W8DTNOL7WoCsDd5WTUiUZ6Dgbuac5KmV6DVV+
 KzX5OPxuPWewIV1ZjBGZFNturruA/7RihZX4kV19qSAUSDolijCWEk3uwOKlg9t/uoOtvH+ydWM
 rPKUPgJh0VdNrks+FqRR3W5iuAli+Qhqni2gpq5FYtiHk1SdzSC6hKSFUC1dJJKLD5WsdFR6G/X
 BXsKmh5bgZX8bAOAWWJqS2a2ErbqorrD+SAVrJz4NXaKannT7mdTHDANXB/0dUvfmxa15iI1duk
 E7XnVimY49fD1z0ZEnn0BDUfHQa/y0OKXnuyn8x5jEHCZ9fnnCDUMFTKLwvRD7HnPCR2NYqUCUu
 zOHdaeMjtba8QltnN1XhnDwEmr3TQFJAjySt1flCX332MI56Ixm4xutw8fBnivyJLEbQLuoa3pB
 FLnupPlmt077YApYJR6Mp3A==
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
index d3f93e9ba60a..7bd4befd84c8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2044,10 +2044,13 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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

