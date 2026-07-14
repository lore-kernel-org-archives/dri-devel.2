Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E4DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 247D010ECF8;
	Tue, 14 Jul 2026 11:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PpdSU78f";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F02D10E943
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784029496;
 bh=jcngV4jbMINzejAf1lptWsag8jNh6HhdqeoK3tR+i4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PpdSU78fFrjz5e/YoupjYtMYR/PWqmDeSDe+vDIfM4MYz+9/ykykdTnTN+8ZBeUkx
 RL1gQP+fukVokP8LvaRDxNspCsUjTOmMwrjigELVsRB7IE50RsGXxSNrBst0vF98HJ
 rAX8hOs70QmqEZDZhAoSGvL32Lh3rtNJctRagu0r9LWdX+W4w8I095n/fGH+gypGxv
 +817llF8tyKQPC/fYbiTwPc5GRig3CycSOPdiZUpEWSUoS7yQsMt9d51kBzyGkKvCH
 qhRFVGFDMpUHHNixLkS2K3q7kva1qo8Fw9VlMpIPyHTUTn5B7AGl2nKbIbndB667y6
 /QPETGQNo4LFA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 540B817E0FD2;
 Tue, 14 Jul 2026 13:44:55 +0200 (CEST)
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
Subject: [PATCH v2 22/46] soc: mediatek: mtk-mmsys: Migrate to new Multimedia
 DDP HW indexing
Date: Tue, 14 Jul 2026 13:43:50 +0200
Message-ID: <20260714114414.184512-23-angelogioacchino.delregno@collabora.com>
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

The mediatek-drm driver is ready to switch to the new Multimedia
Subsystem Display Controller HW indexing.

Perform the switch by:
 - Adding new "from_comp_inst" and "to_comp_inst" members in the
   Multimedia Subsystem HW Routes structure (mtk_mmsys_routes);
 - Changing the MMSYS_ROUTE() macro to use those, which performs
   the migration of all SoCs in one go (as all of them use this
   macro to declare their route entries);
 - Adding new mtk_mmsys_hw_connect() and mtk_mmsys_hw_disconnect()
   functions, making use of the new HW Component Type-Instance
   indexing.

Unfortunately, this change needs to go along with the related one
in the mediatek-drm driver, otherwise functionality of the Display
Controller will regress.

The only way to make this possible in two steps is to duplicate
all of the routes structure arrays for all of the SoCs, which
would result in a total of around ~1200 lines changed twice, and
that ignores the big increase in size for this driver during the
migration process so, in order to avoid useless bloat, I opted
for an inter-dependency between the two changes: mediatek-drm
and mtk-mmsys.

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c       | 99 ++++++++++++++++++++------
 drivers/soc/mediatek/mtk-mmsys.h       | 15 ++--
 include/linux/soc/mediatek/mtk-mmsys.h | 16 ++---
 3 files changed, 90 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 2f3e0778bb17..f501a29a7697 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2014 MediaTek Inc.
- * Author: James Liao <jamesjj.liao@mediatek.com>
+ *                    James Liao <jamesjj.liao@mediatek.com>
+ *
+ * Copyrignt (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <linux/delay.h>
@@ -182,38 +185,90 @@ static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask,
 	writel_relaxed(tmp, mmsys->regs + offset);
 }
 
