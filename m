Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA78C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8171310E96D;
	Tue,  4 Aug 2026 09:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2vxV+6v";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB2E10E974;
 Tue,  4 Aug 2026 09:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf2TNc7zxMcPk+YN0R1orKICIWDjQQRVkwjYh3iNg/flmmPUEvbPa7ewHMJTmWuv618eYvJ5AIcMD/5HnUDKlfC0qGZQH47GXwbUWYkC9CbvwypP8cMZgryG+urR4tg0YdWzhl5z0nrqyFICZmt3JrELqRFTL6KCDtIh5rU/xK0KVQoxv8LFAf8JhpAv2RsWMWta3yh5rvWmjTy8zmAqr5awl0rvIFTCy0/rFxQzthRHq7EK9yJKbmphxh/NM3WFMIICriePPHfSLqFpaqK6C/0AJPuUg7A5EjsA+qRzHtd5ZJQ7+kTNMNx7TQjGXZYA3dQ3BtoG4g1eQxwcTB4yGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AggHgXcgXqvjDY7hPtxCQG1HbkW1vjpkp+IrWjK5Rcw=;
 b=v07QNqiB7uumBHk4fgwuu7/wodBXqbsDDpg15edUDQOh2UwMGX6jjcMtedLotuewimmyb9EvQkcH2GrBwPt1BcX88SUDpPtQSunuTn0hgODc/aCvSdN01U1LnuoACccE0dWeJvu7uXcUYmEfj7GFg+7kqM2YQExTYm9VVtlmtet0/EXnq0K8M9THFSW6Sbt5vPREPr8/vTEHOWaT87CiOGZrA19+GZzio9ukqZ1Ubu0LJyA1pR6GPGFSCh0s7PIpKU8IImJRquIxvP1MovtzwN1xHIxptKzyY0dlY2Cy5KUUBj0VHgqFf5D2GhXk8yqhy1fwebydKLJQkEnQ2XBwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AggHgXcgXqvjDY7hPtxCQG1HbkW1vjpkp+IrWjK5Rcw=;
 b=O2vxV+6vE9FphEUJChLMJp3vmsAJwCtp3xJ62cFqMLcCS03HB4NmeRDS10gBSIQT9Y/ic9Ao3d1mEC5iBbI/j4Pmx26cUn607RBwaOgW0d6/Hi4WRwGioNg0mFHdW6PhXuabxuYPdkPtP9gu/9cBr5NZOhvdTv53fTO0hn6+J8U=
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:43:47 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::2f) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Tue, 4
 Aug 2026 09:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:46 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:41 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v9 09/18] drm/amdgpu: add SVM notifier invalidate callback and
 checkpoint
Date: Tue, 4 Aug 2026 17:42:35 +0800
Message-ID: <20260804094246.1719318-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1b41b7-aabf-4dd8-90da-08def20ce140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|921020|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yH37JWmCxe3Uvmmwt7+twbDtbZfBmub4g9SS8olQu+3Z+uRwrdI5MCaQUAW7oK6JXORUa9HJ+ngiwX7ocqOviyhld8D4DFFpY66RLYQMe4uEnF3A9y9+nEpZYVn7pXzBpZ+dq5ro6jVXEBwR+llf0sq1kz7dn29TF3JJGBrWnYQxvPtJjVEFCXKxezqFFKFsDgACaXKaM8pGxqTA2sXZSfzO1g1fWpZ1O5ZPmNCdL77cYG5rGRJyL2EgVIH64bLHjBtt+J1o3Is/4qeAcpPrBybhNnS8amf9taBiuQqO9bFYd4fA7Lmvcd1qgQlSjRG4iIGp8bG62rjQ7ee8jQ/Gy5CkOXfi8qfGJDZo2WaRDiPTXgVYpOs9G7QwsW8QH0DP5Gyo/uYA0nYwnWdP04PCwpt5WW/oNjlkLEkARZxxXSwHFbAC9FUtgbEtVEBgCAnwoxZ+IzPCthkvy92y3Svl9W8xwYCkUliCzsMeB2C/LPUL+kqZMpMS/QEIRovZLE968eosit9MvcvQ2ZdC2WfTFc2V00D8S/eDum4+IurumOCU2pH+6BJknpr02b8W1JYKyxrTJocJjTOZN47Hd2Ih13+nxI6Zaq0epqroLVShD7oVqxHt/yUQgKwvOD+52LM0xLDOoZjWQPD6HTq9HecUn3rBSMkUhwHDR0tG3KzbjyKBukp0qU/Cr9MvOhotRcCuGvlPh4L7gi3l5FW0dHojHxku5iE3HcBZgh61CQSKLcUSAZbgv+5vjuVGxJJlYjb+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GdovIpRK0IUyPtTqMqoa4XVAieoZzFQdWW7zji+DDmmruGb6khIadbp69f+mEqqP6GHPkfpR3W8X/HlBndgIqJ/5xGEjYwQ8Dvw5THjunvBTWa+19wHAIHKjAVW6UZ+lUb0ipE1z7Q0Y2UCKXKnqWeYyVptrmTjr1xMcBOGr4BP8l4NqIsA1RM/kd3G5TKReH4HE5lb68iXCKy3WHdIDEwb92fM+nlpmFCXfknb8STuo1/L9Sp/kglE45LYhtZaPjzOf0PqiHBQepRDo+UFLA1VYuuDmpFHrMt5iPH+Vq+vI5cyus/Vj07z8+aeDINStVOCsMVl7fldvAn2RcZO0vJieLQmzsVWKFqirQcbz0HMATcftw9RyYngSvNyeOXynH6ZhP5tmxCnomSCEhztPgrAKrPveicSeVavFr6fguTODP7Af4zR9omUDLe5aUxx9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:46.5087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1b41b7-aabf-4dd8-90da-08def20ce140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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

