Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA9606C304
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJNMHZzc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC7A1122BF;
	Thu, 29 Oct 2026 13:36:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99E311229D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D940605CF;
 Thu, 29 Oct 2026 13:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E4C1F01828;
 Thu, 29 Oct 2026 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280996;
 bh=EXecqRORm5Eau7Z5lk11mz0HBFkSxD2l3yk0k03nmHY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PJNMHZzcTnEmQgbXXp311GM5CF8B7kYxJE/9c4+R37XQEimZjpK5r7RrSb7V+5COO
 b+wEtqVpPf1Jz4mMxqRzODURwtP4BO/+5KX4Uhjd5WhsA6SMI8YR5hxsKEK2BBReWR
 WFgLSn9WV+6NEVLubi87frE70137dGZrjgZlr7ZdUdgQlxjINi4yvgxwgQV+j/GBpA
 suaV4wQsYEYPFnv9RxAEdpg6YhDHxlRlRSwAZeVJ4lyQm7Tobv+SWDtMplT80ofCSj
 +BxQxeBpZjpuzluz9vloJFlQG7lA52j2NpT9mkZEIn96jzqWinc/CIpN2+svh9jGEL
 N5wBbHEYVQK4g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:02 -0500
Subject: [PATCH v4 15/31] accel: ethosu: Track command stream register
 setup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-15-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current method of tracking command stream state initializing state
tracking to illegal values and assuming unaccessed registers are 0 is
proving inadequate with additional validation. Instead, track all the
registers in a bitmap as the register address space is fairly small.

CMD1 opcodes overlap CMD0 after bit 14 is stripped, so maintain a
separate bitmap for each bank.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Use NPU_CMD_CTRL_CMD1 define

v3:
 - Fix return value in dma_params_valid()

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h |   2 +
 drivers/accel/ethosu/ethosu_gem.c    | 271 ++++++++++++++++++++++++++++++-----
 2 files changed, 237 insertions(+), 36 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index af1489fe08c4..8405e69acb0c 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -88,6 +88,8 @@ struct gen_pool;
 #define PMU_EV_TYPE_CYCLES	0x11
 #define PMU_EV_TYPE_IDLE	0x20
 
