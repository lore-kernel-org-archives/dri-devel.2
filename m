Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36F6606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLzeX1wm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855731122DA;
	Thu, 29 Oct 2026 13:37:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA271122DA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57F0941FC2;
 Thu, 29 Oct 2026 13:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE16C1F01825;
 Thu, 29 Oct 2026 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281019;
 bh=7xahu3ursgj9R2ICIpMtCs8ahKKm2hhp7bMQGfdtbbg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kLzeX1wmYXXN2kpJRJkm9te6HMBit/xSlz7FhTv4k5tG7hwgt5Fm3VKZD7EEacIy5
 wJWVsxX98bD0tO/4HFcM/Vx+Ce1lU7wD54U5DzdixEEMoF1l3M8WpLGcy3rKth+lP5
 TGA/mX9DUw2kvMbYuOroHR6TcOMqAm8lsYMjpGWb+cVuduawjj6QYLFqmRiGm5E06j
 T6JMkczfPHEVIqEBM1UoyexjuVdQb2sQRMEIVGEg49CFyUggNSyQOTOuGfmRMAv5Kq
 Av5ISa/TMBSU6zlLoGzdgQ3GlKE2bBR18Uw1HxyiQTTTOsDGbrR4ei9qlvvTOsxOtS
 2FInWOZ3QNyxA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:15 -0500
Subject: [PATCH v4 28/31] accel: ethosu: Validate resize operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-28-4aa25e22578e@kernel.org>
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

Resize input coordinates are controlled by the scale, offset, and step
registers. Require those values to be explicitly programmed, validate
the scale and step relationships, and use a conservative coordinate
bound when validating the input feature map.

