Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F807CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04D110F4DA;
	Mon,  8 Jun 2026 14:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O0oWcKDI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5137C10F4E0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AECE402D3;
 Mon,  8 Jun 2026 14:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3B71F00898;
 Mon,  8 Jun 2026 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929478;
 bh=7Y9xYHuH6R+IPPQ4aNgPAc8tQldBYFq42TxAO8vBAes=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=O0oWcKDIPERFhc5XLQVOhbketAFPtp/WC7p4K8ftUU3521Fc7rG4gpXlhZi0cBZ06
 lNhPw4EZ3uDOBvebhFD3FZ8zPEHf8rWmQ6cHNpk5swYeBD6u/cFbsYF3n+M564J4oL
 c9qZ7TNTJOHwvpfSqD15XZ6OFd3oWk7TjYloVcKAAUUDpPYQy35XTGQTgSxQQAFmI+
 xxw90NWzYD3fufuRt85mTsPySQq1oJ0XSQKJymCi98wNwNeDUcshJ2A/lZ7vQF3tpu
 EHzWE/a/V1gm9dsutQebSA9KhRt0A941K/+o4yxmEi4qSbjl6TZmONDMrCyKVGS0xO
 93xXkrGVcijQw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:16 +0200
Subject: [PATCH v2 34/78] drm/bridge: dw-hdmi-qp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-34-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CL8AfnfQI12+t6/DZaSpYTTpCtoPr+1k6XiX9j8E910=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql0M+lyW/XFX36/FdX8FLJT8a1zPW9X2SbeOWPpAZu
 nO9xvu9HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiXS8Z69Mfax9zd9WQ/37x
 qlWNhuejs7ObvovamIvx5ZlIv299W7rPnCum56dt45OE6yrnlv94xVjvrpOmu9Li4PGAK95Xlql
 Pu5f89rfpAZVl3vusVN159zFXyklVcNwW2eNx17VYy55HNhAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 1c214a8e6dc2..a5217574c77e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -1190,11 +1190,11 @@ static int dw_hdmi_qp_cec_transmit(struct drm_bridge *bridge, u8 attempts,
 #endif /* CONFIG_DRM_DW_HDMI_QP_CEC */
 
 static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = dw_hdmi_qp_bridge_atomic_enable,
 	.atomic_disable = dw_hdmi_qp_bridge_atomic_disable,
 	.detect = dw_hdmi_qp_bridge_detect,
 	.edid_read = dw_hdmi_qp_bridge_edid_read,
 	.hdmi_tmds_char_rate_valid = dw_hdmi_qp_bridge_tmds_char_rate_valid,

-- 
2.54.0

