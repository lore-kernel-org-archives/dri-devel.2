Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD0CC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 355BF10EF5E;
	Wed,  1 Jul 2026 12:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LLSwJXIN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F59810EF5E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908473;
 bh=dgIW5F8hcEp7JDgooypSvLbWNF1e1X2mYaV32rWjqhM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LLSwJXINwsLXrln1+MuDYLOVpNVKOWCVcnEMuoZ9IFICveXwzUasvI+RNyPmUiSuI
 +nJUd1lugkigzu5C9LSMMHCSkQISChIzGKtmij55qh5zx9IrWusHduQdl/Jzb2VTGO
 YLM9/p5aFfOr853vfY5YdfFyzEU0JjOBL0P40eMjU+ENUJzsPWKAgscSMpb/iyTUmy
 g8FwTqXw5tkmiIYBOLXtf8mouvDmBUtjCSUxJy8xEQ3Jpr2/vuqmseygz84kLm5aoj
 9+3EZhPM55WO6AKfPbMpdW7MG7MbGtcHSZiQUMM+tKvUq3+sMCtBkGjSRmev4PxCqJ
 waZl1sBmL50kw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 211AB17E35CD;
 Wed,  1 Jul 2026 14:21:12 +0200 (CEST)
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
Subject: [PATCH 10/42] drm/mediatek: Create new mtk_drm_legacy and move
 deprecated code
Date: Wed,  1 Jul 2026 14:20:25 +0200
Message-ID: <20260701122057.19648-11-angelogioacchino.delregno@collabora.com>
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

Since mediatek-drm shifted from hardcoded per-SoC-per-Board path
definitions for the display controller to devicetree graph based
path building, the first ones are used less and less, and those
are also decreasing ease of code browsability (hence, readability)
in the mtk_drm_drv.c file.

This means that those big arrays are almost irrelevant now (for
modern code, of course).

Seen the need to keep compatibility with older devicetrees, then,
move all of the deprecated arrays in new mtk_drm_legacy files and
add a big warning to those, explaining that no new SoCs must be
implemented like so, and making it clear that it shall exclusively
contain legacy and deprecated code.

Also, especially with the restructuring work that is currently in
progress (with MuteX finally getting trigger-sources support and
other changes that will follow), it is expected to see more code
being moved in the mtk_drm_legacy territory.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/Makefile         |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 277 +------------------
 drivers/gpu/drm/mediatek/mtk_drm_legacy.c | 309 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_legacy.h |  28 ++
 4 files changed, 339 insertions(+), 276 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_legacy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_legacy.h

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 8079962597c8..f40ad5565716 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -13,6 +13,7 @@ mediatek-drm-y := mtk_crtc.o \
 		  mtk_disp_rdma.o \
 		  mtk_disp_wdma.o \
 		  mtk_drm_drv.o \
+		  mtk_drm_legacy.o \
 		  mtk_dsi.o \
 		  mtk_dpi.o \
 		  mtk_ethdr.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 09c7d038348d..1396cbc65627 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -35,6 +35,7 @@
 #include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
 #include "mtk_drm_drv.h"
+#include "mtk_drm_legacy.h"
 
 #define DRIVER_NAME "mediatek"
 #define DRIVER_DESC "Mediatek SoC DRM"
