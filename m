Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E59CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E57010F5A9;
	Fri, 19 Jun 2026 12:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fkPGNQ4F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C9C10F597
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:27:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36950601F2;
 Fri, 19 Jun 2026 12:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF2B1F00A3D;
 Fri, 19 Jun 2026 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872021;
 bh=4DYgDTdQxoQs5/Acj4UuK6ZGLl7MSEF++04nWxrV/IQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fkPGNQ4FnBrUeZNc7X4vS6SU8QfiaPMTCkAxH6o0aJXP5Z/Iz5uPUZGQzdzxfL3GA
 9M+A9yVur1Hd+0vtQvtRDflXL1PFa7U6/sfUFJLLCBIx5lv7d7YyNVkjd/9t2UZw6k
 /AQR+IVuGyJ5tbWlpjVsiEygrjqgiwCgcwnrvIlqU4nlEHrYzBmxq5fTsWpi5y2ZER
 qYfSII3J4v5PZjGqB0w0NewDz+fnw8ws6+0sKn/pq4wDqIMjhWDWQTCTgjJ9+ki5Ih
 9rzy5vcnGyO25eT6AwwvXmnM1vSJzMrFcI2yOgMNHlqmOpXWVqq0oM1GSvMr3ERFbt
 tB9Dfg2xfxs5w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:55 +0200
Subject: [PATCH v3 50/78] drm/mediatek: dpi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-50-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4vEdFTeqmRJs/IptJNcK+ndXJCSStQmeCH+8L3c3neE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmpgwPhc831N6fJZ62VlExh6Oc4dlKhxeRUgdSJ850L
 drFsndRx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgIhyhjJWNf2KO1l3N2ty52
 Md3WxuE858ch0TbWTsVVqpeX20jdfLNb50Nx4akft8/+2b6w6MXBZYw1nP7K0x4d8OlN/hg5NU/
 sz3/zLyvYHONT422W/3qz8Va68sHzn3JSdfu1jgdPnGDy7M4ZAA==
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bb4b7e6f1e29..959c994eef24 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -987,11 +987,11 @@ static const struct drm_bridge_funcs mtk_dpi_bridge_funcs = {
 	.atomic_check = mtk_dpi_bridge_atomic_check,
 	.atomic_get_output_bus_fmts = mtk_dpi_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = mtk_dpi_bridge_atomic_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.debugfs_init = mtk_dpi_debugfs_init,
 };
 
 static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,

-- 
2.54.0

