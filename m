Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA5EC982D0
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 06:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7444510E042;
	Sun, 20 Sep 2026 06:25:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7452710E042;
 Sun, 20 Sep 2026 06:25:22 +0000 (UTC)
X-UUID: 0a7b5e62b4bc11f19a56ed5b684f684d-20260920
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:ea75b3e9-dc40-4118-a377-ea1fee5e913b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:973adf967bcc4b30aa32854c9f1050fa,
 BulkI
 D:nil,BulkQuantity:0,SF:102|123|136|850|865|898,TC:nil,Content:0|15|50|99,
 EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a7b5e62b4bc11f19a56ed5b684f684d-20260920
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1118696961; Sun, 20 Sep 2026 14:25:14 +0800
From: yaolu@kylinos.cn
To: lingshan.zhu@amd.com, Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/amdkfd: drop KFD_QUEUE_TYPE_DIQ note
Date: Sun, 20 Sep 2026 14:25:10 +0800
Message-Id: <20260920062510.166584-1-yaolu@kylinos.cn>
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

Commit e1b73b64271d ("amdkfd: remove DIQ support") removed the
KFD_QUEUE_TYPE_DIQ enumerator from enum kfd_queue_type but left its
description behind in the note block.

Fixes: e1b73b64271d ("amdkfd: remove DIQ support")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb..2847a5ec5ede 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -430,8 +430,6 @@ enum kfd_unmap_queues_filter {
  *
  * @KFD_QUEUE_TYPE_HIQ: HIQ queue type.
  *
- * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
- *
  * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
  *
  * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDMA engine ID.
-- 
2.25.1

