Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E353EC61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C584F10F19C;
	Thu, 27 Aug 2026 20:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MVgsmmQQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCC510F195
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0099A601EF;
 Thu, 27 Aug 2026 20:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C011F000E9;
 Thu, 27 Aug 2026 20:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862800;
 bh=hzR9RLCyU76G62Dq90oauFYiDU2TqRfYxKeKOLu97co=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MVgsmmQQN6NIEXxq8eit9LyVhsZST9szrbp5fKhPIlVqHqfuXgLI6/REQXxzdo1Xl
 yjy4jT1offVOLnZz+NPWnQW0AU1s3LURwQ1OQVZwdFLJ9ycLXuWv7eCfCd9tN26tZ2
 P2KsFDK6fPhTiZXqc8ICFQuov/HUmdab5TiiFXD0LoF0vWqqSIdkzUvUdJg8uN/WxE
 +hA87C/xJlQlJfzbmIG5sMc6CnkyBk5bDf1hx2xr6zbvhQksuicL82oMQDsMmBOuBJ
 hwTbqNh4DQjfzDIIIaU3OyRltCOoyduhgsg4mkxfuKZqQYGo/ZfbwwROwinexQOj2G
 rOXES/Qp5928A==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:03 -0500
Subject: [PATCH 04/11] accel: ethosu: Ensure SRAM size is 0 on mapping failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-4-346f9ea8791c@kernel.org>
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

On a mapping failure of the SRAM, the SRAM size is left as non-zero. The
probe will succeed as the error return is not checked since having SRAM is
not a hard requirement. The non-zero size allows jobs to access SRAM which
is left pointing to physical base address 0x0.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index d121fb0d7732..f1af7b3ea038 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -281,8 +281,6 @@ static int ethosu_device_suspend(struct device *dev)
 
 static int ethosu_sram_init(struct ethosu_device *ethosudev)
 {
-	ethosudev->npu_info.sram_size = 0;
-
 	ethosudev->srampool = of_gen_pool_get(ethosudev->base.dev->of_node, "sram", 0);
 	if (!ethosudev->srampool)
 		return 0;
@@ -293,6 +291,7 @@ static int ethosu_sram_init(struct ethosu_device *ethosudev)
 							     ethosudev->npu_info.sram_size,
 							     &ethosudev->sramphys);
 	if (!ethosudev->sram) {
+		ethosudev->npu_info.sram_size = 0;
 		dev_err(ethosudev->base.dev, "failed to allocate from SRAM pool\n");
 		return -ENOMEM;
 	}

-- 
2.53.0

