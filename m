Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFC606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N8RtxCQM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE33112862;
	Fri, 27 Nov 2026 08:42:45 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5445112862;
 Fri, 27 Nov 2026 08:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swTxYM3iJ29ZX2jNYanUj4mUcISj/ApZqYT65bsMVACYo+3y1NBir1q3BazqGLJ+XOxr0GdtLxihB481/eNhXF3u22Ro7bge7EmYZQyl3VQQNfiOqt+vVGKQXaPNUoJjdey+G733067mQakcGJtWm+ikZNHD+9JAtjNvOpNXH5IVWCeDCKZ7o1VcTx7xPiCnzSBr3KNHN0wG05dK3Z8ug68+9fRbm6sQ+Jgzy58FbW1kwSpe7+nXnYUXbCaKmzkDHqA2B5G8ctvKBcH0xwWvYxl7+X+gWNSWSD2bUjeeiL9x3WVBf4XRcgdp8V4wb05cJhN1q5O8PlKTXsQnJu0FIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOek5tWgyBTHg/HHlevJWZ71C0SHmgVGjarVKMzZiW8=;
 b=gjlyN0n5GuTy+dGOk5Hpr3E3P+ZOzfS5g5H+tZmTx4bsY5cw0lFhBAIq2FOQZdj/oXnOUD7BS6KHci39bC5f+u2mtTzOzVD10WGQjlSPlegkrPLLWaH3S9e5EVc7T+m9Ufh0FANX5Ob3Rzrv1HpOOsTAPLC7l4EWeUwG8pboP4Hz8CbgaO3ZL08OsR/CTahTVr1kDIkNXlYfpw+c0le8SAHmqjZ5oxZeQK6L4swHAWiWyr4T7W6pXa2NgBhDMUCWdS62vhs87x2415kIWIg4pL7PZag83h4194d1NIZredOmyeYaCQN0l5ntmyVIi0U8OFSGOk2ZdDM+h/GwYIdaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOek5tWgyBTHg/HHlevJWZ71C0SHmgVGjarVKMzZiW8=;
 b=N8RtxCQMKN8IDlX0hsME7MXgU9Uq3Vvtm/0EYrY+Q7Qpb19nmG1bm7p3vvCL5jdPiV8KUg5mK+5hAS85Bqd7eUq2bSNrvx8xiEHINObIDg8iD5XBvjup/ewKyim98Gf3m4RNJQZQzIRrmB6JiMOHTWsWyUFAMBsgMZXJDT5zC0Q=
Received: from CH0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:610:119::7)
 by MW9PR12MB999210.namprd12.prod.outlook.com (2603:10b6:303:301::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:42:36 +0000
Received: from CH2PEPF000166BB.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::3) by CH0PR03CA0373.outlook.office365.com
 (2603:10b6:610:119::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Fri, 27
 Nov 2026 08:42:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BB.mail.protection.outlook.com (10.167.252.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:30 -0600
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
Subject: [PATCH v11 09/22] drm/amdgpu: add SVM notifier invalidate callback
Date: Fri, 27 Nov 2026 16:41:32 +0800
Message-ID: <20261127084149.925625-10-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BB:EE_|MW9PR12MB999210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1aae54-cda2-4046-ac33-08df4c6262c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|261009223027099003|22082099003|18002099003|921020|10067099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: xoYHbCIJYBjBUg7VJI7fb/mzv8a43VokottexnHWmEPoDX0060MVEiGVkKV7wNX0Gjr+fSTiyhGV2YpKRncK1wRocp5T7a2MQ4FmMRySwKughgXx5anPklCWyCEEE30kliLcjA4bc3vfDvTu49e4b339b9skLvdII6So8PKD/jlyoKvY8HZd6caeLQcgTOAcocTm5XlIELGU1C6qc1rLUnezLxu5bDtmIphAv8+l2U20PJHrcMHn2hZ4R/foVfUwix6lQS4hXyY9sW90ZG71d71CyETXmhnuM6XN/1TpaNcA/iXWIRhisMTPnA9+FRN6mVdgtizdW2pv8ZmQJmygmDH2L79BnXmOlxjNmbFMpRFzr+DTKbQXwlCImkhcVUtjg4gPs69K7GzMaMdbNJ1vIRSCxDKk0XcpUF6jOHor0OdAm0KGpLZScJiTnvTgjm/L/cBn7tSqTChxyRsJx53MSPdTWxKUQXVeq/VruMUmNkDQovJLRJQnU4bn/MDI8wlXTfsMLyEhGpcuKeKqHYnx5d92mCoUlK0M+wPwgbxZTwPIk43MU3chfLoZziumhBkdcl6cw/vAjt3qpVcnFxW9digfnxKi/7jliibOqyrqoGy7HygHXdI+G/waepERbFbbFN0tjyGlRP6/vZ2XQb4a1LcbXsW+7cHNweaePjZLqhZm/yllHjqy3WBHv2Uxx760X8ltsaHUyDOEvMxy0e7czQUVsfZT4Vlzw7U/MtyPs8DEl07yCFDR0aFiS5+3wsvE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(261009223027099003)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHxVUlPkuh8LKxXb99PYEcRXXEIFxGlghhQrl5jWuFNchL2dceAzlosRHufSfWt66vMBHlb1xvnP8BtEmKae2nn0KDlKn/cOC/f8l1J3wdAYGAndjFGpjRsNKYzlSwYILK05/zv9x9kGoEjbP4Dvu8MUMk4DU6TF7/O03C7JUvatnFWqaYmJFednxzZdL7kaQUQXHmbxM5wXTa3tJotC8as5l+0E9zWSlF/zkV/4vScI02wSmd06jc9pWuiK9DobHLweOSjx1Ba2TixleqIRm0yOgR/otGsWLatGHuS6EuXw039s5D/btmjAMVZq/I+N8cbtlTCWt+f6uQb/GNR7GW5zb/GiYnQwhEAqRje84aTbpNG5DU/TXbfwPllDHGOiNLkiyPjOs0F3HQatbZwapUX4jkbyjl+nW4CaAYlb7TMbu3sqWQBazcURIEN2rHlQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:35.6982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1aae54-cda2-4046-ac33-08df4c6262c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999210
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Handle invalidation in two phases: zap affected GPU mappings and flush
translations before releasing their DMA mappings and queuing garbage
collection. Do not use an IH timestamp checkpoint to classify retry
faults: hardware timestamps can reset with GFXOFF and differ by engine.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  3 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 3b6db15bae680..f201105e94c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -659,3 +659,34 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm, struct amdgpu_svm_range *r
 	if (put)
 		drm_gpusvm_range_put(&range->base);
 }
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
+ * the end phase.
+ */
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm, struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first, u64 adj_start, u64 adj_end)
+{
+	struct drm_gpusvm_range *r;
+	bool needs_flush = false;
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r, mmu_range);
+	if (needs_flush)
+		amdgpu_svm_flush_tlb(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		amdgpu_svm_range_notifier_event_end(svm, r, mmu_range);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 82ec0c769d25b..3de80ffe88e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -156,6 +156,9 @@ amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
 				struct drm_gpusvm_ctx *ctx);
 int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
 			       struct drm_gpusvm_ctx *ctx);
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm, struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct drm_gpusvm_range *first, u64 adj_start, u64 adj_end);
 bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm, struct drm_gpusvm_range *range,
 					   const struct mmu_notifier_range *mmu_range);
 int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm, unsigned long start_page,
-- 
2.53.0

