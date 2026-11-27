Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD34606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nRxPIff5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BDF112874;
	Fri, 27 Nov 2026 08:42:51 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C74511285D;
 Fri, 27 Nov 2026 08:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu2Lsv2CP0cjqiLoZSf8OZ5AR6HCCv+X0FI6I1Skfejw0BNUkVddR5JaKkPD7q8mO0KzTIhxiiwilPb+/OfoFRseuesVFtuYcgWhJTIdpC1gOkdgZNy4q5V+WCZNqkpE016RSyBJ9ft1zv1V2AjtLk0tNtSl1W4sLG+HnilKxTsazQHrlKZRDuz9gk8aFfW6I1xzUJLGwdkXtIvbxvsY+ox+ZGY5e3ySPDvp0vpIoeaewBwvEQsYOOEpSBgp1oYqdIyGBWO9A4+6LdQsVdWqu3u7VF4kMYAYoAFGY9NcGB6z4AQCsLE+8Cqa6Gq1Zjduxu85+fupvH3Rs3WdyCS/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydZ1iBTrf8Rr7+xzjJB8t2LRCRKS1YdRenhlf4cMLzo=;
 b=h7aDFzUIZHeTd36/Dx3eZCFWqm9n+z8pBFJIFnItKr9mPlyyXThzo5lDqD/M3gDdY9ydVL8Xfr4sZ90sRN/kMDTJtn7tXQZ76xTPzIbsEqC+i7IEj/RZSKR/IL+AJYiMKuee6/fLGlvMzIw8W0l3guMMmNO0dnTa5LW0B69B/P3i5JYa8tlPSQZpoWQMyRiwxVgqYu/ZfLGYINr3L/n1xuWbvcMxE9v/l32Z356eUJLb7IcpL1P9JmzMG3YC8MhPORrEpFjUslSyWD+3FzA5kgol/e4ZjU5AkbGMwXxcU+PyKpuPIgYWmL2nlF+ks2/J8h/jS+SmkqhIQkx3CxiT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydZ1iBTrf8Rr7+xzjJB8t2LRCRKS1YdRenhlf4cMLzo=;
 b=nRxPIff5MGXHrLt0PbZ89Uvwh1agVsSP/GtTtrj7WgIuwlYHmyNrbITaVOThMfaIuGZphxT60AggFNtoRvJDEhdOgnOexNrkLfryDe3ARwCYr6ClzUYyfYSeR/MLGIn4QRqVgv5TSMV/bIQmwPtwE1QzG9Qtw/u1TYtUnHq9Vyc=
Received: from CH0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:610:b3::33)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:42:30 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::72) by CH0PR03CA0058.outlook.office365.com
 (2603:10b6:610:b3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 08:42:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:30 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:25 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v11 08/22] drm/amdgpu: implement SVM range notifier and GC
 helpers
