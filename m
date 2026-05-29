Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FF2CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7449E10F903;
	Fri, 29 May 2026 05:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Og9Ep07v";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8DB10F909;
 Fri, 29 May 2026 05:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECeJhLyMNGbpZsupAs1i2EmSLbEgSxjqHfWZNzTMrtIpteviURt98wJ7m65GvtGpfo/aDkpj0cabyZdH8U/itI5DtJW8o0tAejDybeKCtD1pcgoebrFw+Oh+fSB3LoZrEm3SB5hoe1g8jkAchO7O0hwpzuKISYAhMm6TKKOLx0MR67HQAX9+lLtKjMQJPzvYkhOnBN4ygRVp3KbqqzcnYHoQy4fwgSKvwBQj133fxM0ZR2NqaCLhAgIiKPcpk0hzGmETgAzqgPDaHj7DSNLf8/X2RIGz3HFGzmtFn3IaGX/zcOVvUvgWEakvz27CEfHQBLJKlnk0McFkweBpcv6NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96pX1/4jAiwCM/GQFHii+YngN6QLnLI7p4EqD688VME=;
 b=V+5Lwq87MbZNdzAa0TMGGEwd3HdawjfshE42GEtDVrShuMceE0F4znNiX4qhRzijRNqSkb3rVOBB0RxFWpfH9zG16s2OXDswUeTtMqZ8ak6wZw7FNT17U88MRBWCO/pOPiD7D2kSXmZvKl12sYfgb8cDlF8yx3Pq1cSgkl890SeeJbMfJqqZd//j0a/rOJtA3ieY3aUlwqx4uSfhBLqwWYA4NGhKHgzimmlEYk+5dVKyg5pTVteEntGgXdR5v4o1jtHr08sbMPhy2qOzQQoPt7gL047UTxTbbZcnvmdf6bNLsuv4NOmdZr09ZPgWdbFuc7NQv8UOcQM4WULvPUwnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96pX1/4jAiwCM/GQFHii+YngN6QLnLI7p4EqD688VME=;
 b=Og9Ep07vRpRHomGqnZ+Kp9FxhNuyWtNWUm7ljLMj0PD5S0B+sVemrHd+W10RXGclfobeqF9LoYqeLw2EDLxY6opeIXRfcaQoV8dfi8JIEm0+jwkEOuBzsTzWQovLR0GAjm0y9oOpWKlRW2z2TcB3pcFfWZ3DxpD8RcliV7akqVA=
Received: from CH0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:610:74::21)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 05:50:05 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::7c) by CH0PR04CA0076.outlook.office365.com
 (2603:10b6:610:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:50:05 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:58 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 4/8] drm/amdgpu: implement xnack-off restore worker
