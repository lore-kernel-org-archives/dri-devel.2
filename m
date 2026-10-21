Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454F606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PpKA4/Db
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FC710F898;
	Wed, 21 Oct 2026 03:00:26 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778A510F898;
 Wed, 21 Oct 2026 03:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DER3mKukUNzgU99IkxqhbjezIDSB83UqpGC9lZN2oQbw7/FC4SJ7hwWjcPMjTndfq5XjxWbwS7NQYIG2YM4AIGuudVSH02tamn9CMMEQ4TSuzVRpWasCH41ZVv/ezVhxyVcts+qa+kVH8BJLQKPBXvdB4Xd4Ud4sdoK2Z2RWIfIHPBXj5TfeYZ776YVHACo18r9JD5zOFc8pjYjCtS4HkSHNML3u/T9oe0vfzLYuUhYKXD3mR5Se8QIz0bEeXAOlwdylQ1i2jjDVjVE9hW6qPbK8yIWoYaiIHZ6sXkNXiFOFnoRmRFVvWvsHxAD9PntO7Bxm1zbP+dY3pXMwWzY3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpjbtCRhyoiQt1JHk/bWMk1m8qRPQ4NNXLDtA+pIiCo=;
 b=wpVizCYDZ+ehf4r/V5ehA+r7vO9furRTS7Z3qLqlACjryH4p6ENFFpcX15P0IPupFAe1nPenpc/j0xgDf9bszT3A8w/7XKoCvtqUhg/GgVTTFSqK71bHZY5gMMlWb7Ki9qtGPgmMpJt2RhxGhT5yDfvAO3RdTvks3+shXRhVjVvyD5F2Png2jNjYBIxsui67gyZ9779OZd7MvWT/iT4IPychGBQ5AgFwS8CDRdApWLUueGV+jQ/yTa2iqhsgUItHdwyFUGFJttCu66J7Jh8LNVfIyPwiiyQvXqfQaFkOYmJ9ItqnCqQuyXLimcOiPSvqhMML2gkaWUlh56ENdxhhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpjbtCRhyoiQt1JHk/bWMk1m8qRPQ4NNXLDtA+pIiCo=;
 b=PpKA4/Db0fMT9KHg9k5euxSQHqpAoIHteLGmPM5Kp1MXAuQfc6IqnYPBkVqJ8oKAHBzXnrjXO/EfangXSZiJIU1VAD2RQovk/uesv8kouNlHe2G+B1FPY0BGUw+i4xxgIIlshCa3On+G6XE76+TG8j8vTdzalcbuT0P313oPpMA=
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:00:11 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9a) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:00:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:02 -0500
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
Subject: [PATCH v10 08/22] drm/amdgpu: implement SVM range notifier and GC
 helpers
Date: Wed, 21 Oct 2026 10:58:47 +0800
Message-ID: <20261021025915.2433837-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d8464a-6661-4a06-398e-08df2f1f6bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261009223327099003|56012099006|11063799006|261009220027099003|261009221727099003|261009221227099003|261009223027099003|10067099003|22082099003|18002099003|921020|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: mzApQcYumYN2AGFO8kUdR1irdGkA5xDNMNMoxHgaebKWvAy2elbRvUuYWY4RQV6DqOIaW3KI14aYZH/q+CoHwacDeRhnPLPpsfONDNDXbeX8ORyf2u+OFFAySkwRKjOnbUwyD5YWqZbXDeKkRatYSy33T0FyjWtXm/XWtyLdo0DBVZotynbpkij9ECf2yHbB3Ud6qisGIL0ZHAEZLqHYtYsYj4q0v/a6zNYP6x2K2mufvOBcY2hJ8OqcOz1htUjKuttbXtfCvxh/g7mOoDVgv5UA6O3fF4pe8NeeXDCfb76YA8esI2lbX1rlCzxZNYff67MtN4VxBG3PU0Q3DB0o1UapEuBcD+qd1Yj/94RysKN0KX0iq7n2zOgQbyu8WVpEoftkPNfohor8+4dmImznyRD8JoEICBnWSfzEawYQhyGJ51FClpHnsJMrrto+qNpmw9yuc6SWdnjuvIkGyC9aDZcBlwtiKiVQpHfzVDbxunrXIHfhb2DNVWChjehcmVQgGmKZOrUhl8KB2j6HuBb05R/mbWh1c/Mjipt4QripXJihcFKiStBe4Rq61eMsXjqscLHb5IrmsiK7Ivzksr1OE21+/G1e97Px7bCtLHvUJ6TWUDm9bfWSrtUovpUgegiUeQ783Xb5g9tstPuEGn7GxM6sCH0cxE8A36rVu/vAU78f1a6F9YRvw35Cz7rAHWOVpyTmdOPYktIDG1hCiBc/SDSZoQoAgrDxZ4MOsHmJSkNz2BLvnI7Kx0b3OlNqZa3R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261009223327099003)(56012099006)(11063799006)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(921020)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CxWK1d7X2F8hj66waXJSLSZ1p0ytvJkpuaEgbtkHu1P1nLHl/PEa8GU9anRytaVetNgrQhC3poHxl9gBiYNdeCtY5o8lbBF6AWXpsl4cnhGOL4ZecPVTazRWyxXpp/DUjg324e5n+7m00GEm1h1bMHjbXENpVyAA0iixeZaEJUj+cPh3wEooeZneO0L4aYoms/LBXP8lraOXVVPXMtxnbilp4e9/dyQ64OGWX56opnxfzb5jx46EarQxD8nZEG7VVM5YR9yux5rj8owkAAjKLXE+riJgSi02473o7LD/nLPAgyGEGFPY6hj2bUJ8WFXUose47uJa+rdBwmTYcSyClNp8nugdv64fun80qLAlQdA5tQNNF5cmh9HORbNp88wvZeHHnJxgrW70LMq0fmNp8GM5xffp7bmbd4eJh3TNOaXRFkkO3xIL7Hv1MxbggPf7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:11.0162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d8464a-6661-4a06-398e-08df2f1f6bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Add MMU notifier event handling and garbage collection infrastructure:
- remove invalidated ranges from gpusvm
- zap affected PTEs and invalidate GPU mappings
- queue unmapped ranges for deferred garbage collection
- serialize GC queue state and range references
- drain queued GC before changing each attribute segment
- reject ranges already marked unmapped during lookup

