Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69292C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F21C10EDBE;
	Tue,  8 Sep 2026 22:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGb2tNyz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4E110EDB7
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:05:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02EDD447C2;
 Tue,  8 Sep 2026 22:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A467B1F00A3F;
 Tue,  8 Sep 2026 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905108;
 bh=wQ38CeQVxfxCLL11wS5WjaU8X5ollLIrbqI1T/Ql4J0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mGb2tNyzS1M+C2XxcIPZivNu8WtLXWOaN1QOG6/nWedtoocl/gV1PVAZZG7IxZM92
 j84G4P3gtRPG5hulnW7pMZFQQHWhP8h7wRYKKfk6jupaYhWV6JCqjWWiI3mblJJ7Zj
 scYj73vO2o9VV7YKGizqSu2G+d0RUfc9I+uS8PtQzpNgb2yqkZuD4ppPRcEuSkSdmH
 dnljEyPZRRLAQrl5PA4hWyZm2dcP0fbCeZvit6AlYA0kFC2XH6UzP1/I5AZkXv5KmM
 zk9hZsxEsYiwDAgRYe9gZV6K+D6n5uwGSumGZvI31MMzPPAbNWdajuBfZuCWIulYJa
 mzqwPYoo63KMw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:50 -0500
Subject: [PATCH v3 13/22] accel: ethosu: Validate all feature map tiles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-13-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

The command-stream validator checked only the final feature-map
coordinate. For tiled tensors, this can leave an earlier tile base
address unchecked even though the operation accesses it.

Check the final coordinate of every tile touched by an operation. Also
treat U65 feature maps as 2x2 tiled: its precision rounding bits are not
the U85 storage encoding.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Fix for storage mode 0 intermediate tile calculations

v2:
 - no changes
---
 drivers/accel/ethosu/ethosu_gem.c | 145 ++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 28 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5d4e89783139..11aa3f4dd0e7 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -434,6 +434,94 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 	return addr;
 }
 