Date: Fri, 29 May 2026 13:49:24 +0800
Message-ID: <20260529054928.596825-5-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 76257638-e6d0-4629-1ff5-08debd462255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|6133799003|921020|5023799004|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: /E5YwCe4PdNYQswLtbSIUFo600LKYKOfLQOa+ZGZ2j0K7vEYBs66JUkoBz7sWaYEPwOIIlwjlKV9J4vEV87HyMN9IvkChjCrmLylqTPOuUqZDZSbYkLxSO1Z3ycvb4rdY3uqbtZL50Vc2B5yxzMnD5zi7BnfTxRANSu8H2g+jxRlEhYGdncTW5tJUySHlUnNYgbergdiAj+K6CbuQ5ZrWq7N2MM+CLLIZj6JDOU41WSzohq0BhMLzyfXorLiP86wB6rigk1OTPYUXdlYTwSr4x6zFSMI0qBof05l4kBw8AUMBE+k9mzC/cB8T8uhPB1MzZyO0EzvNaJxR2eFrN6m7Jk/R6MFn9/hynyBEtvuv2u1cID702qUihfWVfuLoKg00rHaBc5uyRd4lErcQLMlQ3efvD0krBNtAA60TQqhrnkl0GnMeaDQUSxc7JvySdgq0iFGcPW8lrEG3qiYsX+puw8iFmdpQN4ZI7T4DwkfNggUjVm8fneLhRz0sOS463BlaBgCv9aKpXcH5asUYlWjrHolr0onWM3Iv6CLsjEvMXiP8ARtpocepBJmBm1rtDHlaGgbgEsznSgJG6VIbXqEw+1vRWnf+tM673FJnutIr9Y8UzY/KsvjaTl9dGhhPOZc++QcHWn+BV99Mcw8TugVSpp50/UTLHFv35Wu71I0NHXEKvLsyquNX3jH00Vb2z1YUqcbx31wP5hDOWxXQYAZXncPEbTtW0KyGmHhyELpIzl0E82vfJhAp4NDocw96BquQXrwaU7bXQi+QAB7TlAnPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(921020)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HEPPNsz6ECn7734K/gI4DTZa7PcWv6c5rOzx8h60nz5L/kFgmukzKmOMZw6gTrrXLdjsZkSwUu19uqccpsjVFTNCoXLRYWv3ZpjyhCUXwYRWYyAG2/1O0mD0YzL8f9LZfgCzuiv2CEJnbs9e/yrPezQHr5cWl8ET30P4kfy2s/sPP4K5ecNl6pS0cr2SdldVusg4kdAt1FJ9DmnaDOeh2Q9SysPc5rGyLGMW7jGw1PjPT+w366qJCzxcg0l7MhnuB99jgRyw9E0e6/W+3F1fmU4+58uNeqvIg7yzvRg2872KD45CubjAgjYlMI/ei5kX6i5mwmEOrrT78K3QOTNgsorHaUwlOJpZ9RJl+IzfTPEtD6BlnfYytYk/ms19EMPMkzaxkkEn2DRTaCx2Ja9OguuwFkkAcd1yCGxjrsXsL5/Eu/euhloKhtwlxnQUBj/v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:50:05.4268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76257638-e6d0-4629-1ff5-08debd462255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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

Add delayed restore worker for xnack-off range restoration:
- svm_restore_range: restore single range by looking up attributes
  and updating GPU mappings.  Uses the per-segment PTE-flag pipeline:
  amdgpu_svm_range_is_valid() and amdgpu_svm_range_update_mapping()
  consume the attribute set plus the read_only flag directly, so no
  pte_flags is pre-computed here.
- amdgpu_svm_restore_worker: main delayed work loop that dequeues
  ranges from restore list, attempts restoration, handles retries
  with re-enqueue on failure, checks for completion to invoke end
  callback when all evictions are resolved

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 169 ++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index b231c7d44..a76c0401e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -222,6 +222,175 @@ svm_restore_enqueue_work(struct amdgpu_svm *svm,
 				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 }
 
