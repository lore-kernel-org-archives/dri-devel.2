Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08162C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623D010F2A5;
	Fri, 31 Jul 2026 14:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hyc8x1Bb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B3810F2C6
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785508929;
 bh=6Zd4OqerlwYFnaNKsaEfTrdLQVTFpRQ12tFpK/5BhJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hyc8x1Bb8PPLWTsAgZxGikygGIa0kC307sPMe8wTnCma5Duv0TCDIO25KLaAjMHik
 sZbWMCeTJTFbNSpUH5LxSFFrlmySEZHGFhhQz6LP8DhzxBfhNkXdBjJ/fqDY9RBabF
 Lma4xBt6CGDN4PvX48iL/fD1d3wSdVVa7whnF+b8b7uH9GfrhMy+pcO6YGfUdd0azz
 DuGpWUCMmElWRPCdVcdxECcEshzsiOwxPCPrIDCq8+HrE3Aa4UwQz1A/fLTgM2TlXG
 EPxK5a5a7qnvqVyo+bG8MSx2VO65p6Wbxj98yQHQj41FSB72apQYS+eelRMkGA3I7C
 jBFHIDnTExg9A==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 484F617E08E9;
 Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0007E48002F; Fri, 31 Jul 2026 16:42:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Jul 2026 16:42:08 +0200
Subject: [PATCH v8 03/21] drm/bridge: synopsys: dw-dp: Cancel pending HPD work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-3-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=6Zd4OqerlwYFnaNKsaEfTrdLQVTFpRQ12tFpK/5BhJY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstECUSFS0UuATzDi49K5jfLrdgHALtoP6U
 ERnDnCO7PzboIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qa0EoP/iALzEtnGFHT7YRM+2ilE/+NXt37lixuptbvRSq2xnNObsWOq+yvBKlpiXGlI/Cucyt
 Eqy/hTkj39yc9m6ugwoA8vUx+L2650+31UJlXnq58H+yVYh2LBp7hGUQoutnTzKEC92sxUCdiaK
 HytSk8rRUBtrSnFewwsTqZ5c+/2zZM8LdaDBN2GInFBhAFgIi7pIMVcUrXGJeUfAUmJUfqYLpfY
 mYIkhHerxofXidru1yeJnonO3Hgax2eNnNVB7bug1PfiOf3j5vwUHQNMrr5Fnj/BDbRlOGO32gM
 gPb+ydDE98rrOZg8itEHeryM/fzUOHF5QMYOc5SaeOdd+cJ4iVqid7GJypZ5svc16gwa3mfRiMy
 nat/2bXmU6HMEEVp1bTm0eVccY4pS7C30bpqkR9AFatSwsmBta+nlFPABo2N71Maf3lUgRDQS3s
 51McPGRdntPCTw7CKqeSgjX46M9H9psLgQODgdL8JB0+E2XYZNFErExr90pgSrntCGfXZVVREWI
 g36VgIjedisNopholbLYN6qM9DxVqOkx1bHX6cJJGKvCevvCOjIPhaEe0+4a/Kulccla2dVbjBP
 Pt7IErXG4zw72KzC9B2wr9kZ/NKzoH6keayUZ+kN7E1rVYrpIG4MEVKkMYls/Dm7D9SCNUXJoyW
 Fzo/Rnc1yHnC5ugEmWfUz7w==
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

There is a race condition during device removal: If the HPD interrupt
started an HPD worker exactly when the device is removed, the worker
thread might access invalid resources. Avoid this by stopping any
pending work immediately after disabling the interrupt.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 7f8249514171..6289ed06e231 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/devm-helpers.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/media-bus-format.h>
@@ -2027,7 +2028,6 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
 	mutex_init(&dp->irq_lock);
-	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
 
 	res = devm_platform_ioremap_resource(pdev, 0);
@@ -2108,6 +2108,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	if (dp->irq < 0)
 		return ERR_PTR(dp->irq);
 
+	ret = devm_work_autocancel(dev, &dp->hpd_work, dw_dp_hpd_work);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
 	if (ret) {

-- 
2.53.0

