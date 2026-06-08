Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC91CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B4A10F4FC;
	Mon,  8 Jun 2026 14:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nkFBMfXM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B3310F4FA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9068D601FA;
 Mon,  8 Jun 2026 14:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69EE1F00893;
 Mon,  8 Jun 2026 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929526;
 bh=GEERyI2wRk6hXmjZiH6Yfv+7VqML6S7ee4jouDKbAKM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nkFBMfXM7ERJuoRB92S8OvyKgpbPpTSiPl+OKC63jtvWHdC4vWCyroXVTbe0ooGas
 Ry8m5pv2SkMuCQIYZDmkyzAquMDnXwsMYFMd2kna3YtL1SONy3jxmtrhaIKwW2paik
 EDZNf3UKhY1c1zqEpLk/I5GoP9OyZMXjWXNvGZpv3LOKZnWspF9K5/nrsqNvFfgiLK
 Tuf9U+R/G+ymfrozVogzijfjen8Dv2pTLZOnJiAdVc7mlMd3kIvI+HMOgzW2Vxy6EF
 6fLz0vmVv8vhFNr34AY3UgTTT7PSl5Nlz7ZBT1T7FqSxLEOmTyJc2UKYFTTkHyeCq1
 +Bh/iSz9AXzOA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:34 +0200
Subject: [PATCH v2 52/78] drm/mediatek: hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-52-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3qhzzkgz+F06HVp5IrjHs45JERMJiYbFVs709y5n2Dc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql6O9atw1tj8IWXD4cOTH6IX/JVZc7N3xnVO98fkBz
 1Mplln+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAinh6M9a7tUebPH+Tz620/
 N9ldUfD+Gj85lWqO7v4fsl//pdSHb/bXytDeULXD/KfL/gTLlxYKjA3T8zMz3y3SkTtwVe3tmZm
 /39+5nS+8cXbh/WU1Ygdb/6f4JRubqM3512g2y+DrnF1fNTMB
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
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 38a7c7953874..738090a47176 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1070,11 +1070,11 @@ static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
 	.mode_valid = mtk_hdmi_bridge_mode_valid,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = mtk_hdmi_bridge_attach,
 	.mode_fixup = mtk_hdmi_bridge_mode_fixup,
 	.atomic_disable = mtk_hdmi_bridge_atomic_disable,
 	.atomic_post_disable = mtk_hdmi_bridge_atomic_post_disable,
 	.mode_set = mtk_hdmi_bridge_mode_set,

-- 
2.54.0

