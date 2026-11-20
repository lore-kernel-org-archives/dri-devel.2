Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605560A2619
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDLROQVs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264C2112B6F;
	Fri, 20 Nov 2026 14:58:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC80B112B66
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6B2B41B05;
 Fri, 20 Nov 2026 14:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E21F000C6;
 Fri, 20 Nov 2026 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186715;
 bh=rCN0jgUEMa9AdeZMqtrg4yHBJ6LWJjidugOmWuQI37I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZDLROQVsOzM3wA+4VAGUylO2UQZLRim1RblFmArusWdu3FnwFjcwm8PmVjeWFFJJ6
 RQKSrcsk/XXm3EYQD6P6IyC+R+q//zdZAD2JEZirzeCJexJt/14bRLKoheokEM9lbt
 TrJZjyBmv/hS+kS7+totQzgXmAro+nbopHYX91OuW0/UzcIHMNsFTvPbeh2iehALj7
 OHL4Eu4JnbUoIs9YbPR6M/qVK0MuDDp+7kEmsPl4gc3vFzTiF4+gB/ESSwVnrdJ7Jh
 F+4wmyB7xsjZ/HonGCT8UBi0y1n3hUkd1W9v5dN91BP+wWYJcxc9hAqQYlHf8KLCGm
 aDTXJhRuzLXug==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:39 -0600
Subject: [PATCH v5 15/19] accel: ethosu: Validate resize operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-15-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
In-Reply-To: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resize input coordinates are controlled by the scale, offset, and step
registers. Require those values to be explicitly programmed and validate
their scale and step relationships before calculating feature-map bounds.

KERNEL_WIDTH_M1 and KERNEL_HEIGHT_M1 specify the input dimensions for
resize, not a convolution footprint to add to each sampling coordinate.
Compute the final sampling position using the signed resize offset,
check it against the input dimensions, and include the upper sample
only for interpolation modes that use it.

Pass zero-based maximum coordinates to feature-map validation, as for
other operations. Keep the block-step relationship based on the stored
M1 block dimensions, as required by the hardware.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - Use signed resize offsets and the programmed input dimensions.
 - Account for interpolation mode when including an upper sample.
 - Avoid adding input dimensions to the sampling footprint or converting
   the maximum coordinate to an element count.
 - Do not validate an accumulator input for resize as the accumulator is
   never used for resize.

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
index 368daac25acc..6aa7f035f32c 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -117,6 +117,8 @@ enum ethosu_cmds {
 	NPU_SET_OFM_HEIGHT_M1 = 0x112,
 	NPU_SET_OFM_DEPTH_M1 = 0x113,
 	NPU_SET_OFM_PRECISION = 0x114,
+	NPU_SET_OFM_BLK_WIDTH_M1 = 0x115,
+	NPU_SET_OFM_BLK_HEIGHT_M1 = 0x116,
 	NPU_SET_OFM_WIDTH0_M1 = 0x11a,
 	NPU_SET_OFM_HEIGHT0_M1 = 0x11b,
 	NPU_SET_OFM_HEIGHT1_M1 = 0x11c,
@@ -127,6 +129,10 @@ enum ethosu_cmds {
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
@@ -177,6 +183,8 @@ enum ethosu_cmds {
 	NPU_SET_WEIGHT2_LENGTH = 0x4093,
 	NPU_SET_WEIGHT3_BASE = 0x4094,
 	NPU_SET_WEIGHT3_LENGTH = 0x4095,
+	NPU_SET_RESIZE_X = 0x4096,
+	NPU_SET_RESIZE_Y = 0x4097,
 };
 
 #define NPU_ACC_FORMAT_INPUT_MASK	GENMASK(5, 4)
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index b8f840ab1cee..ff89cfdb4772 100644
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
@@ -681,6 +693,98 @@ calc_acc_input_size(struct drm_device *ddev,
 	return ret;
 }
 
+static int resize_axis_size(struct cmd_state *st, int axis, u16 ofm_size,
+			    u16 ofm_blk_size, u16 ifm_size, u16 mode, u32 *size)
+{
+	struct resize_axis *resize = &st->resize[axis];
+	u64 one_step, blk_step, coord;
+	s64 position;
+	u32 remainder;
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
+	if (check_mul_overflow((s64)ofm_size, (s64)one_step, &position) ||
+	    check_add_overflow(position, (s64)resize->offset, &position))
+		return -EINVAL;
+
+	/* Sampling positions are clamped to the programmed IFM dimensions. */
+	coord = div_u64_rem(max_t(s64, position, 0), resize->scale_n,
+			    &remainder);
+	if (coord > ifm_size)
+		return -EINVAL;
+
+	if ((mode == 0 && position >= 0) ||
+	    (mode == 2 && 2 * remainder >= resize->scale_n))
+		coord = min_t(u64, coord + 1, ifm_size);
+
+	*size = coord;
+	return 0;
+}
+
+
+static int calc_sizes_resize(struct drm_device *ddev,
+			     struct ethosu_validated_cmdstream_info *info,
+			     struct cmd_state *st, u16 mode)
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
+			       st->ifm.width, mode, &ifm_width);
+	if (ret)
+		return ret;
+	ret = resize_axis_size(st, 1, st->ofm.height[2], st->ofm_blk_height,
+			       st->ifm.height[2], mode, &ifm_height);
+	if (ret)
+		return ret;
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
+	if (!feat_matrix_chained(edev, &st->ofm))
+		info->output_region[st->ofm.region] = true;
+
+	return 0;
+}
+
 static int buffer_size(struct ethosu_validated_cmdstream_info *info,
 		       struct cmd_state *st, struct buffer *buf, s8 region,
 		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
@@ -999,7 +1103,12 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_RESIZE: // U85 only
-			return -EINVAL;
+			if (ethosu_is_u65(edev) || param > 2)
+				return -EINVAL;
+			ret = calc_sizes_resize(ddev, info, &st, param);
+			if (ret)
+				return ret;
+			break;
 		case NPU_SET_KERNEL_WIDTH_M1:
 			st.ifm.width = param;
 			break;
@@ -1098,6 +1207,12 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
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
@@ -1168,6 +1283,34 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
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
@@ -1204,6 +1347,22 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
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

