Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA224CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A54B10F3A6;
	Fri,  8 May 2026 07:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FvbTE7bt";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E7E10F3A6;
 Fri,  8 May 2026 07:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z45zey5xBL9MJ4tIinBjLsad8sfEB1uBypXHqQPwg+fmCQ/e4lIbi14jBGusiMCnIeMrtSyR1Olg4DuNglVHhw58QycqEyCoYqwAnBTxJkuHlPscqbSPnrNYx50Zu3Q7Is4JAc4a34eNnYPQXzyMDAlJE0Ex/Z61YGLc/vv716oIy9Q68bMsCuxMKUDNqChu3K2kdNL/houP4dfPtT5JQRR6zRTN7cZkavOfVZYGdfyo1MusnvrUEQsvGnNZBr6T32fhV+kSNmd9irv/jZckqdXZTNg3zE+QldCFhcHAYx5mxhsw+ITdbQZxH9n0TjHrqhVftjkuhorFx0kWMAstQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy0oufT5aZAtbhXNAQa9gkCwuygRMxSVbkX1LHYInq8=;
 b=fpgjZf1fF/+lCjtl8zi/rdjrCn1rte8IZdgsh6aM1nJsR5lM0/0Iohw7m9ygDHBaiRB25usVL1yb/MADHCEoUKQ6TSpc7dwcPz1/NjUB3WVmgI/eZPIH0Kig/lmq7oUIn778f2P+fykgTkjKeMEkaRmLzuAic+2aABf7INYV/RExfqzW8Mk3fE6Tb2gqRot8lrj12ZF02VWk6IQXEoJ+KXK4MTJa1nWzVfM5dlFklQ6vFTq5nNaIReE76ZdRzNam0gMTmqr+UqAbeOLxI6y6eBNTvSrufnkO4f7NLs+XAEcG70KTMZMMNBHqdNY3vGpf79N943WOhfNyLa5wdRwbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy0oufT5aZAtbhXNAQa9gkCwuygRMxSVbkX1LHYInq8=;
 b=FvbTE7btjvxOoys9n1yVSt5cbZjuiupTEedhCIXSUutP2ngpFay7Iihav3H+bQCgOyw0yC3qa9do2Ft/UK36Hjty9/gq49/duoqjzGM6nVRG+gyEf4WQCCroJwTRd2eSGWOGa3LhBdXLHWkyH5k1n4vLN8VPD7UbGFPNHCzyl/U=
Received: from MN2PR13CA0031.namprd13.prod.outlook.com (2603:10b6:208:160::44)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:52:29 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::c8) by MN2PR13CA0031.outlook.office365.com
 (2603:10b6:208:160::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Fri, 8
 May 2026 07:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:28 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:52:24 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 09/12] drm/amdgpu: add SVM notifier invalidate callback and
 checkpoint
