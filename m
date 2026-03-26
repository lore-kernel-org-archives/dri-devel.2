Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059E010A88EE
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1095910EB90;
	Thu, 26 Mar 2026 17:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gg3RkyV7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AA510EB9B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774546299;
 bh=WK6R+7QJFKVea6UgKC346gGcxVko+iiFZdNswmotuwk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gg3RkyV7SLcdChSgalrdAL3vJb9j9SMuQhkKCcMJb3pX5UWbvd1aqGeNaxf6QRoL0
 ilbr7f4Fs8cAByGC1kVpWZ07JLqdRAWVCZfA7DWOctm/Uk9OLy0Ew9RygX6itm0tCc
 MthaTvYfY0rf2dEwSYYY5Af02jdyuroeu6LuZLvM1hXcDGVRCnFWCPiWY1XPt1BN0g
 QP4W9fbpkyPM7FeKrPvjshJZigQf22dS5LgvnqhEJchyWXEbZbcUNknCAb1O5diXfr
 8aFGAR1rvTjdpg0y8RFQeQW0Jv4W/LRb0HxZo3TXjjKX8RI97/r8d/N4E13HGaqbnb
 p84G7n2h5slGw==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de
 [91.248.208.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2DB8C17E6199;
 Thu, 26 Mar 2026 18:31:39 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 3FCDB480028; Thu, 26 Mar 2026 18:31:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Mar 2026 18:31:25 +0100
Subject: [PATCH 01/10] drm/bridge: synopsys: dw-dp: Simplify driver data
 setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-synopsys-dw-dp-improvements-v1-1-501849162290@collabora.com>
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
In-Reply-To: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
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
 Conor Dooley <conor+dt@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=WK6R+7QJFKVea6UgKC346gGcxVko+iiFZdNswmotuwk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnFbXlTLjLV50RceYH4oIZermgoMgC6bev7s
 AivxRoBxfY/BokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpxW15AAoJENju1/PI
 O/qaYXAP/R7QF9aI9g2V8v1VTeFd7/PWpJusJmFvAilKsdiOPl8EBa5EZ6UuZyTltH/dy9yEGJm
 v8bI6yo7HDFBonXoRdr80VtAqf4bq3lLuDysjRBUj6sx3UK4fHY9fOTO46yazuMq9Bn/m6ibK90
 qHZpCfzhTGIW9rO8MyXUYtMuwGiI3lrgy5nEpp6xsjjWs1nFfQ4s81nLniom/pItzNuwCLPlUxu
 3+pIoX2QhRki4+jRdVI2LgWUATAOAEY+pPP4fHjBNd5O+ZB7efI8zIVfQjoU/kqLp8dO3mkc40k
 B6XzZIy2p7Xjr5ABc+sKmd8DPACpOiQPI5n7sRC0YK75yKH9hCiLCHeYmL7XAK7kvx08qN9IN0a
 JlWs6X+tSblxgdccUcLTxSaCrWK4boMsDcWmky+lK6+T9ZCUIu2mlEmKx5yM7u2RZfmCIRMOHtS
 rZzRbYJoLQyuTII6tNh8fMxBny49analj8D/gWrawy+dNsKnpc5y5kCSSwq+JnQmlff4zdG8IPL
 aBpx5oWIyAjQJQ1+6AaQFSapFXJNrCpOeVzRUPKkVaEKNI3Oa+Bh0/oMm2fL6RQkZuOLqujueza
 TeCuf9nT5oyNaeAupV/7+c1S2cGTKL7agfJHJh0obqGXnkNjhbaaeuUoZtoDn47d4Azrpc7n5Bv
 9djN06H9FpQu1Ijg9yCoy5g==
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

There is no need to get the platform device just for setting up
the driver data. Simplify the logic.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 22c0911f1896..dd8db923d6d7 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -74,7 +74,6 @@ static const struct drm_encoder_helper_funcs dw_dp_encoder_helper_funcs = {
 
 static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	const struct dw_dp_plat_data *plat_data;
 	struct drm_device *drm_dev = data;
 	struct rockchip_dw_dp *dp;
@@ -87,7 +86,7 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
 		return -ENOMEM;
 
 	dp->dev = dev;
-	platform_set_drvdata(pdev, dp);
+	dev_set_drvdata(dev, dp);
 
 	plat_data = of_device_get_match_data(dev);
 	if (!plat_data)

-- 
2.53.0