Date: Fri, 27 Nov 2026 16:41:31 +0800
Message-ID: <20261127084149.925625-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd91f27-cf4c-4a98-1e52-08df4c625fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|921020|261102123227099003|56012099006|11063799006|5023799004|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|10067099003|261021123027099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003|22082099003|261009220027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: TYXw1dSl60Kj7n4Y7uK1DxiyMHhQyZxFqGnMq/8A5ESeyIEWYot1DlLjD5EtLwev4/u7m+9NOf9FPSVjyWAGYtQ+IooVLSkDao2VqMCmTze3ZH5vIWkyJsgnqPR0Ps0BAvjA947qYl3CqyICbwJLAMoS4hlivM0wMzknIq2CAPbN2VgX1qnYZ5GAIHaSS4YzL79a2RV6qMOdLATQRMgM16w8JR1urF5BhXKewRPyGWfmOcfEDUlJZ2gXWLrUA1oyBNcHX2EUJseeq8Jp8rz0xuakOmqB4MVQ+xgY0tksd/3PFVwhCTjN3ml9kO/7UAob8P66m6IKbD3OyV2b5OeCeiz0pmeIPk1kSAPSWdZzVVMxJG4P4srcKJdRN6oInPrIXvEc4zEDNbjheYZJQegMid44yViDzaDpTbE4kj8Ttqy5QzvYeaBng+PKXPjllH66YbWWiX4glscozdYAAphbti15pBLizn2ACvX25wE3/KMsbGRK4Xkl+G9089KPYaeZXS0Aagn1RpgvHs1M0ap+SczwEjyBJyp4cSXcItv1kS+09Elop29S/11wa2tPTmSPThkXgGlvfJrC4v2SYeCU462PwJvzK4ycn9Kgw7KHH6eLvIWKCvOUYTMlKdOLvGvqtAu8a91CIqcD/aPyb53Deq2Haln1lYAb1ryxxOVzWHYOtmNY6DSYFKQ8ToEQKUdvUlR0LUqLdw3dnH2XmyptUL+5IrZZa8ZkZfojg5CHuAYHvL7C5p4XVo/CoYXCVCUT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(921020)(261102123227099003)(56012099006)(11063799006)(5023799004)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003)(22082099003)(261009220027099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QgviJFJpSfIp4/dEtVZ9pAojBJBIV/E0ktye5MXpZFooO2n5b8UmmrX8nPKAS/1EY4G5A5jljtWlKrE0luO3zV69Hf+heShZps1Fy3chraoBHlVLnmrzv5Bb9C5AR0FbLljIb4kxpHrTTP2JS4AU48v6oOzoDIi+9lWM0BJfjWFRL//iZxt0ltSFiCWlv7LFB2/X5X2RzqLxBcxxSuYCOQ2fMZPxEfiIhmXIxdYtliTO/BgGuAVP9MQr1nLC/5SJ5wGGQR6NAoqpE0bjVS9PMuPGxL7h0Mm29Vw6/K1Njrpt9+Aui9kN4IywFg8+FSwMlEvug91IzwemgbNJhX9wjYUQ83YaRhQcR56RHpWsro+aOTbHurEaEWMrVlXx0IJ8Wij/SuooX5UyaWiE9sJ8528wPBshRzoU5/80kj7YiGYdQJipdVXpQCwt4wOtFSVt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:30.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd91f27-cf4c-4a98-1e52-08df4c625fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Add MMU notifier event handling and garbage collection infrastructure:
- remove invalidated ranges from gpusvm
- zap complete ranges before invalidating their DMA mappings
- queue unmapped ranges for deferred garbage collection
- serialize GC queue state and range references
- drain queued GC before changing each attribute segment
- reject ranges already marked unmapped during lookup

The last two steps prevent attribute updates and prefetch mapping from
reusing a stale range that has been marked unmapped but has not yet been
removed from the gpusvm tree.

The notifier releases DMA mappings for the complete GPUSVM range. Zapping
only the notifier intersection would leave valid GPU PTEs referencing
unmapped DMA addresses, so invalidate the complete GPU mapping first.

On attribute changes, discard cached DMA mappings even when the
range survives. Complete the compute TLB flush before releasing
mappings, and propagate failures. Clearing GPU_RO must obtain
write-qualified pages for COW rather than reuse a read-only cache.

Invalidate the AMDGPU-owned page cache with the generic pages API.
Keep unmap state on the GPUSVM range and pass its device-owned cache
to drm_gpusvm_range_set_unmapped().

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 323 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  10 +
 3 files changed, 339 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 0db96a4700666..70a3db7c830cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -556,6 +556,12 @@ static int amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
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
index 405284f80734c..3b6db15bae680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -36,6 +36,15 @@
 #include <linux/mmu_notifier.h>
 #include <uapi/linux/kfd_ioctl.h>
 
+static void amdgpu_svm_range_unmap_pages(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
+					 const struct drm_gpusvm_ctx *ctx)
+{
+	unsigned long npages = (drm_gpusvm_range_end(range) - drm_gpusvm_range_start(range)) >>
+			       PAGE_SHIFT;
+
+	drm_gpusvm_unmap_pages(&svm->gpusvm, &to_amdgpu_svm_range(range)->pages, npages, ctx);
+}
+
 bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
 {
 	struct drm_gpusvm_range *base = &range->base;
@@ -152,6 +161,7 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 				unsigned long gpuva_start, unsigned long gpuva_end,
 				struct drm_gpusvm_ctx *ctx)
 {
+	struct drm_gpusvm_range_flags flags;
 	struct drm_gpusvm_range *r;
 
 retry:
@@ -169,6 +179,10 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 	if (IS_ERR(r))
 		return ERR_CAST(r);
 
+	flags.__flags = READ_ONCE(r->flags.__flags);
+	if (flags.unmapped)
+		return ERR_PTR(-EAGAIN);
+
 	return to_amdgpu_svm_range(r);
 }
 
@@ -336,3 +350,312 @@ int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_a
 
 	return 0;
 }
