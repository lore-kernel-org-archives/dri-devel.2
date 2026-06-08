Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1FCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4B710F4DE;
	Mon,  8 Jun 2026 14:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bU65FdSY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009E510F4DC
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD28844381;
 Mon,  8 Jun 2026 14:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0CE1F00898;
 Mon,  8 Jun 2026 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929472;
 bh=f8p1+C8f0/I2zzZ3pkr60RfB/8Ey6Z5EvIyhW82wvxE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bU65FdSYivfw2bZGlpP651aUXxs+MOrvgXNUTuEJYzKuof11plD/3yyWY7YEp8P/7
 iknFSoFWt9MmZpxyC6qJNKowTicxWldjhQ1Of6f7mhmfYb9WSqPbbbrZc65jGt7dFw
 FmjEA8twShkT8mCvteDcOlcEv+lpNUH0ue/HyWerPT/fblatTEaWhlVOTBbOmkopOq
 XFfhAdJYMW35jCiwOSYOCAfNsSuOLnZk/k2cRSRDSb9OUPw62C6xQARG5fuY2Ff90f
 ntIjAdAX4y3IG+jkTcKBuiNwzhxgcOii1fRes3qHGXUIFYHwt2cle++CsZ6Ti6mKTx
 q3w72vXUtiwXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:14 +0200
Subject: [PATCH v2 32/78] drm/bridge: ssd2825: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-32-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8RFKnEE/pkExQr982zKUsAKyOpwejb/YCG8gx9af9IE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql4ObXdmWsNsGMLu2lb/q2bdhVbx3pvu5QKWdajUue
 jU8N5Z0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgImwfGZsuLbv8+PMPysLFvO/
 02WM/XNXY93iTVt7D3PMEd6gaFN47vHU1arJPPbLmY9FsuoLi0UYM9a7c58oEuhzNdMJm53GuGr
 Dvu7Vf+WmnhH5kLpc7uTaN1lx3D+Xb2SukGW/v8vZx26TBy8A
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
 drivers/gpu/drm/bridge/ssd2825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
index 91f1510fc2d4..e345f3a652c2 100644
--- a/drivers/gpu/drm/bridge/ssd2825.c
+++ b/drivers/gpu/drm/bridge/ssd2825.c
@@ -678,11 +678,11 @@ static const struct drm_bridge_funcs ssd2825_bridge_funcs = {
 
 	.atomic_pre_enable = ssd2825_bridge_atomic_pre_enable,
 	.atomic_enable = ssd2825_bridge_atomic_enable,
 	.atomic_disable = ssd2825_bridge_atomic_disable,
 
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
 static const struct drm_bridge_timings default_ssd2825_timings = {

-- 
2.54.0

