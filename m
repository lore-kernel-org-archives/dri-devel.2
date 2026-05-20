Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4F3CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5258310E11C;
	Wed, 20 May 2026 12:05:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B0A10E11C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:05:33 +0000 (UTC)
X-UUID: 2f298910544411f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9b2a9711-6ccc-4660-8dcb-f774cd3c5ab6, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:86bdcbeb20b570dcd5575306646e0b3a,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|850|865|898,TC:nil,Content
 :0|15|50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
 :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f298910544411f1aa26b74ffac11d73-20260520
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1881316677; Wed, 20 May 2026 20:05:25 +0800
From: yaolu@kylinos.cn
To: xry111@xry111.site
Cc: chenhuacai@kernel.org, dri-devel@lists.freedesktop.org, jeffbai@aosc.io,
 linux-kernel@vger.kernel.org, lvjianmin@loongson.cn, markus.elfring@web.de,
 wuqianhai@loongson.cn, yaolu@kylinos.cn, zhengxingda@iscas.ac.cn
Subject: [PATCH v3] drm/loongson: rm unused member lsdc_device->gpu
Date: Wed, 20 May 2026 20:05:20 +0800
Message-Id: <20260520120520.293729-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <788292607f1d81531f27b6fb616debc2d0ec1da1.camel@xry111.site>
References: <788292607f1d81531f27b6fb616debc2d0ec1da1.camel@xry111.site>
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

From: Lu Yao <yaolu@kylinos.cn>

lsdc_device->gpu never be used.
And there has a pci_dev refcount leak in lsdc_get_dedicated_vram() for
calling pci_get_domain_bus_and_slot().

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
v2->v3: rm lsdc_device->gpu for it don't be used suggested by Xi Ruoyao
  Link: https://lore.kernel.org/all/788292607f1d81531f27b6fb616debc2d0ec1da1.camel@xry111.site

v1->v2: add fixes tag and parentheses to function names suggested by
Markus.
  Link: https://lore.kernel.org/dri-devel/8ba844ab-9851-4045-a4e8-a96e6d1511e2@web.de

 drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
 drivers/gpu/drm/loongson/lsdc_drv.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 34405073c4d4..99b8f0cda7ad 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -181,8 +181,8 @@ static int lsdc_get_dedicated_vram(struct lsdc_device *ldev,
 
 	ldev->vram_base = base;
 	ldev->vram_size = size;
-	ldev->gpu = pdev_gpu;
 
+	pci_dev_put(pdev_gpu);
 	drm_info(ddev, "Dedicated vram start: 0x%llx, size: %uMiB\n",
 		 (u64)base, (u32)(size >> 20));
 
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.h b/drivers/gpu/drm/loongson/lsdc_drv.h
index fbf2d760ef27..208bbcf689bf 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.h
+++ b/drivers/gpu/drm/loongson/lsdc_drv.h
@@ -269,7 +269,6 @@ struct lsdc_device {
 	/* @descp: features description of the DC variant */
 	const struct lsdc_desc *descp;
 	struct pci_dev *dc;
-	struct pci_dev *gpu;
 
 	struct loongson_gfxpll *gfxpll;
 
-- 
2.25.1

