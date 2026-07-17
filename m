Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D2FC4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C8910F42F;
	Fri, 17 Jul 2026 06:12:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6EE10E433
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:12:17 +0000 (UTC)
X-UUID: 71a0e32681a611f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:526f1c60-46cd-46c1-bcb0-b6d959c130e0, IP:15,
 URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:35
X-CID-INFO: VERSION:1.3.12, REQID:526f1c60-46cd-46c1-bcb0-b6d959c130e0, IP:15,
 UR
 L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:35
X-CID-META: VersionHash:e7bac3a, CLOUDID:ccb4b48d63988cb69eafd1c593126874,
 BulkI
 D:26071714121162HUFXCY,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
 |102|127|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:11|93|82|1,Fi
 le:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
 DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71a0e32681a611f1aa26b74ffac11d73-20260717
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 848065994; Fri, 17 Jul 2026 14:12:09 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/5] accel/ethosu: check DMA mask setup
Date: Fri, 17 Jul 2026 14:11:41 +0800
Message-ID: <20260717061145.1478139-2-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
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

dma_set_mask_and_coherent() can fail when platform DMA operations do not
support the requested 40-bit address mask. Ignoring the error leaves the
previous DMA configuration in place. Probe then continues without ensuring
that DMA addresses are suitable for the NPU.

Return the error so the driver does not bind with an unsupported DMA
configuration.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716082530.1023538-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
New in v2.

Sashiko report:

> This is a pre-existing issue, but does this code ignore the return value of
> dma_set_mask_and_coherent() which is called earlier in ethosu_probe()?
>
> If the platform only supports 32-bit DMA and the call fails, the default
> 32-bit mask is retained. The DRM core and driver might proceed assuming
> 40-bit DMA is active, handing the NPU physical addresses greater than 4 GB,
> which could lead to silent DMA address truncation and memory corruption.

 drivers/accel/ethosu/ethosu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index ed9c748a54ad..f3920185389d 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -339,7 +339,9 @@ static int ethosu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, ethosudev);
 
-	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
+	if (ret)
+		return ret;
 
 	ethosudev->regs = devm_platform_ioremap_resource(pdev, 0);
 
-- 
2.43.0
