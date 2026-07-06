Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042A2C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296E710E347;
	Mon,  6 Jul 2026 11:13:50 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62FD10E347;
 Mon,  6 Jul 2026 11:13:47 +0000 (UTC)
X-UUID: bd1b28d0792b11f1aa26b74ffac11d73-20260706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:615fdcf3-dd64-45a7-ae4b-d9ac2a6c1cc5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:b54be00bfd7698c547a44b9c0b80abf1,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bd1b28d0792b11f1aa26b74ffac11d73-20260706
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <lilinmao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1941358266; Mon, 06 Jul 2026 19:13:38 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@linux.intel.com>,
 Konstantin Khorenko <khorenko@virtuozzo.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/guc: Sort multi-lrc engines by logical instance
Date: Mon,  6 Jul 2026 19:13:23 +0800
Message-Id: <20260706111328.618675-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

logical_sort() looks up the engine for each logical instance i by
scanning all MAX_ENGINE_INSTANCE + 1 slots of the engines array, even
though its only caller initializes just num_engines entries, so the
scan can dereference uninitialized stack pointers.  In addition, the
final memcpy() passes *engines and *sorted instead of the arrays
themselves, so it copies engine structure data rather than the pointer
arrays.

Replace the implementation with a plain sort() of the initialized part
of the array, keyed by the logical mask.  This touches only initialized
entries, does not copy anything by hand, and does not rely on the
logical numbering being contiguous.

Fixes: f9d72092cb49 ("drm/i915/guc: Add basic GuC multi-lrc selftest")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
index 28e8a092f4e7..b56768d202b0 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
@@ -3,6 +3,8 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include <linux/sort.h>
+
 #include "gt/intel_gt_print.h"
 #include "selftests/igt_spinner.h"
 #include "selftests/igt_reset.h"
@@ -10,21 +12,21 @@
 #include "gt/intel_engine_heartbeat.h"
 #include "gem/selftests/mock_context.h"
 
+static int cmp_logical_instance(const void *a, const void *b)
+{
+	const struct intel_engine_cs *ea = *(const struct intel_engine_cs **)a;
+	const struct intel_engine_cs *eb = *(const struct intel_engine_cs **)b;
+
+	if (ea->logical_mask < eb->logical_mask)
+		return -1;
+	if (ea->logical_mask > eb->logical_mask)
+		return 1;
+	return 0;
+}
+
 static void logical_sort(struct intel_engine_cs **engines, int num_engines)
 {
-	struct intel_engine_cs *sorted[MAX_ENGINE_INSTANCE + 1];
-	int i, j;
-
-	for (i = 0; i < num_engines; ++i)
-		for (j = 0; j < MAX_ENGINE_INSTANCE + 1; ++j) {
-			if (engines[j]->logical_mask & BIT(i)) {
-				sorted[i] = engines[j];
-				break;
-			}
-		}
-
-	memcpy(*engines, *sorted,
-	       sizeof(struct intel_engine_cs *) * num_engines);
+	sort(engines, num_engines, sizeof(*engines), cmp_logical_instance, NULL);
 }
 
 static struct intel_context *
-- 
2.25.1