Date: Fri, 8 May 2026 15:51:26 +0800
Message-ID: <20260508075129.1161157-10-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508075129.1161157-1-honglei1.huang@amd.com>
References: <20260508075129.1161157-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 533e1fad-3578-481c-d54a-08deacd6c0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7VAyPFqG7FjYLfXpTrKKferqVxyi8sj0JVZP2HQw/oyHRqC2RZq89RvJej61dxn6SRn0QqKGflZQzqBtimlWPoufiTIIRPWVssUamhSlRXpy5SOaJIF+6cHPsbSrMJKuglV6dIfczCcgxzjG0180W/zrMFcB5xydeJ0PY0qovlE49DmuxKC5mJrElxRpAO9xGNGZWHDHI1DV3JNXz9d2okiD2KtVI1jrKUFzY7V9ek6xqAaF28rk/3PFXDnNXEFK66olUIZHFkyjM7Xyt468ZFlkYseXPEh0lcWTmMxRKtdZESyzmKDloB9jQPfjCfe+brTjcvP+RTfNAfWkf7liGnCtRkK0kd9dpEwYp7KkyOV2okAVWoZ9vLpnuzF9JNgggymXPhM59CEYXccylPuyFjl56YySTTVwI0aH9gVFsGz7X1z7SUaQUK7jH8b+dR6+uVGqCXjGhWcTFoqRtu0qZDvOP1oFmfPVoias51wIFNg2o4MDVqGi0u6dn3e5naOVQ1Cl0rMBpmR1bKl4id/eCRQh18ZiFuJq4gmdEdbh1Z/ShEMHho4rpTShkqhpp2Xn2GsmJnpAIW+HKwaw1fXM3o+rhWWJADnOrudXBcWowSNKrtKqfe3u6xqynVwxDAvgno4SAu1N3CSuJg4SsFVuhCLDGsS9vqZKVlguZ30O8cEcJQvd1ImF9c1QKaadZ4/fxnNeErQpuqLHpEn28DJCeG+vOhkFeXuoq8IpUXN2HlvmVtWMI4asleoDo84sEGTWHu72iGj1m7h3tn1rsUPiKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iI42ZHyJmZuI4Rj45wDrMz5DLm994ffSS0lL/8se4qmkDSHWI2IGrIj198ALpPpMHV3Y6b0YEKg6Jw4MXhTW61FyWXMlYxQVe3NgILkbtMD60fCHA6LM8n7Pau1TV01uKn0C9GjEl1WKRoahfhaA2LeGj4Jdwds2BCOjP7TasXIb0drSkOVj37XnA5rw1LXhZd3fu3aJX4xSx+vsWs60mU3j4BqWV+HXcjxKcLLGux/O3Hzgwrwsnm4KyLGsIYXQsRjf8etolf+HiD45yhzVsPVeVMQoYTj5ncuQwZazW3g5NqIMdpHh26n41gKPPxJLv8ce6cJ8RlMm9ri2fmck/F0wqHeEisjqL7i0eqHDdEarRRSyOP1u+wGD4YpIw2/alCq2hWu5j0Ea44OXjR5i5r/zQRQvCZGIuyoVYWkhLc0h2m1RtdqCylNsxx686zVl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:28.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533e1fad-3578-481c-d54a-08deacd6c0ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

Add top-level MMU notifier callback and checkpoint timestamp:
- amdgpu_svm_capture_checkpoint_ts: capture interrupt handler write
  pointer timestamp for stale retry fault filtering
- amdgpu_svm_range_invalidate: top-level drm_gpusvm_ops.invalidate
  callback dispatching per-range notifier begin/end with TLB flush
  batching, MMU_NOTIFY_RELEASE filtering, and exiting-state check

These complete the invalidation path: attribute changes trigger
invalidate_interval, while MMU notifier events flow through this
callback to perform PTE zap, TLB flush, and GC queueing.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 49240c704..fe543a16b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -714,3 +714,74 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 	if (dequeue)
 		drm_gpusvm_range_put(&range->base);
 }
+
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
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_range *r, *first;
+	uint64_t adj_start = mmu_range->start, adj_end = mmu_range->end;
+	bool needs_flush = false;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	AMDGPU_SVM_TRACE("INVALIDATE: pasid=%u, gpusvm=%p, seqno=%lu, [0x%016lx-0x%016lx]-0x%lx, event=%d\n",
+			 svm->vm->pasid, &svm->gpusvm,
+			 notifier->notifier.invalidate_seq,
+			 mmu_range->start, mmu_range->end,
+			 mmu_range->end - mmu_range->start, mmu_range->event);
+
+	if (mmu_range->event == MMU_NOTIFY_RELEASE)
+		return;
+	if (atomic_read(&svm->exiting))
+		return;
+
+	adj_start = max(drm_gpusvm_notifier_start(notifier), adj_start);
+	adj_end = min(drm_gpusvm_notifier_end(notifier), adj_end);
+
+	first = drm_gpusvm_range_find(notifier, adj_start, adj_end);
+	if (!first)
+		return;
+
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
+								     mmu_range);
+	if (!needs_flush)
+		goto range_notifier_event_end;
+
+	svm->flush_tlb(svm);
+
+range_notifier_event_end:
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		amdgpu_svm_range_notifier_event_end(svm, r, mmu_range);
+}
-- 
2.34.1

