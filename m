Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5656C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB4910EF76;
	Wed,  1 Jul 2026 12:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Pqz3I5hF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF8010EF7F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908517;
 bh=uu8wJ1s5TWs2lno7lmR5awOKX1/OE5RoeHGMPhn0IuQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pqz3I5hFJsi0cdI86xdAiBVhN0NtAe+ilBgw6glokfvpo8r7iwqBuW3vR8fX1OWpL
 nKgo6k8GfGHLODhfYp52nwQS8edL5pslfMJI1Zj0ec+n5BnAKiK8Lb9A4beidPz92u
 lUIE/Zwk8HIBwHVNBT1yRp1CO9Ts1qJzHbfUadwEsXxaCZwaN8dsadgHLpcZ96BeG2
 YDDtTiW0oK9W60Oho25EYrWSz0fvYPgiSGKM7uKiLhn8H9Hye8NA/qos859qJy00ii
 y1/lUimaZOiRcoybVfAtnR5izy8ISH+ItGXISVbcfyklQUZT0S5SeyvaAsdBLIFHco
 OZuR6w99I0CNg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 21C8717E0F44;
 Wed,  1 Jul 2026 14:21:57 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 42/42] drm/mediatek: mtk_drm_drv: Fail init only if all paths
 are invalid
Date: Wed,  1 Jul 2026 14:20:57 +0200
Message-ID: <20260701122057.19648-43-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Up until now, if not all display controller paths were valid, the
driver would fail probing and refuse to bind components: while
that was a good idea before, now that mediatek-drm gained much
more flexibility, it is finally possible to gracefully handle
this situation and register only the valid paths while leaving
the invalid ones unregistered, without any crash.

Count how many output paths are found, and then count how many
have failed probing: if there is at least one valid path, avoid
erroring out, so that at least some outputs will just work.

Of course, any path failing is not a clean situation and must be
resolved: in this case, function mtk_crtc_create() still prints
error messages so, even though some output works, that will not
go unnoticed, as a quick check in kmsg will show the errors that
made a certain path not to register.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index f5c9fe1588d0..65a891815408 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -379,6 +379,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct mtk_drm_private *priv_n;
 	struct device *dma_dev = NULL;
 	struct drm_crtc *crtc;
+	int num_failed = 0;
+	int num_paths = 0;
 	int ret, i, j;
 
 	if (drm_firmware_drivers_only())
@@ -445,15 +447,29 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 			if (!priv_n->data->output_paths[i].len)
 				continue;
 
+			num_paths++;
+
+			dev_vdbg(drm->dev,
+				 "[CTRL%d-CRTC%d] Path Len:%d, Controller Order:%u\n",
+				 j, i, priv_n->data->output_paths[i].len,
+				 priv_n->data->output_paths[i].order);
+
 			ret = mtk_crtc_create(drm, i, j,
 					      priv_n->data->conn_routes,
 					      priv_n->data->num_conn_routes);
+			if (ret == 0)
+				break;
 
-			if (ret)
-				goto err_component_unbind;
+			num_failed++;
 		}
 	}
 
+	if (num_failed == num_paths) {
+		dev_err(drm->dev, "No valid Display Controller path! Going out.\n");
+		ret = -ENODEV;
+		goto err_component_unbind;
+	}
+
 	/* IGT will check if the cursor size is configured */
 	drm->mode_config.cursor_width = 512;
 	drm->mode_config.cursor_height = 512;
-- 
2.54.0