+static int
+svm_restore_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
+{
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	struct amdgpu_svm_attr_range *attr_range;
+	struct amdgpu_svm_attrs attrs;
+	unsigned long range_start_page;
+	int ret;
+	struct drm_gpusvm_ctx map_ctx;
+	bool devmem_possible, need_vram_migration;
+
+	amdgpu_svm_assert_locked(svm);
+
+	range_start_page = drm_gpusvm_range_start(&range->base) >> PAGE_SHIFT;
+
+	mutex_lock(&attr_tree->lock);
+	attr_range = amdgpu_svm_attr_find_locked(attr_tree, range_start_page);
+	if (attr_range)
+		attrs = attr_range->attrs;
+	mutex_unlock(&attr_tree->lock);
+
+	if (!attr_range || !amdgpu_svm_attr_has_access(attrs.access))
+		return 0;
+
+	devmem_possible = amdgpu_svm_attr_devmem_possible(svm, &attrs);
+	need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, &attrs);
+	devmem_possible = false; /* TODO: add migration */
+	map_ctx = (struct drm_gpusvm_ctx){
+		.read_only = !!(attrs.flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	if (amdgpu_svm_range_is_valid(svm, range, &attrs))
+		return 0;
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "RESTORE - GET PAGES");
+
+	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
+	if (ret)
+		return ret;
+
+	AMDGPU_SVM_RANGE_DEBUG(range, "RESTORE - UPDATE MAPPING");
+
+	ret = amdgpu_svm_range_update_mapping(svm, range, &attrs,
+					      map_ctx.read_only,
+					      true, true, true);
+	return ret;
+}
+
+static bool amdgpu_svm_nonretryable(int ret)
+{
+	switch (ret) {
+	case -ENOENT:
+	case -EFAULT:
+	case -EPERM:
+	case -EINVAL:
+	case -EHWPOISON:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void amdgpu_svm_restore_worker(struct work_struct *w)
+{
+	struct delayed_work *dwork = to_delayed_work(w);
+	struct amdgpu_svm_restore *rst = container_of(dwork, struct amdgpu_svm_restore, work);
+	struct amdgpu_svm *svm = container_of(rst, struct amdgpu_svm, restore);
+	unsigned long resched_delay =
+		max_t(unsigned long, 1,
+		      msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+	struct amdgpu_svm_range_op_ctx op_ctx;
+	int evicted_record;
+	bool need_resched = false;
+	bool has_pending;
+	int ret;
+
+	if (atomic_read(&svm->exiting))
+		return;
+
+	evicted_record = atomic_read(&svm->restore.evicted_ranges);
+	if (!evicted_record)
+		return;
+
+	if (!svm->gpusvm.mm) {
+		atomic_set(&svm->restore.evicted_ranges, 0);
+		svm->restore.end(svm);
+		return;
+	}
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, &svm->restore.list,
+					       &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+
+		down_write(&svm->svm_lock);
+		if (UNMAP_WORK(op_ctx.pending_ops))
+			ret = 0;
+		else
+			ret = svm_restore_range(svm, op_ctx.range);
+		up_write(&svm->svm_lock);
+
+		if (ret) {
+			if (!amdgpu_svm_nonretryable(ret)) {
+				AMDGPU_SVM_TRACE("restore work retry [0x%lx-0x%lx] ret=%d\n",
+						 op_ctx.start_page,
+						 op_ctx.last_page, ret);
+				spin_lock(&svm->work_lock);
+				if (!UNMAP_WORK(op_ctx.range->pending_ops))
+					op_ctx.range->pending_ops |=
+						AMDGPU_SVM_RANGE_OP_RESTORE;
+				op_ctx.range->pending_start_page =
+					min(op_ctx.range->pending_start_page,
+					    op_ctx.start_page);
+				op_ctx.range->pending_last_page =
+					max(op_ctx.range->pending_last_page,
+					    op_ctx.last_page);
+				spin_unlock(&svm->work_lock);
+				need_resched = true;
+			} else {
+				AMDGPU_SVM_TRACE(
+					"restore work drop non retryable [0x%lx-0x%lx] ret=%d\n",
+					op_ctx.start_page,
+					op_ctx.last_page, ret);
+			}
+		}
+
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+
+	spin_lock(&svm->work_lock);
+	has_pending = !list_empty(&svm->restore.list) ||
+		      !list_empty(&svm->gc.list);
+	spin_unlock(&svm->work_lock);
+
+	if (!need_resched && !has_pending) {
+		flush_work(&svm->gc.work);
+
+		spin_lock(&svm->work_lock);
+		has_pending = !list_empty(&svm->restore.list) ||
+			      !list_empty(&svm->gc.list);
+		spin_unlock(&svm->work_lock);
+	}
+
+	if (!need_resched && !has_pending) {
+		drm_gpusvm_notifier_lock(&svm->gpusvm);
+		spin_lock(&svm->work_lock);
+
+		has_pending = !list_empty(&svm->restore.list) ||
+			      !list_empty(&svm->gc.list);
+
+		spin_unlock(&svm->work_lock);
+
+		if (!has_pending &&
+		    atomic_cmpxchg(&svm->restore.evicted_ranges, evicted_record, 0) ==
+		    evicted_record) {
+			drm_gpusvm_notifier_unlock(&svm->gpusvm);
+			svm->restore.end(svm);
+			return;
+		}
+		drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	}
+
+	queue_delayed_work(svm->restore.wq, &svm->restore.work, resched_delay);
+}
 int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
 			    void (*begin)(struct amdgpu_svm *),
 			    void (*end)(struct amdgpu_svm *))
-- 
2.34.1