Add invalidate_ranges callback and checkpoint timestamp:
- amdgpu_svm_capture_checkpoint_ts: capture interrupt handler write
  pointer timestamp for stale retry fault filtering
- amdgpu_svm_range_invalidate: invalidate_ranges callback dispatching
  per range notifier begin/end with TLB flush batching, checkpoint
  timestamp capture on MMU_NOTIFY_UNMAP events

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  6 ++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 9e348390795a6..ed057545d0964 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -728,3 +728,74 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
 	if (put)
 		drm_gpusvm_range_put(&range->base);
 }
+
+/**
+ * amdgpu_svm_capture_checkpoint_ts() - Record the IH ring write pointer time
+ * @svm: The SVM context.
+ *
+ * Capture the timestamp of the most recent interrupt handler write pointer
+ * into @svm->checkpoint_ts. Retry faults whose timestamp predates this
+ * checkpoint are stale and are dropped by the fault handler.
+ */
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
+{
+	struct amdgpu_device *adev = svm->adev;
+	struct amdgpu_ih_ring *ih;
+	uint32_t checkpoint_wptr;
+
+	if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+		ih = &adev->irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			WRITE_ONCE(svm->checkpoint_ts,
+				   amdgpu_ih_decode_iv_ts(adev, ih,
+							  checkpoint_wptr, -1));
+			return;
+		}
+	}
+
+	ih = &adev->irq.ih_soft;
+	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+	if (ih->rptr != checkpoint_wptr)
+		WRITE_ONCE(svm->checkpoint_ts,
+			   amdgpu_ih_decode_iv_ts(adev, ih,
+						  checkpoint_wptr, -1));
+}
+
+/**
+ * amdgpu_svm_range_invalidate() - MMU notifier invalidate_ranges callback
+ * @svm: The SVM context.
+ * @notifier: The GPU SVM notifier covering the invalidated ranges.
+ * @mmu_range: The MMU notifier range describing the event.
+ * @first: First GPU SVM range in the affected interval.
+ * @adj_start: Adjusted start address of the affected interval.
+ * @adj_end: Adjusted end address of the affected interval.
+ *
+ * Dispatch the two phase notifier handling across every range in
+ * [@adj_start, @adj_end): run the begin phase for all ranges, then
+ * the end phase. On an unmap event, also capture a checkpoint timestamp
+ * so stale retry faults can be filtered.
+ */
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first,
+				 uint64_t adj_start, uint64_t adj_end)
+{
+	struct drm_gpusvm_range *r;
+	bool needs_flush = false;
+
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
+								     mmu_range);
+	if (needs_flush)
+		amdgpu_svm_flush_tlb(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		amdgpu_svm_range_notifier_event_end(svm, r, mmu_range);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index f423be277a85a..5e49d774711ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -175,6 +175,12 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
 			       struct drm_gpusvm_range *range,
 			       struct drm_gpusvm_ctx *ctx);
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first,
+				 uint64_t adj_start, uint64_t adj_end);
 bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
 					   struct drm_gpusvm_range *range,
 					   const struct mmu_notifier_range *mmu_range);
-- 
2.53.0

