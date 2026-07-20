Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBC8C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FECF10E218;
	Mon, 20 Jul 2026 23:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G2ZM2OgN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C43310E218
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 23:14:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A46360A7A;
 Mon, 20 Jul 2026 23:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACC41F000E9;
 Mon, 20 Jul 2026 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784589293;
 bh=pDaWvvxRuAehB5ZQNrThFSP7mO3JmMq1HLAOrpVqUmY=;
 h=From:To:Cc:Subject:Date;
 b=G2ZM2OgN3VrDA5j5wcCekEGQ3QzPNnwfOCptGlbn/U9tEebE5G/75n25zk/YeMJtb
 aEGVKG3tEtJyvQjKUhYM+3pIxdE5Oxf0WmJl7VA8OdHwDGKCmtvoQ/qKrVPgvDxdqP
 psTd92oCQIZN0KdxhFY0XjT87VIuNR/RalNbPXAysFbUOOpRJP4nq1Ow9fUeu3sp2R
 tkzflkA6fCsz9qbkGqOvy0P4hiq+BrbcU1IZv87Q71HAFus5Xz2ljwpYcQlpFSR44T
 uO7JmO8ZbzOmv5dnhZKCTngdd5lDS+NaXbC6Y8D33HT53lFh19A++9blhfTUGDVfAC
 0kg4s9DDWS4pQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Frank Li <Frank.Li@nxp.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] accel: ethosu: Fix element size accounting for cmd stream
 validation
Date: Mon, 20 Jul 2026 18:14:47 -0500
Message-ID: <20260720231450.485221-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

There are 2 issues with the element size handling in the command stream
validation which result in too small of a size calculated when the
element size is 16/32/64 bits.

For NHWC format, the element size is simply missing from the
calculation.

The bitfield for the element size is different between IFM/IFM2 and
OFM. IFM and IFM2 encode the precision in parameter bits 2:3, while OFM
uses bits 1:2.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_gem.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 3401883e207f..1daff32610c7 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -194,7 +194,7 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 
 static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
 			      struct feat_matrix *fm,
-			      u32 x, u32 y, u32 c)
+			      u32 x, u32 y, u32 c, bool ofm)
 {
 	u32 element_size, storage = fm->precision >> 14;
 	int tile = 0;
@@ -231,10 +231,11 @@ static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
 
 	switch ((fm->precision >> 6) & 0x3) { // format
 	case 0: //nhwc:
-		addr += x * fm->stride_x + c;
+		element_size = BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
+		addr += x * fm->stride_x + c * element_size;
 		break;
 	case 1: //nhcwb16:
-		element_size = BIT((fm->precision >> 1) & 0x3);
+		element_size = BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
 
 		addr += (c / 16) * fm->stride_c + (16 * x + (c & 0xf)) * element_size;
 		break;
@@ -268,7 +269,7 @@ static int calc_sizes(struct drm_device *ddev,
 			return -EINVAL;
 
 		len = feat_matrix_length(info, &st->ifm, ifm_width,
-					 ifm_height, st->ifm.depth);
+					 ifm_height, st->ifm.depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
 		if (len == U64_MAX)
@@ -277,7 +278,7 @@ static int calc_sizes(struct drm_device *ddev,
 
 	if (ifm2) {
 		len = feat_matrix_length(info, &st->ifm2, st->ifm.depth,
-					 0, st->ofm.depth);
+					 0, st->ofm.depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
 		if (len == U64_MAX)
@@ -309,7 +310,7 @@ static int calc_sizes(struct drm_device *ddev,
 	}
 
 	len = feat_matrix_length(info, &st->ofm, st->ofm.width,
-				 st->ofm.height[2], st->ofm.depth);
+				 st->ofm.height[2], st->ofm.depth, true);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
 	if (len == U64_MAX)
@@ -333,7 +334,7 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		depth = st->ifm.broadcast & 0x4 ? 0 : st->ofm.depth;
 
 		len = feat_matrix_length(info, &st->ifm, width,
-					 height, depth);
+					 height, depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
 		if (len == U64_MAX)
@@ -346,7 +347,7 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		depth = st->ifm2.broadcast & 0x4 ? 0 : st->ofm.depth;
 
 		len = feat_matrix_length(info, &st->ifm2, width,
-					 height, depth);
+					 height, depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
 		if (len == U64_MAX)
@@ -354,7 +355,7 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 	}
 
 	len = feat_matrix_length(info, &st->ofm, st->ofm.width,
-				 st->ofm.height[2], st->ofm.depth);
+				 st->ofm.height[2], st->ofm.depth, true);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
 	if (len == U64_MAX)
-- 
2.53.0

