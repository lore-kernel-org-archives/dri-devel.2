Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D45ACD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D380A10F908;
	Fri, 29 May 2026 05:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JzsQFMa5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE36C10F901;
 Fri, 29 May 2026 05:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJnrZimQPTYOlWp3zv7hYk3/3PxSLbo0pDvucRhT72bPKt0DpZAiS+da7yfIiPgKYXNncslt29SNrwOBLlUoIk3gZ8FoI3dCa6/AUd5L71UGlj7Dne9Qo2CoFQ+k024d1PCrWSBL1WS4X48KrRQChJrmkQWLS3ZF0F07bXEHrGeZd36q5w8wWtKyBerZujnvkaHosn/cf3gdNteogA42uPHi708sJbL16Mp1W7zjnKeKEdRkOGVdHVc0nsI6p2pZpfNJa1v29ucAqGrZhw9zemjM3YsuV/WCpVwkc6Ctvxsz7YjqaVdrtNFR4CD9CGorYhncwdYMunqavAl+Onx/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZR+qZ6cl1sCed8BTHYppEhOis9A0MSte7Q/y2eXZdY=;
 b=I4PODHsR8c4dIzYsuc/ChgnKafNVr+Qk+q835VuEHk5LEWKxKCfwA0LEXdubHm8GNwi2bSvoD1FxpmgfVEJJhIVJisAgz3GEIPXHy+AV0bF6UgdLt4r/A85EtTmFScHTreQBvRWLNmsc+YOrVPsBbrGd3f0JvjkNkbjHWdKAcAjGuSb83XAXhLEnT4exMsSdr3SWjn1kKqQ9KGMnInaNAF25PIwW/h6GOAw1Dp6BiF891J2X+PooeW0NcxFqcGDgnDU+BlLd2SjXi5+kFEhUXaq5ZQOTawsO+e5gmegA+VAh9zMo9MWTJzENHIf5nNYwBxgzZaYEfOElwwTfaie5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZR+qZ6cl1sCed8BTHYppEhOis9A0MSte7Q/y2eXZdY=;
 b=JzsQFMa54idR0LV18L/DuOu5HveliFzXRtS5IR+TmIgYJ9YiEZw6VBgts1JK5lZYUACYoZtFzSe9ItgI8Ug0BmCUYx7oPb5DzTCjXIHpQrQqh0quowBp7+e/Sk8x4Ky6nUhsBpD1gyAxGh+3EQmeJEnLq/Caz3fFn//lEigEt/U=
Received: from CH0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:610:74::23)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 05:49:59 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::9b) by CH0PR04CA0078.outlook.office365.com
 (2603:10b6:610:74::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 05:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:49:59 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:54 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 3/8] drm/amdgpu: implement xnack-off restore core and
 invalidate callback
Date: Fri, 29 May 2026 13:49:23 +0800
Message-ID: <20260529054928.596825-4-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054928.596825-1-honglei1.huang@amd.com>
References: <20260529054928.596825-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c08a444-ed2a-4b05-b87e-08debd461e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|921020|3023799007|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8fEWTmqSjDTTuE2+UAzNRdMF/iUlbmCuy25ygtsG9MIKSs8pdM+bIJynV2jV199V3sdNIeeelPrMpBCYwIHvySkR28iueaQkrFF+tuLogrkh9TlaApORenz9YVO1rPFUXqeM7CEeziBrpje6U9Fd19+HGCMH6Xv+4CPdtoRyS4GpiYofvr/uKu1w/QizxL3rgwGkWUjG7noqK47r3fjSM1YtCDVmsXWlrHY7IKc37eSjwrdJUdWtiPYzIx7V9bcyyheDdJqp9jgPCG116LUSUa1BouEJpKVccQMIJL9eiSsf4Qo092jhikFOKqHt4U+gLznv28DV2OoeShIdwu1S2xnyXep7kC9PvPN/8aRWK3ytOckd4KBKPGLT8cjPwwTR/qbRBDatB2h46dEDxCo5Mm5s5UJ8+AWlg2w0edhQzsk1ME9ivUGW+IjOa+XfTkvwuDQa63EG2tb4CXhcwBm7DUcPSyuaUXXchI4AsR9jOAHxRFCtJc5ZPQNkGdsv0jXVOQ9PZCAq6FJ0/vbZ7J+HXKFDSXPkElXSiyMVyPUGoiMDFKEbimdOcmMyhaf0lYbBbMld92rMZmGKFdIAfy6b5fXYIXT3vadLEoJRRWrCnRfL0JmpMzgqDwM5tIk+NFkYNnuCCrK0gmNwrri8mrsV+9FgtQeds1n4w9fu+4818NcxLyjXyvA0f1gd1dj+FFdB5sZmwI0gYEw9Zv8fOh1DM3dWmTi4Whipj719qLXew6Nh6/9etYyAP7TlTnyY+//4B/Y43/x2k+JHygtPKpV/VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(921020)(3023799007)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: khYeKdy357oUXGk2vsKc/PGh0DEGBfgPQ2aAkD50kSZqZFLyRxv0sSesnR7rBtHp8wBXf1F3sWVSoZW9NTwRhcom5U3MwGZ/Dzp3FA0kgZ0LrbaXJ79y4hN0Zfgi+9/u0w5wbUk2/feGk2Q0aS0b3A9WUJRUq+FiDy/j51TqjHD0a/DPoJcPhFummRtEMfr60xurojzkgttgAVE3L7DRG53XVJQ2H0EfWn/VLV7UriDYhSp8OaOiK2DKBQCPDufcyav4PCu3J4dx9y7G6/0lcO0hlVs6x6MCDtsd4IskbqobpnsPgbowxKhB6/z0BSoQzJTIHTETfLX9U9hqs2xAw3/a9EzTbuj5Tcyu96Sj+oDE0LRygNcvzJlYAIHCYFRpzv3fHKdri1veENgWgu2/WVsps0yM6JDSukyBXukLIVPqL7kpESWCaXNa4+ELF5VJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:49:59.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c08a444-ed2a-4b05-b87e-08debd461e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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

