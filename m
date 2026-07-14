Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F25C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD21310E6B8;
	Tue, 14 Jul 2026 11:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="E/4uA4pX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C139410E573
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784029475;
 bh=jmaYUP/r44wCR72Nc3+9Fb6W8Pm4khTfRCLiVTVhzcA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E/4uA4pX4Pd1vdKPSwy4CtrXiEBl9OuzlvrP0tf+Sab14gHIg5Z5k2Z4cAcsRP1eS
 SURPXcqvNx/o0ywZlBkRMeJ+gGj4rGQSOr1fZah5YylX6gg/MTfhlFWAifife70Uz1
 M4ChdBQttEtm5aYE6UpfWSFtQgSDBFU5ZOTZiA8OD8uE55qbBMMkwKKT4+lAgYEiFo
 8xatjtfwfYcT/5XyDlKAJX9X55sehN/k5HdVLe+Ttn/2Av/4KwY8l6FU4qMGToBfWC
 asXM+yrTAWwKNbzZis0UFjswJLomPnLMsZvLxQhJUTgh5LAtwgUmJFDC88Fytnc/Fy
 8DPbvcN56xs4g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CD1A017E0E1C;
 Tue, 14 Jul 2026 13:44:34 +0200 (CEST)
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
Subject: [PATCH v2 05/46] drm/mediatek: Add missing component types in
 mtk_ddp_comp_type
Date: Tue, 14 Jul 2026 13:43:33 +0200
Message-ID: <20260714114414.184512-6-angelogioacchino.delregno@collabora.com>
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

In preparation to remove the mtk_ddp_comp_id enumeration, add the
missing component types ETHDR_MIXER, PADDING and MDP_RDMA in the
mtk_ddp_comp_type enumeration.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/linux/soc/mediatek/mtk-mmsys.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index fb88202d100a..3ddfdeac658d 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -92,6 +92,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_COLOR,
 	MTK_DISP_DITHER,
 	MTK_DISP_DSC,
+	MTK_DISP_ETHDR_MIXER,
 	MTK_DISP_GAMMA,
 	MTK_DISP_MERGE,
 	MTK_DISP_MUTEX,
@@ -99,12 +100,16 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_OVL,
 	MTK_DISP_OVL_2L,
 	MTK_DISP_OVL_ADAPTOR,
+	MTK_DISP_PADDING,
 	MTK_DISP_POSTMASK,
 	MTK_DISP_PWM,
 	MTK_DISP_RDMA,
 	MTK_DISP_UFOE,
 	MTK_DISP_WDMA,
 
+	/* MDP Components */
+	MTK_DISP_MDP_RDMA,
+
 	/* Keep Display outputs at the end for readability */
 	MTK_DPI,
 	MTK_DP_INTF,
-- 
2.54.0