This prevents retained or malformed resize state from accessing beyond
the validated input feature-map buffer.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Fix width and height calculations to account for kernel size reported
   by sashiko

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h |   8 ++
 drivers/accel/ethosu/ethosu_gem.c    | 161 ++++++++++++++++++++++++++++++++++-
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index c3789474fa7b..135c33f57045 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -121,6 +121,8 @@ enum ethosu_cmds {
 	NPU_SET_OFM_HEIGHT_M1 = 0x112,
 	NPU_SET_OFM_DEPTH_M1 = 0x113,
 	NPU_SET_OFM_PRECISION = 0x114,
+	NPU_SET_OFM_BLK_WIDTH_M1 = 0x115,
+	NPU_SET_OFM_BLK_HEIGHT_M1 = 0x116,
 	NPU_SET_OFM_WIDTH0_M1 = 0x11a,
 	NPU_SET_OFM_HEIGHT0_M1 = 0x11b,
 	NPU_SET_OFM_HEIGHT1_M1 = 0x11c,
@@ -131,6 +133,10 @@ enum ethosu_cmds {
 	NPU_SET_ACC_FORMAT = 0x124,
 	NPU_SET_WEIGHT_REGION = 0x128,
 	NPU_SET_SCALE_REGION = 0x129,
+	NPU_SET_RESIZE_X_SCALE_N_M1 = 0x12a,
+	NPU_SET_RESIZE_Y_SCALE_N_M1 = 0x12b,
+	NPU_SET_RESIZE_X_OFFSET = 0x12c,
+	NPU_SET_RESIZE_Y_OFFSET = 0x12d,
 	NPU_SET_DMA0_SRC_REGION = 0x130,
 	NPU_SET_DMA0_DST_REGION = 0x131,
 	NPU_SET_DMA0_SIZE0 = 0x132,
@@ -181,6 +187,8 @@ enum ethosu_cmds {
 	NPU_SET_WEIGHT2_LENGTH = 0x4093,
 	NPU_SET_WEIGHT3_BASE = 0x4094,
 	NPU_SET_WEIGHT3_LENGTH = 0x4095,
+	NPU_SET_RESIZE_X = 0x4096,
+	NPU_SET_RESIZE_Y = 0x4097,
 };
 
 #define NPU_ACC_FORMAT_INPUT_MASK	GENMASK(5, 4)
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index fe6bf1a2f8cb..0b227664afc7 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -149,6 +149,15 @@ struct feat_matrix {
 	u8 pad_right;
 };
 
+struct resize_axis {
+	u16 scale_n;
+	s16 offset;
+	u16 one_step_int;
+	u16 one_step_mod;
+	u16 blk_step_int;
+	u16 blk_step_mod;
+};
+
 #define NPU_CMD0_REGS	0x200
 #define NPU_CMD1_REGS	0x100
 
@@ -162,6 +171,9 @@ struct cmd_state {
 	struct feat_matrix ofm;
 	struct feat_matrix ifm;
 	struct feat_matrix ifm2;
+	u16 ofm_blk_width;
+	u16 ofm_blk_height;
+	struct resize_axis resize[2];
 };
 
 static void cmd_state_init(struct cmd_state *st)
@@ -663,6 +675,98 @@ calc_acc_input_size(struct drm_device *ddev,
 	return ret;
 }
 
+static int resize_axis_size(struct cmd_state *st, int axis, u16 ofm_size,
+			    u16 ofm_blk_size, u32 *size)
+{
+	struct resize_axis *resize = &st->resize[axis];
+	u64 one_step, blk_step, coord;
+
+	if (resize->offset < -(s16)resize->scale_n ||
+	    resize->offset >= resize->scale_n ||
+	    resize->one_step_mod >= resize->scale_n ||
+	    resize->blk_step_mod >= resize->scale_n)
+		return -EINVAL;
+
+	one_step = resize->one_step_int * resize->scale_n +
+		resize->one_step_mod;
+	blk_step = resize->blk_step_int * resize->scale_n +
+		resize->blk_step_mod;
+	if (check_mul_overflow((u64)ofm_blk_size, one_step, &coord) ||
+	    blk_step != coord)
+		return -EINVAL;
+
+	if (check_mul_overflow((u64)ofm_size, one_step, &coord) ||
+	    check_add_overflow(coord, (u64)resize->scale_n - 1, &coord))
+		return -EINVAL;
+
+	coord = div_u64(coord, resize->scale_n);
+	if (coord >= U32_MAX)
+		return -EINVAL;
+
+	*size = coord + 1;
+	return 0;
+}
+
+
+static int calc_sizes_resize(struct drm_device *ddev,
+			     struct ethosu_validated_cmdstream_info *info,
+			     struct cmd_state *st)
+{
+	struct ethosu_device *edev = to_ethosu_device(ddev);
+	u32 ifm_width, ifm_height;
+	u64 len;
+	int ret;
+
+	if (!cmd_state_reg_is_set(st, NPU_SET_KERNEL_WIDTH_M1) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_KERNEL_HEIGHT_M1) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_OFM_BLK_WIDTH_M1) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_OFM_BLK_HEIGHT_M1) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_X_SCALE_N_M1) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_Y_SCALE_N_M1) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_X_OFFSET) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_Y_OFFSET) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_X) ||
+	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_Y))
+		return -EINVAL;
+
+	ret = resize_axis_size(st, 0, st->ofm.width, st->ofm_blk_width,
+			       &ifm_width);
+	if (ret)
+		return ret;
+	ret = resize_axis_size(st, 1, st->ofm.height[2], st->ofm_blk_height,
+			       &ifm_height);
+	if (ret)
+		return ret;
+
+	if (check_add_overflow(ifm_width, (u32)st->ifm.width, &ifm_width) ||
+	    check_add_overflow(ifm_height, (u32)st->ifm.height[2], &ifm_height))
+		return -EINVAL;
+
+	ret = feat_matrix_size(edev, info, st, &st->ifm, FEAT_MATRIX_IFM,
+			       ifm_width, ifm_height, st->ifm.depth, false, &len);
+	dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n", NPU_OP_RESIZE,
+		st->ifm.region, st->ifm.base[0], len);
+	if (ret)
+		return ret;
+
+	ret = feat_matrix_size(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
+			       st->ofm.width, st->ofm.height[2], st->ofm.depth,
+			       true, &len);
+	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n", NPU_OP_RESIZE,
+		st->ofm.region, st->ofm.base[0], len);
+	if (ret)
+		return ret;
+
+	ret = calc_acc_input_size(ddev, info, st);
+	if (ret)
+		return ret;
+
+	if (!feat_matrix_chained(edev, &st->ofm))
+		info->output_region[st->ofm.region] = true;
+
+	return 0;
+}
+
 static int buffer_size(struct ethosu_validated_cmdstream_info *info,
 		       struct cmd_state *st, struct buffer *buf, s8 region,
 		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
@@ -972,7 +1076,12 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_RESIZE: // U85 only
-			return -EINVAL;
+			if (ethosu_is_u65(edev) || param > 2)
+				return -EINVAL;
+			ret = calc_sizes_resize(ddev, info, &st);
+			if (ret)
+				return ret;
+			break;
 		case NPU_SET_KERNEL_WIDTH_M1:
 			st.ifm.width = param;
 			break;
@@ -1069,6 +1178,12 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			}
 			st.ofm.precision = param;
 			break;