+#define NPU_CMD_CTRL_CMD1		BIT(14)
+
 enum ethosu_cmds {
 	NPU_OP_STOP = 0x0,
 	NPU_OP_CONV = 0x2,
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 2b9c98251c94..75f6901d19e5 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only or MIT
 /* Copyright 2025 Arm, Ltd. */
 
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
@@ -148,7 +149,12 @@ struct feat_matrix {
 	u8 pad_right;
 };
 
+#define NPU_CMD0_REGS	0x200
+#define NPU_CMD1_REGS	0x100
+
 struct cmd_state {
+	DECLARE_BITMAP(cmd0, NPU_CMD0_REGS);
+	DECLARE_BITMAP(cmd1, NPU_CMD1_REGS);
 	struct dma_state dma;
 	struct buffer scale[2];
 	struct buffer weight[4];
@@ -159,8 +165,29 @@ struct cmd_state {
 
 static void cmd_state_init(struct cmd_state *st)
 {
-	/* Initialize to all 1s to detect missing setup */
-	memset(st, 0xff, sizeof(*st));
+	memset(st, 0, sizeof(*st));
+}
+
+static void cmd_state_set_reg(struct cmd_state *st, u16 cmd)
+{
+	u16 reg = cmd & ~NPU_CMD_CTRL_CMD1;
+
+	if (cmd & NPU_CMD_CTRL_CMD1) {
+		if (reg < NPU_CMD1_REGS)
+			__set_bit(reg, st->cmd1);
+	} else if (reg < NPU_CMD0_REGS) {
+		__set_bit(reg, st->cmd0);
+	}
+}
+
+static bool cmd_state_reg_is_set(struct cmd_state *st, u16 cmd)
+{
+	u16 reg = cmd & ~NPU_CMD_CTRL_CMD1;
+
+	if (cmd & NPU_CMD_CTRL_CMD1)
+		return reg < NPU_CMD1_REGS && test_bit(reg, st->cmd1);
+
+	return reg < NPU_CMD0_REGS && test_bit(reg, st->cmd0);
 }
 
 static u64 cmd_to_addr(u32 *cmd)
@@ -168,13 +195,54 @@ static u64 cmd_to_addr(u32 *cmd)
 	return (((u64)cmd[0] & 0xff0000) << 16) | cmd[1];
 }
 
-static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
-		      struct dma_state *dma_st, struct dma *dma)
+static bool dma_use_src_stride(struct ethosu_device *edev,
+			       const struct dma_state *dma_st, const struct dma *dma)
+{
+	return ethosu_is_u65(edev) || dma == &dma_st->src;
+}
+
+static bool dma_params_valid(struct ethosu_device *edev, struct cmd_state *st,
+			     const struct dma_state *dma_st,
+			     const struct dma *dma,
+			     u16 region_cmd, u16 addr_cmd)
+{
+	s8 mode = dma->mode;
+
+	if (!cmd_state_reg_is_set(st, region_cmd) ||
+	    !cmd_state_reg_is_set(st, addr_cmd) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_DMA0_LEN) || mode < 0 || mode > 2)
+		return false;
+
+	if (mode >= 1 &&
+	    !cmd_state_reg_is_set(st, dma_use_src_stride(edev, dma_st, dma) ?
+				  NPU_SET_DMA0_SRC_STRIDE0 :
+				  NPU_SET_DMA0_DST_STRIDE0))
+		return false;
+	if (mode == 2 &&
+	    !cmd_state_reg_is_set(st, dma_use_src_stride(edev, dma_st, dma) ?
+				  NPU_SET_DMA0_SRC_STRIDE1 :
+				  NPU_SET_DMA0_DST_STRIDE1))
+		return false;
+
+	if (mode >= 1 &&
+	    (!cmd_state_reg_is_set(st, NPU_SET_DMA0_SIZE0) || !dma_st->size0))
+		return false;
+	if (mode == 2 &&
+	    (!cmd_state_reg_is_set(st, NPU_SET_DMA0_SIZE1) || !dma_st->size1))
+		return false;
+
+	return true;
+}
+
+static u64 dma_length(struct ethosu_device *edev,
+		      struct ethosu_validated_cmdstream_info *info,
+		      struct cmd_state *st, struct dma_state *dma_st,
+		      struct dma *dma, u16 region_cmd, u16 addr_cmd)
 {
 	s8 mode = dma->mode;
 	u64 len = dma->len;
 
-	if (len == U64_MAX)
+	if (!dma_params_valid(edev, st, dma_st, dma, region_cmd, addr_cmd))
 		return U64_MAX;
 
 	if (mode >= 1) {
@@ -209,17 +277,98 @@ static bool feat_matrix_chained(struct ethosu_device *edev, struct feat_matrix *
 	return !ethosu_is_u65(edev) && storage == 2;
 }
 
+enum feat_matrix_type {
+	FEAT_MATRIX_IFM,
+	FEAT_MATRIX_OFM,
+	FEAT_MATRIX_IFM2,
+};
+
+static u16 feat_matrix_base_cmd(enum feat_matrix_type type)
+{
+	switch (type) {
+	case FEAT_MATRIX_IFM:
+		return NPU_SET_IFM_BASE0;
+	case FEAT_MATRIX_OFM:
+		return NPU_SET_OFM_BASE0;
+	case FEAT_MATRIX_IFM2:
+		return NPU_SET_IFM2_BASE0;
+	}
+
+	return 0;
+}
+
+static int feat_matrix_validate(struct ethosu_device *edev,
+				struct cmd_state *st, struct feat_matrix *fm,
+				enum feat_matrix_type type)
+{
+	u32 format;
+	u16 stride_cmd;
+
+	switch (type) {
+	case FEAT_MATRIX_IFM:
+		if (!cmd_state_reg_is_set(st, NPU_SET_IFM_REGION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PRECISION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_DEPTH_M1))
+			return -EINVAL;
+		if (feat_matrix_chained(edev, fm))
+			return 0;
+		if (!cmd_state_reg_is_set(st, NPU_SET_IFM_WIDTH0_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_HEIGHT0_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_HEIGHT1_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_STRIDE_Y))
+			return -EINVAL;
+		break;
+	case FEAT_MATRIX_OFM:
+		if (!cmd_state_reg_is_set(st, NPU_SET_OFM_REGION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_PRECISION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_DEPTH_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_WIDTH_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_HEIGHT_M1))
+			return -EINVAL;
+		if (feat_matrix_chained(edev, fm))
+			return 0;
+		if (!cmd_state_reg_is_set(st, NPU_SET_OFM_WIDTH0_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_HEIGHT0_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_HEIGHT1_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_OFM_STRIDE_Y))
+			return -EINVAL;
+		break;
+	case FEAT_MATRIX_IFM2:
+		if (!cmd_state_reg_is_set(st, NPU_SET_IFM2_REGION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM2_PRECISION))
+			return -EINVAL;
+		if (feat_matrix_chained(edev, fm))
+			return 0;
+		if (!cmd_state_reg_is_set(st, NPU_SET_IFM2_WIDTH0_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM2_HEIGHT0_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM2_HEIGHT1_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM2_STRIDE_Y))
+			return -EINVAL;
+		break;
+	}
+
+	format = (fm->precision >> 6) & 0x3;
+	stride_cmd = feat_matrix_base_cmd(type) + (format ? 6 : 4);
+	if (!cmd_state_reg_is_set(st, stride_cmd))
+		return -EINVAL;
+
+	return 0;
+}
 static u64 feat_matrix_length(struct ethosu_device *edev,
 			      struct ethosu_validated_cmdstream_info *info,
-			      struct feat_matrix *fm,
+			      struct cmd_state *st, struct feat_matrix *fm,
+			      enum feat_matrix_type type,
 			      u32 x, u32 y, u32 c, bool ofm)
 {
 	u32 element_size, storage = ethosu_is_u65(edev) ? 0 : fm->precision >> 14;
 	int tile = 0;
 	u64 addr;
+	u64 offset;
 
 	if (fm->region < 0)
 		return U64_MAX;
+	if (feat_matrix_validate(edev, st, fm, type))
+		return U64_MAX;
 
 	if (feat_matrix_chained(edev, fm))
 		return 0;
@@ -247,24 +396,39 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 	default:
 		return U64_MAX;
 	}
-	if (fm->base[tile] == U64_MAX)
+	if (!cmd_state_reg_is_set(st, feat_matrix_base_cmd(type) + tile))
 		return U64_MAX;
 
-	addr = fm->base[tile] + y * fm->stride_y;
+	if (check_mul_overflow(y, (u64)fm->stride_y, &offset) ||
+	    check_add_overflow(fm->base[tile], offset, &addr))
+		return U64_MAX;
 
 	switch ((fm->precision >> 6) & 0x3) { // format
 	case 0: //nhwc:
 		element_size = BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
-		addr += x * fm->stride_x + c * element_size;
+		if (check_mul_overflow(x, (u64)fm->stride_x, &offset) ||
+		    check_add_overflow(addr, offset, &addr) ||
+		    check_mul_overflow(c, element_size, &offset) ||
+		    check_add_overflow(addr, offset, &addr))
+			return U64_MAX;
 		break;
 	case 1: //nhcwb16:
 		element_size = BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
 
-		addr += (c / 16) * fm->stride_c + (16 * x + (c & 0xf)) * element_size;
+		if (check_mul_overflow(c / 16, (u64)fm->stride_c, &offset) ||
+		    check_add_overflow(addr, offset, &addr) ||
+		    check_mul_overflow(16 * x + (c & 0xf), element_size, &offset) ||
+		    check_add_overflow(addr, offset, &addr))
+			return U64_MAX;
 		break;
+	default:
+		return U64_MAX;
 	}
 
-	info->region_size[fm->region] = max(info->region_size[fm->region], addr + 1);
+	if (check_add_overflow(addr, 1ULL, &offset))
+		return U64_MAX;
+
+	info->region_size[fm->region] = max(info->region_size[fm->region], offset);
 
 	return addr;
 }
@@ -278,7 +442,13 @@ static int calc_sizes(struct drm_device *ddev,
 	u64 len;
 
 	if (ifm) {
-		if (st->ifm.stride_kernel == U16_MAX)
+		if (!cmd_state_reg_is_set(st, NPU_SET_KERNEL_WIDTH_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_KERNEL_HEIGHT_M1) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_KERNEL_STRIDE) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_TOP) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_LEFT) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_RIGHT) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_BOTTOM))
 			return -EINVAL;
 		u32 stride_y = ((st->ifm.stride_kernel >> 8) & 0x2) +
 			((st->ifm.stride_kernel >> 1) & 0x1) + 1;
