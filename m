Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBD6CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1407C10EAEB;
	Tue, 19 May 2026 07:42:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C0B10EAEB
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:42:07 +0000 (UTC)
X-UUID: 39d0c53e535611f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:147676b3-0a48-4bf0-a383-389b827aa062, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:18729937a79218eecfc03e4b8a614fbb,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
 50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
 OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 39d0c53e535611f1aa26b74ffac11d73-20260519
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 915976552; Tue, 19 May 2026 15:42:02 +0800
From: yaolu@kylinos.cn
To: lvjianmin@loongson.cn,
	wuqianhai@loongson.cn
Cc: chenhuacai@kernel.org, jeffbai@aosc.io, xry111@xry111.site,
 zhengxingda@iscas.ac.cn, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: [PATH] drm/loongson: add cleanup path for lsdc_ttm_init
Date: Tue, 19 May 2026 15:41:58 +0800
Message-Id: <20260519074158.144134-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

There has resource leak when TTM_PL_VRAM or TTM_PL_TT man range init
failed.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
index d7441d96a0dc..c84bc582f77c 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -554,7 +554,7 @@ int lsdc_ttm_init(struct lsdc_device *ldev)
 
 	ret = ttm_range_man_init(&ldev->bdev, TTM_PL_VRAM, false, num_vram_pages);
 	if (unlikely(ret))
-		return ret;
+		goto err_vram;
 
 	drm_info(ddev, "VRAM: %lu pages ready\n", num_vram_pages);
 
@@ -565,11 +565,17 @@ int lsdc_ttm_init(struct lsdc_device *ldev)
 
 	ret = ttm_range_man_init(&ldev->bdev, TTM_PL_TT, true, num_gtt_pages);
 	if (unlikely(ret))
-		return ret;
+		goto err_gtt;
 
 	drm_info(ddev, "GTT: %lu pages ready\n", num_gtt_pages);
 
 	return drmm_add_action_or_reset(ddev, lsdc_ttm_fini, ldev);
+
+err_gtt:
+	ttm_range_man_fini(&ldev->bdev, TTM_PL_VRAM);
+err_vram:
+	ttm_device_fini(&ldev->bdev);
+	return ret;
 }
 
 void lsdc_ttm_debugfs_init(struct lsdc_device *ldev)
-- 
2.25.1

