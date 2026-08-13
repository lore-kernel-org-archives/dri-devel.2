Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0946DC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C33010E075;
	Thu, 13 Aug 2026 20:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4SAZGrj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB3B10E075
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh0TVBWfzBrSvQuHfp25qznJOfp24iwBh9UHTfhir+2T4OwYD27Zwyy3UK/YenCLap6vYF2e2WweBXj02MrSkN3pv8o42FJlHeS1trptukgz0B+VUuP8s6x9WNOD6B+8DNAHKvcFrGnphvl3Zh11icb6tCXM71Apubo2XHgstDNAetXexTVNhNLqOqN+H6b/F39HykXHIr1VqlRNtf7t/kiRTfIbfULBLLips9nBtHPzZ/6Rt1Ln9tn/TcKCuJS6uyMB7kVy1swZtFoB4QiUYwFwCiQcUJNhHwyoawN0edGGEd1bx8wFfceZJQJRajQ+OiCnw1y7XxLYlX5MTFxHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTCKPKTJcX6G0xSjpxr/UhD1ezE5PY5DVBDdJ4GP8PM=;
 b=ODSWqS/VOyyuubt2DQPTv63wOyRQAknefBqjNOW3QDqITTpZWWsaglQyD6IlekwN1JGXW+vKDj39DWn3dp2LRvmy+HISD3M6yVHG7uRxp5+nXUPABEzaUJ+s48pJJ+QyO+ZIZtYaKEObnteYrYwnOKQVdZ1/aBdOpA84gnioQnSmTBDT9NBCyYKCBPXAdyPLa86K7FeNyf8mbQBS1eag8QN4U1pstZSrdhK+NyOSBjjA7nzs0REzKGlYVEvUIrzqiS86WB7cDOBsn6Mwg5VhuhRZKk89EOCnq56vjnP0yjajbDIvCuYc+mVhBW+WmMDx/oGlATlHRcVMbgHkcU3wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTCKPKTJcX6G0xSjpxr/UhD1ezE5PY5DVBDdJ4GP8PM=;
 b=D4SAZGrjHeaLOvWVooYPEYTu3CO3ETRBvzoQUoZ2aJjRlWUblIEDYYnuJNcyBaknmy2AeaJczKGGdnJtXAygB2GP9aPo8J9ZUzQWWwwxKOqBr/djpkSXAjydcBxNvDXZ4fSdLHdYx3oMz/8punPlum7gzqYT99GlmNHEcPfj2ok=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 20:50:24 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a9) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 20:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 20:50:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 15:50:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 15:50:23 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 15:50:23 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Fix unexpected wait when flushing
 notifier_wq
Date: Thu, 13 Aug 2026 13:50:16 -0700
Message-ID: <20260813205016.941743-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e76bef-ea20-4ef3-9d25-08def97c7fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: jYwyBTFEcllZxKM7LJsxdf9OchIF4k9aQw9wNo4XJngagX52PoHUblCpF7tKxkz/rk7VbXpQsQYDA93VP9/zWfVK40w7+RgvvAfc4dh64ju/rLzNcnAnVDbyE7Og3UmeS3xLgcHqoy7sDMIPzIT4M9YLJ6EPdyKIlx7CArPYunb8M3gC44MEdFvTiWNavBufc5Tkv/Djy2Mu2RWsfQHJH/ZTXDta8blfo2uLJaE+pn7qSHJbuOO8/t88EdrdTWTLC8CExq1+WrQvIppiajxCilrPBCElGNMKMJiaYgayMBEL+mq8qyCYyvuiAwmSEpk4PHOSXF7DQzcwZy0e92muvunaFqq4o33ydSCl2KMT/vUW+LEYKTDsdw0seFLJfbPBsPkMMRdU5oZgZhfzXDMDO3NmFSa6wDs0G3p+QDdGgDz1fxAh6kH9NH0WRg73HY/7Zcf3qI8igBl4L+eMa+cmQItrtPe2tLbnUdx925SltI/Liql76pEpYlRrBvStKLEESC0dHAFlt3yhOzYQCToA55OAU6p4d4/TxY/vhrCAVNNrc8h4jh1irtOggeiAud+LjMX2yF1JMeGs1BCIsfdyXMSz0f/xw5dAhu/NWdVMKRMsC74LY5fVUy5uYbzUaAJnC33VCABAE+karCT87bL62B4wX9TbfX+90acmP/9GcOhXaG2u8qmk43rtRYDTpQ1Os3FtpYWzMKj6XsYdt+eXAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AdsGDEqGdtIsZMMyl1Hqf09xHoveO3M35bbjse8QPLggcknJ3ZXHNW9S1GfUuukIyOte3zTgo36Rrgwi6Sq4admS7LCYSUKPyIctHYDSFfqoqd3slbwmHi4gb+jl/Ra4WNujmZREitETIiMV2Lbrp4JD4Fip2NBjNPxAV6kRBYUS4mpoxVD68yewvQTWUMuYAq5XYbwj6qxk+SCejz16W1PCaGfaAJ45sZUUahXEC/O7jkznv0IaIT4JAS2w6ExDTKv5q87Qh1IufbV/uF2nJ/wpYuATMz0vzpM4msfDlLP+9LUiS8FnEEVzcYdOaB1h0DJv5A8XvxAyoxXvTRxxBk+ArDcqMwM6SnMQQ0LWGubvIy9BfrNfxek+dsG0fmyg10rRWZDeSAQRwrstiqfF0RoXhy4/5nmfxhgySt0XUGcRbUPdDRpAfViv6X/KuHBb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:50:24.4529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e76bef-ea20-4ef3-9d25-08def97c7fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
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

