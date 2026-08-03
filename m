Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D6BC55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C3510E07E;
	Mon,  3 Aug 2026 18:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XqBELNTG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB4B10E07E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780303;
 bh=gsnLkYdJot6Z1ais3o8Gn5zKRKRHUmR6IXkylWaPyJE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XqBELNTGDIR6Kn23VzSalnNY3N0Z3qALuVcDDGA6lM9LDt/j/3HNV2v0zLTipDjX6
 q0AYBWNEKOfwhFAzqXjhPesBO5fNHOv/n1beAEJcjNLFRwy7Aqu6OIYZEHAcmtqcPP
 WYpUpvIddA2q1Cwzp0Rf6uL1eGd9qgbIDfvAuQjE4ifdUy3tFLOPXab/vKZ9RlaaBi
 rAhSZ/24s/YMjYUP5kZb/GkU73ojhT3bNZ+8Qzw+Q6nFdwmQGS6MG8VgDZEIpoNWvQ
 mo2g0k7y0dXx3UJE2iXHM81XEjSN8QXRoPqoz8+rr3zi1tlAYCU3aL8bVyBitqMGUD
 zjBwy82rAivWQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BA6D117E08E1;
 Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 6473048002F; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:04 +0200
Subject: [PATCH v9 03/22] drm/bridge: synopsys: dw-dp: Fix error handling
 in dw_dp_link_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-3-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=gsnLkYdJot6Z1ais3o8Gn5zKRKRHUmR6IXkylWaPyJE=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E5RW8CHJOFx/ap2kREctC+xp44RGQRb9
 3YHU9jsZxop0IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhOAAoJENju1/PI
 O/qazc0P/jmxNEHDRPWvJ9vOHzDo2Pnelys/zqgKGjCVWSuCzKv6BxJ19dXi8Ur+m+P5h62Z6Ke
 BTz8r+dgEKl3BN7BEk4umBJlFxniNmFfqGP6zOB8VG+mNzzmIpKpcuKb15yGGEx4fERiSB1H9rf
 qGE+66Bd2fu7ISUTiIkEBKbEsB1t8n8KDoNhK+wwz4Ms8AJficCUawYDCfMVyWqJFaIMM3M6I7S
 EcW8x5X1Il+GXJLEX/LrnzuGjpLjSsHlIqaeKSv300Av59NUf2yf2qsU2YqPrvHd+S7oxvo/Jew
 y5i2XGnWADjUf7jZG1p6N2rQduwATvnYZRux+prwxRKA6Pb3IGrW8K/modMdK9BNfMLY9FTC8El
 Fz1rpzBQIyR8rWgNIQhSL4OYah2ISfz4JuzM+H+7XOroJZNDGXdrb3fictmOfhoiWV1oJ52hqV2
 ckB5t7e/zAtCi8IbAZG//UvCHZJH3tFh0MISnNplviqnxKrMR2elY7aeLoNskE8VkYE3Euyt6Ge
 xoQHUF6Ijyf/4dTdq/VCgntDzX4zKNlyQz8DUQO2xOaUJEr32kNoiJVqi67DOgeHSN6scPn4Pah
 UkyKms2F6uzgS8qCD+F8hnux1uLyJ1QD5qrp5z2fTb//kTIEO2CMcWnxuwapx17r3HWfIIjKwij
 qSSuKrrsTm+r2A+xCK0swvA==
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

Add missing error handling in dw_dp_link_enable(), which failed to
release resources it already requested before hitting an error.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 06997208945e..e332d66b8057 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1636,10 +1636,19 @@ static int dw_dp_link_enable(struct dw_dp *dp)
 
 	ret = drm_dp_link_power_up(&dp->aux, dp->link.revision);
 	if (ret < 0)
-		return ret;
+		goto err_phy_power_off;
 
 	ret = dw_dp_link_train(dp);
+	if (ret < 0)
+		goto err_link_power_down;
+
+	return 0;
+
+err_link_power_down:
+	drm_dp_link_power_down(&dp->aux, dp->link.revision);
 
+err_phy_power_off:
+	phy_power_off(dp->phy);
 	return ret;
 }
 

-- 
2.53.0

