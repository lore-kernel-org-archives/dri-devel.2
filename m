Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BB7C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31A910E58F;
	Mon, 13 Jul 2026 08:31:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080E210E58F;
 Mon, 13 Jul 2026 08:31:04 +0000 (UTC)
X-UUID: 2c0d83c87e9511f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:1c3859d4-f82f-4cc0-9ce0-488c3dc37588, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:5c2935fe4293b9d09a414be2a6fa101d,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
 50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c0d83c87e9511f1aa26b74ffac11d73-20260713
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <lilinmao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 255197116; Mon, 13 Jul 2026 16:30:57 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
 Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] drm/xe/oa: Check managed mutex initialization errors
Date: Mon, 13 Jul 2026 16:30:53 +0800
Message-Id: <20260713083053.321091-1-lilinmao@kylinos.cn>
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

drmm_mutex_init() can fail while registering its managed cleanup action.
On failure, the reset path destroys the mutex, so continuing OA setup
leaves an unusable lock that later paths may acquire.

Return the error from per-GT OA initialization and abort device-wide OA
initialization if the metrics lock cannot be initialized.

Fixes: a9f905ae7b6f ("drm/xe/oa/uapi: Initialize OA units")
Fixes: cdf02fe1a94a ("drm/xe/oa/uapi: Add/remove OA config perf ops")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/gpu/drm/xe/xe_oa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 2dce6a47202c..f3a0d5bf7894 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -2713,9 +2713,7 @@ static int xe_oa_init_gt(struct xe_gt *gt)
 
 	__xe_oa_init_oa_units(gt);
 
-	drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
-
-	return 0;
+	return drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
 }
 
 static void xe_oa_print_gt_oa_units(struct xe_gt *gt)
@@ -2855,7 +2853,10 @@ int xe_oa_init(struct xe_device *xe)
 	oa->xe = xe;
 	oa->oa_formats = oa_formats;
 
-	drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
+	ret = drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
+	if (ret)
+		goto exit;
+
 	idr_init_base(&oa->metrics_idr, 1);
 
 	ret = xe_oa_init_oa_units(oa);
-- 
2.25.1

