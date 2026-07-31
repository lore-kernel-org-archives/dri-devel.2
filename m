Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78733C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C4410F293;
	Fri, 31 Jul 2026 14:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iWBZ9U48";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D581010F2CA
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785508929;
 bh=xnajaehGeKqaSKIiYJaOEGQ01W5URX41oCYdG+inSws=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iWBZ9U48IBmQ+EunYX6JEJrXwp/0+0vrsYnpy1J9I9dqHmVLEJWeVCLo+A8nrYHR9
 3qXYo7ImnGLb8Amiw+de0txge5GZiLuBqf3EPPd1sKKyFwZXRU8mV8Mu6nq56mmqzj
 9Pf564FY23HCqDemuRbP8xBzyOs5n+PrbIdmoBz96wfvk6SRruT29nMWStm255k8Ab
 +Gia+SothP1qSQe0SrOo6xRbObSO9FquGkmHX4xBWh4VEXSdMiqikg1EIlgaefqyxY
 /OBmY+4yAhgkl8/9geZHcetdawWsQngF4ajCxqU3qdTGmukZdQrHYU9vBRzWvmnKuL
 doOS3wPQkIIZg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A6A5317E091F;
 Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0995C48003D; Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Jul 2026 16:42:14 +0200
Subject: [PATCH v8 09/21] drm/bridge: synopsys: dw-dp: Support
 MEDIA_BUS_FMT_FIXED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-9-ac1e6a75782f@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=xnajaehGeKqaSKIiYJaOEGQ01W5URX41oCYdG+inSws=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstEDF/O6nFlXMYotmPi7Paj6gydxBGAsAO
 cht73WLYlT1n4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qaLFcP/1NC9hlZH+xFFCRuPhGo40b81NgQEFjg7VgSzHTOlAX7cm/aDlzbW+MOhEhSzmrRlh3
 wkhlZVDKHv+rDvT1/7XM2Z1k+S3jL3W/DZRPhlNljW8H90QThXOG2UAgUJFRDiccO9+eq28lWNF
 qF68qxLGuM3EXcqXASkqkyVnQhc59ji0eIYfR25tQIGSNjtQ0jRyujdQSwtYKClawWnyMQnkyCZ
 djhNrcygXjBd3yosDHEfoqUkaPW7UmQzfi5f1d9fPN4HGTUuLhc0ziRqM5UTfEqFSAkyS+4Il7j
 ujwXiN/l7ergMQfziHbmCzRmvUosCiRx0ukoVejCVteNC7jrcKGvvfXOrGtgiXS6vGnL7WBGXHu
 U3wUQLkIhYzB28oyrIExfBLEbbsxXqpnQvIG/do6uBBod1VJ9DI5dkjocgrNVzQV8WA3plYPkP0
 TfmM4Tsh/QogHJfEddh8KpI/vZw0rVGJqq9J8g5IWTZ2A19e7gy0SuaLiLPOTYtdcM/a9BYqLgo
 t9bT98mk9+/MdyG0g8mqoAZ9Yf7XGtorN5jlOFFOC9uadvEf9wVMAMHaZTbsoBiQyCgYnCWJaue
 /k0J00we/MKM2ZB5+PIw2+KbMTpqAq02NDDdmSb+j2vq7gq2JMBFjsf2Sch7ThJ06y4ZEXY9iup
 JvuwrAqldq1BtzQf7FxwySQ==
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
instead. For decent support of this, two areas are changed:

1. In atomic_check, resolving MEDIA_BUS_FMT_FIXED output format by
   using the negotiated input format.

2. Implementing a custom .atomic_get_input_bus_fmts hook that, on
   MEDIA_BUS_FMT_FIXED, advertises all bandwidth-validated formats
   from dw_dp_bridge_atomic_get_output_bus_fmts(). This lets the
   upstream encoder negotiate the best mutually supported format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 7127928c2650..42927335f0fd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1537,6 +1537,7 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 				     struct drm_connector_state *conn_state)
 {
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	unsigned int out_bus_format = bridge_state->output_bus_cfg.format;
 	struct dw_dp *dp = bridge_to_dp(bridge);
 	struct dw_dp_bridge_state *state;
 	const struct dw_dp_output_format *fmt;
@@ -1547,7 +1548,10 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	state = to_dw_dp_bridge_state(bridge_state);
 	mode = &state->mode;
 
-	fmt = dw_dp_get_output_format(bridge_state->output_bus_cfg.format);
+	if (out_bus_format == MEDIA_BUS_FMT_FIXED)
+		out_bus_format = bridge_state->input_bus_cfg.format;
+
+	fmt = dw_dp_get_output_format(out_bus_format);
 	if (!fmt)
 		return -EINVAL;
 
@@ -1814,6 +1818,32 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	return output_fmts;
 }
 
+static u32 *
+dw_dp_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state,
+				       u32 output_fmt,
+				       unsigned int *num_input_fmts)
+{
+	/*
+	 * MEDIA_BUS_FMT_FIXED means the downstream bridge does not constrain
+	 * the bus format. In that case, advertise all formats supported by the
+	 * DP link so the upstream encoder can negotiate the best match.
+	 */
+	if (output_fmt == MEDIA_BUS_FMT_FIXED)
+		return dw_dp_bridge_atomic_get_output_bus_fmts(bridge,
+							       bridge_state,
+							       crtc_state,
+							       conn_state,
+							       num_input_fmts);
+
+	return drm_atomic_helper_bridge_propagate_bus_fmt(bridge, bridge_state,
+							 crtc_state, conn_state,
+							 output_fmt,
+							 num_input_fmts);
+}
+
 static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
 {
 	struct dw_dp_bridge_state *state;
@@ -1860,7 +1890,7 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_duplicate_state = dw_dp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
-	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
+	.atomic_get_input_bus_fmts = dw_dp_bridge_atomic_get_input_bus_fmts,
 	.atomic_get_output_bus_fmts = dw_dp_bridge_atomic_get_output_bus_fmts,
 	.atomic_check = dw_dp_bridge_atomic_check,
 	.mode_valid = dw_dp_bridge_mode_valid,

-- 
2.53.0

