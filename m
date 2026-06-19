Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DDACD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000C610F595;
	Fri, 19 Jun 2026 12:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DETdnws1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A2210F596
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0BD6601E1;
 Fri, 19 Jun 2026 12:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F71A1F000E9;
 Fri, 19 Jun 2026 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872008;
 bh=26XL4lSzUqpILLh/PcoT6si2JR5Lsw4xQDZRhDjhcMs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DETdnws1Zzc3D8MO/ET6c6kVZtnPYQ4qR+pgDz51zuhTFRpXUD2WVG0FAQx6Rp+BQ
 5fxhd+JXSg6LeO+bfEwu8LVHBRM2mnLqQZlfZJJsB+Gh+sFBWIdHpdstJ/bYJc+CJE
 c5l/jnS+SM9KINPP9M5fqDHFSFHl8gx2ueHyu2J1dde+olDhp9J3G1OQ9TmIGDKL54
 gVxKt5Oqa7dxj5h7XRjkL1KaxhxpREY0xFrA4eXzzK7Qd3KoNlhMRK39yVHaiCX6Lf
 9FRqXh8ImVgU3fypLyGrLQJoDkDXWAEucX90zTQmIyKuF9ofPGjI2GA3iebcz/J4t/
 S73O0giFat9lg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:50 +0200
Subject: [PATCH v3 45/78] drm/bridge: ti-tdp158: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-45-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kcwxGKfzL09+bm/fY4Ghfqy8QdQwk+Sf8ZY1oVBhG3o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJn85NI9v5g3lMV265l6hygmpEJ8l0YfLHl/amunbZ
 lc1r1GnYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwk34uxTiN3WkBK3GLh6QKp
 L3eWrXKZW7VFdtVj3xsNAZNL7vIfLAt5fv/v3G3fu68+tbq7sCKXk7HO9vsp1vaed4Kbf9/l2bL
 s7LPzZlXnZlscqT+z1FGkInaCkdDk4O8akjYJ3kZ2BdGhDCcA
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
 drivers/gpu/drm/bridge/ti-tdp158.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tdp158.c b/drivers/gpu/drm/bridge/ti-tdp158.c
index 3a19967f213f..01fc643bd78f 100644
--- a/drivers/gpu/drm/bridge/ti-tdp158.c
+++ b/drivers/gpu/drm/bridge/ti-tdp158.c
@@ -58,11 +58,11 @@ static const struct drm_bridge_funcs tdp158_bridge_funcs = {
 	.attach = tdp158_attach,
 	.atomic_enable = tdp158_enable,
 	.atomic_disable = tdp158_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static int tdp158_probe(struct i2c_client *client)
 {
 	struct tdp158 *tdp158;

-- 
2.54.0