-void mtk_mmsys_ddp_connect(struct device *dev,
-			   enum mtk_ddp_comp_id cur,
-			   enum mtk_ddp_comp_id next)
+/**
+ * mtk_mmsys_hw_connect - Connect MultiMedia Subsystem (MMSYS) Hardware IPs
+ * @dev:            Device pointer
+ * @src_type:       Type of the Source IP
+ * @src_hw_inst_id: Hardware instance of the Source IP
+ * @dst_type:       Type of the Destination IP
+ * @dst_hw_inst_id: Hardware instance of the Destination IP
+ *
+ * This function connects one MultiMedia Subsystem (MMSYS) related hardware
+ * to another (in the same subsystem), depending on supported connections.
+ * In short, this connects "Source" to "Destination", as in, enables sending
+ * data from a Source IP to a Destination IP.
+ *
+ * As a final note - depending on the SoC and on the specific IPs, it may
+ * also be possible to connect multiple Sources to a single Destination.
+ *
+ * Examples below follow this format to explain hardware components:
+ *      [Source Type][Instance ID] -> [Destination Type] [Instance ID]
+ *
+ * Example 1 - Single Source to Destination
+ *                         GAMMA 0 -> DITHER 0
+ *
+ * Example 2 - Multiple Sources to Single Destination
+ *                 MDP_RDMA 0 -----\
+ *                                  |
+ *                                  v
+ *                 MDP_RDMA 1 ---> MERGE 1 \
+ *                 MDP_RDMA 2 ---> MERGE 2 -\
+ *                                           >> ETHDR_MIXER 0
+ *                 (other 1)  ---> MERGE 3 -/
+ *                 (other 2)  ---> MERGE 4 /
+ *
+ * Note that in Example 2, some components are not chained together, but
+ * connected in parallel to a destination.
+ */
+void mtk_mmsys_hw_connect(struct device *dev,
+			  enum mtk_ddp_comp_type src_type, u8 src_hw_inst_id,
+			  enum mtk_ddp_comp_type dst_type, u8 dst_hw_inst_id)
 {
 	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
 	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
-	int i;
 
-	for (i = 0; i < mmsys->data->num_routes; i++)
-		if (cur == routes[i].from_comp && next == routes[i].to_comp)
-			mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask,
-					      routes[i].val, NULL);
+	for (int i = 0; i < mmsys->data->num_routes; i++) {
+		if (src_type != routes[i].from_comp_type ||
+		    src_hw_inst_id != routes[i].from_comp_inst ||
+		    dst_type != routes[i].to_comp_type ||
+		    dst_hw_inst_id != routes[i].to_comp_inst)
+			continue;
 
-	if (mmsys->data->vsync_len)
-		mtk_mmsys_update_bits(mmsys, MT8188_VDO1_MIXER_VSYNC_LEN, GENMASK(31, 0),
-				      mmsys->data->vsync_len, NULL);
+		mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask, routes[i].val, NULL);
+		dev_dbg(dev, "Connected %u-%u to %u-%u\n",
+			src_type, src_hw_inst_id, dst_type, dst_hw_inst_id);
+	}
 }
-EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
-
-void mtk_mmsys_ddp_disconnect(struct device *dev,
-			      enum mtk_ddp_comp_id cur,
-			      enum mtk_ddp_comp_id next)
+EXPORT_SYMBOL_NS_GPL(mtk_mmsys_hw_connect, "MTK_MMSYS");
+
+/**
+ * mtk_mmsys_hw_disconnect - Disconnect MultiMedia Subsystem (MMSYS) Hardware IPs
+ * @dev:            Device pointer
+ * @src_type:       Type of the Source IP
+ * @src_hw_inst_id: Hardware instance of the Source IP
+ * @dst_type:       Type of the Destination IP
+ * @dst_hw_inst_id: Hardware instance of the Destination IP
+ */
+void mtk_mmsys_hw_disconnect(struct device *dev,
+			     enum mtk_ddp_comp_type src_type, u8 src_hw_inst_id,
+			     enum mtk_ddp_comp_type dst_type, u8 dst_hw_inst_id)
 {
 	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
 	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
-	int i;
 
-	for (i = 0; i < mmsys->data->num_routes; i++)
-		if (cur == routes[i].from_comp && next == routes[i].to_comp)
-			mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask, 0, NULL);
+	for (int i = 0; i < mmsys->data->num_routes; i++) {
+		if (src_type != routes[i].from_comp_type ||
+		    src_hw_inst_id != routes[i].from_comp_inst ||
+		    dst_type != routes[i].to_comp_type ||
+		    dst_hw_inst_id != routes[i].to_comp_inst)
+			continue;
+
+		mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask, 0, NULL);
+		dev_dbg(dev, "Disconnected %u-%u from %u-%u\n",
+			src_type, src_hw_inst_id, dst_type, dst_hw_inst_id);
+	}
 }
-EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
+EXPORT_SYMBOL_NS_GPL(mtk_mmsys_hw_disconnect, "MTK_MMSYS");
 
 void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width, int height,
 				  struct cmdq_pkt *cmdq_pkt)
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index c51a5e334e29..5c9319f3a2bb 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -80,20 +80,13 @@
 
 #define MMSYS_RST_NR(bank, bit) (((bank) * 32) + (bit))
 
-/* Temporary compatibility definitions */
-#define DDP_COMPONENT_BLS0		DDP_COMPONENT_BLS
-#define DDP_COMPONENT_CCORR0		DDP_COMPONENT_CCORR
-#define DDP_COMPONENT_UFOE0		DDP_COMPONENT_UFOE
-#define DDP_COMPONENT_GAMMA0		DDP_COMPONENT_GAMMA
-#define DDP_COMPONENT_ETHDR_MIXER0	DDP_COMPONENT_ETHDR_MIXER
-
 /*
  * This macro adds a compile time check to make sure that the in/out
  * selection bit(s) fit in the register mask, similar to bitfield
  * macros, but this does not transform the value.
  */
 #define MMSYS_ROUTE(from, fsid, to, tsid, reg_addr, reg_mask, selection)	\
-	{ DDP_COMPONENT_##from##fsid, DDP_COMPONENT_##to##tsid, reg_addr, reg_mask,	\
+	{ MTK_DISP_##from, fsid, MTK_DISP_##to, tsid, reg_addr, reg_mask,	\
 	  (__BUILD_BUG_ON_ZERO_MSG((reg_mask) == 0, "Invalid mask") +		\
 	   __BUILD_BUG_ON_ZERO_MSG(~(reg_mask) & (selection),			\
 				   #selection " does not fit in "		\
@@ -102,8 +95,10 @@
 	}
 
 struct mtk_mmsys_routes {
-	u32 from_comp;
-	u32 to_comp;
+	u8 from_comp_type;
+	u8 from_comp_inst;
+	u8 to_comp_type;
+	u8 to_comp_inst;
 	u32 addr;
 	u32 mask;
 	u32 val;
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index bbdd0b01927d..f67f21d04163 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -118,14 +118,6 @@ enum mtk_ddp_comp_type {
 	MTK_DDP_COMP_TYPE_MAX
 };
 
-void mtk_mmsys_ddp_connect(struct device *dev,
-			   enum mtk_ddp_comp_id cur,
-			   enum mtk_ddp_comp_id next);
-
-void mtk_mmsys_ddp_disconnect(struct device *dev,
-			      enum mtk_ddp_comp_id cur,
-			      enum mtk_ddp_comp_id next);
-
 void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val);
 
 void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width,
@@ -134,6 +126,14 @@ void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width,
 void mtk_mmsys_hdr_config(struct device *dev, int be_width, int be_height,
 			  struct cmdq_pkt *cmdq_pkt);
 
+void mtk_mmsys_hw_connect(struct device *dev,
+			  enum mtk_ddp_comp_type src_type, u8 src_hw_inst_id,
+			  enum mtk_ddp_comp_type dst_type, u8 dst_hw_inst_id);
+
+void mtk_mmsys_hw_disconnect(struct device *dev,
+			     enum mtk_ddp_comp_type src_type, u8 src_hw_inst_id,
+			     enum mtk_ddp_comp_type dst_type, u8 dst_hw_inst_id);
+
 void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16 alpha,
 			       u8 mode, u32 biwidth, struct cmdq_pkt *cmdq_pkt);
 
-- 
2.54.0