+static int feat_matrix_check_location(struct ethosu_device *edev,
+				      struct ethosu_validated_cmdstream_info *info,
+				      struct cmd_state *st, struct feat_matrix *fm,
+				      enum feat_matrix_type type, u32 x, u32 y,
+				      u32 c, bool ofm, u64 *max_len)
+{
+	u64 len;
+
+	len = feat_matrix_length(edev, info, st, fm, type, x, y, c, ofm);
+	if (len == U64_MAX)
+		return -EINVAL;
+
+	*max_len = max(*max_len, len);
+	return 0;
+}
+
+static int feat_matrix_size(struct ethosu_device *edev,
+			    struct ethosu_validated_cmdstream_info *info,
+			    struct cmd_state *st, struct feat_matrix *fm,
+			    enum feat_matrix_type type,
+			    u32 x, u32 y, u32 c, bool ofm, u64 *max_len)
+{
+	u32 storage = ethosu_is_u65(edev) ? 0 : fm->precision >> 14;
+	int ret;
+
+	*max_len = 0;
+
+	if (storage == 0) {
+		ret = feat_matrix_check_location(edev, info, st, fm, type, 0, 0,
+						 c, ofm, max_len);
+		if (ret)
+			return ret;
+
+		ret = feat_matrix_check_location(edev, info, st, fm, type,
+						 min(x, (u32)fm->width0),
+						 min(y, (u32)fm->height[0]), c, ofm,
+						 max_len);
+		if (ret)
+			return ret;
+
+		if (fm->width0 < x) {
+			ret = feat_matrix_check_location(edev, info, st, fm, type, x,
+							 min(y, (u32)fm->height[1]), c,
+							 ofm, max_len);
+			if (ret)
+				return ret;
+		}
+
+		if (fm->height[0] < y) {
+			ret = feat_matrix_check_location(edev, info, st, fm, type,
+							 min(x, (u32)fm->width0), y, c,
+							 ofm, max_len);
+			if (ret)
+				return ret;
+		}
+
+		if (fm->width0 < x && fm->height[1] < y)
+			return feat_matrix_check_location(edev, info, st, fm, type,
+							  x, y, c, ofm, max_len);
+
+		return 0;
+	}
+
+	if (storage == 1) {
+		ret = feat_matrix_check_location(edev, info, st, fm, type, x, 0, c,
+						 ofm, max_len);
+		if (ret)
+			return ret;
+		if (fm->height[0] < fm->height[1] && fm->height[1] <= y) {
+			ret = feat_matrix_check_location(edev, info, st, fm, type, x,
+							 fm->height[1], c, ofm,
+							 max_len);
+			if (ret)
+				return ret;
+		}
+		if (fm->height[1] < y) {
+			ret = feat_matrix_check_location(edev, info, st, fm, type, x,
+							 fm->height[1] + 1, c, ofm,
+							 max_len);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return feat_matrix_check_location(edev, info, st, fm, type, x, y, c, ofm,
+					  max_len);
+}
+
 static int buffer_size(struct ethosu_validated_cmdstream_info *info,
 		       struct cmd_state *st, struct buffer *buf, s8 region,
 		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
@@ -464,6 +552,7 @@ static int calc_sizes(struct drm_device *ddev,
 {
 	struct ethosu_device *edev = to_ethosu_device(ddev);
 	u64 len;
+	int ret;
 
 	if (ifm) {
 		if (!cmd_state_reg_is_set(st, NPU_SET_KERNEL_WIDTH_M1) ||
@@ -486,23 +575,22 @@ static int calc_sizes(struct drm_device *ddev,
 		if (ifm_height < 0 || ifm_width < 0)
 			return -EINVAL;
 
-		len = feat_matrix_length(edev, info, st, &st->ifm,
-					 FEAT_MATRIX_IFM, ifm_width, ifm_height,
-					 st->ifm.depth, false);
+		ret = feat_matrix_size(edev, info, st, &st->ifm, FEAT_MATRIX_IFM,
+				       ifm_width, ifm_height, st->ifm.depth, false,
+				       &len);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
-		if (len == U64_MAX)
-			return -EINVAL;
+		if (ret)
+			return ret;
 	}
 
 	if (ifm2) {
-		len = feat_matrix_length(edev, info, st, &st->ifm2,
-					 FEAT_MATRIX_IFM2, st->ifm.depth, 0,
-					 st->ofm.depth, false);
+		ret = feat_matrix_size(edev, info, st, &st->ifm2, FEAT_MATRIX_IFM2,
+				       st->ifm.depth, 0, st->ofm.depth, false, &len);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
-		if (len == U64_MAX)
-			return -EINVAL;
+		if (ret)
+			return ret;
 	}
 
 	if (weight) {
@@ -544,13 +632,13 @@ static int calc_sizes(struct drm_device *ddev,
 			return -EINVAL;
 	}
 
-	len = feat_matrix_length(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
-				 st->ofm.width, st->ofm.height[2], st->ofm.depth,
-				 true);
+	ret = feat_matrix_size(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
+			       st->ofm.width, st->ofm.height[2], st->ofm.depth,
+			       true, &len);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
-	if (len == U64_MAX)
-		return -EINVAL;
+	if (ret)
+		return ret;
 	if (!feat_matrix_chained(edev, &st->ofm))
 		info->output_region[st->ofm.region] = true;
 
@@ -565,18 +653,19 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 	struct ethosu_device *edev = to_ethosu_device(ddev);
 	u32 height, width, depth;
 	u64 len;
+	int ret;
 
 	if (ifm) {
 		height = st->ifm.broadcast & 0x1 ? 0 : st->ofm.height[2];
 		width = st->ifm.broadcast & 0x2 ? 0 : st->ofm.width;
 		depth = st->ifm.broadcast & 0x4 ? 0 : st->ofm.depth;
 
-		len = feat_matrix_length(edev, info, st, &st->ifm,
-					 FEAT_MATRIX_IFM, width, height, depth, false);
+		ret = feat_matrix_size(edev, info, st, &st->ifm, FEAT_MATRIX_IFM,
+				       width, height, depth, false, &len);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
-		if (len == U64_MAX)
-			return -EINVAL;
+		if (ret)
+			return ret;
 	}
 
 	if (ifm2) {
@@ -584,21 +673,21 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		width = st->ifm2.broadcast & 0x2 ? 0 : st->ofm.width;
 		depth = st->ifm2.broadcast & 0x4 ? 0 : st->ofm.depth;
 
-		len = feat_matrix_length(edev, info, st, &st->ifm2,
-					 FEAT_MATRIX_IFM2, width, height, depth, false);
+		ret = feat_matrix_size(edev, info, st, &st->ifm2, FEAT_MATRIX_IFM2,
+				       width, height, depth, false, &len);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
-		if (len == U64_MAX)
-			return -EINVAL;
+		if (ret)
+			return ret;
 	}
 
-	len = feat_matrix_length(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
-				 st->ofm.width, st->ofm.height[2], st->ofm.depth,
-				 true);
+	ret = feat_matrix_size(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,
+			       st->ofm.width, st->ofm.height[2], st->ofm.depth,
+			       true, &len);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
-	if (len == U64_MAX)
-		return -EINVAL;
+	if (ret)
+		return ret;
 	if (!feat_matrix_chained(edev, &st->ofm))
 		info->output_region[st->ofm.region] = true;
 

-- 
2.53.0