@@ -63,282 +64,6 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-static const struct mtk_drm_comp_definition mt2701_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_BLS },
-	{ DDP_COMPONENT_DSI0 },
-};
-
-static const struct mtk_drm_comp_definition mt2701_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_RDMA1 },
-	{ DDP_COMPONENT_DPI0 },
-};
-
-struct mtk_drm_path_definition mt2701_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt2701_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt2701_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt2701_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt2712_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_OD0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_DPI0 },
-	{ DDP_COMPONENT_PWM0 },
-};
-
-static const struct mtk_drm_comp_definition mt2712_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_OVL1 },
-	{ DDP_COMPONENT_COLOR1 },
-	{ DDP_COMPONENT_AAL1 },
-	{ DDP_COMPONENT_OD1 },
-	{ DDP_COMPONENT_RDMA1 },
-	{ DDP_COMPONENT_DPI1 },
-	{ DDP_COMPONENT_PWM1 },
-};
-
-static const struct mtk_drm_comp_definition mt2712_mtk_ddp_third[] = {
-	{ DDP_COMPONENT_RDMA2 },
-	{ DDP_COMPONENT_DSI3 },
-	{ DDP_COMPONENT_PWM2 },
-};
-
-struct mtk_drm_path_definition mt2712_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt2712_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt2712_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt2712_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
-	},
-	[CRTC_THIRD] = {
-		.comp = mt2712_mtk_ddp_third,
-		.len = ARRAY_SIZE(mt2712_mtk_ddp_third),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt7623_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_BLS },
-	{ DDP_COMPONENT_DPI0 },
-};
-
-static const struct mtk_drm_comp_definition mt7623_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_RDMA1 },
-	{ DDP_COMPONENT_DSI0 },
-};
-
-struct mtk_drm_path_definition mt7623_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt7623_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt7623_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt7623_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt7623_mtk_ddp_ext),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8167_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_CCORR },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_DITHER0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_DSI0 },
-};
-
-struct mtk_drm_path_definition mt8167_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8167_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8167_mtk_ddp_main),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8173_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_OD0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_UFOE },
-	{ DDP_COMPONENT_DSI0 },
-	{ DDP_COMPONENT_PWM0 },
-};
-
-static const struct mtk_drm_comp_definition mt8173_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_OVL1 },
-	{ DDP_COMPONENT_COLOR1 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_RDMA1 },
-	{ DDP_COMPONENT_DPI0 },
-};
-
-struct mtk_drm_path_definition mt8173_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8173_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8173_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt8173_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8183_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_OVL_2L0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_CCORR },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_DITHER0 },
-	{ DDP_COMPONENT_DSI0 },
-};
-
-static const struct mtk_drm_comp_definition mt8183_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_OVL_2L1 },
-	{ DDP_COMPONENT_RDMA1 },
-	{ DDP_COMPONENT_DPI0 },
-};
-
-struct mtk_drm_path_definition mt8183_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8183_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8183_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt8183_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8186_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_CCORR },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_POSTMASK0 },
-	{ DDP_COMPONENT_DITHER0 },
-	{ DDP_COMPONENT_DSI0 },
-};
-
-static const struct mtk_drm_comp_definition mt8186_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_OVL_2L0 },
-	{ DDP_COMPONENT_RDMA1 },
-	{ DDP_COMPONENT_DPI0 },
-};
-
-struct mtk_drm_path_definition mt8186_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8186_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8186_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt8186_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt8186_mtk_ddp_ext),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8188_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_CCORR },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_POSTMASK0 },
-	{ DDP_COMPONENT_DITHER0 },
-};
-
-struct mtk_drm_path_definition mt8188_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8188_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8188_mtk_ddp_main),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8192_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_OVL_2L0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_CCORR },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_POSTMASK0 },
-	{ DDP_COMPONENT_DITHER0 },
-	{ DDP_COMPONENT_DSI0 },
-};
-
-static const struct mtk_drm_comp_definition mt8192_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_OVL_2L2 },
-	{ DDP_COMPONENT_RDMA4 },
-	{ DDP_COMPONENT_DPI0 },
-};
-
-struct mtk_drm_path_definition mt8192_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8192_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8192_mtk_ddp_main),
-	},
-	[CRTC_EXT] = {
-		.comp = mt8192_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt8192_mtk_ddp_ext),
-	},
-};
-
-static const struct mtk_drm_comp_definition mt8195_mtk_ddp_main[] = {
-	{ DDP_COMPONENT_OVL0 },
-	{ DDP_COMPONENT_RDMA0 },
-	{ DDP_COMPONENT_COLOR0 },
-	{ DDP_COMPONENT_CCORR },
-	{ DDP_COMPONENT_AAL0 },
-	{ DDP_COMPONENT_GAMMA },
-	{ DDP_COMPONENT_DITHER0 },
-	{ DDP_COMPONENT_DSC0 },
-	{ DDP_COMPONENT_MERGE0 },
-	{ DDP_COMPONENT_DP_INTF0 },
-};
-
-static const struct mtk_drm_comp_definition mt8195_mtk_ddp_ext[] = {
-	{ DDP_COMPONENT_DRM_OVL_ADAPTOR },
-	{ DDP_COMPONENT_MERGE5 },
-	{ DDP_COMPONENT_DP_INTF1 },
-};
-
-struct mtk_drm_path_definition mt8195_vdo0_legacy_paths[MAX_CRTC] = {
-	[CRTC_MAIN] = {
-		.comp = mt8195_mtk_ddp_main,
-		.len = ARRAY_SIZE(mt8195_mtk_ddp_main),
-	},
-};
-
-struct mtk_drm_path_definition mt8195_vdo1_legacy_paths[MAX_CRTC] = {
-	[CRTC_EXT] = {
-		.comp = mt8195_mtk_ddp_ext,
-		.len = ARRAY_SIZE(mt8195_mtk_ddp_ext),
-	},
-};
-
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.output_paths = mt2701_legacy_paths,
 	.shadow_register = true,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_legacy.c b/drivers/gpu/drm/mediatek/mtk_drm_legacy.c
