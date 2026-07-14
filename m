Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B08C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B219E10E6A3;
	Tue, 14 Jul 2026 11:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="j16Uz93h";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E752F10E573
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784029474;
 bh=Ip0z0Dqm9bUaaMp/etGb29cMeapZRLGllSD+m34VwVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j16Uz93hCM00fKmLqkfKyUHd+O3FtxoL9CNdPoleCVNsfb5em7W+NNiIxnt/KmX8i
 0KRQozPXAnTxiMkZbEnryV0X79Ulqgw71OhzZObmUpsHDGTHebWzQhJzie0s9cBM5l
 HO7391y4q3uIo7xqtB8q/WbzBYUF4A4U8/wn1ZR2o+RyXC8hLd/3VoMp3ub8vW5OBv
 DavFbTLvSjtv9LmMFyZm2VNaFR1/Agy6PynLQaEAQtFH2MJKH1Eviuqe5hHKN6ZMj9
 GvlZm7wcwmlQPYz4DJ7GAx91lWnHdGrnLjDVof4kqQtLQIANdx4irbEjNt9/A7HG4R
 s1bM3pLnpfIrg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E777517E0DE9;
 Tue, 14 Jul 2026 13:44:33 +0200 (CEST)
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
Subject: [PATCH v2 04/46] drm/mediatek: Move mtk_ddp_comp_type enumeration to
 mtk-mmsys.h
Date: Tue, 14 Jul 2026 13:43:32 +0200
Message-ID: <20260714114414.184512-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
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

In preparation for a major refactoring of MMSYS, MUTEX and of
mediatek-drm, move the mtk_ddp_comp_type enumeration to the
mtk-mmsys.h header, as this will be shared between multiple
MediaTek multimedia related drivers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h | 25 ---------------------
 include/linux/soc/mediatek/mtk-mmsys.h  | 29 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 99bf1e1015da..bbc66072fe6b 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -22,31 +22,6 @@ struct mtk_plane_state;
 struct drm_crtc_state;
 struct drm_dsc_config;
 
-enum mtk_ddp_comp_type {
-	MTK_DISP_AAL,
-	MTK_DISP_BLS,
-	MTK_DISP_CCORR,
-	MTK_DISP_COLOR,
-	MTK_DISP_DITHER,
-	MTK_DISP_DSC,
-	MTK_DISP_GAMMA,
-	MTK_DISP_MERGE,
-	MTK_DISP_MUTEX,
-	MTK_DISP_OD,
-	MTK_DISP_OVL,
-	MTK_DISP_OVL_2L,
-	MTK_DISP_OVL_ADAPTOR,
-	MTK_DISP_POSTMASK,
-	MTK_DISP_PWM,
-	MTK_DISP_RDMA,
-	MTK_DISP_UFOE,
-	MTK_DISP_WDMA,
-	MTK_DPI,
-	MTK_DP_INTF,
-	MTK_DSI,
-	MTK_DDP_COMP_TYPE_MAX,
-};
-
 struct mtk_ddp_comp;
 struct cmdq_pkt;
 struct mtk_ddp_comp_funcs {
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 4885b065b849..fb88202d100a 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -84,6 +84,35 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_ID_MAX,
 };
 
+enum mtk_ddp_comp_type {
+	/* DISP Components */
+	MTK_DISP_AAL,
+	MTK_DISP_BLS,
+	MTK_DISP_CCORR,
+	MTK_DISP_COLOR,
+	MTK_DISP_DITHER,
+	MTK_DISP_DSC,
+	MTK_DISP_GAMMA,
+	MTK_DISP_MERGE,
+	MTK_DISP_MUTEX,
+	MTK_DISP_OD,
+	MTK_DISP_OVL,
+	MTK_DISP_OVL_2L,
+	MTK_DISP_OVL_ADAPTOR,
+	MTK_DISP_POSTMASK,
+	MTK_DISP_PWM,
+	MTK_DISP_RDMA,
+	MTK_DISP_UFOE,
+	MTK_DISP_WDMA,
+
+	/* Keep Display outputs at the end for readability */
+	MTK_DPI,
+	MTK_DP_INTF,
+	MTK_DSI,
+
+	MTK_DDP_COMP_TYPE_MAX
+};
+
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next);
-- 
2.54.0

