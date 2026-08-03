Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8844C55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675D110E74F;
	Mon,  3 Aug 2026 18:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kejvUvAK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1AF10E712
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780304;
 bh=H5ZUJOl/H1QOryuuNilUdPBhRk3UnTA7OI1VTUSXwiU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kejvUvAKUih5OClM7cUMIBL5lQgt+4P3oH+1t6L523e/hlGIQK0tMIYjRQRQtl83M
 wxi47eUppylZpr2e6F9qpFhT6UFcAuNh2sTqMRsO45vxqzh4rfNwOPqptNucI2GNnV
 mlekXq9WtvRYXaYMz4LQJC9NfZ1dW0p7c64h2tPbFsOH4i5L5iIQxzbamXsOUV4lfC
 k52B18AUWPuWNeRQ/M41G7BZ4edzQU9krE4sEYp857yEiPxr6f4/NtTNd3jrg5umN8
 0yidLoK+HAuOU0aDTlbNZijwPCif9U5pOcf+kPDxu9ess6najQN1rQU2FBrITJKajx
 NwBSpy11lHLCw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BCF1E17E107E;
 Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 66089480030; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:05 +0200
Subject: [PATCH v9 04/22] drm/bridge: synopsys: dw-dp: Cancel pending HPD work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-4-2e6e46135312@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=H5ZUJOl/H1QOryuuNilUdPBhRk3UnTA7OI1VTUSXwiU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E4odgo8y7L0BhfmGTZQvmB5285+7lh85
 8i3DqHO2o5+P4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhOAAoJENju1/PI
 O/qaffUP/ArN/c6teqkaCXzww1gFCCj954fhfj9yFNCplV+OoZxLYBJdeemUzrxhyErVYRJ+85M
 7cwjk8IFbpqbwwR903XZuG+q8/spForWmw5k3SnSE4eZ0KTVf1xs5t1aWhm/pLAJgagSxsVVkIO
 l3asIRk3FXpQjh8q1S9xxADa/mFDKgp43dmzNx8uf8umgV0J9Cn92m/KCrDJSbYedxDCtl90GNn
 GAcjx3jm5L9PuIiErxqzrf+8/oQQrBjPqSPOdyKTJEn7XKRzRrsnTLLVYGDksDuZCJgkK5LdgL4
 hD0n+8+EkvawBJrMy+JWsMZ9E1ai7HqSg05s77UjZLgFm3p2nZnqu/Pv/jaE2DBMfolci7hBFPz
 gpT8bLKOgmcUCmWoASNTHjR4EDo5I+oy00uDXsoESbiGBBEvN+rCEFi+1qwEWpKpup8RpEMunqa
 J91TUZoIj1lREgafZTG1DC7S/h0+yZUcYrIr0303HEvIBkxgDwiOpnsUBsAooBHOchtnMoRkgQo
 Wwqo+Taz2KMxX3fJL7gFA5nBmofgFbR5btlHRwyY5pdcp02AM7kZQ6HWVNrMSi2JD1FLEwh2W7F
 oiQoawFP+V0tgQKicdTT+YNxzN15SBeotCSwiH1zdjTdW9hbGo6GjZfSZi+dYz0EDsZk0mzpu1z
 l+YhcbtopauuWvqjN8Ow0aw==
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
index e332d66b8057..278953a8549a 100644
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
@@ -2039,7 +2040,6 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
 	mutex_init(&dp->irq_lock);
-	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
 
 	res = devm_platform_ioremap_resource(pdev, 0);
@@ -2120,6 +2120,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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

