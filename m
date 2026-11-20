Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CF606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvJYUSyn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8E1112B6D;
	Fri, 20 Nov 2026 14:59:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3B7112B5C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A90014692E;
 Fri, 20 Nov 2026 14:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD041F00A36;
 Fri, 20 Nov 2026 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186706;
 bh=HnnxhzyMXZMilpbzp72La6orrAlXi+darEn01RzXf5s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BvJYUSyneEWTU7TcFeqJk1PWWMSZtbBW16E+u02Stf/ifgcHQDhzGDjZEIK/Gfu9h
 SWjB99Af+q0omuZDsYUzWObRSRA1VraXJwlKsKKrdJnqOB4lUDr1R/FqKCh614LqsM
 5wevDkymCxLpTRBcl7XzNW0F+5ILNUCjb+v6WLKkJJnkT8uGcLHHcs/pZzICggopSh
 nYBMK4PfXK7IRepJIiMLg+2wXjpbG+1AAg0At6HS0SOCEkNz80TLt0zgooLWXhO0oW
 CJCtRmiO7Do5bDar+AbEbsXb5ATZQktAKAyFWBaje3HBPwEILt1OO5wXxkpBVsmaHp
 D258+lUfdtMWw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:37 -0600
Subject: [PATCH v5 13/19] accel: ethosu: Split U65 and U85 DMA length
 validation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-13-52d459acdb84@kernel.org>
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

Ethos-U65 and Ethos-U85 have slightly different DMA programming models.
The U65 has skip values added on to the size whereas U85 has signed
stride values. The U65 shares the skip values for source and destination
whereas the U85 has independent settings for source and destination.

The current validation only correctly handles U65 constraints and only
for source 2D/3D mode. Split the shared DMA length calculation into U65
and U85 specific versions adding U65 destination 2D/3D mode and U85
constraints.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - Handle U85 shared stride mode
 - Fix U65 case with mixed contiguous buffer and strided buffer

v4:
 - Only account for a skip/stride between transfers and not at the end of
   last transfer

v3:
 - Fix U65 destination stride/skip handling

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 131 +++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 24 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 1d2bc5d4a37a..0ab73b99c458 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -212,12 +212,18 @@ static bool dma_use_src_stride(struct ethosu_device *edev,
 	return ethosu_is_u65(edev) || dma == &dma_st->src;
 }
 
