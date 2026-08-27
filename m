Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93EC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6C410F1B3;
	Thu, 27 Aug 2026 20:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CIQVGsDo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B36610F195
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE7414322C;
 Thu, 27 Aug 2026 20:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78A71F00A3E;
 Thu, 27 Aug 2026 20:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862799;
 bh=uKRuauSHS7on2i2iMUcMVC1/wQ8QGKYpMLEC5RACVLg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CIQVGsDoYzHEuoTPQ1yEWP7Qqb3b+X9Aa6dVflNeVPLLcUWtkSqTmBllkZD3YvGdD
 U1b22kIvz0xIm44FVAu3C3wmyBZK0OZzoczxJveeCqtFytJUy3877p1LiypYbP2YBo
 OxongRGP8eabViiKh72axWv7BHp4cNuYJrQKjMVqEvCFKD44bt+Vj9pF+FxzanRko6
 H0kneYZfMPE1paAfakswBLXnLZ/g9TMYp/fufoaX1ebFfjxWkXHYIchImodEsySuM3
 eF2uoFlZEpoF5aOl/KmgzTtNo74ZL2xkJsEoTZLjr/wETENNZ+s86cJBtFjIEAkrdn
 O1AMbQHr2Z9jQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:02 -0500
Subject: [PATCH 03/11] accel: ethosu: Ensure cmd stream ends with a stop op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-3-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
In-Reply-To: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
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

While the QSIZE register setting should prevent an out of bounds access
of the command stream, it is not clear whether the h/w generates an
interrupt in this case as is required (to prevent a timeout). As a stop op
is expected end of the command stream, let's just ensure it is present. A
stop op in the middle of the command stream also makes no sense.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_device.h | 1 +
 drivers/accel/ethosu/ethosu_gem.c    | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index d4458eac8447..1eca8590e68d 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -87,6 +87,7 @@ struct gen_pool;
 #define PMU_EV_TYPE_IDLE	0x20
 
 enum ethosu_cmds {
+	NPU_OP_STOP = 0x0,
 	NPU_OP_CONV = 0x2,
 	NPU_OP_DEPTHWISE = 0x3,
 	NPU_OP_POOL = 0x5,
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index d50fed64d4d9..eda9f42239be 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -390,6 +390,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 	struct ethosu_validated_cmdstream_info __free(kfree) *info = kzalloc_obj(*info);
 	struct ethosu_device *edev = to_ethosu_device(ddev);
 	u32 *bocmds = bo->base.vaddr;
+	bool ends_with_stop = false;
 	struct cmd_state st;
 	int i, ret;
 
@@ -426,6 +427,11 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		}
 
 		switch (cmd) {
+		case NPU_OP_STOP:
+			if (i != size / 4 - 1)
+				return -EINVAL;
+			ends_with_stop = true;
+			break;
 		case NPU_OP_DMA_START:
 			srclen = dma_length(info, &st.dma, &st.dma.src);
 			dstlen = dma_length(info, &st.dma, &st.dma.dst);
@@ -688,6 +694,9 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		}
 	}
 
+	if (!ends_with_stop)
+		return -EINVAL;
+
 	for (i = 0; i < NPU_BASEP_REGION_MAX; i++) {
 		if (!info->region_size[i])
 			continue;

-- 
2.53.0