The last two steps prevent attribute updates and prefetch mapping from
reusing a stale range that has been marked unmapped but has not yet been
removed from the gpusvm tree.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 315 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  16 +
 3 files changed, 337 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index c76e10473968e..014785a6db742 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -583,6 +583,12 @@ amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
 		int ret;
 
 		amdgpu_svm_lock(svm);
+		ret = amdgpu_svm_garbage_collector(svm);
+		if (ret) {
+			amdgpu_svm_unlock(svm);
+			return ret;
+		}
+
 		mutex_lock(&attr_tree->lock);
 		node = interval_tree_iter_first(&attr_tree->tree, cursor, cursor);
 		if (node) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index d4830e53f3d8e..b907f516cdbe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -235,6 +235,7 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 				unsigned long gpuva_start, unsigned long gpuva_end,
 				struct drm_gpusvm_ctx *ctx)
 {
+	struct drm_gpusvm_pages_flags flags;
 	struct drm_gpusvm_range *r;
 
 retry:
@@ -253,6 +254,10 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 	if (IS_ERR(r))
 		return ERR_CAST(r);
 
+	flags.__flags = READ_ONCE(r->pages.flags.__flags);
+	if (flags.unmapped)
+		return ERR_PTR(-EAGAIN);
+
 	return to_amdgpu_svm_range(r);
 }
 
