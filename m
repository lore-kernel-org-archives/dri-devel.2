Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F418FC5AD05
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DA810EFE8;
	Thu,  6 Aug 2026 17:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IL84RrKq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B043C10E372
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035745;
 bh=6qZ7A1oz5Axgnpp4GtqPS8WNzAaEjziX3V59HPLoil0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IL84RrKq9Qn/9nDJ4RKZCLffv8gFO4UGPPvekqyqJhxtl6uQ94/+qymqu0bYnOEoo
 Qin9UyUEhqzizwv47DjWM/oAOF+fIvydI8TMosmvnTrIhV+cKUVgOrMENA8eg96pPV
 yA10c4ASs388BDAKgwGCnKIW7UYl8vpXLAvN4x60dQIyUnbZMNd4gN7yxYG8eF3864
 9Wra/WX7SfrNzVAzQtu+7VZogU4KBu0zYrZo3uOubTPxAUtcJBlQ2R1WorlmwBYR5u
 1ZJetLcu4jxaqNoZSQG2XgXh4jRaLmYNVzUQjXPPsnDVMTVXEd0gj+Za/+kNla+A7A
 YagArL2WqcXiA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A6D2017E11E4;
 Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0545348003D; Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:15 +0200
Subject: [PATCH v11 09/21] drm/bridge: synopsys: dw-dp: Support
 MEDIA_BUS_FMT_FIXED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-9-0d508505f383@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=6qZ7A1oz5Axgnpp4GtqPS8WNzAaEjziX3V59HPLoil0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viA2oLTbGPrfeF1fSUlY7wWRiqYYBQYG3
 0WQreawGeBxuIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qacpQQAIAY+/RYcFy6YpPeU+CddLaw7vJg7XEWrOkvs4azi4PWuRJfEp8Hms61aQKA+qkil3o
 IijWR/tCOaiuSxiC8ylonyUL6vk6GOOvTol/4OiP5/QVq3tSMqFcAwtLAhvVfJRt9gA5mZJtDkX
 evidxQH5Tl2QJo2avPmVf02bydluGMSd2SzfRUbY2/Bjoo9kj4WukkkA0XdroatEoBmldJvrVyJ
 ydcexKFc1wVTd8t6kjpZarz4RzhBVlj+CyEovJUliRIKW7PITeQn50dZo0DepGsly7dO8j7Sq4P
 +ZntC0rAzcsqFsuAUSCY5VkDZjIrqKMpDOPKN1xw3BotzboH+uicTOXXamzJhuGEet7iHz79oMW
 bJxr9mCZ0Ec6n+QOLzu9+MRugdl33Q+xuzHdr/m5kH+A58aORd1JXnrfODhmB18NZ6F2j36X0GA
 Sl0Xx4FmGLxSroo3xL4moMFtMDoyOXNPcnH2IjYsZlIVHGrtbOCYXqLS8XI8yjEfCsuseYBwSFW
 MlkTSrjyER4/nphyvKfFtjFO5P3DgascOboRFMzp+7wE/H0+MteZqEXoGLckyrgliUnhyH7DmDG
 yWqQchJeaY59j/UCpwGCBbSigmK+Dcb2PyrQboIikKGMLWgvyC3L/R4LOYq/gB/VKXoGtnjQdzC
 C0Fe34cXu4FOfYatoqv8zMg==
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
index d35dcd4a413f..b9864a17c01d 100644
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
 
@@ -1830,6 +1834,32 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
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
@@ -1882,7 +1912,7 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
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

