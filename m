Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5ECCD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 01:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8999010E02D;
	Tue,  9 Jun 2026 01:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MajLCYzH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CFD10E02D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 01:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzZCDotuv8/9NrD+HnCGrSa5/TZhhTEm7bF2nep3gmz0j5maCqVpPwRzYnPwG864ZTO7wby56ol71eentviCWJ5r2ujpQ6SgM800o07XeISvqm0Mp2qheRjqs+07lGWbep3IaG4XbCo/d/4dCgU7f79jrH4WinFuHEAFdW5Y7Hm1X8sxlHo7H+28kdwkXOawM5glV3/xGjeBJqS0ib/A19HG/quOU8+XBANwdRTPY1G7uUtn8L5oX9fEYgIDpFeEs9vYs7V9dcUn+0X81vPP3GXAacDSQsQY6bJ+GS5U0WeW2aXuZA1jwe3cC7o3y3jTYv/GanCPvc9/t9s5TcbEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5Edj/mYjvXnWhhmTJMyT3bmNM4Dqs3Dil2w0a7SioY=;
 b=sWAHSoZ2Ltnh8Gkdvxcmm6aPM/3qLJKN7xriIvFll1136f3BdG+qJTiWbCvWPFbpMzRdahBUU/z6PRFgKx78JwAS6jwJ0qct0B7n3/umFywy0bZRzoKJ3bieSH8qpsqXa4VdAhMIrgAIXP4KrFZaELNwDjQxBTOK4Oszd+Wg8QPHqd0mDCQKuxya5BUMruC+R32jcGuQDsUxjZKCecsQsLPUuEIKlEkF1PnGQQZgt0Mk1OKNFO7ma+3Z3KbnxAPHzKNYrUy5cbB+32867z9iYKNd6zuBXnJRbFBJZNHGHb/EZtnFl8I+ueUuSrHkqBpLzf+l7Kn4SBbMieKVFOzHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5Edj/mYjvXnWhhmTJMyT3bmNM4Dqs3Dil2w0a7SioY=;
 b=MajLCYzHx2hDV3AgkMD5g/hkJhs5acQgWRnPk2YTsZ/FABXeHXvx8uLclMR8UZxVid3LfNT3Fgymn5Klo2frbT4AMAMBj38sWw/2n+5ZSNFv9IeK7PxEhJI85mpTES0xtKaHK1LifUYn9LPGUlNoWoie4lcltBRAkXsVxXk/+WU=
Received: from IA1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::16)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 01:12:51 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:464:cafe::59) by IA1P220CA0017.outlook.office365.com
 (2603:10b6:208:464::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 01:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Tue, 9 Jun 2026 01:12:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 20:12:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 18:12:51 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 20:12:50 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V3] accel/amdxdna: Fix VMA access race