+
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	amdgpu_svm_assert_locked(svm);
+
+	if (!base->flags.unmapped && !base->flags.partial_unmap)
+		amdgpu_svm_range_unmap_pages(svm, base, ctx);
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
+ * Invalidate the entire GPU mapping before the event-end phase releases
+ * the range's DMA mappings. The event-end phase queues unmapped ranges
+ * for structural removal by the garbage collector.
+ *
+ * Return: true if PTEs were zapped, false otherwise.
+ */
+bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
+					   const struct mmu_notifier_range *mmu_range)
+{
+	struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+	unsigned long start_page, last_page;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "NOTIFIER");
+
+	if (range->flags.unmapped || !svm_range->gpu_mapped)
+		return false;
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "NOTIFIER - EXECUTE");
+
+	start_page = drm_gpusvm_range_start(range) >> PAGE_SHIFT;
+	last_page = (drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1;
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
+static void amdgpu_svm_gc_enqueue(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+				  unsigned long start_page, unsigned long last_page)
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
+static void amdgpu_svm_gc_add_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *svm_range,
+				    const struct mmu_notifier_range *mmu_range)
+{
+	unsigned long start_page =
+		max(drm_gpusvm_range_start(&svm_range->base), mmu_range->start) >> PAGE_SHIFT;
+	unsigned long last_page =
+		(min(drm_gpusvm_range_end(&svm_range->base), mmu_range->end) >> PAGE_SHIFT) - 1;
+
+	AMDGPU_SVM_RANGE_TRACE(svm_range, "GARBAGE COLLECTOR ADD");
+
+	drm_gpusvm_range_set_unmapped(&svm_range->base, &svm_range->pages, 1, mmu_range);
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
+amdgpu_svm_range_notifier_event_end(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
+				    const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_ctx ctx = {
+		.in_notifier = true,
+	};
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	amdgpu_svm_range_unmap_pages(svm, range, &ctx);
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_gc_add_range(svm, to_amdgpu_svm_range(range), mmu_range);
+}
+
+int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm, unsigned long start_page,
+					 unsigned long last_page)
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
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES | DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(svm->vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (ret) {
+			drm_exec_fini(&exec);
+			return ret;
+		}
+	}
+
+	drm_gpusvm_for_each_notifier_safe(notifier, next_notifier, &svm->gpusvm, start, end) {
+		struct drm_gpusvm_range *range, *next_range;
+
+		drm_gpusvm_for_each_range_safe(range, next_range, notifier, start, end) {
+			struct amdgpu_svm_range *svm_range = to_amdgpu_svm_range(range);
+			bool crosses_boundary = start > drm_gpusvm_range_start(range) ||
+						end < drm_gpusvm_range_end(range);
+
+			if (svm_range->gpu_mapped) {
+				AMDGPU_SVM_RANGE_TRACE(svm_range, crosses_boundary ?
+									  "ATTR DESTROY" :
+									  "ATTR ZAP PTE");
+
+				ret = amdgpu_svm_range_zap_ptes(svm, svm_range,
+								drm_gpusvm_range_start(range) >>
+									PAGE_SHIFT,
+								(drm_gpusvm_range_end(range) >>
+								 PAGE_SHIFT) -
+									1);
+				if (!ret)
+					ret = amdgpu_svm_flush_tlb(svm);
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
+			} else {
+				/*
+				 * The range survives, but its cached DMA mappings
+				 * may no longer match the attributes. Clearing
+				 * GPU_RO must not reuse a DMA_TO_DEVICE mapping
+				 * and bypass the HMM write fault needed for COW.
+				 * Drop the cache so get_pages() refaults and
+				 * remaps pages with the updated permissions.
+				 */
+				amdgpu_svm_range_unmap_pages(svm, range, &ctx);
+			}
+		}
+	}
+
+	drm_exec_fini(&exec);
+
+	pr_debug("attr invalidate done [0x%lx-0x%lx]-0x%lx needs_flush=%d\n", start_page, last_page,
+		 last_page - start_page + 1, needs_flush ? 1 : 0);
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
+bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm, struct list_head *work_list,
+				     struct amdgpu_svm_range_op_ctx *op_ctx)
+{
+	struct amdgpu_svm_range *range;
+
+	lockdep_assert_held(&svm->work_lock);
+
+	range = list_first_entry_or_null(work_list, struct amdgpu_svm_range, work_node);
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
+void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
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
+void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
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
index 641e1dee9e500..82ec0c769d25b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -139,6 +139,12 @@ int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm, struct amdgpu_svm_
 int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
 				    const struct amdgpu_svm_attrs *attrs, bool read_only, bool intr,
 				    bool wait, bool flush_tlb);
+bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm, struct list_head *work_list,
+				     struct amdgpu_svm_range_op_ctx *op_ctx);
+void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm, struct amdgpu_svm_range *range);
+void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm, struct amdgpu_svm_range *range);
+void amdgpu_svm_range_remove(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
+			     struct drm_gpusvm_ctx *ctx);
 int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_attrs *attrs,
 			       unsigned long start, unsigned long end);
 int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm, struct amdgpu_svm_range *range,
@@ -150,5 +156,9 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 				struct drm_gpusvm_ctx *ctx);
 int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
 			       struct drm_gpusvm_ctx *ctx);
+bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
+					   const struct mmu_notifier_range *mmu_range);
+int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm, unsigned long start_page,
+					 unsigned long last_page);
 
 #endif /* __AMDGPU_SVM_RANGE_H__ */
-- 
2.53.0