+static s8 dma_mode(struct ethosu_device *edev,
+		   const struct dma_state *dma_st, const struct dma *dma)
+{
+	return ethosu_is_u65(edev) ? dma->mode : dma_st->src.mode;
+}
+
 static bool dma_params_valid(struct ethosu_device *edev, struct cmd_state *st,
 			     const struct dma_state *dma_st,
 			     const struct dma *dma,
 			     u16 region_cmd, u16 addr_cmd)
 {
-	s8 mode = dma->mode;
+	s8 mode = dma_mode(edev, dma_st, dma);
 
 	if (!cmd_state_reg_is_set(st, region_cmd) ||
 	    !cmd_state_reg_is_set(st, addr_cmd) ||
@@ -245,40 +251,101 @@ static bool dma_params_valid(struct ethosu_device *edev, struct cmd_state *st,
 	return true;
 }
 
-static u64 dma_length(struct ethosu_device *edev,
-		      struct ethosu_validated_cmdstream_info *info,
-		      struct cmd_state *st, struct dma_state *dma_st,
-		      struct dma *dma, u16 region_cmd, u16 addr_cmd)
+static u64 dma_length_finish(struct ethosu_validated_cmdstream_info *info,
+			     const struct dma *dma, u64 len)
 {
-	s8 mode = dma->mode;
-	u64 len = dma->len;
+	if (dma->region >= 0) {
+		u64 end;
 
-	if (!dma_params_valid(edev, st, dma_st, dma, region_cmd, addr_cmd))
-		return U64_MAX;
+		if (check_add_overflow(len, dma->offset, &end))
+			return U64_MAX;
+		info->region_size[dma->region] =
+			max(info->region_size[dma->region], end);
+	}
+
+	return len;
+}
+
+static u64 dma_length_u65(struct ethosu_validated_cmdstream_info *info,
+			  struct dma_state *dma_st,
+			  struct dma *dma)
+{
+	s8 mode = max(dma_st->src.mode, dma_st->dst.mode);
+	u64 len = dma->len;
+	u64 stride;
 
 	if (mode >= 1) {
-		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
-			return U64_MAX;
-		len += dma->stride[0];
 		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
 			return U64_MAX;
+		if (dma->mode >= 1 &&
+		    (check_mul_overflow((u64)dma->stride[0],
+				       (u64)dma_st->size0 - 1, &stride) ||
+		     check_add_overflow(len, stride, &len)))
+			return U64_MAX;
 	}
 	if (mode == 2) {
-		if (dma->stride[1] < 0 && (u64)(-dma->stride[1]) > len)
-			return U64_MAX;
-		len += dma->stride[1];
 		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
 			return U64_MAX;
+		if (dma->mode == 2 &&
+		    (check_mul_overflow((u64)dma->stride[1],
+				       (u64)dma_st->size1 - 1, &stride) ||
+		     check_add_overflow(len, stride, &len)))
+			return U64_MAX;
 	}
-	if (dma->region >= 0) {
-		u64 end;
 
-		if (check_add_overflow(len, dma->offset, &end))
+	return dma_length_finish(info, dma, len);
+}
+
+static u64 dma_length_u85(struct ethosu_validated_cmdstream_info *info,
+			  struct dma_state *dma_st,
+			  struct dma *dma)
+{
+	s8 mode = dma_st->src.mode;
+	s64 min = 0;
+	u64 max = dma->len;
+	s64 stride;
+
+	if (mode >= 1) {
+		if (check_mul_overflow(dma->stride[0],
+				       (s64)dma_st->size0 - 1, &stride))
+			return U64_MAX;
+		if (stride < 0) {
+			if (check_add_overflow(min, stride, &min))
+				return U64_MAX;
+		} else if (check_add_overflow(max, (u64)stride, &max)) {
 			return U64_MAX;
-		info->region_size[dma->region] = max(info->region_size[dma->region], end);
+		}
+	}
+	if (mode == 2) {
+		if (check_mul_overflow(dma->stride[1],
+				       (s64)dma_st->size1 - 1, &stride))
+			return U64_MAX;
+		if (stride < 0) {
+			if (check_add_overflow(min, stride, &min))
+				return U64_MAX;
+		} else if (check_add_overflow(max, (u64)stride, &max)) {
+			return U64_MAX;
+		}
 	}
 
-	return len;
+	if (min < 0 && -(u64)min > dma->offset)
+		return U64_MAX;
+
+	return dma_length_finish(info, dma, max);
+}
+
+static u64 dma_length(struct ethosu_device *edev,
+		      struct ethosu_validated_cmdstream_info *info,
+		      struct cmd_state *st, struct dma_state *dma_st,
+		      struct dma *dma, u16 region_cmd, u16 addr_cmd)
+{
+	if (!dma_params_valid(edev, st, dma_st, dma, region_cmd, addr_cmd))
+		return U64_MAX;
+
+	if (ethosu_is_u65(edev))
+		return dma_length_u65(info, dma_st, dma);
+
+	return dma_length_u85(info, dma_st, dma);
 }
 
 static bool feat_matrix_chained(struct ethosu_device *edev, struct feat_matrix *fm)
@@ -1102,16 +1169,32 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.dma.size1 = param;
 			break;
 		case NPU_SET_DMA0_SRC_STRIDE0:
-			st.dma.src.stride[0] = ((s64)addr << 24) >> 24;
+			if (ethosu_is_u65(edev)) {
+				st.dma.src.stride[0] = addr;
+				st.dma.dst.stride[0] = addr;
+			} else {
+				st.dma.src.stride[0] = sign_extend64(addr, 39);
+			}
 			break;
 		case NPU_SET_DMA0_SRC_STRIDE1:
-			st.dma.src.stride[1] = ((s64)addr << 24) >> 24;
+			if (ethosu_is_u65(edev)) {
+				st.dma.src.stride[1] = addr;
+				st.dma.dst.stride[1] = addr;
+			} else {
+				st.dma.src.stride[1] = sign_extend64(addr, 39);
+			}
 			break;
 		case NPU_SET_DMA0_DST_STRIDE0:
-			st.dma.dst.stride[0] = ((s64)addr << 24) >> 24;
+			if (!ethosu_is_u65(edev))
+				st.dma.dst.stride[0] = sign_extend64(addr, 39);
+			else
+				return -EINVAL;
 			break;
 		case NPU_SET_DMA0_DST_STRIDE1:
-			st.dma.dst.stride[1] = ((s64)addr << 24) >> 24;
+			if (!ethosu_is_u65(edev))
+				st.dma.dst.stride[1] = sign_extend64(addr, 39);
+			else
+				return -EINVAL;
 			break;
 		case NPU_SET_DMA0_SRC:
 			st.dma.src.offset = addr;

-- 
2.53.0