Date: Mon, 8 Jun 2026 18:12:42 -0700
Message-ID: <20260609011242.2833740-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 095eedf1-93cb-4c7d-b8df-08dec5c43a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8rs0pGYAWUuo/phYgYCPReVStgrq+Hk1TxPsSpHGUCKxYmczkyXcq+oMhHREBM875NE2KI/YtB7qxmesVezYwqzeOvzoHVu7bQivACIvZSiTLMIVBlKDPoX8RmWilSov9YhkADngc2UdepKI62ZpN8l9ggMH2xbdtsRIYQ73JEUxsRfLigeXLTNiqzjLG5VAoZKjbzWrGcM8Hhn50zFRloKhm6yh0ImfVytoNwM6vTnvKLehqbEHUgqo/ljyd8K14ouVTTG01Dk+OsbYSUUcq4cM1Dux8Wj/32/BpFgecnPXScOIyooDTGEaitUBkxGNULx2FFM+mF6gDQ5mVpfLEgL9614mI6jivOHAnXsloKJ4TOMeszfcoP2UghmW8CPtCVuiDXU73GG7+51S7ZZTAjFxhytXBZ063mJV5QMJYN/mc1n/p4sDQiCqfzy/Imr6sJBGpd4Rk9Dkt0plBBBJTQV5ehQ998UPDtOp3Nh4cZJdsPr56o/cjztgK8RU+DRNiVnTN9il0S9WTe72my1gLylAi2mrXK+QX4qQR6HlszypESAufB7yl0A7MSzFtJzPJGhS2adDVdDswsWXYJp9GJoBcw7eP91lz1j4zTTqZTZlIu9slDgN0dtYCW0+3hXJxqnc1t1iWWWql/ZxCOGPLwuff0gohOaxxo94MsqxH+dDES91Rg4TvMB2zC70uTR6PB9LSyrVJW/5AT/yhOgMJGmk9WEoL+2AhAWm6duf3q4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VbrFxqZ9yqwR9I21bLnEcWXXDzOyg0sA/t4QLbPomO8Yi4/kcZvd0VFoY/qhtrWk7NHN07TDvvJwQ9bLPXZdzPjw1SEfJ8HeBFHwDqtuMYki/2jl/oNacBLcY7Nn4qV+CBtbNksObpWwjO2xHd3yLaP9XkDE7RsnCycOowo+QTzAJYwm70XZVOKAy4yhPo13YBVs9BZMfFlqLy1ytInPEWbO3EXca5j7sEMLGu9S8cJR58uqpFA921e+Jc6YSi34vZ3upP4p8sPv30liCR+Fte5VxqRiEwDw8l0Td6PZNjpi4YfzVQEmZKKwAGX5YcO1pw7j6r0TKc3AOEHoTxg7JwLzNS+87xeVPQ8pg9ys8c023TnNROb1P1evKVCR3cMX1BkSfCovZW2+PGAYa+PWTsZ/s9eqRE24cUfFtODj7k09u/J+amKQ2KdjVyNdWA5Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:12:51.6632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095eedf1-93cb-4c7d-b8df-08dec5c43a63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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
V3:
  fix sashiko comments: error-path cleanup patch race
V2:
  fix sashiko comments: Use-after-free on `mapp->vma`

 drivers/accel/amdxdna/aie2_ctx.c    |  2 --
 drivers/accel/amdxdna/amdxdna_gem.c | 31 +++++++++++++++++++----------
 drivers/accel/amdxdna/amdxdna_gem.h |  1 -
 3 files changed, 21 insertions(+), 13 deletions(-)

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
index 63976c3bcbe0..20ce304b19ef 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -254,7 +254,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 
 	xdna = to_xdna_dev(to_gobj(abo)->dev);
 	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
-		 mapp->vma->vm_start, mapp->vma->vm_end, abo->type);
+		 mapp->range.start, mapp->range.end, abo->type);
 
 	if (!mmu_notifier_range_blockable(range))
 		return false;
@@ -284,15 +284,23 @@ static const struct mmu_interval_notifier_ops amdxdna_hmm_ops = {
 	.invalidate = amdxdna_hmm_invalidate,
 };
 
+static inline bool compare_range(struct amdxdna_umap *mapp,
+				 struct mm_struct *mm,
+				 unsigned long start, unsigned long end)
+{
+	return (!mapp->unmapped && mapp->notifier.mm == mm &&
+		mapp->range.start == start && mapp->range.end == end);
+}
+
 static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
 				   struct vm_area_struct *vma)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct amdxdna_umap *mapp;
 
-	down_read(&xdna->notifier_lock);
+	down_write(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (!vma || mapp->vma == vma) {
+		if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
 			if (!mapp->unmapped) {
 				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
 				mapp->unmapped = true;
@@ -301,19 +309,16 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
 				break;
 		}
 	}
-	up_read(&xdna->notifier_lock);
+	up_write(&xdna->notifier_lock);
 }
 
 static void amdxdna_umap_release(struct kref *ref)
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
@@ -355,6 +360,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 		return 0;
 	}
 
+	down_read(&xdna->notifier_lock);
+	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
+		if (compare_range(mapp, current->mm, addr, addr + len)) {
+			up_read(&xdna->notifier_lock);
+			return 0;
+		}
+	}
+	up_read(&xdna->notifier_lock);
+
 	mapp = kzalloc_obj(*mapp);
 	if (!mapp)
 		return -ENOMEM;
@@ -380,13 +394,10 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
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

