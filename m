Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174B606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0129B10EC05;
	Wed, 18 Nov 2026 08:55:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F3010EC05;
 Wed, 18 Nov 2026 08:55:13 +0000 (UTC)
X-UUID: bfabcda4e32d11f19a56ed5b684f684d-20261118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:a8f6efcf-226f-4d48-831e-3dc98a10beef, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-20
X-CID-META: VersionHash:7db8b62, CLOUDID:4db1f5e7feaddf4bbc4f6c2c005fc0ad,
 BulkI
 D:nil,BulkQuantity:0,SF:102|123|136|850|865|898,TC:nil,Content:0|15|50|99,
 EDM:-19|2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bfabcda4e32d11f19a56ed5b684f684d-20261118
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 504405037; Wed, 18 Nov 2026 16:55:05 +0800
From: yaolu@kylinos.cn
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: michal.wajdeczko@intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/xe/gt: Abort GT init on LMTT initialization failure
Date: Wed, 18 Nov 2026 16:54:53 +0800
Message-Id: <20261118085453.198348-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lu Yao <yaolu@kylinos.cn>

xe_lmtt_init() can fail, but gt_init_with_gt_forcewake() ignores its
return value. On a PF the probe then continues with a half-initialized
LMTT: lmtt->pd is never set (and lmtt->ops is cleared), so
xe_lmtt_init_hw() returns early and the VF local memory is left without
a translation directory while the driver still reports success.

Return the xe_lmtt_init() error and abort GT init instead, as required
by the documented LMTT contract ("Any LMTT initialization failure
should block VFs enabling").

Fixes: b1d204058218 ("drm/xe/pf: Introduce Local Memory Translation Table")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/xe/xe_gt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 286aee5775c0..1239cbb7c84c 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -582,10 +582,10 @@ static int gt_init_with_gt_forcewake(struct xe_gt *gt)
 
 	if (xe_gt_is_main_type(gt)) {
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
+		if (!err && IS_SRIOV_PF(gt_to_xe(gt)))
+			err = xe_lmtt_init(&gt_to_tile(gt)->sriov.pf.lmtt);
 		if (err)
 			return err;
-		if (IS_SRIOV_PF(gt_to_xe(gt)))
-			xe_lmtt_init(&gt_to_tile(gt)->sriov.pf.lmtt);
 	}
 
 	/* Enable per hw engine IRQs */
-- 
2.25.1