@@ -415,3 +420,313 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 	return 0;
 }
 
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	amdgpu_svm_assert_locked(svm);
+
+	if (!base->pages.flags.unmapped && !base->pages.flags.partial_unmap)
+		drm_gpusvm_range_unmap_pages(&svm->gpusvm, base, ctx);
+
+	amdgpu_svm_range_invalidate_gpu_mapping(range);
+	drm_gpusvm_range_remove(&svm->gpusvm, base);
+}
+
+/**
+ * amdgpu_svm_range_notifier_event_begin() - First MMU notifier phase
+ * @svm: The SVM context.
+ * @range: The GPU SVM range covered by the notifier event.
+ * @mmu_range: The MMU notifier range describing the invalidation window.
+ *
+ * Invalidate the GPU view of @range over the notifier window: zap the
+ * affected PTEs and clear the gpu_mapped flag. The range is not removed
+ * here; structural removal if needed happens in the event-end phase.
+ *
+ * Return: true if PTEs were zapped, false otherwise.
+ */
+bool
+amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
+				      struct drm_gpusvm_range *range,
+				      const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+	unsigned long start_page, last_page;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "NOTIFIER");
+
+	if (range->pages.flags.unmapped || !svm_range->gpu_mapped)
+		return false;
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "NOTIFIER - EXECUTE");
+
+	start_page = max(drm_gpusvm_range_start(range),
+			 mmu_range->start) >> PAGE_SHIFT;
+	last_page = (min(drm_gpusvm_range_end(range),
+			 mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	amdgpu_svm_range_zap_ptes(svm, svm_range, start_page, last_page);
+	amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_gc_enqueue() - Queue a range for work queue processing
+ * @svm: The SVM context.
+ * @range: The SVM range to queue.
+ * @start_page: First page of the pending invalidation interval.
+ * @last_page: Last page of the pending invalidation interval.
+ *
+ * Queue @range on the GC list and kick the GC worker. A range reference
+ * is taken when it first enters IN_GC and dropped only when it returns
+ * to NOT_QUEUED, so the range stays alive while on the GC list or being
+ * processed. All transitions are serialized by svm->work_lock.
+ */
+static void
+amdgpu_svm_gc_enqueue(struct amdgpu_svm *svm,
+		      struct amdgpu_svm_range *range,
+		      unsigned long start_page, unsigned long last_page)
+{
+	if (atomic_read(&svm->exiting))
+		return;
+
+	spin_lock(&svm->work_lock);
+	if (range->queue_state == AMDGPU_SVM_RANGE_NOT_QUEUED) {
+		drm_gpusvm_range_get(&range->base);
+		range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+		list_add_tail(&range->work_node, &svm->gc.list);
+	}
+
+	range->pending_start_page = min(range->pending_start_page, start_page);
+	range->pending_last_page = max(range->pending_last_page, last_page);
+	range->pending_ops |= AMDGPU_SVM_RANGE_OP_UNMAP;
+	spin_unlock(&svm->work_lock);
+
+	queue_work(svm->gc.wq, &svm->gc.work);
+}
+
+static void
+amdgpu_svm_gc_add_range(struct amdgpu_svm *svm,
+			struct amdgpu_svm_range *svm_range,
+			const struct mmu_notifier_range *mmu_range)
+{
+	unsigned long start_page = max(drm_gpusvm_range_start(&svm_range->base),
+				       mmu_range->start) >> PAGE_SHIFT;
+	unsigned long last_page = (min(drm_gpusvm_range_end(&svm_range->base),
+				       mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "GARBAGE COLLECTOR ADD");
+
+	drm_gpusvm_range_set_unmapped(&svm_range->base, mmu_range);
+	amdgpu_svm_gc_enqueue(svm, svm_range, start_page, last_page);
+}
+
+/**
+ * amdgpu_svm_range_notifier_event_end() - Second MMU notifier phase
+ * @svm: The SVM context.
+ * @range: The GPU SVM range covered by the notifier event.
+ * @mmu_range: The MMU notifier range describing the event.
+ *
+ * DMA-unmap the pages for @range. On an actual unmap event, also queue the
+ * range to the GC so it gets structurally removed from the gpusvm trees.
+ */
+static void
+amdgpu_svm_range_notifier_event_end(struct amdgpu_svm *svm,
+				    struct drm_gpusvm_range *range,
+				    const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_gc_add_range(svm, to_amdgpu_svm_range(range),
+					mmu_range);
+}
+
+int
+amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
+				     unsigned long start_page,
+				     unsigned long last_page)
+{
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_notifier *notifier, *next_notifier;
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	struct drm_exec exec;
+	bool needs_flush = false;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+
+	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, true);
+	if (ret)
+		return ret;
+
+	drm_gpusvm_for_each_notifier_safe(notifier, next_notifier, &svm->gpusvm,
+					  start, end) {
+		struct drm_gpusvm_range *range, *next_range;
+
+		drm_gpusvm_for_each_range_safe(range, next_range, notifier,
+					       start, end) {
+			struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+			bool crosses_boundary = start > drm_gpusvm_range_start(range) ||
+						end < drm_gpusvm_range_end(range);
+
+			if (svm_range->gpu_mapped) {
+				AMDGPU_SVM_RANGE_TRACE(svm_range,
+					crosses_boundary ? "ATTR DESTROY" :
+							   "ATTR ZAP PTE");
+
+				ret = amdgpu_svm_range_zap_ptes(svm, svm_range,
+						drm_gpusvm_range_start(range) >> PAGE_SHIFT,
+						(drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1);
+				if (ret < 0) {
+					drm_exec_fini(&exec);
+					return ret;
+				}
+
+				amdgpu_svm_range_invalidate_gpu_mapping(svm_range);
+				needs_flush = true;
+			}
+
+			if (crosses_boundary) {
+				/* remove ranges crossing the boundary so GPU fault
+				 * creates new ranges bounded by the updated
+				 * attr_range boundaries.
+				 * Evict devmem-backed pages back to sysmem first
+				 * so VRAM-resident data is not lost when the range
+				 * is destroyed. No-op for sysmem-only ranges.
+				 */
+				drm_gpusvm_range_get(range);
+
+				amdgpu_svm_range_evict(svm, range);
+				amdgpu_svm_range_remove(svm, svm_range, &ctx);
+
+				amdgpu_svm_range_unqueue(svm, svm_range);
+
+				drm_gpusvm_range_put(range);
+			}
+		}
+	}
+
+	drm_exec_fini(&exec);
+
+	if (needs_flush)
+		amdgpu_svm_flush_tlb(svm);
+
+	pr_debug("attr invalidate done [0x%lx-0x%lx]-0x%lx needs_flush=%d\n",
+			 start_page, last_page, last_page - start_page + 1,
+			 needs_flush ? 1 : 0);
+
+	return 0;
+}
+
+/**
+ * amdgpu_svm_range_dequeue_locked() - Pull the next range off a work list
+ * @svm: The SVM context.
+ * @work_list: The work list to dequeue from.
+ * @op_ctx: Output context filled with the dequeued range's pending state.
+ *
+ * Move the first range on @work_list to PROCESSING and atomically snapshot
+ * its pending op/interval into @op_ctx while resetting them on the range, so
+ * invalidations that arrive during processing accumulate afresh. Caller must
+ * hold svm->work_lock.
+ *
+ * Return: true if a range was dequeued, false if @work_list was empty.
+ */
+bool
+amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
+					struct list_head *work_list,
+					struct amdgpu_svm_range_op_ctx *op_ctx)
+{
+	struct amdgpu_svm_range *range;
+
+	lockdep_assert_held(&svm->work_lock);
+
+	range = list_first_entry_or_null(work_list, struct amdgpu_svm_range,
+					work_node);
+	if (!range)
+		return false;
+
+	list_del_init(&range->work_node);
+	range->queue_state = AMDGPU_SVM_RANGE_PROCESSING;
+
+	op_ctx->range = range;
+	op_ctx->start_page = range->pending_start_page;
+	op_ctx->last_page = range->pending_last_page;
+	op_ctx->pending_ops = range->pending_ops;
+
+	range->pending_start_page = ULONG_MAX;
+	range->pending_last_page = 0;
+	range->pending_ops = AMDGPU_SVM_RANGE_OP_NONE;
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_range_put_if_dequeued() - Finish processing a dequeued range
+ * @svm: The SVM context.
+ * @range: The range previously moved to PROCESSING.
+ *
+ * Called after a PROCESSING range has been handled. If new UNMAP work was
+ * enqueued while it was being processed, re-queue it on the GC list and kick
+ * the worker again; otherwise return it to NOT_QUEUED and drop the reference
+ * taken at enqueue time.
+ */
+void
+amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range)
+{
+	bool release_kref = false;
+	bool queue_gc = false;
+
+	spin_lock(&svm->work_lock);
+
+	if (range->queue_state != AMDGPU_SVM_RANGE_PROCESSING) {
+		spin_unlock(&svm->work_lock);
+		return;
+	}
+
+	if (range->pending_ops & AMDGPU_SVM_RANGE_OP_UNMAP) {
+		list_add_tail(&range->work_node, &svm->gc.list);
+		range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
+		queue_gc = true;
+	} else {
+		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
+		release_kref = true;
+	}
+
+	spin_unlock(&svm->work_lock);
+
+	if (queue_gc)
+		queue_work(svm->gc.wq, &svm->gc.work);
+	if (release_kref)
+		drm_gpusvm_range_put(&range->base);
+}
+
+void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
+					struct amdgpu_svm_range *range)
+{
+	bool put = false;
+
+	amdgpu_svm_assert_locked(svm);
+
+	spin_lock(&svm->work_lock);
+	if (range->queue_state == AMDGPU_SVM_RANGE_IN_GC) {
+		list_del_init(&range->work_node);
+		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
+		range->pending_ops = AMDGPU_SVM_RANGE_OP_NONE;
+		put = true;
+	}
+	spin_unlock(&svm->work_lock);
+
+	if (put)
+		drm_gpusvm_range_put(&range->base);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index e5a5f52166576..f423be277a85a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -149,6 +149,16 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 				    bool read_only,
 				    bool intr, bool wait,
 				    bool flush_tlb);
+bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
+				     struct list_head *work_list,
+				     struct amdgpu_svm_range_op_ctx *op_ctx);
+void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range);
+void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
+					struct amdgpu_svm_range *range);
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
+			     struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx);
 int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 			       const struct amdgpu_svm_attrs *attrs,
 			       unsigned long start, unsigned long end);
@@ -165,5 +175,11 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
 			       struct drm_gpusvm_range *range,
 			       struct drm_gpusvm_ctx *ctx);
+bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
+					   struct drm_gpusvm_range *range,
+					   const struct mmu_notifier_range *mmu_range);
+int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
+					 unsigned long start_page,
+					 unsigned long last_page);
 
 #endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.53.0