From: Honglei Huang <honghuan@amd.com>

Implement the core restore infrastructure and invalidation callback for
xnack-off SVM. The invalidate callback handles MMU notifier events by
quiescing compute queues when needed and scheduling restore work.

For MMU_NOTIFY_UNMAP events, avoid unconditionally quiescing compute
queues -- only quiesce when a range is partially unmapped and has active
GPU mappings (i.e. the GC worker will need a rebuild window). Full-range
unmaps and ranges without GPU mappings skip the quiesce entirely, which
reduces unnecessary queue preemption traffic.

Non-UNMAP events (CLEAR/MIGRATE) always quiesce because PTEs are cleared
synchronously and the restore is asynchronous.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 257 ++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
new file mode 100644
index 000000000..b231c7d44
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_svm.h"
+#include "amdgpu_userptr.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+
+#include <drm/drm_gpusvm.h>
+
+#include <uapi/linux/kfd_ioctl.h>
+
+#define AMDGPU_SVM_RESTORE_WQ_NAME "amdgpu_svm_restore"
+
+static void svm_restore_enqueue_work(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range,
+				     unsigned long start_page,
+				     unsigned long last_page,
+				     uint8_t pending_ops);
+
+static void amdgpu_svm_restore_worker(struct work_struct *w);
+
+static void
+svm_restore_notifier_event_end(struct amdgpu_svm *svm,
+		   struct drm_gpusvm_range *range,
+		   const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+	unsigned long start_page = max(drm_gpusvm_range_start(&svm_range->base),
+				       mmu_range->start) >> PAGE_SHIFT;
+	unsigned long last_page = (min(drm_gpusvm_range_end(&svm_range->base),
+				       mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	if (mmu_range->event == MMU_NOTIFY_UNMAP) {
+		AMDGPU_SVM_RANGE_DEBUG(svm_range, "GARBAGE COLLECTOR ADD");
+		drm_gpusvm_range_set_unmapped(&svm_range->base, mmu_range);
+		svm_restore_enqueue_work(svm, svm_range, start_page, last_page,
+			     AMDGPU_SVM_RANGE_OP_UNMAP);
+	} else {
+		AMDGPU_SVM_RANGE_DEBUG(svm_range, "RESTORE WORKER ADD");
+		svm_restore_enqueue_work(svm, svm_range, start_page, last_page,
+			     AMDGPU_SVM_RANGE_OP_RESTORE);
+	}
+}
+
+static void svm_restore_eviction_begin(struct amdgpu_svm *svm)
+{
+	if (atomic_inc_return(&svm->restore.evicted_ranges) != 1)
+		return;
+
+	svm->restore.begin(svm);
+}
+
+static bool
+svm_restore_unmap_needs_quiesce(struct drm_gpusvm_range *range,
+				const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+
+	if (!READ_ONCE(svm_range->gpu_mapped))
+		return false;
+
+	return drm_gpusvm_range_start(range) < mmu_range->start ||
+	       drm_gpusvm_range_end(range) > mmu_range->end;
+}
+
+void
+amdgpu_svm_restore_invalidate(struct amdgpu_svm *svm,
+			      struct drm_gpusvm_notifier *notifier,
+			      const struct mmu_notifier_range *mmu_range,
+			      struct drm_gpusvm_range *first,
+			      uint64_t adj_start, uint64_t adj_end)
+{
+	struct drm_gpusvm_range *r;
+	bool is_unmap = mmu_range->event == MMU_NOTIFY_UNMAP;
+	bool needs_flush = false;
+
+	if (is_unmap) {
+		bool quiesced = false;
+
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+		r = first;
+		drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end) {
+			if (!quiesced &&
+			    svm_restore_unmap_needs_quiesce(r, mmu_range)) {
+				svm_restore_eviction_begin(svm);
+				quiesced = true;
+			}
+
+			needs_flush |= amdgpu_svm_range_notifier_event_begin(
+							svm, r, mmu_range);
+		}
+
+		if (needs_flush)
+			svm->flush_tlb(svm);
+	} else {
+		svm_restore_eviction_begin(svm);
+
+		r = first;
+		drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+			amdgpu_svm_range_invalidate_gpu_mapping(
+							to_amdgpu_svm_range(r));
+	}
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		svm_restore_notifier_event_end(svm, r, mmu_range);
+}
+
+static void
+svm_restore_enqueue_work(struct amdgpu_svm *svm,
+			 struct amdgpu_svm_range *range,
+			 unsigned long start_page,
+			 unsigned long last_page,
+			 uint8_t pending_ops)
+{
+	bool queue_gc_work = false;
+	bool queue_restore_work = false;
+
+	if (atomic_read(&svm->exiting))
+		return;
+
+	spin_lock(&svm->work_lock);
+
+	/* Deny any work if range is unmapped */
+	if (UNMAP_WORK(range->pending_ops)) {
+		spin_unlock(&svm->work_lock);
+		return;
+	}
+
+	range->pending_start_page = min(range->pending_start_page, start_page);
+	range->pending_last_page = max(range->pending_last_page, last_page);
+
+	if (UNMAP_WORK(pending_ops)) {
+		range->pending_ops = AMDGPU_SVM_RANGE_OP_UNMAP;
+
+		switch (range->queue_state) {
+		case AMDGPU_SVM_RANGE_NOT_QUEUED:
+			drm_gpusvm_range_get(&range->base);
+			list_add_tail(&range->work_node, &svm->gc.list);
+			range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+			queue_gc_work = true;
+			break;
+		case AMDGPU_SVM_RANGE_IN_RESTORE:
+			/* Not in processing so move to gc is safe. */
+			list_move_tail(&range->work_node, &svm->gc.list);
+			range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+			queue_gc_work = true;
+			break;
+		case AMDGPU_SVM_RANGE_PROCESSING:
+			/* Do not move range into gc, because if the range is being
+			 * processed by the restore worker, moving it to GC may cause
+			 * use-after-free: the GC worker would remove the range while
+			 * the restore worker is still using it.
+			 * Owner worker will see UNMAP in pending_ops by
+			 * put_if_dequeued() and move to gc after processing the
+			 * restore work.
+			 */
+			break;
+		case AMDGPU_SVM_RANGE_IN_GC:
+			break;
+		}
+	} else {
+		switch (range->queue_state) {
+		case AMDGPU_SVM_RANGE_NOT_QUEUED:
+			range->pending_ops |= AMDGPU_SVM_RANGE_OP_RESTORE;
+			drm_gpusvm_range_get(&range->base);
+			list_add_tail(&range->work_node, &svm->restore.list);
+			range->queue_state = AMDGPU_SVM_RANGE_IN_RESTORE;
+			queue_restore_work = true;
+			break;
+		case AMDGPU_SVM_RANGE_IN_RESTORE:
+			range->pending_ops |= AMDGPU_SVM_RANGE_OP_RESTORE;
+			break;
+		case AMDGPU_SVM_RANGE_PROCESSING:
+			/*
+			 * Owner worker will see RESTORE in pending_ops
+			 * via put_if_dequeued() and queue into restore worker.
+			 */
+			range->pending_ops |= AMDGPU_SVM_RANGE_OP_RESTORE;
+			break;
+		case AMDGPU_SVM_RANGE_IN_GC:
+			/* Should not goto here cause UNMAP denies all the work. */
+			break;
+		}
+	}
+
+	spin_unlock(&svm->work_lock);
+
+	if (queue_gc_work)
+		queue_work(svm->gc.wq, &svm->gc.work);
+	if (queue_restore_work)
+		queue_delayed_work(svm->restore.wq, &svm->restore.work,
+				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+}
+
+int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
+			    void (*begin)(struct amdgpu_svm *),
+			    void (*end)(struct amdgpu_svm *))
+{
+	svm->restore.wq = alloc_ordered_workqueue(AMDGPU_SVM_RESTORE_WQ_NAME,
+						  WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	if (!svm->restore.wq)
+		return -ENOMEM;
+
+	svm->restore.begin = begin;
+	svm->restore.end = end;
+	atomic_set(&svm->restore.quiesced, 0);
+	atomic_set(&svm->restore.evicted_ranges, 0);
+	INIT_LIST_HEAD(&svm->restore.list);
+	INIT_DELAYED_WORK(&svm->restore.work, amdgpu_svm_restore_worker);
+	return 0;
+}
+
+void amdgpu_svm_restore_fini(struct amdgpu_svm *svm)
+{
+	cancel_delayed_work_sync(&svm->restore.work);
+	amdgpu_svm_clean_queue(svm, &svm->restore.list);
+	atomic_set(&svm->restore.evicted_ranges, 0);
+	if (atomic_read(&svm->restore.quiesced))
+		svm->restore.end(svm);
+	destroy_workqueue(svm->restore.wq);
+	svm->restore.wq = NULL;
+}
+
+void amdgpu_svm_restore_flush(struct amdgpu_svm *svm)
+{
+	flush_delayed_work(&svm->restore.work);
+}
-- 
2.34.1

