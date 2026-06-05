Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD84CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761EB11A545;
	Fri,  5 Jun 2026 07:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xXCbb4G8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A873611A541;
 Fri,  5 Jun 2026 07:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qchr9NePW4ozfUM1+wkQS/RwMHPm9wS84nLefXtmSb8P6ovG9Szv/k61//8LJQruMKbvmwzC9HA5vcbnpqrK+Jk5OGv7ZCqvikueXhHu1keLzd1kDA4tOWn5UPolmpyj405E2pF8KyXWokaE8Txp+vLWVm23fMOTv0uh4aI3SiT4ZS9felFz2K1ppoFt629abcSlAOY1YHJmuSjTwh846pxQ5kcu/YlXKeTzqOURvgsuqAwt6VhL9JcnbOtjBxcq5WcmLOMQxux/VUIyRe/g3S40ST39ghrTbj1LuMwb2+vkFtB9HcIX0e6Ue9CjXpN7ERuSHmgbnesiPET3ttoUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDxWwgnfKLc8ajfHkpbN8rhepiNiZtaIluoiSRhaGvA=;
 b=l8aoF+iYm1mChEgAimtKvgBpu6aPE4yQ81pKC6YQ4aTs+S38dI1qpx6zq28OdXbVjY5pgboLyX7y+UXOcVSvZcChaUmgvuVW9TXUjzPFJzKYO+KUiHVR0WAKDClXoRlTf3V8BpVMa7piYqHDgOU+ygBez9sNyP0KVc7LvxBpfkqh/KzQ4pWD1L14L2Y9LfdOmAjM0SJQ+UFSupMmyeV0nZPN4J7gdlc6GKoSWJSjyLGIgvYOMKXzPmR6T4UREyPXwASpfhyw5/txj9XI5F8Z7VBhmA966zDaaht3i0i52INlPwLRjPiLTwOSmega70n8wPbNA/kxohEmSGLhot7I8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDxWwgnfKLc8ajfHkpbN8rhepiNiZtaIluoiSRhaGvA=;
 b=xXCbb4G8bhnpEK5HtDj7cxfZBtug829aN6LdLHdEHOZPSD47I8JZjpJpYNS+C5r6mSvF7dgrUnMVtUUXJMsgzb9lJMFU50/rS5DRdeFpzOSkBFWTDb5XDGWWUAt425w/XPMJcUlkpG10XD64VxQuf8bl9qBi+g/DK5QVU1/3raY=
Received: from PH8PR05CA0011.namprd05.prod.outlook.com (2603:10b6:510:2cc::28)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:54:14 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::7b) by PH8PR05CA0011.outlook.office365.com
 (2603:10b6:510:2cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:54:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:11 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:54:08 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 8/8] drm/amdgpu: integrate VRAM migration into SVM restore
 and realign paths
Date: Fri, 5 Jun 2026 15:53:40 +0800
Message-ID: <20260605075340.20199-9-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f7ecc8-f241-4c89-43b0-08dec2d7a224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|6133799003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 2ZQd4K8sfHla7J0qufU2eaB3imHqJ4INs8GXTQ3aLKRf+2h0HdE2RsOvRfjczdGAf+6BoaVJQIUF1u8MTr2uLaaZxZQP3vlioZZTpFkmVthCaf96PW7aT/crvVDgxyuRyMbDZucrHJRyJGI5Jdl99hMd/B5TlisoLW2SkwJis5EKP7B3lzJBVATxnrMO1NGSfuPUNB+VxMhCPLieyttCo/Tz9kMRXyVS+Nuv0TABlkKfXZ8zk1yHuRMIE/bk3YlgCU0DFGdK6S+66RHMO/PrBerhsTr66RtZZ1iD5t0HZ5E9EcmVqUItbCnJRw/+Sjrx2YFmFp0YDLSkQpxdGXpNWXAyLUt9jSKCxuoZxcTufDBPffUCUeT0nWCpZ/WoZVt0w7COAux8JGXvb0r6F2fA9eYKo5oQzg6xyO26J1NyQ5yiEn+99jOyTCdY3K3Y9bligF3JKy5PUjzUUbrL9kPaneJX/21BSJf7u5e3aGzTk5rWdvUDGGbbMydFmelsmFDAbY0KRQAEq8YMBNuqcC6h8LEvCsJ62fe0F20sMzsOOmf0RQENFzsraNWlnfUg0IjZWnpWJgGq9xZwLEsXa4X15Vxk88ocYUCAVhBXTHjA/ZPVIOGVIfavXXS3CzmYleT/8CcrMIe5vsgVPa35n/FZNFZ7bi2XbySNUKeH0QK+hOWexCVcKh2m9HOXluMGMLzxtb1FLGN7hCQY2WnC/Ml3+ik2AtkQ3qvv9pILU+twKjCiZ6llXNmSvcesba7Tnd95iBQ7epDksWPzBNlVrmxABg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 17g5ZzLWAw/K9ZmdkKv4xtBpX85pKsBcLRffxIi257GElZjso4u+z1xg7/fXgTuZDnz0U+1NThcaBomuY5E40LzSzbq+3xsY3HPhhgEDLak7afS1ArImdN9N7v3HLqtgP8+BLwscQ6IBPx43j2ChYuqk9smRvej1ULQJMUQXXcicsDBYw2nUeTa7e06LQeL5HRElAD048Z/0n4WIEPGdOrJ63VQzlTWTIrEVCkCG+YAmz9AckR0uhE4KgoVfUFEclXXH+hmWLg0CvzXRL8oOyYpu9Q3GEY0ipcE1j95Q7udLvkbC34ffQtQWdoBg6a6Vk2qqbsValiR+tPrGUHcY+fED3U07YpvaVBMYbW4UZNJ/Bdy2zoKQlGatSPRjTkaz606yzL9gly7Q1JRCXOaosRJpsRqFBr1TNOmehzL20uFHPNRIZwa0kwzkldAWaKdG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:54:12.6037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f7ecc8-f241-4c89-43b0-08dec2d7a224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

