Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B3C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DB610F247;
	Fri, 21 Aug 2026 07:23:08 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4A310F1F5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 03:20:21 +0000 (UTC)
X-UUID: 39b658ae9d0f11f19a56ed5b684f684d-20260821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:cb065ed6-5c68-4f65-891a-d4022dd11f31, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-30
X-CID-META: VersionHash:7db8b62, CLOUDID:7c34450e327ec8c0643bcdc64de1cde7,
 BulkI
 D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 39b658ae9d0f11f19a56ed5b684f684d-20260821
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <lijun01@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 980581485; Fri, 21 Aug 2026 11:20:14 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn, koby.elbaz@intel.com, konstantin.sinyuk@intel.com,
 ogabbay@kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] accel: habanalabs: pm: use DEFINE_SIMPLE_DEV_OPS for pm
 struct
Date: Fri, 21 Aug 2026 11:19:59 +0800
Message-Id: <20260821031959.288264-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 07:23:07 +0000
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

use DEFINE_SIMPLE_DEV_PM_OPS for hl_pm_ops,
pm_sleep_ptr() to safely drop the references without
triggering compiler warnings. and add the value of
'.freeze .thaw .poweroff .restore'. if these
address are null, may cause error in s4.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/accel/habanalabs/common/habanalabs_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 483e1ad9fc41..6de59a9bac9b 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -706,10 +706,7 @@ static void hl_pci_reset_done(struct pci_dev *pdev)
 	hl_device_reset(hdev, flags);
 }
 
-static const struct dev_pm_ops hl_pm_ops = {
-	.suspend = hl_pmops_suspend,
-	.resume = hl_pmops_resume,
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(hl_pm_ops, hl_pmops_suspend, hl_pmops_resume);
 
 static const struct pci_error_handlers hl_pci_err_handler = {
 	.error_detected = hl_pci_err_detected,
-- 
2.25.1

