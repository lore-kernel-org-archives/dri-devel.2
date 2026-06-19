Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A3CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1578910F57C;
	Fri, 19 Jun 2026 12:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g4HI0SkE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD7310F57A
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F9F0601F1;
 Fri, 19 Jun 2026 12:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A811F00AC4;
 Fri, 19 Jun 2026 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871944;
 bh=0Q/fNz3Rde1xjM7otzFUGHI7EV+0y4LmVRxgdIcVJlc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=g4HI0SkEBOvX4eRIMIx6ERkMO1j7GNdslKh3DAJLDzahYHi6KgsnoAtpxtx76LtEa
 wWh2O+yBmtmHKKr9oJoHgSnsMh473heglWHBeJ/IRrX3+c6MNMdz5DLtu3jUXF+GDQ
 T4r8UO4y2qMj1UKxkkd9psG1qO0kOQhQKRTbtqXkveouQtUDY+HlBrWA1jnjDrsX9H
 Cmg2UVYkfelm1gmPmgIseYRGG5IqIBOZfIky6QXwWLw2U45WZuWERDdGEdVBNewUjE
 ajKckphSwti/kf8AWyCdBFIyLQHcgyThRoBDHtOV0lE0QXPGoZQH07CWVOR5GBbqzP
 K2Zk7VRBpRAsg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:26 +0200
Subject: [PATCH v3 21/78] drm/bridge: ite-it6263: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-21-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=mripard@kernel.org;
 h=from:subject:message-id; bh=R+wa6MrgU5DS7Nf3vYn2PjFjI7tWUu2fKEhK56vfXRE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJp9zzI7ZFfL+SDqy1HTNT36JYvHfWRHSr/Ts7Q7Vu
 UtsmZ3aMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYSbMXYsPhkgbXy340KM/cZ
 Sa4qkdr6wetzQKNr9O8a88zwqP/vrP/YMnNVVUh8m2d+YVfL2ocqjHWKoh8uJRXEJzCrLZlQt2+
 dBVsd81zbQ9I2HxM3zgwwzTuvbxTauJItb7L7opkBM1fxuQEA
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

Reviewed-by: Liu Ying <victor.liu@nxp.com>
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

