Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C564E10A88E7
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FE410EB31;
	Thu, 26 Mar 2026 17:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="e9NHhoOC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D5D10EBA1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774546298;
 bh=ib7f4PTuwY8kPJVoSf2e6nZJwrE7r5uosxSm8TrvvSk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=e9NHhoOC/tS4QF6dvsQmLl/fSCjHJ7Ar/sftRfUqtINjfevSvGHNvyOkhufYEUJPx
 15l9oJJnMO57BtvoF49ywI4Q9WVfGey8nxPKvSx1USG7qqcwF1eZsCt0caMUP1tYIN
 yOsESEDcNlt32DxHu0ouyrO/gUMYZd/v9gzznhCzf5qk5FDbGdvAb3TGbyAtkcf9FT
 YPZOEiTn4ZP5b/ko8nwmDG2N1AKVwl61S01O3qs18cdZkx/6rzIphWR12OFUwcGg9Z
 yiBZAxnLR8OiuYXb7rM1rI4Tyb3vg6F3uWceiRKvDR+Z7dgnGNxVuGoXyHCsavrO/B
 TK2dgbaXtfeEQ==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de
 [91.248.208.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B20817E6190;
 Thu, 26 Mar 2026 18:31:38 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 4057948002B; Thu, 26 Mar 2026 18:31:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Mar 2026 18:31:26 +0100
Subject: [PATCH 02/10] drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-synopsys-dw-dp-improvements-v1-2-501849162290@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ib7f4PTuwY8kPJVoSf2e6nZJwrE7r5uosxSm8TrvvSk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnFbXmnC95nPls+Yyqj1s1uG/t8PoHbkbItM
 bGyvgrYUxUvbIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpxW15AAoJENju1/PI
 O/qaRRkP/3sVxjoSl1PgF87qI641Ov3TtoVcKAbmcIJqgaXsblfVJwnpBmlL1Mgx9Dz4tO0KuDX
 lQhaFyKh4KSBnlGtoRK19Tv9/4PRi1XjU7LVwp+GARCJTJeyf8fNmFpZaqyp98NRX9NFNIZpQ6G
 P0QG2//my/aVFJBYymneWVSOt3h1Q9xX8btrbvFRtR34LGceSD5EkKk7lX5w1phjAnorkGTV08N
 PXzbqDe+sMKiscKDzVfG8IgoOD1m+bw05XBm2LbbHgyp8VEWAuwDnDz1EHcMV2OI+Ak745UBzzP
 NCxZ1xCu62N9D3JkQ49MmT+Z+GG1JYbc/ihnlfS3vYBOef0MVGblknVFti/r+icjl48/h3lC+Kx
 btHavU8mKc1HAUVIbFmG91rmmyw2gK9AnRaGJosbeGc3Y9sZMQUbiRVFKn1srsYclHBXoQHlK8/
 2fyuNN1Sn7IQws3bj7QLVW1+Ia5U95O2wrB8DtpArUEM5fB1D7+//FGL33XuRvCECCVF5mK/Wck
 /QU7KshHx/QzBvGj/upYW1RusnHu8apSh2tthsoEOybCQ86yR3Z2Sss35FI6yfp18Zxjsecmb4u
 T7r/1u+qQY5LiHtbZ/qajIPhwAxEhrhMWYZjEWsxNB3J40IEo8GaYhn97zQyjjXDRxne32fGiT/
 12nDsKJrEgnQuNV3/nPk15Q==
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

Add support for MEDIA_BUS_FMT_FIXED, which is e.g. requested for USB-C
DP chains as the last bridge in the chain (aux-hpd-bridge) does not
implement atomic_get_output_bus_fmts(), which results in the generic
drm_atomic_bridge_chain_select_bus_fmts() code using MEDIA_BUS_FMT_FIXED
instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 8f2739fa189e..222862d962d9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1528,6 +1528,7 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 				     struct drm_connector_state *conn_state)
 {
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	unsigned int out_bus_format = bridge_state->output_bus_cfg.format;
 	struct dw_dp *dp = bridge_to_dp(bridge);
 	struct dw_dp_bridge_state *state;
 	const struct dw_dp_output_format *fmt;
@@ -1538,7 +1539,10 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	state = to_dw_dp_bridge_state(bridge_state);
 	mode = &state->mode;
 
-	fmt = dw_dp_get_output_format(bridge_state->output_bus_cfg.format);
+	if (out_bus_format == MEDIA_BUS_FMT_FIXED)
+		out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+
+	fmt = dw_dp_get_output_format(out_bus_format);
 	if (!fmt)
 		return -EINVAL;
 

-- 
2.53.0

