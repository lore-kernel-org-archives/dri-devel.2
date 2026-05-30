Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91215CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB47A11280E;
	Sat, 30 May 2026 14:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R22bVinX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9F311280B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2221660121;
 Sat, 30 May 2026 14:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371E1F00893;
 Sat, 30 May 2026 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149648;
 bh=k9Pysf+zLQ7um103P6/YWGT1ooeIvywyOVpWrz4ey1o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R22bVinX9DL6QNqd8n7U+fM35u2/xvuHWH+mfXquNimkRbCgq16VnG2OZ4hHxccsg
 2o79OLSvGcWqd6AlBcTTCZXe3l1ckgkwgtNQsGkoCt3i6tg1/rA504BxSO1k60RLo/
 a9qGxzwaT10RjHW+9zqhbQgy1McJ9mLLSSxJOQqB2jkv9gb9N6+OCY670Uio03Wzn5
 9fUbN17wy9pREj4E0ssnUiiKKbosbcWoCl5zcSDeNVLf8hmdO6XBu4q8ullGjCJAPe
 UQGPADVZzT12tF8wo8+ogID6yK5D2VbMzUlMwIZ0RolmT/53Svr98mR2TX33m8CeCz
 BUGRgnkkWpmZQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:25 +0200
Subject: [PATCH 20/76] drm/bridge: ite-it6505: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-20-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tiY6srFjIYcw9Hk+SEQNjWwp1oRRIhJB5eFqsHUcjok=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb+1u7TrOFLNtQ25HQsazjMnn8nJuN1+r8I02sfCZ1
 yer2/C2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzERoyxPvnntzPiCyZbPr0a
 /va3Vtua5IffQ3snyfLn/3lw+trdjvSG1V+Xrpx+sWVi07rvZRwLwxgbVk165eQT+sOtf0LSh97
 mqfeaZ+TeF/xUtPvb79YrjJoPis+b56xpNdRkn1c5eeGiebaBAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 6b7cb132a437..8ecb43611dba 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3237,11 +3237,11 @@ static const struct drm_edid *it6505_bridge_edid_read(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it6505_bridge_attach,
 	.detach = it6505_bridge_detach,
 	.mode_valid = it6505_bridge_mode_valid,
 	.atomic_enable = it6505_bridge_atomic_enable,
 	.atomic_disable = it6505_bridge_atomic_disable,

-- 
2.54.0

