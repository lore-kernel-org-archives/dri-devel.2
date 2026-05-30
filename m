Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AABCD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4624710E368;
	Sat, 30 May 2026 14:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HyE2a8Bu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66CC10E368
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D7A442A5C;
 Sat, 30 May 2026 14:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0841F00893;
 Sat, 30 May 2026 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149616;
 bh=NLXK+GEAdnyC+tEJZ0IxfpdLM4gIM81fKytp1ltxCT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HyE2a8Bu6Z19MkINY2f3GQ2+bZ5SSZetcHB1T+jLPj3C9ualK/MA5BciO5KOaaPN+
 RZsccRZGMep6V+e1imWzO3GF5M5aG6IqIAYJxOAOXjTKAhbx5aqPkS6zs5rJmlP66B
 Y5TYlNPrIXFKRxWlNvX5/KVP8lNc06aO7eZsWTMpVCcIi/3cRvXjZKGYDBvmcmrzSk
 O+XEmOeCC0L57OyS5I4kWZfy1QloMoanRvsFN+FoYfrTczI0HtzFceOJjrlz0q0FA7
 95lqKez3o8BkdFFVT1wZmby+Yk4qSjs1zhfMymIN2wYCxpF9TEf8BWOnI27qNrE8Ld
 M1wUKBAWhp/Ow==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:13 +0200
Subject: [PATCH 08/76] drm/bridge: anx7625: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-8-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3XZMHYVDyT9dCjKpqNqWYnOK5jAWm2gvH6Z9pTlXtGU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSby3T9s49zfdmjeJEw+SX2wLYPwaW882fc38Ca8Nd3
 x1yhuzHO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE+qcyNsxeNC8hjOdkEtsU
 0ZVT7V/yntFXf5MzgydYb+8lhqCkg39FUhj5GveYZWc0euz2ySw6yNjw3ijIZUZpyGrRTwaHwsO
 mVVu/NmlOZLAXZDt7suCUPad+a9V97vaY1+/efXLlawtaXwEA
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
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 513c11cdbc74..2e2c6d925506 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2677,11 +2677,11 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
 	.atomic_check = anx7625_bridge_atomic_check,
 	.atomic_enable = anx7625_bridge_atomic_enable,
 	.atomic_disable = anx7625_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.detect = anx7625_bridge_detect,
 	.edid_read = anx7625_bridge_edid_read,
 	.hpd_enable = anx7625_bridge_hpd_enable,
 	.hpd_disable = anx7625_bridge_hpd_disable,
 };

-- 
2.54.0

