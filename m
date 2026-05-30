Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B811CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6DDB11284C;
	Sat, 30 May 2026 14:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="abWJxm/D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F43B112832
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EEB840A77;
 Sat, 30 May 2026 14:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52271F00899;
 Sat, 30 May 2026 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149740;
 bh=Lb8+Yah6POxOEW4zC6qNypDezT9KunyvjgDgSOKXVGw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=abWJxm/D1GzNGT28p2szjMCeeaQJP+/4U5Hw65AqIHjdtPNszHWmeu9O+L/Idb2zj
 BZkKB9blxShpgVtmqvTTvsuRURllzTYYt3ToQmLuldbbhnh2dXmcQdxS9/Nl7Bs+Yr
 xrfotKtab2CDmkjd9daK4XBvAdFPZLvQvYv2QheoSHKu/iEFxwGIKvrGaRW0PQef7x
 7xshSUHGcB6nnq3IHMT376fQeS1KG/JKRWepYBti0uYXh0x5BQC9ujQ/poLsgQ8bl7
 8mQZY/1W5zfoqY5UhLrZZuFSy0GIoJOwhmVzQ/PSUDKFDrUllb/1zfNRbexKk+V2uD
 p2M5Q86VGgJJQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:59 +0200
Subject: [PATCH 54/76] drm/meson: encoder_hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-54-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Lb7rES85ug5bcahF/lcO4GX1UrOeAWFb9bqnR6HN/7g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb32ZnJzOTTdOYrrFriV4VHp5a+HeFV9Oc899rPFxY
 syZjB1LO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEXLMZG77MESmX33pt2ZrY
 7P06Patl3shXb/3W1vEk4ryMsNymVJXamcZnz9wPMYm5pnDeyGN7HGN9WbTtR4c/3u+DBG44TAz
 VVXbcnldg9j6R//Om3MZNHzbO22+4qi5V3nwKM9+zVy8rGNcDAA==
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