new file mode 100644
index 000000000000..623e510de9ff
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_drm_legacy.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Compatibility layer for legacy mediatek-drm
+ *
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *
+ * All (or most of) MediaTek SoCs released since around year 2014 onwards
+ * have got a new Multimedia System (and Display Controller) architecture,
+ * featuring an extreme flexibility on the connection of all of the various
+ * multimedia-related hardware components (or sub-IPs).
+ *
+ * Many different boards based on those SoCs are using different displays,
+ * different outputs, hence wildly different display pipelines: for this,
+ * a solution based on a devicetree graph (OF Graph) was chosen for setting
+ * up the correct pipeline for each device.
+ *
+ * However, removing the hardcoded display controller paths would break all
+ * of the devices using the new display driver on an old devicetree.
+ *
+ * This compatibility layer makes possible to keep the display controller
+ * functionality working when a board/device:
+ *  - Uses an old devicetree with no OF Graph; and
+ *  - Uses a new kernel with the new mediatek-drm graph-based pipeline
+ *    building code.
+ *
+ *                            ** WARNING **
+ * This exists only to avoid ABI breakages and no new SoC should ever be
+ * added to this file.
+ */
+
+#include "mtk_drm_drv.h"
+#include "mtk_drm_legacy.h"
+
+static const struct mtk_drm_comp_definition mt2701_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_BLS },
+	{ DDP_COMPONENT_DSI0 },
+};
+
+static const struct mtk_drm_comp_definition mt2701_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_RDMA1 },
+	{ DDP_COMPONENT_DPI0 },
+};
+
+struct mtk_drm_path_definition mt2701_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt2701_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt2701_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt2701_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt2712_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_OD0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_DPI0 },
+	{ DDP_COMPONENT_PWM0 },
+};
+
+static const struct mtk_drm_comp_definition mt2712_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_OVL1 },
+	{ DDP_COMPONENT_COLOR1 },
+	{ DDP_COMPONENT_AAL1 },
+	{ DDP_COMPONENT_OD1 },
+	{ DDP_COMPONENT_RDMA1 },
+	{ DDP_COMPONENT_DPI1 },
+	{ DDP_COMPONENT_PWM1 },
+};
+
+static const struct mtk_drm_comp_definition mt2712_mtk_ddp_third[] = {
+	{ DDP_COMPONENT_RDMA2 },
+	{ DDP_COMPONENT_DSI3 },
+	{ DDP_COMPONENT_PWM2 },
+};
+
+struct mtk_drm_path_definition mt2712_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt2712_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt2712_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt2712_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
+	},
+	[CRTC_THIRD] = {
+		.comp = mt2712_mtk_ddp_third,
+		.len = ARRAY_SIZE(mt2712_mtk_ddp_third),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt7623_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_BLS },
+	{ DDP_COMPONENT_DPI0 },
+};
+
+static const struct mtk_drm_comp_definition mt7623_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_RDMA1 },
+	{ DDP_COMPONENT_DSI0 },
+};
+
+struct mtk_drm_path_definition mt7623_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt7623_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt7623_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt7623_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt7623_mtk_ddp_ext),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8167_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_CCORR },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_DITHER0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_DSI0 },
+};
+
+struct mtk_drm_path_definition mt8167_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8167_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8167_mtk_ddp_main),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8173_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_OD0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_UFOE },
+	{ DDP_COMPONENT_DSI0 },
+	{ DDP_COMPONENT_PWM0 },
+};
+
+static const struct mtk_drm_comp_definition mt8173_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_OVL1 },
+	{ DDP_COMPONENT_COLOR1 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_RDMA1 },
+	{ DDP_COMPONENT_DPI0 },
+};
+
+struct mtk_drm_path_definition mt8173_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8173_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8173_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt8173_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8183_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_OVL_2L0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_CCORR },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_DITHER0 },
+	{ DDP_COMPONENT_DSI0 },
+};
+
+static const struct mtk_drm_comp_definition mt8183_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_OVL_2L1 },
+	{ DDP_COMPONENT_RDMA1 },
+	{ DDP_COMPONENT_DPI0 },
+};
+
+struct mtk_drm_path_definition mt8183_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8183_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8183_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt8183_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8186_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_CCORR },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_POSTMASK0 },
+	{ DDP_COMPONENT_DITHER0 },
+	{ DDP_COMPONENT_DSI0 },
+};
+
+static const struct mtk_drm_comp_definition mt8186_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_OVL_2L0 },
+	{ DDP_COMPONENT_RDMA1 },
+	{ DDP_COMPONENT_DPI0 },
+};
+
+struct mtk_drm_path_definition mt8186_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8186_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8186_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt8186_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt8186_mtk_ddp_ext),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8188_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_CCORR },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_POSTMASK0 },
+	{ DDP_COMPONENT_DITHER0 },
+};
+
+struct mtk_drm_path_definition mt8188_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8188_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8188_mtk_ddp_main),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8192_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_OVL_2L0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_CCORR },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_POSTMASK0 },
+	{ DDP_COMPONENT_DITHER0 },
+	{ DDP_COMPONENT_DSI0 },
+};
+
+static const struct mtk_drm_comp_definition mt8192_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_OVL_2L2 },
+	{ DDP_COMPONENT_RDMA4 },
+	{ DDP_COMPONENT_DPI0 },
+};
+
+struct mtk_drm_path_definition mt8192_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8192_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8192_mtk_ddp_main),
+	},
+	[CRTC_EXT] = {
+		.comp = mt8192_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt8192_mtk_ddp_ext),
+	},
+};
+
+static const struct mtk_drm_comp_definition mt8195_mtk_ddp_main[] = {
+	{ DDP_COMPONENT_OVL0 },
+	{ DDP_COMPONENT_RDMA0 },
+	{ DDP_COMPONENT_COLOR0 },
+	{ DDP_COMPONENT_CCORR },
+	{ DDP_COMPONENT_AAL0 },
+	{ DDP_COMPONENT_GAMMA },
+	{ DDP_COMPONENT_DITHER0 },
+	{ DDP_COMPONENT_DSC0 },
+	{ DDP_COMPONENT_MERGE0 },
+	{ DDP_COMPONENT_DP_INTF0 },
+};
+
+static const struct mtk_drm_comp_definition mt8195_mtk_ddp_ext[] = {
+	{ DDP_COMPONENT_DRM_OVL_ADAPTOR },
+	{ DDP_COMPONENT_MERGE5 },
+	{ DDP_COMPONENT_DP_INTF1 },
+};
+
+struct mtk_drm_path_definition mt8195_vdo0_legacy_paths[MAX_CRTC] = {
+	[CRTC_MAIN] = {
+		.comp = mt8195_mtk_ddp_main,
+		.len = ARRAY_SIZE(mt8195_mtk_ddp_main),
+	},
+};
+
+struct mtk_drm_path_definition mt8195_vdo1_legacy_paths[MAX_CRTC] = {
+	[CRTC_EXT] = {
+		.comp = mt8195_mtk_ddp_ext,
+		.len = ARRAY_SIZE(mt8195_mtk_ddp_ext),
+	},
+};
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_legacy.h b/drivers/gpu/drm/mediatek/mtk_drm_legacy.h
new file mode 100644
index 000000000000..a87741ec0dcd
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_drm_legacy.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Support for legacy mediatek-drm display paths
+ *
+ * Please read mtk_drm_legacy.c for more information.
+ *
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef MTK_DRM_LEGACY_H
+#define MTK_DRM_LEGACY_H
+
+struct mtk_drm_path_definition;
+
+extern struct mtk_drm_path_definition mt2701_legacy_paths[];
+extern struct mtk_drm_path_definition mt2712_legacy_paths[];
+extern struct mtk_drm_path_definition mt7623_legacy_paths[];
+extern struct mtk_drm_path_definition mt8167_legacy_paths[];
+extern struct mtk_drm_path_definition mt8173_legacy_paths[];
+extern struct mtk_drm_path_definition mt8183_legacy_paths[];
+extern struct mtk_drm_path_definition mt8186_legacy_paths[];
+extern struct mtk_drm_path_definition mt8188_legacy_paths[];
+extern struct mtk_drm_path_definition mt8192_legacy_paths[];
+extern struct mtk_drm_path_definition mt8195_vdo0_legacy_paths[];
+extern struct mtk_drm_path_definition mt8195_vdo1_legacy_paths[];
+
+#endif /* MTK_DRM_LEGACY_H */
-- 
2.54.0