+		case NPU_SET_OFM_BLK_WIDTH_M1:
+			st.ofm_blk_width = param & 0x7f;
+			break;
+		case NPU_SET_OFM_BLK_HEIGHT_M1:
+			st.ofm_blk_height = param & 0x7f;
+			break;
 		case NPU_SET_OFM_REGION:
 			st.ofm.region = param & 0x7;
 			break;
@@ -1139,6 +1254,34 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_SET_SCALE_REGION:
 			st.scale[0].region = param & 0x7;
 			break;
+		case NPU_SET_RESIZE_X_SCALE_N_M1:
+			if (ethosu_is_u65(edev))
+				break;
+			if (param & GENMASK(15, 11))
+				return -EINVAL;
+			st.resize[0].scale_n = param + 1;
+			break;
+		case NPU_SET_RESIZE_Y_SCALE_N_M1:
+			if (ethosu_is_u65(edev))
+				break;
+			if (param & GENMASK(15, 11))
+				return -EINVAL;
+			st.resize[1].scale_n = param + 1;
+			break;
+		case NPU_SET_RESIZE_X_OFFSET:
+			if (ethosu_is_u65(edev))
+				break;
+			if (param & GENMASK(15, 12))
+				return -EINVAL;
+			st.resize[0].offset = sign_extend32(param, 11);
+			break;
+		case NPU_SET_RESIZE_Y_OFFSET:
+			if (ethosu_is_u65(edev))
+				break;
+			if (param & GENMASK(15, 12))
+				return -EINVAL;
+			st.resize[1].offset = sign_extend32(param, 11);
+			break;
 		case NPU_SET_WEIGHT_BASE:
 			st.weight[0].base = addr;
 			break;
@@ -1175,6 +1318,22 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_SET_WEIGHT3_LENGTH:
 			st.weight[3].length = cmds[1];
 			break;
+		case NPU_SET_RESIZE_X:
+		case NPU_SET_RESIZE_Y:
+			if (ethosu_is_u65(edev))
+				break;
+			if ((cmds[0] & BIT(31)) ||
+			    (cmds[1] & (GENMASK(31, 27) | GENMASK(15, 11))))
+				return -EINVAL;
+			st.resize[cmd - NPU_SET_RESIZE_X].one_step_int =
+				FIELD_GET(GENMASK(19, 16), cmds[0]);
+			st.resize[cmd - NPU_SET_RESIZE_X].blk_step_int =
+				FIELD_GET(GENMASK(30, 20), cmds[0]);
+			st.resize[cmd - NPU_SET_RESIZE_X].one_step_mod =
+				FIELD_GET(GENMASK(10, 0), cmds[1]);
+			st.resize[cmd - NPU_SET_RESIZE_X].blk_step_mod =
+				FIELD_GET(GENMASK(26, 16), cmds[1]);
+			break;
 
 		case NPU_SET_DMA0_SRC_REGION:
 			if (param & NPU_DMA_REGION_INDEX_MODE)

-- 
2.53.0

