Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45499CD6E57
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD74B112830;
	Sat, 30 May 2026 14:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UVYa6Pnc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6740D112824
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5098343944;
 Sat, 30 May 2026 14:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CA1F00893;
 Sat, 30 May 2026 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149724;
 bh=IEAkwZ/+qLbTldwIct/HqL+WkNuYktF+5BeZoWCYbmk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UVYa6Pnc8ThqS82mksjneTG8EEUySLxzvjXLFss6GjQQtTakTlMvAve51I3T5kC+w
 vyGaukumkCZE0svGSilGupaAMwSdNxkgTveiHbWfkgIl9nA/JBaYz8tvNvMPx15SYu
 YQsZWfmtUIKNg73PRzW+/YggW3uPOQ+P4/F8Dqo78StbKEN9bzjmtqLJ/vbPOVFsTG
 snP50ispoDnLZsgiQsVNNosXcKm/QB+n3QGDBk1VxpnlA+yUEGvSWDaC/b4i4mClmr
 gGNbIQ4SEgj2AcadMSE6a+Q3JXdLTokiFGmEOMFuvPQem9OOuQoURESKxjDu1z+l3A
 BIeA2z83mXNNw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:53 +0200
Subject: [PATCH 48/76] drm/mediatek: dpi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-48-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z8CweYx7cyZyxe2DMmfvnRTRy+5EXHTwsjDkYvirUvA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb72+LbAxWM3j2bXFqda6/4np5j3fmXyTbiwq3cjC4
 b4t5ejqjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARTVvGGl6VvM9vD17uOcuY
 /TB+vvL/mMt3FlR5iPx4vjhiZqflp/g5xXeCRdYefNpqEifhIrk/gbFOQV9Q4ZGywukw7eiohqR
 1C6ssxMtL1Gdv3cYecFXI9DHvwdLUt5pZet9t1cu5GQ7YrgcA
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

