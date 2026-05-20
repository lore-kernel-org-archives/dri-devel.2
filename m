Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40424CD4F5B
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 01:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8007C10E01F;
	Wed, 20 May 2026 01:53:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E3010E01F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:53:20 +0000 (UTC)
X-UUID: aacfb66c53ee11f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:34e8c752-9a61-452e-b6ad-de7657ef1004, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:03fe5521317c55050ea56c46162d73f4,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|850|865|898,TC:nil,Content
 :0|15|50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
 :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aacfb66c53ee11f1aa26b74ffac11d73-20260520
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 688329187; Wed, 20 May 2026 09:53:15 +0800
From: yaolu@kylinos.cn
To: markus.elfring@web.de
Cc: chenhuacai@kernel.org, dri-devel@lists.freedesktop.org, jeffbai@aosc.io,
 linux-kernel@vger.kernel.org, lvjianmin@loongson.cn, wuqianhai@loongson.cn,
 xry111@xry111.site, yaolu@kylinos.cn, zhengxingda@iscas.ac.cn
Subject: [PATCH v2] drm/loongson: mode_config.cursor_width should use
 hw_cursor_w
Date: Wed, 20 May 2026 09:53:09 +0800
Message-Id: <20260520015309.35088-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <47e5bbaf-7b39-4c5c-849b-314204db1b97@web.de>
References: <47e5bbaf-7b39-4c5c-849b-314204db1b97@web.de>
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

mode_config.cursor_width should use hw_cursor_w rather than hw_cursor_h.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
v1->v2: add fixes tag suggested by Markus.
  Link: https://lore.kernel.org/dri-devel/47e5bbaf-7b39-4c5c-849b-314204db1b97@web.de/

 drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 79bb61278aa7..02615fa6a1d5 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -139,7 +139,7 @@ static int lsdc_mode_config_init(struct drm_device *ddev,
 	ddev->mode_config.preferred_depth = 24;
 	ddev->mode_config.prefer_shadow = 1;
 
-	ddev->mode_config.cursor_width = descp->hw_cursor_h;
+	ddev->mode_config.cursor_width = descp->hw_cursor_w;
 	ddev->mode_config.cursor_height = descp->hw_cursor_h;
 
 	ddev->mode_config.helper_private = &lsdc_mode_config_helper_funcs;
-- 
2.25.1

