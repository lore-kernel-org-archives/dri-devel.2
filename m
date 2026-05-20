Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DF9CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D6B10E1DC;
	Thu, 21 May 2026 06:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=milton.pro header.i=@milton.pro header.b="X9ryc74F";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2026 19:49:51 UTC
Received: from v54.v54282eed.euw1.send.eu.mailgun.net
 (v54.v54282eed.euw1.send.eu.mailgun.net [185.250.239.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCE110E380
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 19:49:51 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=milton.pro; q=dns/txt;
 s=s1; t=1779306590; x=1779313790; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=u3yECB4BZhRkzhhdtMe3LWOTRcJ8A7sXAfXbRFilawY=;
 b=X9ryc74FZBW+sga6vLlVCKha2hkos7M0l6kUp1IWzYcSW0q6Fr8jHvEK/F7w4vegV7nlrlWwf65XHGkeqRIRRUMvdUz7m8ntwxre0udPy6LFhOTPRcPSyU36WL1ezdtqye1kVzV4B7k0W6pvAtrGjiUbajZgQweaKYQ2IQiGpsM=
X-Mailgun-Sid: WyIzYzBkYiIsImRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmciLCJlNzAyNyJd
Received: from thinkpad-arch (ppp-124-122-133-95.revip2.asianet.co.th
 [124.122.133.95])
 by 1501f30ea100eb77ddb9d48846edcc8c8b1ad516c7bcd730380eeb9579bf1418 with SMTP
 id 6a0e0f2f155c8781d6bf8a42 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 20 May 2026 19:44:47 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Nikolay Mikhaylov <sonny@milton.pro>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Nikolay Mikhaylov <sonny@milton.pro>
Subject: [PATCH v2] drm/xe/ggtt: hold FORCEWAKE while updating GGTT PTEs on LNL
Date: Thu, 21 May 2026 02:44:12 +0700
Message-ID: <20260520194426.1334262-1-sonny@milton.pro>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 06:44:53 +0000
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

GGTT PTEs are written through GSM using MMIO writes. On Lunar Lake
systems affected by the referenced issue, hangs have been observed around
GGTT update paths while the GT may be entering RC6 under GuC control.

The GGTT modify paths currently rely on xe_pm_runtime_get_noresume() for
power management protection. That prevents the device from entering D3,
but does not keep the GT out of RC6 while the device is otherwise runtime
PM active.

Hold GT FORCEWAKE across the observed GGTT PTE write batches:

  - xe_ggtt_insert_node_transform() and __xe_ggtt_insert_bo_at(),
    covering the display framebuffer pin path observed as the primary
    trigger on LNL/Wayland systems
  - xe_ggtt_clear(), covering the GGTT node removal/unpin path

This keeps the change limited to the paths where the hang has been
observed. The exact code shape submitted here has been tested by multiple
LNL users, including several weeks of uptime without reproducing the hang.

Boot-time xe_ggtt_initial_clear() is also covered by the xe_ggtt_clear()
wrap. That is incidental and not the primary load-bearing path for the
reported issue.

The insert-path FORCEWAKE wrapping was originally proposed by Márton Vigh
(@mrtnvgh):
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3418761

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
Tested-by: Nikolay Mikhaylov <sonny@milton.pro>
Signed-off-by: Nikolay Mikhaylov <sonny@milton.pro>
---
 drivers/gpu/drm/xe/xe_ggtt.c | 39 ++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index a351c578b170..c048bad70ebf 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -20,6 +20,8 @@
 #include "regs/xe_regs.h"
 #include "xe_assert.h"
 #include "xe_bo.h"
+#include "xe_device.h"
+#include "xe_force_wake.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_types.h"
 #include "xe_map.h"
@@ -272,9 +274,18 @@ static void xe_ggtt_clear(struct xe_ggtt *ggtt, u64 start, u64 size)
 	else
 		scratch_pte = 0;
 
-	while (start < end) {
-		ggtt->pt_ops->ggtt_set_pte(ggtt, start, scratch_pte);
-		start += XE_PAGE_SIZE;
+	/*
+	 * GSM (mapped at tile->mmio.regs + SZ_8M) is not in an always-on
+	 * power domain. Hold FORCEWAKE for the PTE write batch to keep
+	 * the GT awake; on LNL GuC autonomously enters RC6 via
+	 * GUCRC_FIRMWARE_CONTROL and writeq() to GSM hangs if the GT
+	 * is asleep.
+	 */
+	xe_with_force_wake(fw_ref, gt_to_fw(ggtt->tile->primary_gt), XE_FW_GT) {
+		while (start < end) {
+			ggtt->pt_ops->ggtt_set_pte(ggtt, start, scratch_pte);
+			start += XE_PAGE_SIZE;
+		}
 	}
 }
 
@@ -769,10 +780,19 @@ struct xe_ggtt_node *xe_ggtt_insert_node_transform(struct xe_ggtt *ggtt,
 	if (ret)
 		goto err_unlock;
 
-	if (transform)
-		transform(ggtt, node, pte_flags, ggtt->pt_ops->ggtt_set_pte, arg);
-	else
-		xe_ggtt_map_bo(ggtt, node, bo, pte_flags);
+	/*
+	 * Hold FORCEWAKE for the PTE write batch. xe_pm_runtime_get_noresume()
+	 * upstack only prevents D3, not RC6: GuC may have placed the GT into
+	 * RC6 autonomously (GUCRC_FIRMWARE_CONTROL on LNL), and writeq() to
+	 * GSM hangs if the GT is asleep. Triggers most often from the display
+	 * framebuffer pin path on LNL/Wayland.
+	 */
+	xe_with_force_wake(fw_ref, gt_to_fw(ggtt->tile->primary_gt), XE_FW_GT) {
+		if (transform)
+			transform(ggtt, node, pte_flags, ggtt->pt_ops->ggtt_set_pte, arg);
+		else
+			xe_ggtt_map_bo(ggtt, node, bo, pte_flags);
+	}
 
 	mutex_unlock(&ggtt->lock);
 	return node;
@@ -844,7 +864,10 @@ static int __xe_ggtt_insert_bo_at(struct xe_ggtt *ggtt, struct xe_bo *bo,
 		u16 pat_index = xe_cache_pat_idx(tile_to_xe(ggtt->tile), cache_mode);
 		u64 pte = ggtt->pt_ops->pte_encode_flags(bo, pat_index);
 
-		xe_ggtt_map_bo(ggtt, bo->ggtt_node[tile_id], bo, pte);
+		/* See xe_ggtt_insert_node_transform()/xe_ggtt_clear() */
+		xe_with_force_wake(fw_ref, gt_to_fw(ggtt->tile->primary_gt), XE_FW_GT) {
+			xe_ggtt_map_bo(ggtt, bo->ggtt_node[tile_id], bo, pte);
+		}
 	}
 	mutex_unlock(&ggtt->lock);
 
-- 
2.53.0

