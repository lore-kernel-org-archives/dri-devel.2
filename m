Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98C6C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD9D10EDB6;
	Tue,  8 Sep 2026 22:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WRr1FRpi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6385F10EDB0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:05:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCD5660231;
 Tue,  8 Sep 2026 22:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701401F00A3E;
 Tue,  8 Sep 2026 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905100;
 bh=sRBKq+2Umg2Iw+/V4MgGP4abKYY9eE606qemJj7IMBo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WRr1FRpinzIqkYXgjH92g2dXPRSg0QMLL4zSozziJRNd5xp7aOA+ii7e5aIrAKoc5
 /dqzaZ17cV2DTquPLFFkkrtHvzHFg4/GID1/jsGTuqqXh7vbmGoP4PUp7JHAmtH5L4
 X6PjVFXutNfTqC/VMiL5U/IGhrLHXGbENl1ZBrMZWwq0MY2Xbn7jADwGXnt/qecbOU
 zsTYjgWqFDNxYcwGQ6OGumBnrO09OOSxM+hpTCp30ro6i5E8zGUzI9Z9/vV3TegXKn
 gASK2w71thUVE5yd1xacivMWWMICQtmg2CW49uyBCYAp4WQlqqGxAfei62fYZdDDOP
 PpVQcwwoiEQbA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:44 -0500
Subject: [PATCH v3 07/22] accel: ethosu: Move DMA mode to src/dst struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-7-490fe215286f@kernel.org>
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

The DMA mode setting is independent for source and destination, so it
should be part of the src/dst struct dma rather than the global DMA
state.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index c046aee42687..2b9c98251c94 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -110,6 +110,7 @@ int ethosu_gem_create_with_handle(struct drm_file *file,
 
 struct dma {
 	s8 region;
+	s8 mode;
 	u64 len;
 	u64 offset;
 	s64 stride[2];
@@ -118,7 +119,6 @@ struct dma {
 struct dma_state {
 	u16 size0;
 	u16 size1;
-	s8 mode;
 	struct dma src;
 	struct dma dst;
 };
@@ -171,7 +171,7 @@ static u64 cmd_to_addr(u32 *cmd)
 static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 		      struct dma_state *dma_st, struct dma *dma)
 {
-	s8 mode = dma_st->mode;
+	s8 mode = dma->mode;
 	u64 len = dma->len;
 
 	if (len == U64_MAX)
@@ -664,13 +664,14 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				st.dma.src.region = -1;
 			else
 				st.dma.src.region = param & 0x7;
-			st.dma.mode = (param >> 9) & 0x3;
+			st.dma.src.mode = (param >> 9) & 0x3;
 			break;
 		case NPU_SET_DMA0_DST_REGION:
 			if (param & 0x100)
 				st.dma.dst.region = -1;
 			else
 				st.dma.dst.region = param & 0x7;
+			st.dma.dst.mode = (param >> 9) & 0x3;
 			break;
 		case NPU_SET_DMA0_SIZE0:
 			st.dma.size0 = param;

-- 
2.53.0

