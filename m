Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F21CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C67010F4F1;
	Mon,  8 Jun 2026 14:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WUHJHG/S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0E810F4F1
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B62A443FC7;
 Mon,  8 Jun 2026 14:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE361F00898;
 Mon,  8 Jun 2026 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929507;
 bh=26XL4lSzUqpILLh/PcoT6si2JR5Lsw4xQDZRhDjhcMs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WUHJHG/SnejsE30bqyN6rki7H2SwFEXxDnw/SwFV7QwjY9kQp2w7ku5J15vxFBMuY
 acLFZJOh7j3eihFMIiyImVFD1D8YCHgkrb5ycRWNj8pFwKqApHVkVqIr4VrU7iYjmP
 skTNOYGZptwSq6oElI6oVJWNJ4hj9tFnyzCgbWiPp8P++6VKcm2HkPEFSdTdrg5NxH
 Fsb9QuYqDT1UaRmCAnQucKZeovYp6e44B5oUEYzqm2BPSokCN96NN5of5LYtfOCtGe
 FiqGAII3ENtm+Q6ScSy2H0U5iZkrDVNRoBkhNI2jbXDD6dPeG+oqCRhC7t1Y7NNIoD
 5h1uFqNqPtVsg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:27 +0200
Subject: [PATCH v2 45/78] drm/bridge: ti-tdp158: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-45-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kcwxGKfzL09+bm/fY4Ghfqy8QdQwk+Sf8ZY1oVBhG3o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlyMC7S1+pEtO26uWvb5EUEKcZYtm8+Qg8UkvHG76r
 NNffjCjYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEz4yxPmd93eRba9L+Bqrk
 1xz9J87nfv37buu7z4LZmteUZalPOMMqwXetevf6pVM8LulaRN9gZayP3TBdyr59mbORi+Bz79v
 yx2z/LQzdvGz69P9N2gcmvuFsXeqnsCJj+xxtoQXF0cJPdpUCAA==
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

