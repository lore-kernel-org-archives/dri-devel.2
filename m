Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDCECD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A0910F588;
	Fri, 19 Jun 2026 12:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gw+8Sb2f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D119310F582
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52696601E2;
 Fri, 19 Jun 2026 12:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431D1F00A3A;
 Fri, 19 Jun 2026 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871960;
 bh=nHR1gDkHFy27JqR3VB7JuCZe4hSMhthC8M5Zk28a5V8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gw+8Sb2ftO2/g4taIq8TPATBB+vrylmqYpsQv2sA6IVa+NSDGBmJolfX8ueRWv4bg
 UNt+M2bSZ0BqoflpbvRJzly1fuQmeXR4LMkBQ1CBnm2sHJxWsYBcyUdjNkgSxHVcYi
 IOPo17n1u9dGPJO/TI5ffuYT1L3V+F+WPCcNz4PLe5NwjPRWbTJkgWkRxlj0c5FwXN
 hLp0dU7waMsRyIny4Wf/37hzozlocWwQ7ZbuDQ5PXUWHUC8CxGLt1pvLja1X5sRqpO
 uoXA469xQbyS/+YwaFUAXBurdgXjbL6tgFtX4QFT+m7miJz0Wff7YqQpfmXKSA2VdR
 34I6NvxkRHNjg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:32 +0200
Subject: [PATCH v3 27/78] drm/bridge: nwl-dsi: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-27-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=mripard@kernel.org;
 h=from:subject:message-id; bh=c6NPaYQaqGp+lY0oc3b8ziCMalLHIq/s+T1XUxylp34=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJl9j06WWCXAG2W3MW52y3kOt6alE+7a7bge3lcio3
 Fl8aVtKx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiITRxjnen8P9m2lrXHzu/3
 aWI4KiX/wCeWz23NoZXH3IUXLN/7XDzixUSWm2GrSrTL3j+xnnjsNWNDY83+YKsGAb65CTN3+hu
 4r2h+uHMmZ5fDjNV//zYl/594+PDep0/ipQ7t/7rlm6LI0515AA==
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
 drivers/gpu/drm/bridge/nwl-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 3c9ae93c4f67..09992529f3d8 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -958,11 +958,11 @@ static u32 *nwl_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_check		= nwl_dsi_bridge_atomic_check,
 	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
 	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
 	.atomic_get_input_bus_fmts = nwl_bridge_atomic_get_input_bus_fmts,
 	.mode_set		= nwl_dsi_bridge_mode_set,

-- 
2.54.0

