Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84402CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD05410F4FF;
	Mon,  8 Jun 2026 14:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B83j4Wzw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C2C10F4FF
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44392601FA;
 Mon,  8 Jun 2026 14:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C991F00898;
 Mon,  8 Jun 2026 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929545;
 bh=Frg1svv5g5oTib/AevHGfkT2WVf/3XNyAwUxUMYtJLk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=B83j4WzwP/Rc//NHlSjy00L6FrQf0pyVm7D2c4ozoP439HXA0Dw6Y0ouruGYBCZXi
 Qnw6MQfXmiKYXfWuA/xQWkoL+21dSb/VczvAKl8jXJV03vvxA+oI5VV/pvu084HZd/
 CSVzZXtsEoDFg73rV5lPXeDd/KuK1cTMubQRUdgi59OfSChcbJfRsQ4BcgbKRiHp9g
 gRYbROEGUhccvlb+pZIXwl4y7i/Drg3ztIqgqJs3SMppPHJq1/BsAWVJ2BTF8f1WKZ
 FsEbkWXUkTUTI98uR4vEw/TvJJT8wHJlWKQspkdscoVnTBXRVTPvACwUpee8mKZad1
 UtMgEM1hufI2w==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:41 +0200
Subject: [PATCH v2 59/78] drm/omap: hdmi4: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-59-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=mripard@kernel.org;
 h=from:subject:message-id; bh=AKHRRnAzVQvxKy7MsKARlGXNxwClc6Jkx5xpP1jFdGI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql+OLHV0+t/7eaDM1rTLs5JfKgOlhx3QvvTPaZr3m6
 JpPG3P2d0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJfHzJ2HBthtmK+MkXekI/
 aGUU2k9eMps34vOqncp7TT/b8e1sdO35/7jv6e25Lh99NcoUkuJY2RkbHoZtTq2a7nPn6+Povzx
 9/u7/3N4v7dUQfmaxfJ/XwaUta197aKcJWV99mHnzXfFqqTNSAA==
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
 drivers/gpu/drm/omapdrm/dss/hdmi4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index e306247ed8a0..61cfd003569c 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -495,11 +495,11 @@ static const struct drm_edid *hdmi4_bridge_edid_read(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs hdmi4_bridge_funcs = {
 	.attach = hdmi4_bridge_attach,
 	.mode_set = hdmi4_bridge_mode_set,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = hdmi4_bridge_enable,
 	.atomic_disable = hdmi4_bridge_disable,
 	.hpd_notify = hdmi4_bridge_hpd_notify,
 	.edid_read = hdmi4_bridge_edid_read,
 };

-- 
2.54.0

