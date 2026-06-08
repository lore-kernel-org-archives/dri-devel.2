Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B609CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB3810F4D3;
	Mon,  8 Jun 2026 14:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i8BE/AaG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24C110F4D6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE14240C42;
 Mon,  8 Jun 2026 14:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647911F00898;
 Mon,  8 Jun 2026 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929456;
 bh=DeWx6iN02e4OqMXFbAdpakSsh29OPp+j7bdDMgNLaAg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=i8BE/AaGhBO2C4dVh9wVkvzz6nUNJfLL72tMeblv123ckjHFiW3ls79fAvISL/+y7
 6cUZQQnSrB744qC6xvqx5/F5TuiHmoV0+nZ4MrtYEfKN8XNZqw59KK6onfPvKQD0/O
 KJtTzjOz4K0MLv6CzKSI8wJ9Tqg35BoDWPLa6vp/JtpFY5DGKt2U5fNRhlesJ5OXi0
 PvUA2c7C9SaBYAcnMr5vLDknBon1gbc3lYeK0Pi4ngt/9OlvvoU1uj6fs6IM6M/o8t
 kx9BwYxP2kSOYNA4PH7o8YhYiKmGA83yomDsoSm2eKoB7jN3fagDZhf1Fw2od9Tu4j
 1YSz8ubqR/8TQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:08 +0200
Subject: [PATCH v2 26/78] drm/bridge: lvds-codec: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-26-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pbKNRIay9gU1cIZ9OwGTdkcKNFhu5slRM1DNhbZHOks=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlwNWZq64JzV1ao2l0HJV5TvdLx+0dyz9vZhr2uEL1
 WYcCzIudExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJnBFgbDg+2VFHO6L0Xrnc
 yQP1F3lVX3InSbCx6tgkBE6+LCSf3PqxYa2H/8cYw0qzSdZr5KWWMDZsTl9dsG7zSzmBle9nz44
 J2p6ee7Wg8FFQscZhxufPX+xf8F31RmDS2cK3s46tvy0X/zMFAA==
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

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/lvds-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
index e6a7147e141b..d1135dc3b99f 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -102,11 +102,11 @@ static const struct drm_bridge_funcs funcs = {
 	.attach = lvds_codec_attach,
 	.enable = lvds_codec_enable,
 	.disable = lvds_codec_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = lvds_codec_atomic_get_input_bus_fmts,
 };
 
 static int lvds_codec_probe(struct platform_device *pdev)
 {

-- 
2.54.0