@@ -292,8 +462,9 @@ static int calc_sizes(struct drm_device *ddev,
 		if (ifm_height < 0 || ifm_width < 0)
 			return -EINVAL;
 
-		len = feat_matrix_length(edev, info, &st->ifm, ifm_width,
-					 ifm_height, st->ifm.depth, false);
+		len = feat_matrix_length(edev, info, st, &st->ifm,
+					 FEAT_MATRIX_IFM, ifm_width, ifm_height,
+					 st->ifm.depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
 		if (len == U64_MAX)
@@ -301,8 +472,9 @@ static int calc_sizes(struct drm_device *ddev,
 	}
 
 	if (ifm2) {
-		len = feat_matrix_length(edev, info, &st->ifm2, st->ifm.depth,
-					 0, st->ofm.depth, false);
+		len = feat_matrix_length(edev, info, st, &st->ifm2,
+					 FEAT_MATRIX_IFM2, st->ifm.depth, 0,
+					 st->ofm.depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
 		if (len == U64_MAX)
@@ -313,8 +485,9 @@ static int calc_sizes(struct drm_device *ddev,
 		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
 			op, st->weight[0].region, st->weight[0].base,
 			st->weight[0].base + st->weight[0].length - 1);
-		if (st->weight[0].region < 0 || st->weight[0].base == U64_MAX ||
-		    st->weight[0].length == U32_MAX)
+		if (!cmd_state_reg_is_set(st, NPU_SET_WEIGHT_REGION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_WEIGHT_BASE) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_WEIGHT_LENGTH))
 			return -EINVAL;
 		info->region_size[st->weight[0].region] =
 			max(info->region_size[st->weight[0].region],
@@ -325,16 +498,18 @@ static int calc_sizes(struct drm_device *ddev,
 		dev_dbg(ddev->dev, "op %d: S:%d:0x%llx-0x%llx\n",
 			op, st->scale[0].region, st->scale[0].base,
 			st->scale[0].base + st->scale[0].length - 1);
-		if (st->scale[0].region < 0 || st->scale[0].base == U64_MAX ||
-		    st->scale[0].length == U32_MAX)
+		if (!cmd_state_reg_is_set(st, NPU_SET_SCALE_REGION) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_SCALE_BASE) ||
+		    !cmd_state_reg_is_set(st, NPU_SET_SCALE_LENGTH))
 			return -EINVAL;
 		info->region_size[st->scale[0].region] =
 			max(info->region_size[st->scale[0].region],
 			    st->scale[0].base + st->scale[0].length);
 	}
 
-	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
-				 st->ofm.height[2], st->ofm.depth, true);
+	len = feat_matrix_length(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
+				 st->ofm.width, st->ofm.height[2], st->ofm.depth,
+				 true);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
 	if (len == U64_MAX)
@@ -359,8 +534,8 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		width = st->ifm.broadcast & 0x2 ? 0 : st->ofm.width;
 		depth = st->ifm.broadcast & 0x4 ? 0 : st->ofm.depth;
 
-		len = feat_matrix_length(edev, info, &st->ifm, width,
-					 height, depth, false);
+		len = feat_matrix_length(edev, info, st, &st->ifm,
+					 FEAT_MATRIX_IFM, width, height, depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
 		if (len == U64_MAX)
@@ -372,16 +547,17 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		width = st->ifm2.broadcast & 0x2 ? 0 : st->ofm.width;
 		depth = st->ifm2.broadcast & 0x4 ? 0 : st->ofm.depth;
 
-		len = feat_matrix_length(edev, info, &st->ifm2, width,
-					 height, depth, false);
+		len = feat_matrix_length(edev, info, st, &st->ifm2,
+					 FEAT_MATRIX_IFM2, width, height, depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
 		if (len == U64_MAX)
 			return -EINVAL;
 	}
 
-	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
-				 st->ofm.height[2], st->ofm.depth, true);
+	len = feat_matrix_length(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
+				 st->ofm.width, st->ofm.height[2], st->ofm.depth,
+				 true);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
 	if (len == U64_MAX)
@@ -425,7 +601,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		cmd = cmds[0];
 		param = cmds[0] >> 16;
 
-		if (cmd & 0x4000) {
+		if (cmd & NPU_CMD_CTRL_CMD1) {
 			if (get_user(cmds[1], ucmds++))
 				return -EFAULT;
 
@@ -436,6 +612,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			addr = cmd_to_addr(cmds);
 		}
 
+		cmd_state_set_reg(&st, cmd);
+
 		switch (cmd) {
 		case NPU_OP_STOP:
 			if (i != size / 4 - 1)
@@ -443,8 +621,10 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			ends_with_stop = true;
 			break;
 		case NPU_OP_DMA_START:
-			srclen = dma_length(info, &st.dma, &st.dma.src);
-			dstlen = dma_length(info, &st.dma, &st.dma.dst);
+			srclen = dma_length(edev, info, &st, &st.dma, &st.dma.src,
+					    NPU_SET_DMA0_SRC_REGION, NPU_SET_DMA0_SRC);
+			dstlen = dma_length(edev, info, &st, &st.dma, &st.dma.dst,
+					    NPU_SET_DMA0_DST_REGION, NPU_SET_DMA0_DST);
 			if (srclen == U64_MAX || dstlen == U64_MAX)
 				return -EINVAL;
 
@@ -455,16 +635,28 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				st.dma.dst.region, st.dma.dst.offset, dstlen);
 			break;
 		case NPU_OP_CONV:
-		case NPU_OP_DEPTHWISE:
 			use_ifm2 = param & 0x1;  // weights_ifm2
+			if (!cmd_state_reg_is_set(&st, NPU_SET_OFM_PRECISION))
+				return -EINVAL;
 			use_scale = !(st.ofm.precision & 0x100);
 			ret = calc_sizes(ddev, info, cmd, &st, true, use_ifm2,
 					 !use_ifm2, use_scale);
 			if (ret)
 				return ret;
 			break;
+		case NPU_OP_DEPTHWISE:
+			if (!cmd_state_reg_is_set(&st, NPU_SET_OFM_PRECISION))
+				return -EINVAL;
+			use_scale = !(st.ofm.precision & 0x100);
+			ret = calc_sizes(ddev, info, cmd, &st, true, false, true,
+					 use_scale);
+			if (ret)
+				return ret;
+			break;
 		case NPU_OP_POOL:
 			use_ifm = param != 0x4;  // pooling mode
+			if (!cmd_state_reg_is_set(&st, NPU_SET_OFM_PRECISION))
+				return -EINVAL;
 			use_scale = !(st.ofm.precision & 0x100);
 			ret = calc_sizes(ddev, info, cmd, &st, use_ifm, false,
 					 false, use_scale);
@@ -472,11 +664,18 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_ELEMENTWISE:
-			use_scale = ethosu_is_u65(edev) ?
+			if (!ethosu_is_u65(edev) &&
+			    !cmd_state_reg_is_set(&st, NPU_SET_IFM_BROADCAST))
+				return -EINVAL;
+			use_ifm2 = (param != 5) && (param != 6) &&
+				(param != 7) && (param != 0x24);
+			if (use_ifm2 &&
+			    !cmd_state_reg_is_set(&st, NPU_SET_IFM2_BROADCAST))
+				return -EINVAL;
+			use_scale = use_ifm2 && (ethosu_is_u65(edev) ?
 				    (st.ifm2.broadcast & 0x80) :
-				    (st.ifm2.broadcast == 8);
-			use_ifm2 = !(use_scale || (param == 5) ||
-				(param == 6) || (param == 7) || (param == 0x24));
+				    (st.ifm2.broadcast == 8));
+			use_ifm2 = use_ifm2 && !use_scale;
 			use_ifm = st.ifm.broadcast != 8;
 			ret = calc_sizes_elemwise(ddev, info, cmd, &st, use_ifm, use_ifm2);
 			if (ret)

-- 
2.53.0

