Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5E9CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175D810F80E;
	Mon,  8 Jun 2026 17:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fOIc9oyK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F8F10F80E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVq0RQB2hAAWHq6sidz0sRhhgZHWN9nmB0fObPiqFVqFpgT+BiF7xVWATz5XTpD1RFOo/veVBIxhdOCsEaQZQtDGwzTlhspDpejvJWkfOkA0EuZueU0+WUjvri5BVkDMYsezvwSa7y51TLYugl+uuJX+KG7LkIN+SX3MZAgX07s43xvkYKi7nc9Ybsh1lqW0OhTV1L1JeU4Vn9XngBWUWCAho1OW649mKSUi65qxKJS0dWT/f20Nt2z2CHU8EMiXTyZrkhfTeC0jX2dBf5MO9BcV922bzj+Fx2hNU+PpYI+OiVm9pUvYTuXFYPANpKQvkAUDDIs9aMs1ri6EuMX90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsCJ+++Cs9zI66FWEMFC7HGBg4GJA5AXdu8AvsAQoTk=;
 b=JQyfrEUg7GBbicTTDqQSXbCpLAqqKG8i9IfDLMagAbQC8CoVziGlaZkzlpP6h8FpCNqXYWOy1MexzS7eWwS3rIwJ/khKyrojQ7SjyYvYKypQVsi4n3KvLReKqfpg+U+qduSTVeRJLk4IuEeIPwnM/c0dYcX2dBj5wqS064ATl/1iaxdyJb3bQg+OlnnuAZ4ca2X6XiXOyM2JokoaGd+BIPXTBad+6BqhYM9WtWIbdOiqPvPGWOicAJeeo6BPDHMZzgQ5GcALMSUFXPa3QGHVAcEs2UnVp4qHo5egH4JUtL8k5Wbbqh6OytzddY6+uLpvNId+ZqO7ppvHIAsLkq9zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsCJ+++Cs9zI66FWEMFC7HGBg4GJA5AXdu8AvsAQoTk=;
 b=fOIc9oyKfgymSdRXNz/aJccR8mmUBLzL8Vym2f1//YC3Uv8zvhhXOVHHG/NWdGevlnEtTuzeePOPVNgz+adTAnnpUO9h3CgPaxvji+KLv3MDP38WNIcWEfsObfnKPeFp0b461vKhXl0lalz6bLtgiBlygiodDvTuuxN1hdYPyVM=
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 17:50:22 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::2d) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 17:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 17:50:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 12:50:20 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 12:50:19 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix VMA access race
Date: Mon, 8 Jun 2026 10:50:18 -0700
Message-ID: <20260608175018.2756886-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: de1b82b8-a231-47e5-bbc6-08dec5866995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 0aEi3HCpt4P6gpKqzXHu7NHh+GvFa/lwLnHhlJCe92IBC0QwE9MbvOuGOJlYIKfzq32OShpxL6io4peLtgG6nTSPhlPmN4GTodsvsaIqsZL+kONZNCUzUpV0J6dagyEL5Y2U7T+IB0VzrHGYQkktfSJi+Oxp9SweYiOCd4ZnfeCqc2Qvlt2E9Zoq1dQFYl9ONeBx5I9hF/xWHsf7vU80qF276S1L6EaIGG4jRzXiX4F1IsLRGcGDI79CL/Gzzv05e7sZrkASmgZWDMuFsI0sj/xMAMM3/+2P5dlR/x3yGmOQJAZIptWaK9FKbqt3zf6Q1wKuhA8/CgSBhBFeUjc6Hz4+3eaBLPP1GtwWYgmJf4W/fFqgf8Q5yWGualcJTsarS5Mlmfo0t8XkXIEEgyN+96lTq8CyOZCAkGo/iBN3gsaaEYywF1MSTbFqTPAsUqcfmbAcCb9s1RpSIp0HXZqVfXoU6avTdrFM8mqECUHzxSO1fYyDANGBlSIr28AGHjQ6df7TTLqvdYAy/6GBp2sto4viBE0U5NF9uoutPP5BaYtRp0a3CKuDYB1kl8fCrtjVe+tiMuN7VgRMWRNi0wg0Z60FT3NQz1S9dEPkjPLLokbmAZHoOynhEH0u1K2EmK/o3QWUg/1mQPYoYe5Zd9SO/1MBGEMMHTsfh4NP/kxDdiMHHfKVdSg+bHO8sd4UX5xZvzgJn2Z/u4FouGrHzq7Xe9cKS6FpmmxKPq2iUl9UXJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D9bvqD2euA4qCOh0FBHd2XG7Y1+Bx7YDSZvwKUeymNEtXzDKoE9VTR0Vfq4t9oVFc/h7jBfmRG9VbMsvIM1/wwFXP+fv14Nlsr8+X/hp7strLRnDFg3KJ+MF0MWad9qOoL7tQ7KuCHndrzcdFJJgV5Eewk3MwGwtyMeuSNz25qGKwGYCwTCgx8NPVN7RUIGMvWTh75LLcSh39047GMCvXCI9Fq+VyntEYXGIVUkzOK1z33YIL/ByPifQIGITIZuGzYiMd+S1/9IjYwrSafZYR3CBLhVn9NGEsve/s0GTuRidP8I8ZaAzPdpI5tJz/wlag34IAUDCA+xdRQYuz4rx3ATEauaGfmtUr7BIZEHA7bEImv5OsNCFVOaUW5IVEaBjFrKQVwa1ozbDz+nWV3MxgzZcRKdCmfIvSdKPk0UuGEG1wNEh8q40rx+K/2CgxBwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:50:22.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1b82b8-a231-47e5-bbc6-08dec5866995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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
 drivers/accel/amdxdna/aie2_ctx.c    | 2 --
 drivers/accel/amdxdna/amdxdna_gem.c | 7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)

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
index 63976c3bcbe0..80dd183ecba9 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -271,6 +271,10 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	if (range->event == MMU_NOTIFY_UNMAP) {
 		down_write(&xdna->notifier_lock);
 		if (!mapp->unmapped) {
+			if (is_import_bo(abo) && mapp->vma->vm_file &&
+			    mapp->vma->vm_file->f_mapping)
+				mapping_clear_unevictable(mapp->vma->vm_file->f_mapping);
+
 			queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
 			mapp->unmapped = true;
 		}
@@ -308,12 +312,9 @@ static void amdxdna_umap_release(struct kref *ref)
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
-- 
2.34.1

