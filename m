Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351DACD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662F910F9AF;
	Mon,  8 Jun 2026 20:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOD0K9jp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A9710F9AF
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3olkJ+SbL7pYdlRm9LsHT37VRyStiMvptCXZCUptHHIzPE4WBSUeEDNBUGcTf7y0jVAR5iV5Ev2FeUllsh0J31d1CcRy7/bI9e0poSSbjCE4bDHyoQCe9dRwWJVmPsw1gepTWNW5exrVgDFu2S/MlMapLohuxsHpkl+1nuwljW8ztGGG/skwtlpGuKW2+QmbdCaZqhTwfPcQnlSE2tps2NhNeJUEHlkBl+8ky+wzn+CAEPvn2sRtfrnkSoXX+ChE726Q1HDD/5evWf5atQogifT1epg92SYQ/XEJVk6qWvno1AFdIOXAXTC/psm2XG7FXVZAAdRHQ63zziOa6223g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChS/w70yUzPcQ3kHJXHaqLNrwEt3l2PlYhYWBQ4+1v8=;
 b=ZTxdoT0LZql799ACj6FRjLgOMtxQu/dkqJ3COcz3SPbRuamwqlghUQHDjbIOb3hPggb5PpOjXGo0e8QwYNkcAQcc2cY8TQ5LLcM8GRtFSTQhAfRkmx+2MPACZ702hDFE6zrgpB/f3U2sJpsawjsVPzD+ZBcn9+LyrYmL5CiOAts203zp4IBkan7ACupCPvrvNovO96jcYNDJx2f1RkEyzUDa3YHgnYdvMNFm9PjYydWkHsdMoxEVmOO9JzFHv3cXPIHcItHxGN2bRglGkJIOSh0btFjsKG5OaZWmnZk8FahWgoW+3XV864Qlhi9wj8YF5NKlXBFL8T/lsuLVUmGgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChS/w70yUzPcQ3kHJXHaqLNrwEt3l2PlYhYWBQ4+1v8=;
 b=yOD0K9jpsFRA7PU0agelYAVM4ytejMlt5uH+c1ApiYBc2xlqe6Zh1LUEckHp/F8Ui4wpzo5PPcHJokaCpR5V3VQZt/UZur6t9hQJUBYovFhHhHxNW1L6DJB5Wziu/R09gW/g/hjaBxfgsAJUAHYkaQo0oGL8KUyZtqLrG3K+dBU=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 20:28:31 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::4) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 20:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 20:28:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:28:30 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 15:28:30 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Fix VMA access race
Date: Mon, 8 Jun 2026 13:28:28 -0700
Message-ID: <20260608202828.2771524-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 011c2067-8f88-4ba1-5c78-08dec59c8175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ta+L1KUaK/CLVuVhl4VW6WA9a2o40Icr8M2xKy/C6hz5hUiWX34AWYvru2Q8yFhuR66HQa3+FAZfmsxMRkGQuS1oOoM6ndHUwkqUOOtRvRFVbFQvlaMqhgUpeTeCCrbDqbi/wdu5AwfNIQsD/Xam9ma5cfgWUy8lJTmEBggbffMNbEW5fKy0vGyt0ERrB+fCsZOxh32OaYI+faBRWDkcUBpWfvRG7QzHYwl9YWpJiP7zHhBb74V74AP7YLtUehCQmpNmghKi/lxyHi6ZSJzWdngNRPXMnaViNuxOXvkrnTvMn79EfgYggtj0sO01aCqlpO1Jne6Dxf6UvFx6rZnxtRv+UGnFkUYALXrWy6PzfSdlNI+gdo9X7lvR7ZZtmjo9Whj/MnSd5RX5uaXerwCsl6ASfe/TE0nh1in9ZwMXaQ6O7u5sHyzomNICJBL3jENGeDn6zuDVxwsScfByOeLoiY7hHZ16+n9vLbR0OW3LET1lBDUC6VcRAO3wn0phj3QOSzgf16K5tnsE8RjSp+/VX1W3gEuCSMJlOeWf/Zlm9Wcx0DuSrmVvF5ULovCdS4o/cLEeWB0TY+lcBAQm7EXpHRYR6A19b/HtiRJQtgXQaRvgrZGGpuYet5Ik5Atvf90k2IYC0+EaEPJVMnfv69IjdskpIHMmk6JSPTvW9fEFh4Gyo5nSzm5bWsIMkvImCqjgB7AhHg9WmYsCIY/kaYf+RyaA0+uGRYEKxGmkK/F04f4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TGfbIPAlDnsk+iASvKm5S9rhgzrEgkFtIg0FQVGW4t30EBp9hmrOk60MzJDzpPAsH9s1QXeTfqlfZo+8ax/Qey3YlWk/bloeZ5/m+SyU7tUVxSPCXJyqAiVzsgoa9gHLR7KhrXfFVzECHXvB41ChqWn2QJGH2fe9GVznotobjZ8wbBb+eWMN8QX3TZKuXHTtfjPZO9EVi737eFRiiMpMW5+wfIkbtnka28lt6WV8kUsziWIoweZVwZOEVsUhsW96tcSBP2QJvF8dOonA3ofxqBJqgPfAkEQ8S0oNKZLSGuZ6xWG9wh2XrSMGjxvHStOhT2Wn+3fU5T8sTjeEdN804gW0iLljy3bY2h9Ch7eNNscHLzAL4Jx+YiXhkwuLZ5sPw2n0y0IY7WPjAQiE6CONLp76rc31P/594ZCkebHf1ly6kSKQJ3mNCiJxgRL3ySVX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 20:28:31.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011c2067-8f88-4ba1-5c78-08dec59c8175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

