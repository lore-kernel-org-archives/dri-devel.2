Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B15CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE3E10F4CB;
	Mon,  8 Jun 2026 14:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mOdr9q30";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAEC10F4D1
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FB70601E8;
 Mon,  8 Jun 2026 14:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912891F00893;
 Mon,  8 Jun 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929443;
 bh=0uBdkXuKRYUznudTKJ/0AzvjVeCi4kyl3MgjsON45Co=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mOdr9q30hw45f4UAPeZ+KOxHJBd3e9ViJzSZ3xRgyMA1foYCpD5f5p8d66fIugBaB
 x9zCQRf6EYAv9jML4OHrmCopu+Yw9b/eKdHU1jGE+uRA/NsSsS7xr0lpA287vDNmL1
 h1UstYnyTTs1dpqs4bUOn9pHPXCoK5FO8o60WIyEPyMI3LFRKvOHZm4T3T4hLeK8ca
 U0Pn2MgmnQ6O/Xd3Umu4qxb6Zu59Al0lL5jApj5JRHDqRO5OCRcBusYAJFC4rlAZ79
 GgX+aHw4Dj8+zS7R9nfrbDz1+A0WOTnKAjjwI8FBw25/dWmCrXeq+uCJ5f5+sPj1n1
 pc23HlvDaaNtw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:03 +0200
Subject: [PATCH v2 21/78] drm/bridge: ite-it6263: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-21-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SYyBc3NEquPNdWr903C6ZONuaBG+L3j8ybbQHrCn1lo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql/0entph/rXP7+GizMOfy5c3nEmXTt/9q4VDXYS9Y
 c8HLx2HjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR02yMDX1s6mWqkvncWoey
 i//2n34me/dm/Ld9F5bf67s/pef+4d5l9wvqDR7sWrTgkq/gsr/LNjHWB7jmvJu4tlHQSfSr0af
 rHT6+CsKXvn1KFv2+7+Xc/J6d8SfvCW1fPOmO9rafFjzyC9s3AAA=
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
To: Liu Ying <victor.liu@nxp.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index c7d588be12cb..4c0b670806cc 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -827,11 +827,11 @@ static int it6263_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it6263_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it6263_bridge_attach,
 	.mode_valid = it6263_bridge_mode_valid,
 	.atomic_disable = it6263_bridge_atomic_disable,
 	.atomic_enable = it6263_bridge_atomic_enable,
 	.detect = it6263_bridge_detect,

-- 
2.54.0

