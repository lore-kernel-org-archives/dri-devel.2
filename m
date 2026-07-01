Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64C7C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0014010EF4E;
	Wed,  1 Jul 2026 12:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="J9AwQjsR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D2810EF4C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908452;
 bh=knL125EqyeDrxGL3Ld+yoYxozWxizbjazjQr+Cmfeww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J9AwQjsRjbU+eOAh5iRR3sAr+iiBXCt944cwy3yqYQeus2HgH1dvBLmfxuvG874Oh
 5/rIavH3IYSPgKEvRrreXsWhp4qaj7HKFStCQXj1yCrDSzp3J0C3ttQOHGp7CnqXF1
 VLXu8o6BUJsU9egdpFa4o4QWbxLqB9tZMpTLQ48EzQLgJh83r6oo6hvDP45Sp35rxC
 4gBjxcp4WqhWOlFS8rT84GHKkGOhgDC8pG3vPbCh0za/C/jcFnmyVucp+Y32HEPT0T
 XqZ2WQj9BnpJOPzooTYilY/1+Hc0u+6YGhW2V0Mtx4S03jbFMml41jpCZBMip1p/FU
 3G4C5ZxF2hZ2Q==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA5E317E0FAA;
 Wed,  1 Jul 2026 14:20:50 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 andi.shyti@kernel.org, djakov@kernel.org, broonie@kernel.org,
 jitao.shi@mediatek.com, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 4/6] soc: mediatek: mtk-mutex: Add new functions to add/remove
 triggers
Date: Wed,  1 Jul 2026 14:20:41 +0200
Message-ID: <20260701122043.19612-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
References: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
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

Add new mtk_mutex_add_trigger() and mtk_mutex_remove_trigger() to
replace, in the near future, their older style equivalents such as
mtk_mutex_add_comp() and mtk_mutex_remove_comp() for the Display
Controller related MuteX triggers.

The same functions will be used to also replace the Media Data
Path 3 (MDP3) specific mtk_mutex_write_mod(), unifying the MuteX
handling across all of the currently supported multimedia-related
drivers for MediaTek SoCs.

While at it, this also takes into account the upcoming refactoring
of mtk_mmsys and mediatek-drm, which are about to migrate to a new
Component "Type -> Hardware ID" mapping, by adding a new function
parameter "hw_inst_id" to support that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 60 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h |  6 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 6ffdcb673ae9..28715b07e668 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -960,6 +960,65 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_unprepare);
 
+static enum mtk_mutex_sof_id mtk_mutex_get_sof_trig(enum mtk_ddp_comp_type type,
+						    unsigned int hw_inst_id)
+{
+	switch (type) {
+	case MTK_DISP_DSI:
+		return MUTEX_SOF_DSI0 + hw_inst_id;
+	case MTK_DISP_DPI:
+		return MUTEX_SOF_DPI0 + hw_inst_id;
+	case MTK_DISP_DP_INTF:
+		return MUTEX_SOF_DP_INTF0 + hw_inst_id;
+	default:
+		break;
+	}
+
+	return DDP_MUTEX_SOF_MAX;
+}
+
+void mtk_mutex_add_trigger(struct mtk_mutex *mutex, enum mtk_ddp_comp_type type,
+			   unsigned int hw_inst_id, unsigned int mtx_trig_id)
+{
+	struct mtk_mutex_ctx *ctx = container_of(mutex, struct mtk_mutex_ctx, mutex[mutex->id]);
+	enum mtk_mutex_sof_id sof_id = mtk_mutex_get_sof_trig(type, hw_inst_id);
+	const u32 offset = DISP_REG_MUTEX_MOD(ctx, mtx_trig_id, mutex->id);
+	u32 val;
+
+	if (sof_id < DDP_MUTEX_SOF_MAX) {
+		const u32 sof_offset = DISP_REG_MUTEX_SOF(ctx->data->mutex_sof_reg, mutex->id);
+
+		writel(ctx->data->mutex_sof[sof_id], ctx->regs + sof_offset);
+		return;
+	}
+
+	val = readl(ctx->regs + offset);
+	writel(val | BIT(mtx_trig_id % 32), ctx->regs + offset);
+}
+EXPORT_SYMBOL_NS_GPL(mtk_mutex_add_trigger, "MTK_MUTEX");
+
+void mtk_mutex_remove_trigger(struct mtk_mutex *mutex, enum mtk_ddp_comp_type type,
+			      unsigned int hw_inst_id, unsigned int mtx_trig_id)
+{
+	struct mtk_mutex_ctx *ctx = container_of(mutex, struct mtk_mutex_ctx, mutex[mutex->id]);
+	enum mtk_mutex_sof_id sof_id = mtk_mutex_get_sof_trig(type, hw_inst_id);
+	const u32 offset = DISP_REG_MUTEX_MOD(ctx, mtx_trig_id, mutex->id);
+	u32 val;
+
+	if (sof_id < DDP_MUTEX_SOF_MAX) {
+		const u32 sof_offset = DISP_REG_MUTEX_SOF(ctx->data->mutex_sof_reg, mutex->id);
+
+		val = readl(ctx->regs + sof_offset);
+		writel(val & ~ctx->data->mutex_sof[sof_id], ctx->regs + sof_offset);
+		return;
+	}
+
+	val = readl(ctx->regs + offset);
+	writel(val & ~BIT(mtx_trig_id % 32), ctx->regs + offset);
+}
+EXPORT_SYMBOL_NS_GPL(mtk_mutex_remove_trigger, "MTK_MUTEX");
+
+/* TODO: Legacy - Scheduled for removal */
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id)
 {
@@ -1011,6 +1070,7 @@ void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_add_comp);
 
+/* TODO: Legacy - Scheduled for removal */
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id)
 {
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 635218e3ac68..5368206dd62c 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -67,16 +67,22 @@ enum mtk_mutex_sof_index {
 	MUTEX_SOF_IDX_MAX		/* ALWAYS keep at the end */
 };
 
+enum mtk_ddp_comp_type;
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev);
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
+void mtk_mutex_add_trigger(struct mtk_mutex *mutex, enum mtk_ddp_comp_type type,
+			   unsigned int hw_inst_id, unsigned int mtx_trig_id);
 void mtk_mutex_enable(struct mtk_mutex *mutex);
 int mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
 			     void *pkt);
 void mtk_mutex_disable(struct mtk_mutex *mutex);
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id);
+void mtk_mutex_remove_trigger(struct mtk_mutex *mutex, enum mtk_ddp_comp_type type,
+			      unsigned int hw_inst_id, unsigned int mtx_trig_id);
 void mtk_mutex_unprepare(struct mtk_mutex *mutex);
 void mtk_mutex_put(struct mtk_mutex *mutex);
 void mtk_mutex_acquire(struct mtk_mutex *mutex);
-- 
2.54.0

