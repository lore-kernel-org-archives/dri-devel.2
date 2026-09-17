Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0475C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA5610EFE7;
	Thu, 17 Sep 2026 17:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWwje4W1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABD410EFE7
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcFEt3STIgILVbjZcHYCgXjflB6bd+g5IzeSoJ6VNHJVwGi5tOY87962RWdUOBdYpYIVLzNFSXF5MWHfsVNupsaKX/RWASTzax4i+nffVntOi5gc5pVZE2WuR9gN4MgsYeZ/F5BG+VGMOp08hBrpICka73sE3+6BR00JhhjDoq8xOlcb6pC72Hl2CBouGufh6QwRrRX1PaTcr6in8r4zuVs9J6iqqEqUvTtQ6rl5N/Jzp9oQMbxntQ6pxe5ZSEExjY0f0lJ4QgX5MQ45GR2aAEndVzS6+J/Pfv1JJMwb0Juj7pUGtBgEddSD907imi2sek96nA98NZGl+JbVBsVpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpAVGTQKKBWwlpBOaywGyx7HCAD3rAGjGxNRBPfkWKo=;
 b=JC6gknhGPXwF6eNH7+VA34xwqXaOiIqKVS6VcuKb/jBDmXFIHDGlO6WwOISPbmdWvE76l8Xn+p9K7w3Bf4DyFNNOTUBwp1KF4rpy7CdUbOZc5ssKszQQVr8ZsnxwkgmECeObmAjpIngXZtihAqHIqv9Y/veSH97Z18cDsB7hUbXUIScaQmrsQNkTV1/d/d43mTZ30ctJ6bBgAO/Tcvm/e8YX0giLFW6lLpqi1E9Vyvn4CwnngbJsQ9tYfimdDowGK11yOn2mOHV9RTMDTbJQ6XkqclZDfY9meygw4nO1Fy0x/GfYCqMlnNjy1VqURm5SC2CZB1xCAONMnqmNpW3kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpAVGTQKKBWwlpBOaywGyx7HCAD3rAGjGxNRBPfkWKo=;
 b=yWwje4W1xJVH+hxPIjPrGaNjx7kWvlpcx3n/ic+QBhvJO8jTWGncyS2/h8DyX502YFMohmNCAWgJdVORe0629BbPqaqni2ajHPEtHaXzhKvKJMYyE1CrF/YWBdxfAqSdjwb9+bFDY6IGgr+Z9jreiRfjQa1KjsBafrQ/KkHUvOA=
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 17:20:07 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::56) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 17:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 17:20:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 12:19:59 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 12:19:59 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V3] accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults
Date: Thu, 17 Sep 2026 10:19:52 -0700
Message-ID: <20260917171952.1883974-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abc414f-c547-4063-078a-08df14dfe7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: IBgcTpCVNoMvSP5tEhZtM0c7mRs1rJCCqtYeT66WFmbqficCJuGf2p/Lbq8yecdTEmv3YSlzag4C5ghG4BHzBTxQ6HB1l5V4SiEfIbEQ0rk5JvZyeJ7Gw2mzo0LKP2yTXNXy0JpDuHitFBZPJAjMj4Tq4iPlsXI5B8isXRM/vCUnzNgkw1TcOG0fJL8S8ayAB9wxFex7r5PhEltfE+U7uylF4xtYOZl5o2goTFbBIB5yFWNL+/F1DTux+0aggwpM5ojkgCBl1ChYBJaXYW1aOEKBUgEYnOF3fQWLGg+EHbIm5Y817dYPQDoUUDcRCHHEhBlHuZFnPoCHTNuw5Hwvw1oOpW7IT2NqscANlqaIT34BlGUGIecBIP+0i6Ok/n31ZkK+A/mFwLYM1pQbUDBZn2XMLvD63VGs5nnPxfGZfVlm6mYyi3eHwiVBAN2gFJcQ6LMNdS3OUxdunbzBvhRDOjIYClSBRMEjlm6Ud3vdgqvT8Ynul34L+KA7ciMtDxuSC3aW+3XGqBKe4yx6VQ7I6CDRdJ/jtDuTN8/hTG3iJFhH1nv+CY6wA+PQZQdJzK+v/QwpHw0xzdF8boC8V2MHJbuwpzF4ifzQiKkY5M20NBRNGXMEKfdFjbCfcgzmIQhRuG1Bn0UR0I6Gu1LUF0yfVUUPzPf58l0oezvJVTMhQx0ktmb4qzID3jK63+7isSZJISxw62FovEFduG3fwU9MjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LrUPZ/r+WYZDl0GIMg/OpIDPwXaRX8JKN6I1mTEJI3xlIXzmO46UItiXlaJRTb6ouHiGT0Sa0RzPLhp4br6Eze3AoEeBccaHedVT1CI9iUSEfOhk4AS9/m42wZk/ew8wnPUf5WFlratvuGq6TJiHJFrwEMOqSOazy50kuNAHbnvGksGtRs+r7Esv8zvwcMHbziGfdn9pw+1hQsJFXhNn2pPEtmY/l46OYeG3NK2i7ztk/Tw9s52pwWAwV8z6M10S9QW8k5yw730v0LHU4W9yFRHsIagalFRdBx/465+SIvTpMq6hmt/gL6kDPOkTEmi2tApFtE6neHN9//vJ2GS/97LL292IxLlSd53Anfn+0BuG2RSOXPjb9RNN9hQTl8frorTrfEFPGpvG73mBr/GStMFlB1NyB4/bYz9LJVzuZ1n9gLgchGBeo1hdF+ReyxZi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:20:00.6149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abc414f-c547-4063-078a-08df14dfe7b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
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

When aie2_populate_range() faults in pages, it only sets
HMM_PFN_REQ_FAULT. Without HMM_PFN_REQ_WRITE, handle_mm_fault() does not
request write permissions and may populate the CPU page tables with
read-only PTEs.

Check the VMA flags and set HMM_PFN_REQ_WRITE when the VMA has VM_WRITE.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V3:
  Revert the V2 change. Instead, add comment to describe why it is not
an issue.
V2:
  Fix sashiko comment.

 drivers/accel/amdxdna/amdxdna_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index e861db6f9369..a5e30855c8a1 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -418,7 +418,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	mapp->range.notifier = &mapp->notifier;
 	mapp->range.start = vma->vm_start;
 	mapp->range.end = vma->vm_end;
+	/*
+	 * Access permissions are fixed at mmap() time. Changing them later
+	 * with mprotect() is not supported: the range keeps requesting the
+	 * original permissions, so the application may see a fault failure
+	 * or an IOMMU fault.
+	 */
 	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
+	if (vma->vm_flags & VM_WRITE)
+		mapp->range.default_flags |= HMM_PFN_REQ_WRITE;
 	mapp->abo = abo;
 	kref_init(&mapp->refcnt);
 
-- 
2.34.1

