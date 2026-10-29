Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA272606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qtq8rQJx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DC71122F0;
	Thu, 29 Oct 2026 13:37:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0245A10E7FC
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF82342AF1;
 Thu, 29 Oct 2026 13:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7EC1F01825;
 Thu, 29 Oct 2026 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281016;
 bh=cDQAl2kMTSRMOjLE3vtGkZN+Rhn2ibmxtT8V0e0lcOk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qtq8rQJxjTTbbxBhveFH/TUUesCAvF2JBgzho0xDiVHYoxMahVkNtM4bvyWG4riPh
 fAuUDE/gvFdlYyMOUi5ki5+6XRKUFGameiKLLfMmckuoa68CI+t+YQMEsTpMGMMjo7
 gRkB8ehwaNzC4EN/4lApllXy+Jk2w+5qWS7qIKcWSVdID9Bs6f1LmDRBiydYdhXuph
 lHpVNttfapsvB4aYxc6wxGEvy1SY135dEoZ4QYNGygpL1D8AOp1vcZWqD4yz6kDQ6I
 4QgBmBcpLpB9OAUDvlNGdLKKuzcDxrbhdY8kEMI/eCJhqgsCgQgv/2Esr+3YbNnMTF
 1AXj4jW5D+IpQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:13 -0500
Subject: [PATCH v4 26/31] accel: ethosu: Split U65 and U85 DMA length
 validation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-26-4aa25e22578e@kernel.org>
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
v4:
 - Only account for a skip/stride between transfers and not at the end of
   last transfer

v3:
 - Fix U65 destination stride/skip handling

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 119 ++++++++++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 23 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 117046e5a61f..04c0de8336cd 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -245,40 +245,97 @@ static bool dma_params_valid(struct ethosu_device *edev, struct cmd_state *st,
 	return true;
 }
 
-static u64 dma_length(struct ethosu_device *edev,
-		      struct ethosu_validated_cmdstream_info *info,
-		      struct cmd_state *st, struct dma_state *dma_st,
-		      struct dma *dma, u16 region_cmd, u16 addr_cmd)
+static u64 dma_length_finish(struct ethosu_validated_cmdstream_info *info,
+			     const struct dma *dma, u64 len)
+{
+	if (dma->region >= 0) {
+		u64 end;
+
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
 {
 	s8 mode = dma->mode;
 	u64 len = dma->len;
+	u64 stride;
 
-	if (!dma_params_valid(edev, st, dma_st, dma, region_cmd, addr_cmd))
-		return U64_MAX;
+	if (mode >= 1) {
+		if (check_mul_overflow(len, (u64)dma_st->size0, &len) ||
+		    check_mul_overflow((u64)dma->stride[0],
+				       (u64)dma_st->size0 - 1, &stride) ||
+		    check_add_overflow(len, stride, &len))
+			return U64_MAX;
+	}
+	if (mode == 2) {
+		if (check_mul_overflow(len, (u64)dma_st->size1, &len) ||
+		    check_mul_overflow((u64)dma->stride[1],
+				       (u64)dma_st->size1 - 1, &stride) ||
+		    check_add_overflow(len, stride, &len))
+			return U64_MAX;
+	}
+
+	return dma_length_finish(info, dma, len);
+}
+
+static u64 dma_length_u85(struct ethosu_validated_cmdstream_info *info,
+			  struct dma_state *dma_st,
+			  struct dma *dma)
+{
+	s8 mode = dma->mode;
+	s64 min = 0;
+	u64 max = dma->len;
+	s64 stride;
 
 	if (mode >= 1) {
-		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
+		if (check_mul_overflow(dma->stride[0],
+				       (s64)dma_st->size0 - 1, &stride))
 			return U64_MAX;
-		len += dma->stride[0];
-		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
+		if (stride < 0) {
+			if (check_add_overflow(min, stride, &min))
+				return U64_MAX;
+		} else if (check_add_overflow(max, (u64)stride, &max)) {
 			return U64_MAX;
+		}
 	}
 	if (mode == 2) {
-		if (dma->stride[1] < 0 && (u64)(-dma->stride[1]) > len)
+		if (check_mul_overflow(dma->stride[1],
+				       (s64)dma_st->size1 - 1, &stride))
 			return U64_MAX;
-		len += dma->stride[1];
-		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
+		if (stride < 0) {
+			if (check_add_overflow(min, stride, &min))
+				return U64_MAX;
+		} else if (check_add_overflow(max, (u64)stride, &max)) {
 			return U64_MAX;
+		}
 	}
-	if (dma->region >= 0) {
-		u64 end;
 
-		if (check_add_overflow(len, dma->offset, &end))
-			return U64_MAX;
-		info->region_size[dma->region] = max(info->region_size[dma->region], end);
-	}
+	if (min < 0 && -(u64)min > dma->offset)
+		return U64_MAX;
 
-	return len;
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
@@ -1083,16 +1140,32 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
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

