Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275A2C5ACAC
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D1E10EC20;
	Thu,  6 Aug 2026 17:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BDGHBD4s";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C3310E361
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035746;
 bh=HJ4BFYGE+BpWSg5pZ0L+h8cPm9Opa0kg25ZJyYX3+8o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BDGHBD4svxhT6TLZPCNKHZQ21TQdz7sAqGDBo9nZbEaP/Rm9PKzMv+9+4jlH+EI4P
 sbUT6T9naqBl2xRVqGOqvT5vUQsqqgNmvjSpIpfDCVx0zJ1qKL7iCl/aTX7k8e0613
 M86pXTB87PcxmWQwa46RU+koT6mUTzs/fpZ5RSFWW6e8KkDKYkRNMfw3P+mDg4LaYW
 eHhEaEFwZS9prK80/4vHOR0tPfZ5H5Z7rM62M1lstzpMN/r2dm0Apq4FP4+rWxca+T
 l+eaWZ1Yhlf9JRSjKWkQwwZDAb3tDs1warnr+Ojr85tx5MPGYiTU3iX01lHqSU4uJ4
 mrPWnFX1ssfEQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 06BF017E12A2;
 Thu, 06 Aug 2026 19:02:26 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 13FB0480065; Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:25 +0200
Subject: [PATCH v11 19/21] drm/bridge: synopsys: dw-dp: Use regmap_set_bits
 in dw_dp_send_sdp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-19-0d508505f383@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=HJ4BFYGE+BpWSg5pZ0L+h8cPm9Opa0kg25ZJyYX3+8o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viBeQd4T3g+Pzh1w/HSWJWhpMgYegO+Iy
 +9eatZnJLF9lokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qaLTEP/jVCr7EepydxLo/fMD/IdC1O0pgOGN9qsBbUljW+VAJ/GsyuKlQrhzvOXjBdaqJBOAG
 EE2kyD2KlLdPNd7RXU70h7NthOt/H3oiIA5rtRZsaXzGbGmnhT+kxNIKiEORLHQnK4iQQ/WSN9l
 LpH/bVfKyWJv49sDL8B0iLb0FS4YasU0LjK/nlhZoKizqZmJ3u59ZtqJq2bpz5ZnijRhrK7IQFe
 M37ZouER21fd/0esH0V8up7JkPk9lJGfNpgP0tR0X5tjFs8UXEr0rgP53ykJS3Lb0o9O8IFr/S6
 bnusAf+i38UEJF1APuGlW8eaArlJ8j228zcDip58D0DekagNGE+SHW+CVFbSeEQR33+u1tLt0VP
 uw84JdCBJ/mNpvx5P/mHkCpptCSH87GQxRBLqF/u9i9gb1u82WJR1lMYxTbMEP0dC1PY4n7nAjY
 30/yfHuUTktTH6Sdb41x6yP4neBpyKR512ppIEiyM5NVhkq/VWR1ZLtqWF5Oi+Ij9k5TAJvFDJV
 DE+j3QIIUiyMwX6W4erupPzOe1aMIdFaurTNufu1UBTMXaiOOQf2mo5YCCMWRiVn5YGC+RE/T30
 U1+1ZqrSd0BdandxE191wmQQ59I3gC4TAZMxW+hPXEK/xlf7Eqp9qr1K3S3SzhPSbCPokskxATE
 PHLtFwpn42sgWaLKTvv0oEw==
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

Simplify dw_dp_send_sdp() a little bit by making use of
regmap_set_bits.

No functional change intended.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 39e21524a965..b610abf76ef7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1070,14 +1070,12 @@ static int dw_dp_send_sdp(struct dw_dp *dp, struct dw_dp_sdp *sdp)
 			     FIELD_PREP(SDP_REGS, get_unaligned_le32(payload)));
 
 	if (sdp->flags & DW_DP_SDP_VERTICAL_INTERVAL)
-		regmap_update_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
-				   EN_VERTICAL_SDP << nr,
-				   EN_VERTICAL_SDP << nr);
+		regmap_set_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
+				EN_VERTICAL_SDP << nr);
 
 	if (sdp->flags & DW_DP_SDP_HORIZONTAL_INTERVAL)
-		regmap_update_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
-				   EN_HORIZONTAL_SDP << nr,
-				   EN_HORIZONTAL_SDP << nr);
+		regmap_set_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
+				EN_HORIZONTAL_SDP << nr);
 
 	return nr;
 }

-- 
2.53.0

