Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1961C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5599210E21A;
	Mon, 20 Jul 2026 23:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ld0YPPan";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B24110E21A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 23:14:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEF36439D2;
 Mon, 20 Jul 2026 23:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD88A1F000E9;
 Mon, 20 Jul 2026 23:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784589294;
 bh=67Rvgs0fzhxtM+EDpuX1yu3hOZEARMtFzsPXsG8VE/g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ld0YPPan8d9ur/MeZ99oTvf0hWPI+KaQ5SlU1dhFOP8Mk1dpCNApFFHwXu4o3HPYh
 CN8VznVbsvP/qP+48GqxGcEKgA48XM6pZRX8wWIOAVlo9etn1abejxMuknGrV0JhTz
 +2VBqRE8SzguV3/xOfTPv6ApkZmtaZcHE7QmeW9+vFdqCB/polSWT3WfFcTCAJHKE2
 dbz7EwQpJApY/0pq9lyidJ1hzmdbaMah2DrTXqvcnW59ri/ztUhJHzo6Dbc+zFffoP
 +ErbSbpeOz7FfIpu4kobyPZ8NvD51Q3MWXwk8jZXEH97REnuwRmeiFGE+dHU3zuR/r
 xV2VjwdMIha2Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Frank Li <Frank.Li@nxp.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] accel: ethosu: Handle U85 internal chaining buffer
Date: Mon, 20 Jul 2026 18:14:48 -0500
Message-ID: <20260720231450.485221-2-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720231450.485221-1-robh@kernel.org>
References: <20260720231450.485221-1-robh@kernel.org>
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

The Ethos-U85 supports an internal chaining buffer as temporary storage
between some operations. When chaining is activated, the IFM/OFM region
setting selects a chaining buffer rather than a region, and the IFM/OFM
base addresses don't matter. In this case, the feature matrix size
calculations should be skipped. Otherwise, the command stream will be
intermittently rejected depending on prior feature matrix base
addresses.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_gem.c | 35 +++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 1daff32610c7..d50fed64d4d9 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -192,7 +192,15 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	return len;
 }
 
-static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
+static bool feat_matrix_chained(struct ethosu_device *edev, struct feat_matrix *fm)
+{
+	u32 storage = fm->precision >> 14;
+
+	return !ethosu_is_u65(edev) && storage == 2;
+}
+
+static u64 feat_matrix_length(struct ethosu_device *edev,
+			      struct ethosu_validated_cmdstream_info *info,
 			      struct feat_matrix *fm,
 			      u32 x, u32 y, u32 c, bool ofm)
 {
@@ -203,6 +211,9 @@ static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
 	if (fm->region < 0)
 		return U64_MAX;
 
+	if (feat_matrix_chained(edev, fm))
+		return 0;
+
 	switch (storage) {
 	case 0:
 		if (x >= fm->width0 + 1) {
@@ -223,6 +234,8 @@ static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *info,
 			tile = 1;
 		}
 		break;
+	default:
+		return U64_MAX;
 	}
 	if (fm->base[tile] == U64_MAX)
 		return U64_MAX;
@@ -251,6 +264,7 @@ static int calc_sizes(struct drm_device *ddev,
 		      u16 op, struct cmd_state *st,
 		      bool ifm, bool ifm2, bool weight, bool scale)
 {
+	struct ethosu_device *edev = to_ethosu_device(ddev);
 	u64 len;
 
 	if (ifm) {
@@ -268,7 +282,7 @@ static int calc_sizes(struct drm_device *ddev,
 		if (ifm_height < 0 || ifm_width < 0)
 			return -EINVAL;
 
-		len = feat_matrix_length(info, &st->ifm, ifm_width,
+		len = feat_matrix_length(edev, info, &st->ifm, ifm_width,
 					 ifm_height, st->ifm.depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
@@ -277,7 +291,7 @@ static int calc_sizes(struct drm_device *ddev,
 	}
 
 	if (ifm2) {
-		len = feat_matrix_length(info, &st->ifm2, st->ifm.depth,
+		len = feat_matrix_length(edev, info, &st->ifm2, st->ifm.depth,
 					 0, st->ofm.depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
@@ -309,13 +323,14 @@ static int calc_sizes(struct drm_device *ddev,
 			    st->scale[0].base + st->scale[0].length);
 	}
 
-	len = feat_matrix_length(info, &st->ofm, st->ofm.width,
+	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
 				 st->ofm.height[2], st->ofm.depth, true);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
 	if (len == U64_MAX)
 		return -EINVAL;
-	info->output_region[st->ofm.region] = true;
+	if (!feat_matrix_chained(edev, &st->ofm))
+		info->output_region[st->ofm.region] = true;
 
 	return 0;
 }
@@ -325,6 +340,7 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 			       u16 op, struct cmd_state *st,
 			       bool ifm, bool ifm2)
 {
+	struct ethosu_device *edev = to_ethosu_device(ddev);
 	u32 height, width, depth;
 	u64 len;
 
@@ -333,7 +349,7 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		width = st->ifm.broadcast & 0x2 ? 0 : st->ofm.width;
 		depth = st->ifm.broadcast & 0x4 ? 0 : st->ofm.depth;
 
-		len = feat_matrix_length(info, &st->ifm, width,
+		len = feat_matrix_length(edev, info, &st->ifm, width,
 					 height, depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
 			op, st->ifm.region, st->ifm.base[0], len);
@@ -346,7 +362,7 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 		width = st->ifm2.broadcast & 0x2 ? 0 : st->ofm.width;
 		depth = st->ifm2.broadcast & 0x4 ? 0 : st->ofm.depth;
 
-		len = feat_matrix_length(info, &st->ifm2, width,
+		len = feat_matrix_length(edev, info, &st->ifm2, width,
 					 height, depth, false);
 		dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
 			op, st->ifm2.region, st->ifm2.base[0], len);
@@ -354,13 +370,14 @@ static int calc_sizes_elemwise(struct drm_device *ddev,
 			return -EINVAL;
 	}
 
-	len = feat_matrix_length(info, &st->ofm, st->ofm.width,
+	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
 				 st->ofm.height[2], st->ofm.depth, true);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
 	if (len == U64_MAX)
 		return -EINVAL;
-	info->output_region[st->ofm.region] = true;
+	if (!feat_matrix_chained(edev, &st->ofm))
+		info->output_region[st->ofm.region] = true;
 
 	return 0;
 }
-- 
2.53.0

