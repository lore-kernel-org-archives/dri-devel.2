Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5314FC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F7810F1EE;
	Thu, 16 Jul 2026 08:21:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2792010E2EC
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:52:49 +0000 (UTC)
X-UUID: f16629a080e211f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b851bdb5-e949-4d71-8483-07a832b03d0c, IP:15,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:b851bdb5-e949-4d71-8483-07a832b03d0c, IP:15,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:8535b07d34f1815adba18499d605d937,
 BulkI
 D:260716145245NEMXN3OL,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
 |136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
 k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
 ,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f16629a080e211f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 586882134; Thu, 16 Jul 2026 14:52:42 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] accel/ethosu: check MMIO mapping errors in probe
Date: Thu, 16 Jul 2026 14:52:19 +0800
Message-ID: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

devm_platform_ioremap_resource() returns an error pointer when the register
resource cannot be mapped. ethosu_probe() stores it and continues until
initialization dereferences it through MMIO accessors.

Return the mapping error before initializing the device.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/accel/ethosu/ethosu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index ed9c748a54ad..b2901eb8a7a0 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -342,6 +342,8 @@ static int ethosu_probe(struct platform_device *pdev)
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
 
 	ethosudev->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ethosudev->regs))
+		return PTR_ERR(ethosudev->regs);
 
 	ethosudev->num_clks = devm_clk_bulk_get_all(&pdev->dev, &ethosudev->clks);
 	if (ethosudev->num_clks < 0)
-- 
2.43.0