In amdxdna_gem_obj_free(), flush_workqueue(xdna->notifier_wq) waits for
all pending work items on the device-global notifier workqueue, rather
than only the work items associated with the BO being freed.

If another BO has a pending hmm_unreg_work, freeing an unrelated BO can
be unnecessarily blocked until that work completes.

mmu_interval_notifier_remove() is deferred to a workqueue because it
cannot be called from the MMU notifier callback itself. The BO free path
is not a notifier callback, so call mmu_interval_notifier_remove()
directly there and avoid the workqueue.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
  Fix sashiko comment.

 drivers/accel/amdxdna/amdxdna_gem.c | 69 +++++++++++++++++++----------
 drivers/accel/amdxdna/amdxdna_gem.h |  1 +
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1c63eff0a4a8..1c17122d1327 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -253,13 +253,16 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	struct amdxdna_gem_obj *abo = mapp->abo;
 	struct amdxdna_dev *xdna;
 
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	if (mapp->unmapped)
+		return true;
+
 	xdna = to_xdna_dev(to_gobj(abo)->dev);
 	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
 		 mapp->range.start, mapp->range.end, abo->type);
 
-	if (!mmu_notifier_range_blockable(range))
-		return false;
-
 	down_write(&xdna->notifier_lock);
 	abo->mem.map_invalid = true;
 	mapp->invalid = true;
@@ -301,33 +304,40 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
 
 	down_write(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
-			if (!mapp->unmapped) {
-				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
-				mapp->unmapped = true;
-			}
-			if (vma)
-				break;
-		}
+		if (!compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end))
+			continue;
+
+		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
+		mapp->unmapped = true;
 	}
 	up_write(&xdna->notifier_lock);
 }
 
-static void amdxdna_umap_release(struct kref *ref)
+static void amdxdna_hmm_unregister_all(struct amdxdna_gem_obj *abo)
 {
-	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
-	struct amdxdna_gem_obj *abo = mapp->abo;
-	struct amdxdna_dev *xdna;
-
-	mmu_interval_notifier_remove(&mapp->notifier);
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
+	struct amdxdna_umap *mapp, *tmp;
+	LIST_HEAD(dead);
 
-	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
 	down_write(&xdna->notifier_lock);
-	list_del(&mapp->node);
-	if (list_empty(&abo->mem.umap_list))
-		abo->mem.uva = AMDXDNA_INVALID_ADDR;
+	list_for_each_entry_safe(mapp, tmp, &abo->mem.umap_list, node) {
+		mapp->unmapped = true;
+		mapp->cleanup = true;
+		list_move(&mapp->node, &dead);
+	}
 	up_write(&xdna->notifier_lock);
 
+	list_for_each_entry_safe(mapp, tmp, &dead, node) {
+		cancel_work_sync(&mapp->hmm_unreg_work);
+		amdxdna_umap_put(mapp);
+	}
+}
+
+static void amdxdna_umap_release(struct kref *ref)
+{
+	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
+
+	mmu_interval_notifier_remove(&mapp->notifier);
 	kvfree(mapp->range.hmm_pfns);
 	kfree(mapp);
 }
@@ -341,6 +351,20 @@ static void amdxdna_hmm_unreg_work(struct work_struct *work)
 {
 	struct amdxdna_umap *mapp = container_of(work, struct amdxdna_umap,
 						 hmm_unreg_work);
+	struct amdxdna_gem_obj *abo = mapp->abo;
+	struct amdxdna_dev *xdna;
+
+	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
+	down_write(&xdna->notifier_lock);
+	if (mapp->cleanup) {
+		up_write(&xdna->notifier_lock);
+		return;
+	}
+
+	list_del(&mapp->node);
+	if (list_empty(&abo->mem.umap_list))
+		abo->mem.uva = AMDXDNA_INVALID_ADDR;
+	up_write(&xdna->notifier_lock);
 
 	amdxdna_umap_put(mapp);
 }
@@ -643,8 +667,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 
-	amdxdna_hmm_unregister(abo, NULL);
-	flush_workqueue(xdna->notifier_wq);
+	amdxdna_hmm_unregister_all(abo);
 
 	if (abo->pinned)
 		amdxdna_gem_unpin(abo);
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 1e90e32bf3cd..fb033ced1045 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -20,6 +20,7 @@ struct amdxdna_umap {
 	struct kref			refcnt;
 	bool				invalid;
 	bool				unmapped;
+	bool				cleanup;
 };
 
 struct amdxdna_mem {
-- 
2.34.1

