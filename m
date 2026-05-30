Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A66ACD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7DB11282A;
	Sat, 30 May 2026 14:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V6eykwwC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD76112824
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D49D0600CB;
 Sat, 30 May 2026 14:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BF51F00899;
 Sat, 30 May 2026 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149721;
 bh=tkKo06NVcI6uh4ZW6Uzyin5XXMzJtpQRIxgWV7wZoJw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=V6eykwwCGxKXneGrTa/l+tH3JI/+2rqM4JCh3f7Kp/K3PKayHxPavS/gypU+vy6Lu
 Vadn1M75XP5ilajWaca32EYiu49GGWhPjvkaHw62IX1Wk1Mem0d+2cjYIqCIwwZwRO
 Tysyp0e7DLQAI3rC6H3HnORkGCcxvsa3Re0dZ1CmYhwAHpe81VSFwYLyGeyvJJfEJd
 A6hU52VavJcWT1c30JFkq9iVtsbUcbWYcF6U8qjgWPJtxlIMMn5ZY9abn+fCfze+I8
 Q0kXFXuhfTr1nw+4cNY1oX2nO/8ou6POgBaNSifA9gkwU3iGjMm2A2DRZenhgYKwIb
 jNz7eOeKvgYXQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:52 +0200
Subject: [PATCH 47/76] drm/mediatek: dp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-47-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=mripard@kernel.org;
 h=from:subject:message-id; bh=z6xBipWEymo12CMpBvlHKhN+wcozoxiodkjgXo7rQlo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb71kJrNsMgiYIrL24mpRAb3fUZyvdEN7e29w23hYf
 TjWxbq2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkYg1jw+8/0ldzJGINOwqP
 9V2cebrp+JZXLlpeh9yvn78k2x2yqTVu3X9VPYdSLk+V+aVCYaV3GRvaz9m98jvsWH/7VH3H0qa
 f32Ku/fsfdPjQx0iTd0sXPZ3s/NR5X2SPIq+C6O+PzmUrquMB
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
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index eefbc7e0f9c8..f656b85b8421 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2576,11 +2576,11 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.atomic_check = mtk_dp_bridge_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_output_bus_fmts = mtk_dp_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = mtk_dp_bridge_atomic_get_input_bus_fmts,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = mtk_dp_bridge_attach,
 	.detach = mtk_dp_bridge_detach,
 	.atomic_enable = mtk_dp_bridge_atomic_enable,
 	.atomic_disable = mtk_dp_bridge_atomic_disable,
 	.mode_valid = mtk_dp_bridge_mode_valid,

-- 
2.54.0

