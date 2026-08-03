Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB29C55843
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1454110E722;
	Mon,  3 Aug 2026 18:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="b7otiZjW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7348C10E644
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780304;
 bh=yZLykTAN6AQqRCp/IEz9fXVJbOyScQBTvpn7mrG0ZFs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=b7otiZjW6OVVvIWlYupsS/VkYvRIFI5GbKPasX3hsNhenBpvZqes/4HaUUptyCwXd
 AZkdP5QSVtUYhluNgV6p0m/MBOFnFAJKRy2NJmKDC8Hlg++3zuvznNCYj6CSbXirb/
 EOOEzh30mm14dcNDv2dBqf3aGXY2sz5GNB+5Pn6ocrmuSvEekTouBLK1buhq9aQlO/
 TyE8rxnGsxmgMNx7qn6XvHFvw5qaGpWfAhq/DlaZeCgcvT4Wa0RPTXaB/fpSsPg7lK
 XvBNwl4DwXofFGktDmH82+nJmO7EwTqWMBr5vfJ1uj0L18TjSQ8HDsKbXB/Vw4d8Dc
 DHBFMFq1/7zLw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 971E417E125C;
 Mon, 03 Aug 2026 20:05:04 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 7DF34480066; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:21 +0200
Subject: [PATCH v9 20/22] drm/bridge: synopsys: dw-dp: Use regmap_set_bits
 in dw_dp_send_sdp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-20-2e6e46135312@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=yZLykTAN6AQqRCp/IEz9fXVJbOyScQBTvpn7mrG0ZFs=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E838xnyCpPYs/lfqW9PfzxPmMY4dTE6A
 PFN994EeZty2IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhPAAoJENju1/PI
 O/qaQcwP+gPYook4xajED5bjNUiWuN7DK92L0yebsvXMlJvDhENy0lowzQaQSJnww+0IDpLCOz8
 7b4SY/+BXBR4NXeA/AW1cbOw4YvY09MtGb7dEf3aFCgDjq5i9b3GyytqDRltf0dW0YniCAV2yg6
 JJmrn2COdeE/0P3nyqn+yw7WV66YZZ4wF/Vdbj+inu6pZAuKQzkMDH0UMLmo1zMmxctT4BPve/I
 JbYNPDkeH/VcifPuAdhFXpW4P8JK4XQNVNE9JqAZufjkY3x5SqCles2Q54axkbKIxqxLsSu2Zyg
 Fj/qeuNXO6U2FH93zpgHo/+zpnqCXg1OyKnHnV54lX2tw+WnWltBobQeyNlMpNKBVN/fFOBbk4z
 /BfW6mOo10Q11Rvgx0KnR54iSIOENl4kiofc+z6m7lcDr4dFkF2f4pQW2xBkicQDuyvTliNktaM
 UkxWpaMMiZ8mVKBrI/toLD6gW88iN+Tgv2SPT06X3oQp44nV+vKlQXdQ7krfTvsSvpTQkl+o1R4
 DjG1ld96J998Ri/okStcvkQfvwjZ9caM3f6Y6Ynw0xrk+46rbWu/2uwi7zF5kGu7StuYzDEO2ZA
 DIx5X9OYuNnOE59gfuGeSUkk0pLIxNFq9XUgfqgNN32kFVAVqU+8zILlfSpCzmo7la6w0Aksq0u
 9c4yrPNNVcjeDJGSVlJk+vQ==
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
index d8c6a99e93b8..5d10a60d265d 100644
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

