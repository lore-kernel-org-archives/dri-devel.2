Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A386606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OlTQcsBg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A36210F89C;
	Wed, 21 Oct 2026 03:00:37 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8066A10F892;
 Wed, 21 Oct 2026 03:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwPb24kPTtdWmDidxqhepbLb02XF37yptdj9lSN8optEsblig0ScpJHnE5oj81OZt7ER3FOXaZUScfHHsbdMN1o9pn+EFgx/w5jbw9bqzExqqrFMU8bpjWjhsXL1syFdPgiLugfsPLZTbQ7RIqo6hAq7FC5l7pmhmt6p126pRJDU5SkctbxMyKMP4MquAqfBuyZAZwt6bV6l7v92wq8IvhaAKOlQ3yC9rY+HlVwmqPAkQFw2lnkVJVEd0+wL6hNlDfQSqhA69/FhDKOZ9/j3mxoCfJfzC1IaK5deEvH1uN5MEiHgGp4pvRHpqGuAXIeL2p15Q+lzgr0f80JW85W7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiNNzPGddkDDWtD+8YKZY14pr2ksAlVPshXp6zMUCz0=;
 b=R9XzMwrhrwG5iCS7puB5JA/54qRKKIkNHH2FZE+Bbr0BJA+oxzsYe5g0OLPONxrIck8V1YRgtAhhthNGkbnQ9owKfkjtWT5qGVtj55A41BvrqK63ciiBqrRYxOeh8cuWqPQr5M+YhUpJKVUUumFFZz+s2UfHVOOgyD2HccLdQ59iLASp4owzElYJUXk7jiJ8DImyMqJZOfMJxfsfvUdBKV5GiKZQiM0PSLXntKfDcS6huv9PxAH2cTWnd4SvOdCwUP6834ri2sOCQUfv/SfkqBOWVNqYwDj43Pfyu4JcIaDDcPvLOBU1zTJBjiUu1Uj6UiVMLirz4NaJJch4mLQmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiNNzPGddkDDWtD+8YKZY14pr2ksAlVPshXp6zMUCz0=;
 b=OlTQcsBg+R5dGYISMI/1bQcmXHCwu+W4uYz58yKzxpL+Xx5uNjUGTkZqHkAjrWTtMxjTxDP5NmDt8OZwn19yrcXCW75MZSYDpCrQv6U1qtmOD7yyrs8g9CLE3MxBBK/gDBLfkWydu0Yg6SJC1ApyXhwQBK3k7yTDcjQ8qoqWUE4=
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 03:00:14 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::89) by SJ0PR03CA0281.outlook.office365.com
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
 2026 22:00:06 -0500
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
Subject: [PATCH v10 09/22] drm/amdgpu: add SVM notifier invalidate callback
 and checkpoint
Date: Wed, 21 Oct 2026 10:58:48 +0800
Message-ID: <20261021025915.2433837-10-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: abc244d9-673f-4498-e6aa-08df2f1f6c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2PGNcVG4gKDqmj8qxTDS5f+/uOVH2N/UG9Q3I/N21aBY26rB0E5362UB8dE3ROShcOaIvk7sltK5NUaRMElTiQ+8yoiD8nHPpD8rtjtwMheF4zyy/h2LcHKvLKAklaQLzTQs8kwr2csN+Zw5q1R00iVqTABlNwC5A/ypPeszrtxShfZfXWaR5ZhOI9/eRJ0R7p3tUK2Hn14zVk7tFmb3Uy3yS3jpw/kNId5qB9bkEyofVQv/nOLOMTOta3kgXs8ZZXOxztbgLxMHYXcPTKVlZXsOmLscRLOPGM+zdhuXyPJK1IalRe78081DLe2U5G1vud1LcZtDuxCfsqDdvWnaMuLKwMfcQqkvZDdKhfBkWy0lHq+h5W5NSc5wvy5xVMEfYnzgfHekUpyREto4NQ+zK2H+iA3foMRY6Gex1nDSpvjtoQUftjEzDVVuskhFPlKkQGR3zfzgtolwDo7H5wUVMR8gVpj7NMNs1PDftmzGqXLwrjoBxi25ugZgh94IqcS5jAFI8Rygl2uuhykF11B8SOoApXSMZSKBPoSX0ZSTMLlJDMLQh1xk6jMwZhkQw0+0vR+I6fE7fyY3EHY75Yeqhy0Xm/RPHIAJnmQtQpg5e2mRsRXaJ4PJohpfmUKp7+5JaF+ie37pD0Nw29I53VyG51THbghO9Jg1tZJwMeHi4vxOkVu2UJpNKaRHx8fKrF2wS2WiHTeavwsshxj2QOfXsL/317yuELG/ovulQzwmNKrzWryoNppsJotQsQgZn2R0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3m659dn7gHUDG0YDrrx6ELhOTPauayRGiJrX3bBELbkTaWiGQ3kXegQkxop0bRyAE7fzWdZGa1hh6fYdKT82K1xb07xIeJgYFv+KORiFzCrzEVKBjlNghXlDVVnHxVdvAg72aQ+itMcwgfW4lgZ/N+CxIC/aTFr4VX+pzarEOjY4kmnHHiWERqg4gYaUoPTrAY3S6h3AvAMdYT5Mi2wDHzF2N6F2uG8i6AwNUsQ91e8s6zOdkP4Jckv+pwskxOA+GGcFEdRaLpRwMBbFCuU8tGcY4yXak2+zS4OwqU63wNDxw/RYXlnwYWNh6GrAwmHcH7ekc2a2TAeoaT1Y/ONwW53w+CH62W0D2bMEKeqBA4F+YG+6YhLhCc5o4mSZaw0St8OvqDUTvQIus82YqfTMLDxMr6y/DR3Ko1p/3KE1XL7jViSriaKT1zaahSk2Np8D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:11.8983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc244d9-673f-4498-e6aa-08df2f1f6c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

Add invalidate_ranges callback and checkpoint timestamp:
- amdgpu_svm_capture_checkpoint_ts: capture interrupt handler write
  pointer timestamp for stale retry fault filtering
- amdgpu_svm_range_invalidate: invalidate_ranges callback dispatching
  per range notifier begin/end with TLB flush batching, checkpoint
  timestamp capture on MMU_NOTIFY_UNMAP events

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  6 ++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index b907f516cdbe6..62c78c3ce6762 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -730,3 +730,74 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
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

