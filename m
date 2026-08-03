Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7061BC55838
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7111210E644;
	Mon,  3 Aug 2026 18:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EIl2wwhT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA0C10E744
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780304;
 bh=GcGQu+BFm9oPmZHzAujBqT6aIdDXQL2Hqtb6N/i0x7s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EIl2wwhTJFInLF67eshJeFf4D5f2bGGjBhuP2tzdaKPQSKgNxIRO/uqv8H7AJUmCt
 R82EVIaeSOdwcgJj7OsJEzbSVQN0IBmeFP7aS6hISlUrmgXjtm9MTTpruoYtqwzSiK
 KhIZ0x/um63TfcG/BVcYhoUTVohhZpHtrRv+JcWy9QE3hKPLJeXcX4NoAUKunqhOUU
 u+JDZxO5U5AeBbj1kd+2BQGNMTw+JRkLLf3ztNKoiN4dUIcqFJOz+INH9zLKNCHQCo
 OihEEfsEz62XxahVs8HF+QDGls9hCieoChy7Z3N6s7rbNh47rSAYw5U6AhvJHjn6JI
 Z8h4gH6NOHxxQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3276617E1104;
 Mon, 03 Aug 2026 20:05:04 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 6D66848003D; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:10 +0200
Subject: [PATCH v9 09/22] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-9-2e6e46135312@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=GcGQu+BFm9oPmZHzAujBqT6aIdDXQL2Hqtb6N/i0x7s=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E7yZyKT1Iv3rcOC2ucMejbG03+Qo3qdB
 TiKuy/dUbY314kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhOAAoJENju1/PI
 O/qabioP/2eHyDr5D6AtCEohMUlI7OWcgWD52MCFamJhFA+GnQUakQaBeIVvXGS05JVk9GSrRfP
 QXbYseD6JrAn+x8LnAJ2pIocmMf0KgldXpBtOItdehi4VB5hp4ZfnPuacIQ5WxYSD69oeIxlN6W
 Tu2PrsbgHY8BsNXzO8XriNocxRnnTGHZYQTSU+5aiGj2GNSHyHBpbYGw1KvkHgcUyPoY55d/jEt
 d3ud/jjWBMdwQdp1m0lk437BAnewmudgiUzk/BppE7E7hHC2R0M24JQmKxR1oM5myTnFb+24NmH
 M6heUed/v3ay0gjLvLKU4xexxfiY5laQrIk9i6C5ce0RcJKBZAjJ7gvbAi/fLhBleaX+hCRv+Ud
 hAahQClpR0iZxWOakqnRkv7vb9tdwJESXKQ0/ZpddW25P55EPff21MjDicIX7n+WcC3KdXTxA7/
 PF62AiWP0AXpF8Dh51lYpAuTALvwg43retHD1zPLpiDoEhJKWpVab3nAoTzMBqjULC+Uiyjt7PT
 rL4gIA87eUTHj2cHMysZnClraOztkjoJG4XgKCPFk+CTtXQL9EidUdlRq25oeiX5uJKEgEF7qHV
 ar73mQqpBIenJoJXzvgly4uoIhfA0ljtsTePYa5SWlQC3wGqYZefTn1mKwmFgpb4JHEGoMY00Fb
 h1iflOrl3ocpMuwhCq/Au+A==
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

If dw_dp_bandwidth_ok() returns false for all formats, *num_output_fmts
might end up becoming 0. In this case functions calling it assume that
nothing needs to be free'd, so free output_fmts within the function to
avoid leaking memory.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 22a244de08aa..bde938b0d116 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1813,6 +1813,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 		output_fmts[j++] = fmt->bus_format;
 	}
 
+	if (j == 0) {
+		kfree(output_fmts);
+		output_fmts = NULL;
+	}
+
 	*num_output_fmts = j;
 
 	return output_fmts;

-- 
2.53.0

