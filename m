Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7238ACA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A860F10FC09;
	Thu,  8 Oct 2026 03:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lrwOWrL2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45B810FA86
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHJY2dLwHYadtRFMc15E8xStF8dcLtSrHO0wRB17CCwB61ML276QT5neALBOqUTN9xCsL5FfCd2ZakoM40k/uJShCpt06h6c3qdYX43MU35FuS2vh1YdC2MtGuNxrjyygQwAaMS3iOJVVLVgHosNm157HZeAkmLOJiLX/Ha7BeTNS11e7MgJhRSmxWqXo+vvxWA9bRAK4pijtk6j+l1n5CGrFqHIp3fTf7opCAFGx0UrxJ/Da3ict07GdR2atIxM3E+D/CTZ7DfNN5I+jkohGVf2pulqsmm97iS7wFadcY1VFDN3L94YD6lKSfRDg8bSCbcOpnUtpmcHWKReMgljPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7j5RpFA135148VYYUar19J2D26opkys+JGKp1JoGvI=;
 b=BnqupOPGuImusWvtwUhP+dWRcxBY8Drp8Z/4n3phSLS+jYS/hAfRJXcziuBBjMcupYy+HWHEccH5FZmGpmJh/nSvhVOaQelZaZaeaayep9wKUdfbybYmkfBkOlWQ0L3HJ3uAsDcKgza8G+u0ep61/so3cYFI6RdE7r1S5qGWsR0DcsziZa07fcNPeH4Mrmi1q5qydDE+FrRHHSk9L0/XiIMy4y4ST9qtt6sNEV9kzXfc5363mlWu3YdzL3wJB+8JK5IRNjnuYBZABYNZj14Pk33h5dRQ+L1vaFi1oWHqhH7TMHcRaoDjccS2lXNHwEoCTmOfnFQTrrW3UHLp9jbJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7j5RpFA135148VYYUar19J2D26opkys+JGKp1JoGvI=;
 b=lrwOWrL2FLA9jnrGGkUxhZGnK6ACqiZ0q+JjBdPUoS8Rg8UNLXy/26rFiSozpZxnSMNnhrGE/sWVpEqAo6AyARKqfCUiqRBmYlTj9Bc8xyb581rHCDJ/gZ1cJMLBsvX4OiWIUm0IiXf27R3vqcBLVWkStz5lPLOvAdt6QxNdmyM=
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 8 Oct
 2026 03:24:17 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::e) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:24:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 03:24:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:08 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:08 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 15/19] accel/amdxdna: Make populate_range common for AIE2
 and AIE4
Date: Wed, 7 Oct 2026 20:23:44 -0700
Message-ID: <20261008032348.2044667-16-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3c8a4a-ff88-4fc8-772e-08df24eba291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L1IHxodFwDfffTtfjL1pO+R+n/09bQliaMLp3TKuCHZhywPVAbypIp7Kxz+cB1E5/3xGDfnGJw6vWnl7Ax37Rnag6NpvfbSdHAdtEDBtlb4FHLEQB9daKSH8Iqz+sHtuioDLuo5+xFap6I/77n60t2eoVU7sLO7k3CPtwHsX9iTVqLmUejX8uqLK2tHuNkr7oJa7pdSAuXPrTrDemcuhsK4XWqFtMtfesAsTLyPCTnpYf3/IKxf490vI7PcC3531Uonyg3rNK7Rio1pifrVBoNW7dqWqKvmeYljf8mwh0Fecq4pWbK9h+4Ol0hrMcaAnKnth7V7oABom8gfasdXAw0EvJoQsZFG5Js8Y34Dn+1ZUsS/D+AmrgrsGvz3cj99Rs0fU6c2x5iCA+JXzzBmdKl3QVa0c4oPkghG0X2edsAILtafmug414MFuCEb1bhjTMtCQeUkcf48foQ4cJsMSNQqa5aJtRMLDUVIbd89I24tviaa47/ipbpEWJR5spPCmH+vE89AAg3k8w7/FQ/u6d8WoqFdH/vP75siUuNLXQu/hVYqJitZDUVgo+coUT/fFCbEzFG3QOQ3iv/iQKKmqALs9haQkb5KUTFHAaxeoqJ3AXsrietF+XgPNCNHGZhN4tWgtkyfhRvYPVx/NMSu3+qHGdMmp0wYqsArY3q2pc7EcKWVF2UZ8AbM8o1xDt10rIBVvz0ZLW1UscFoIGuYFTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0A/L/ROhwvCXIDNLl13nyrqi3umbVcI+3A6TqqH4UbTdLxUWCSnlc+FTf8rSaE+CpJuN7CCsdJTHUUTxR7h5eRSp77NGYewaGVZTpYWB2LzT0SjL2Y/hud2FNUjlxmZaEEGcmGyIgxAyMzI1kITW/bE+z2nuUS4gAL7789VsLOMXoqi8CQUU1eKKBJC7rdHqmyLhv6aKx7pgnSu6v0TkuIK/kwflnSqLhYCX2e4FkYY8fY57AdiaEdFNn7IJl517+gYO7R5eSMmhQWy83mtnfwl1IdCKIJpQCG1k0V3kZj+chvjHX8/XejCp+L3I6iHpPbyZBZEGVOsccfQ2Ads6p6AdLlqjJlVjjqu1A8akd2R13mG9grAwHOv3BLWx06a3zRcWnyzmR4J1ATnzjbfKQfZpckrO1q7NjhyWh/1zf114JArXVVmeOLi8R8eG7uOK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:17.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c8a4a-ff88-4fc8-772e-08df24eba291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