Integrate the VRAM migration infrastructure into the SVM restore and
boundary realignment paths to ensure correct interaction between
migration and the existing SVM lifecycle framework.

Suppress restore for realigned ranges:
- Add suppress_restore flag to amdgpu_svm_range
- Set flag before svm_restore_realign_boundary() evicts a crossing range
- Prevent migration notifier from enqueueing restore work while
  realignment or VRAM migration is in progress
- Remove existing restore-list entry and drop its queue kref
- On realign failure, clear flag and re-enqueue restore for rollback
- Enqueue, worker retry, and put_if_dequeued paths respect the flag

Extend svm_restore_range() with migration support:
- Move amdgpu_svm_range_is_valid() check before map_ctx setup
- Set devmem_only = false since restore should not force VRAM placement
- Add device_private_page_owner for proper devmem identification

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c   | 76 +++++++++++++++----
 3 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 88923e6a0194..31229c4770b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -728,11 +728,13 @@ amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
 		list_add_tail(&range->work_node, &svm->gc.list);
 		range->queue_state = AMDGPU_SVM_RANGE_IN_GC;
 		queue_gc = true;
-	} else if (RESTORE_WORK(range->pending_ops)) {
+	} else if (RESTORE_WORK(range->pending_ops) &&
+		   !READ_ONCE(range->suppress_restore)) {
 		list_add_tail(&range->work_node, &svm->restore.list);
 		range->queue_state = AMDGPU_SVM_RANGE_IN_RESTORE;
 		queue_restore = true;
 	} else {
+		range->pending_ops &= ~AMDGPU_SVM_RANGE_OP_RESTORE;
 		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
 		release_kref = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 2d677f0965b4..4bf05c304564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -55,6 +55,7 @@ struct amdgpu_svm_range {
 	struct drm_gpusvm_range base;
 	struct list_head work_node;
 	bool gpu_mapped;
+	bool suppress_restore;
 	u8 queue_state;
 	u8 pending_ops;
 	unsigned long pending_start_page;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index 8bf00aed7f15..45a611479d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -28,6 +28,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_migrate.h"
 
 #include <drm/drm_exec.h>
 #include <drm/drm_gpusvm.h>
@@ -151,6 +152,11 @@ svm_restore_enqueue_work(struct amdgpu_svm *svm,
 
 	spin_lock(&svm->work_lock);
 
+	if (!UNMAP_WORK(pending_ops) && READ_ONCE(range->suppress_restore)) {
+		spin_unlock(&svm->work_lock);
+		return;
+	}
+
 	/* Deny any work if range is unmapped */
 	if (UNMAP_WORK(range->pending_ops)) {
 		spin_unlock(&svm->work_lock);
@@ -232,7 +238,7 @@ svm_restore_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
 	unsigned long range_start_page;
 	int ret;
 	struct drm_gpusvm_ctx map_ctx;
-	bool devmem_possible, need_vram_migration;
+	bool devmem_possible;
 
 	amdgpu_svm_assert_locked(svm);
 
@@ -247,20 +253,20 @@ svm_restore_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
 	if (!attr_range || !amdgpu_svm_attr_has_access(attrs.access))
 		return 0;
 
+	if (amdgpu_svm_range_is_valid(svm, range, &attrs))
+		return 0;
+
 	devmem_possible = amdgpu_svm_devmem_possible(svm);
-	need_vram_migration = devmem_possible &&
-			      amdgpu_svm_attr_prefer_vram(&attrs);
 
 	map_ctx = (struct drm_gpusvm_ctx){
 		.read_only = !!(attrs.flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
 		.devmem_possible = devmem_possible,
-		.devmem_only = need_vram_migration,
+		.devmem_only = false,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
-	if (amdgpu_svm_range_is_valid(svm, range, &attrs))
-		return 0;
-
 	AMDGPU_SVM_RANGE_DEBUG(range, "RESTORE - GET PAGES");
 
 	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
@@ -289,6 +295,42 @@ static bool amdgpu_svm_nonretryable(int ret)
 	}
 }
 
+static void
+svm_restore_suppress_range_restore(struct amdgpu_svm *svm,
+				   struct amdgpu_svm_range *range)
+{
+	bool release_kref = false;
+
+	spin_lock(&svm->work_lock);
+
+	WRITE_ONCE(range->suppress_restore, true);
+	range->pending_ops &= ~AMDGPU_SVM_RANGE_OP_RESTORE;
+
+	if (range->queue_state == AMDGPU_SVM_RANGE_IN_RESTORE) {
+		list_del_init(&range->work_node);
+		range->queue_state = AMDGPU_SVM_RANGE_NOT_QUEUED;
+		range->pending_start_page = ULONG_MAX;
+		range->pending_last_page = 0;
+		release_kref = true;
+	}
+
+	spin_unlock(&svm->work_lock);
+
+	if (release_kref)
+		drm_gpusvm_range_put(&range->base);
+}
+
+static void
+svm_restore_unsuppress_range_restore(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range,
+				     unsigned long start_page,
+				     unsigned long last_page)
+{
+	WRITE_ONCE(range->suppress_restore, false);
+	svm_restore_enqueue_work(svm, range, start_page, last_page,
+			       AMDGPU_SVM_RANGE_OP_RESTORE);
+}
+
 static void amdgpu_svm_restore_worker(struct work_struct *w)
 {
 	struct delayed_work *dwork = to_delayed_work(w);
@@ -334,17 +376,19 @@ static void amdgpu_svm_restore_worker(struct work_struct *w)
 						 op_ctx.start_page,
 						 op_ctx.last_page, ret);
 				spin_lock(&svm->work_lock);
-				if (!UNMAP_WORK(op_ctx.range->pending_ops))
+				if (!UNMAP_WORK(op_ctx.range->pending_ops) &&
+				    !READ_ONCE(op_ctx.range->suppress_restore)) {
 					op_ctx.range->pending_ops |=
 						AMDGPU_SVM_RANGE_OP_RESTORE;
-				op_ctx.range->pending_start_page =
-					min(op_ctx.range->pending_start_page,
-					    op_ctx.start_page);
-				op_ctx.range->pending_last_page =
-					max(op_ctx.range->pending_last_page,
-					    op_ctx.last_page);
+					op_ctx.range->pending_start_page =
+						min(op_ctx.range->pending_start_page,
+						    op_ctx.start_page);
+					op_ctx.range->pending_last_page =
+						max(op_ctx.range->pending_last_page,
+						    op_ctx.last_page);
+					need_resched = true;
+				}
 				spin_unlock(&svm->work_lock);
-				need_resched = true;
 			} else {
 				AMDGPU_SVM_TRACE(
 					"restore work drop non retryable [0x%lx-0x%lx] ret=%d\n",
@@ -746,6 +790,7 @@ svm_restore_realign_boundary(struct amdgpu_svm *svm,
 		rs = drm_gpusvm_range_start(r) >> PAGE_SHIFT;
 		rl = (drm_gpusvm_range_end(r) >> PAGE_SHIFT) - 1;
 
+		svm_restore_suppress_range_restore(svm, svm_range);
 		amdgpu_svm_range_evict(svm, r);
 
 		if (svm_range->gpu_mapped) {
@@ -755,6 +800,7 @@ svm_restore_realign_boundary(struct amdgpu_svm *svm,
 			if (ret < 0) {
 				AMDGPU_SVM_TRACE("zap failed ret=%d [0x%lx-0x%lx]\n",
 						 ret, rs, rl);
+				svm_restore_unsuppress_range_restore(svm, svm_range, rs, rl);
 				drm_exec_fini(&exec);
 				return ret;
 			}
-- 
2.34.1

