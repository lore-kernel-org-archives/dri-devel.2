Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16076CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE6710F4FB;
	Mon,  8 Jun 2026 14:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gg7oxSJT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207D510F4FA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07F2B43DFB;
 Mon,  8 Jun 2026 14:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD51F00893;
 Mon,  8 Jun 2026 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929536;
 bh=rJjZc0IhgnYrKyF82EVcvBptKZA3RjfKUz5eV2PYOaU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Gg7oxSJTu7KB6SaKvH/aeTB1CttGbOtCvTqSKHQFArQJkGc3uTJx9my9rR+VFbjse
 AIjZ16FBuAeKMng5FU+7lCXyRJyYprdUbP6zLxYJD7JonoCRrS4+CZLTND0IhuPr70
 bCrPcNZGVw33QVjrVRkf8Eu//ZN0bLrVjBX788JUcMnI+TLiXAAx/+W0ZLDYFQhUKx
 E8UfZnmRfX5rd8zRHUBfOiZRkIGSJ1jNmBzEKXCFFMVNv+41v4AvEcH8sXmxqEtvZZ
 wNac3GE5d+s9gbihgCSBK/hoKnXYuHP/p8Ns83RDFh45CvxCy+Y6YLg1wd97wmv9t5
 NNKELSjUUkDBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:38 +0200
Subject: [PATCH v2 56/78] drm/meson: encoder_hdmi: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-56-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gtmH4lt8SDlqOlNBQJ9TmUX1oA8MT9jRtDBh19zvA/8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql2P16nemHpWY4aBZHmYhtO+zNK/k1ymBPk3ato7vJ
 01MldjcMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZitISxYZeXVGbGCvtLuxYG
 H5y89tyfittJC0Mmf3/7X/PNjFPTZmz/09OdnPj51b23b389fBpxvo+xvsosbA+LYK3bWt4jdxx
 4i3hmWHx1Z/Q5GBj4SMNl/YSJj/K7Fs52Fft175D7nG6rzSn7AA==
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
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 55c0601df3c6..0c7a72cb514a 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -364,11 +364,11 @@ static const struct drm_bridge_funcs meson_encoder_hdmi_bridge_funcs = {
 	.atomic_disable = meson_encoder_hdmi_atomic_disable,
 	.atomic_get_input_bus_fmts = meson_encoder_hdmi_get_inp_bus_fmts,
 	.atomic_check = meson_encoder_hdmi_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 int meson_encoder_hdmi_probe(struct meson_drm *priv)
 {
 	struct meson_encoder_hdmi *meson_encoder_hdmi;

-- 
2.54.0