When a user mapping of a BO is invalidated, the MMU notifier sets
map_invalid and command submission must fault the range back in
before attaching the job fence. AIE2 does this in
aie2_populate_range(), which AIE4 command submission also needs.

Move aie2_populate_range() from aie2_ctx.c into amdxdna_gem.c as
amdxdna_populate_range(), next to the MMU notifier code, and declare
it in amdxdna_gem.h. No functional change for AIE2.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 75 +----------------------------
 drivers/accel/amdxdna/amdxdna_gem.c | 73 ++++++++++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_gem.h |  1 +
 3 files changed, 75 insertions(+), 74 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 8c1b29964f8f..05ed71e641c3 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1105,79 +1105,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
 	return ret;
 }
 
-static int aie2_populate_range(struct amdxdna_gem_obj *abo)
-{
-	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
-	struct amdxdna_umap *mapp;
-	unsigned long timeout;
-	struct mm_struct *mm;
-	bool found;
-	int ret;
-
-	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-again:
-	found = false;
-	down_write(&xdna->notifier_lock);
-	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		/*
-		 * Skip entries that have already been unmapped.
-		 *
-		 * If userspace unmaps the address and later submits I/O using
-		 * it, the IOMMU will reject the access and report a fault.
-		 * Ignore such entries here.
-		 */
-		if (mapp->unmapped)
-			continue;
-
-		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
-			found = true;
-			break;
-		}
-	}
-
-	if (!found) {
-		/*
-		 * This also covers the case where all mappings have been
-		 * removed. There are no invalid mappings left to process.
-		 * Any subsequent I/O using the unmapped address will be
-		 * rejected by the IOMMU.
-		 */
-		abo->mem.map_invalid = false;
-		up_write(&xdna->notifier_lock);
-		return 0;
-	}
-
-	up_write(&xdna->notifier_lock);
-
-	mm = mapp->notifier.mm;
-	if (!mmget_not_zero(mm)) {
-		amdxdna_umap_put(mapp);
-		return -EFAULT;
-	}
-
-	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
-	if (ret)
-		goto put_mm;
-
-	down_write(&xdna->notifier_lock);
-	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
-		up_write(&xdna->notifier_lock);
-		amdxdna_umap_put(mapp);
-		mmput(mm);
-		goto again;
-	}
-	mapp->invalid = false;
-	up_write(&xdna->notifier_lock);
-	amdxdna_umap_put(mapp);
-	mmput(mm);
-	goto again;
-
-put_mm:
-	amdxdna_umap_put(mapp);
-	mmput(mm);
-	return ret == -EBUSY ? -ETIME : ret;
-}
-
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)
 {
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
@@ -1237,7 +1164,7 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 				goto cleanup_job;
 			}
 
-			ret = aie2_populate_range(abo);
+			ret = amdxdna_populate_range(abo);
 			if (ret)
 				goto cleanup_job;
 			goto retry;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index eebd93b6f2c3..98b4768718a8 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -333,6 +333,79 @@ void amdxdna_umap_put(struct amdxdna_umap *mapp)
 	kref_put(&mapp->refcnt, amdxdna_umap_release);
 }
 
+int amdxdna_populate_range(struct amdxdna_gem_obj *abo)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
+	struct amdxdna_umap *mapp;
+	unsigned long timeout;
+	struct mm_struct *mm;
+	bool found;
+	int ret;
+
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+again:
+	found = false;
+	down_write(&xdna->notifier_lock);
+	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
+		/*
+		 * Skip entries that have already been unmapped.
+		 *
+		 * If userspace unmaps the address and later submits I/O using
+		 * it, the IOMMU will reject the access and report a fault.
+		 * Ignore such entries here.
+		 */
+		if (mapp->unmapped)
+			continue;
+
+		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		/*
+		 * This also covers the case where all mappings have been
+		 * removed. There are no invalid mappings left to process.
+		 * Any subsequent I/O using the unmapped address will be
+		 * rejected by the IOMMU.
+		 */
+		abo->mem.map_invalid = false;
+		up_write(&xdna->notifier_lock);
+		return 0;
+	}
+
+	up_write(&xdna->notifier_lock);
+
+	mm = mapp->notifier.mm;
+	if (!mmget_not_zero(mm)) {
+		amdxdna_umap_put(mapp);
+		return -EFAULT;
+	}
+
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
+	if (ret)
+		goto put_mm;
+
+	down_write(&xdna->notifier_lock);
+	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
+		up_write(&xdna->notifier_lock);
+		amdxdna_umap_put(mapp);
+		mmput(mm);
+		goto again;
+	}
+	mapp->invalid = false;
+	up_write(&xdna->notifier_lock);
+	amdxdna_umap_put(mapp);
+	mmput(mm);
+	goto again;
+
+put_mm:
+	amdxdna_umap_put(mapp);
+	mmput(mm);
+	return ret == -EBUSY ? -ETIME : ret;
+}
+
 static void amdxdna_hmm_unreg_work(struct work_struct *work)
 {
 	struct amdxdna_gem_obj *abo = container_of(work, struct amdxdna_gem_obj,
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 9b4aa21a37c9..977548e19ae4 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -103,6 +103,7 @@ static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
 }
 
 void amdxdna_umap_put(struct amdxdna_umap *mapp);
+int amdxdna_populate_range(struct amdxdna_gem_obj *abo);
 void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj *abo);
 
 struct drm_gem_object *
-- 
2.34.1