aie2_populate_range() and amdxdna_umap_release() access a saved VMA
pointer that may have already been freed, leading to a potential
use-after-free.

Remove the VMA accesses from these functions to avoid the race.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
  fix sashiko comments.

 drivers/accel/amdxdna/aie2_ctx.c    |  2 --
 drivers/accel/amdxdna/amdxdna_gem.c | 35 ++++++++++++++---------------
 drivers/accel/amdxdna/amdxdna_gem.h |  1 -
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index da89b3701f5b..3e21e2dabe82 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1023,8 +1023,6 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	kref_get(&mapp->refcnt);
 	up_write(&xdna->notifier_lock);
 
-	XDNA_DBG(xdna, "populate memory range %lx %lx",
-		 mapp->vma->vm_start, mapp->vma->vm_end);
 	mm = mapp->notifier.mm;
 	if (!mmget_not_zero(mm)) {
 		amdxdna_umap_put(mapp);
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 63976c3bcbe0..079914194efc 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -254,7 +254,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 
 	xdna = to_xdna_dev(to_gobj(abo)->dev);
 	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
-		 mapp->vma->vm_start, mapp->vma->vm_end, abo->type);
+		 mapp->range.start, mapp->range.end, abo->type);
 
 	if (!mmu_notifier_range_blockable(range))
 		return false;
@@ -284,21 +284,26 @@ static const struct mmu_interval_notifier_ops amdxdna_hmm_ops = {
 	.invalidate = amdxdna_hmm_invalidate,
 };
 
-static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
-				   struct vm_area_struct *vma)
+static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo, bool unreg_all)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct amdxdna_umap *mapp;
 
+	if (!unreg_all) {
+		down_read(&xdna->notifier_lock);
+		mapp = list_last_entry(&abo->mem.umap_list, struct amdxdna_umap, node);
+		queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
+		mapp->unmapped = true;
+		up_read(&xdna->notifier_lock);
+
+		return;
+	}
+
 	down_read(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (!vma || mapp->vma == vma) {
-			if (!mapp->unmapped) {
-				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
-				mapp->unmapped = true;
-			}
-			if (vma)
-				break;
+		if (!mapp->unmapped) {
+			queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
+			mapp->unmapped = true;
 		}
 	}
 	up_read(&xdna->notifier_lock);
@@ -308,12 +313,9 @@ static void amdxdna_umap_release(struct kref *ref)
 {
 	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
 	struct amdxdna_gem_obj *abo = mapp->abo;
-	struct vm_area_struct *vma = mapp->vma;
 	struct amdxdna_dev *xdna;
 
 	mmu_interval_notifier_remove(&mapp->notifier);
-	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
-		mapping_clear_unevictable(vma->vm_file->f_mapping);
 
 	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
 	down_write(&xdna->notifier_lock);
@@ -380,13 +382,10 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	mapp->range.start = vma->vm_start;
 	mapp->range.end = vma->vm_end;
 	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
-	mapp->vma = vma;
 	mapp->abo = abo;
 	kref_init(&mapp->refcnt);
 
 	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
-	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
-		mapping_set_unevictable(vma->vm_file->f_mapping);
 
 	down_write(&xdna->notifier_lock);
 	if (list_empty(&abo->mem.umap_list))
@@ -497,7 +496,7 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 	return 0;
 
 hmm_unreg:
-	amdxdna_hmm_unregister(abo, vma);
+	amdxdna_hmm_unregister(abo, false);
 	return ret;
 }
 
@@ -619,7 +618,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 
-	amdxdna_hmm_unregister(abo, NULL);
+	amdxdna_hmm_unregister(abo, true);
 	flush_workqueue(xdna->notifier_wq);
 
 	if (abo->pinned)
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index a3e44c7a2395..a35d2f15d32c 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -12,7 +12,6 @@
 #include "amdxdna_pci_drv.h"
 
 struct amdxdna_umap {
-	struct vm_area_struct		*vma;
 	struct mmu_interval_notifier	notifier;
 	struct hmm_range		range;
 	struct work_struct		hmm_unreg_work;
-- 
2.34.1

