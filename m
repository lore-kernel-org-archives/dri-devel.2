Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B0CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F81D10F4ED;
	Mon,  8 Jun 2026 14:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KLVJBNqg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7679910F4EC
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E3CF40671;
 Mon,  8 Jun 2026 14:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F1F1F00898;
 Mon,  8 Jun 2026 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929502;
 bh=xtwcYdjf+v9tNv5QOy283X0HHhcEhAuNDF9H8K6op5Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KLVJBNqgCGATQYFA4C1neJaPHmnhb0Czcf0kGsZAYZWCuETRRITqDKQFrvsIGtEUA
 hm2AL87G81uA/mBBpGtHhFsHidEsRk95K4iLoZ/8r3vlZhF0SZP6pFCiH8uc9uJ70g
 ckDal2V0Ylhub/njAfkM85fyP/gu0s77Gcfy7AKVf2D/AfMZolyOfQC3LY8sLwMHgx
 ldh4DNj80Z4y26Ikw3kZz8Wr5cDdjSmc/jCvZMD9b4hUQ61jB2iqPKIzEfYKtpDdsB
 VVOARPBBMxBEeFSbLmrVOLemrrdVQLuoJ/mo1kTmQ8uqjBc7GL+iLaU4o00PW31RKR
 pH9Bqho7JIpzA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:25 +0200
Subject: [PATCH v2 43/78] drm/bridge: ti-sn65dsi83: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-43-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kIAfG7970eHpC1DYZePYmj5ZHeqf/nGxdj8s+JE1kjg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlyOW8Jt1rD53iz3Iu/uhSPEWzrBlZzSMBVfIFGcw/
 yxIuMzVMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZy4yBjw+u83mX8TIXCa4KM
 zqSdP/yFwTNjwiTh1MdSril1bv33Fj2IdZN8e8V4A5vCv+jvQgG6jA0nJRwXLlzdfO/QtwlZhq/
 PBFVe5w5xY3l2MuLtm+cfHE6fSVSNXDKz/ea/D0H7je8aNYkBAA==
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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..ec6390ee9943 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -799,11 +799,11 @@ static const struct drm_bridge_funcs sn65dsi83_funcs = {
 	.atomic_disable		= sn65dsi83_atomic_disable,
 	.mode_valid		= sn65dsi83_mode_valid,
 
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = sn65dsi83_atomic_get_input_bus_fmts,
 };
 
 static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
 	u32 lvds_vod_swing_data[2], u32 lvds_vod_swing_clk[2], u8 lvds_term)

-- 
2.54.0

