Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1117FC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AC810E745;
	Thu, 17 Sep 2026 16:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kCvZ4dCN";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6541710E766
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3u9OKoGO7u3djixUNiXz//uoqT/skoh6LS2NNGJa/8Gxr/z56EDH7DrVz7jtBm2D02bbgZMwJwyBM2q2GI/cma6xVGmHSmd0Vnk7Fmk8Gw/n6OgOH3qhKTUcFmVdHZLrfSKEXDqz9uvEMeo+gsFKcNGFm8XyvHy+AbYD7YRt2H2VzCYWy+Um6BG0lnidwowQd66EX2pQY5KHNJnLJFTdyEHsvrE8qBOmDVVEbiawff85H5/asCwK+UCQNoq5BfVCZ2cNo4IHoKni3iSmqzNaAqD0Qkb8Z6upX3KKn+MhGbhQWl8s93F3ZWLyPPLwwpV5VctJht/oTjgkA4FwZomUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWTddPqlftsjH7l1b7QvikDR0/WlQ9I11h3NPlPOePQ=;
 b=juEJTgIEmWxv4rttjlEePPjaPJu3FHlAc6xls+dI0b2DMXM6F3hxlMbWhw2bew+MO6S0xRS+uGkBBNnwaEIAn6zlhzqFa6I6HtwIPEk3kKV0t/RBLbUkb+rlR55q8Cgf+tO5vq9FXc10R42YDrTimTNykgwNb4EjGIS2y/ywtPyglqshG/EjYcG9r9PIqH5KN/TTB/HibpMK42Q1GNfLEFtHWaE7+gxv8tbovT6wwHGdq/W4vq3BmboI4KHu99m253IoWNDWc3T6rs5kCPPWoI5o6GmEecA93Abve3XYIXoZTgVmEHTVVk1nkb8pBNRUlan9+jeTdq0PUkUWIn8apA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWTddPqlftsjH7l1b7QvikDR0/WlQ9I11h3NPlPOePQ=;
 b=kCvZ4dCNPWXyLag4GfmDTVKdkX0/E/Rjb57aaHznHJY4bVk8F6c25oQ/xQlGLVXRtv5hFVslFW+wxNYysNzs9K3TtORNj02NI1LMVKEt+ebgcTy5bMyvvNZkkELGI3tF88VHLafTTJHb52KiD8/MmISacv/A55yoL0PbpHTSN4w=
Received: from MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 16:54:11 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::42) by MN2PR22CA0018.outlook.office365.com
 (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 16:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 16:54:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 11:54:11 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 11:54:10 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults
Date: Thu, 17 Sep 2026 09:54:06 -0700
Message-ID: <20260917165406.1881899-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: c07abe1e-e5d7-4c3a-b736-08df14dc4c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4eO/vFjNsZJoP9g9IB4IkSdzTyeqqjFOaSBfDgYa3D02KdVTHleNh1K4gwgbxNpquIHSdeiGrK7V5aggx70R26X/LLSUWl4AyJcV1Ne8iHlqe7oAFiJ+Y2p3V/L/W7AyA+XUaIZIpYe6+L1O1WTp736j2VRPS+jaLjnSzZh2KNKasGsESCeFtfVSDWPGRITdThxpCrOa1HQHikEJnwt8rQjBMVhMJbqnuL/Seu7ReUKulyNIyOMo8KO35xUi2gJs9+s5LPb0j2b0gwWmYf5gIT7imD8do9QHUkqND62GiYZ60PXCMj2vF6BIz2TV+6i0wTUSlKfCIIMvUDXaLVIKpvWfnB5nqNEVPjdrNDJilU2H6VkN4MGmyikrp523WcMOHfSkK4MzjjS8SZmeCkooQFrPW/WVn8/QOtNvFUHc/vsg4KGEeoP4CdamK/5SxAYK55GJUQtsjTruDSMPqtfgD+51IndJk6QA8mR4B+sbH23eX4GXDqgctiTJg1svtRbPYlaSxhGDniJzYIKT2z3h5iVSwNW58Nlv0J0y75HtKfGl0OVUvVYWQKMctmqNifFkRsmqnJHsvaqvl/zib6EYKD+9UDEQYLd5ApfWV8eyJ15dmCaGztnvEl6TWKUL0YI9FipzBXaOK2gz6R8XWs+Hn9AD9NoUXUbUxX7Rgu1xYUdPD3HTlb498MUNf67yoZIEnMBqNzfC/wpe0SKFYm+mvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pPpCSQuSZY2tzi7PMxkH5XKbfh4e+1cCkw2rsOR/9fDm8w8IK6wUGZX60VqeHk9H98hnFucqpT2OUb7GaYYhc8b9Fw1iKyTCugAzTQEUoI8mFElFKTENHFUfN8fbvgo4WxNV/LPDGk/UELtfkB6gEBWXO/l2hl2LZ/evlX8evFuB5KGspfeYuOOVbLm8ysTfb73rFjQX6JA3yLJNYjahIUWxas6vAx+lqkzGw826e+S8nFZF5aZ4r2g0gn9PjppOpJGW99BdU4TCddReplyAaGKsK3YqrRKaTVRKTOB5O6inP3h4Bysfk0GSaTUu/jGLilqV8yaXEdaGxrW4itdbZ1mXCAHSrrpuxUONTFufynd2QRFPmR+tMMDcTu4N+Sn3zKBXkXMI/jBmpKeyTnx1Td1ks7ya1zRWOVNdqhpmMWAf6X6bISWgqSDunpdeq0By
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:54:11.7155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07abe1e-e5d7-4c3a-b736-08df14dc4c6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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
V2:
  Fix sashiko comment.
 drivers/accel/amdxdna/amdxdna_gem.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index e861db6f9369..42d5f856a839 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -249,6 +249,20 @@ u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo)
 	return amdxdna_obj_dma_addr(abo);
 }
 
+static void amdxdna_umap_set_fault_flags(struct amdxdna_umap *mapp,
+					 struct vm_area_struct *vma)
+{
+	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
+
+	if (!vma)
+		vma = vma_lookup(mapp->notifier.mm, mapp->range.start);
+
+	if (vma && vma->vm_start <= mapp->range.start &&
+	    vma->vm_end >= mapp->range.end &&
+	    (vma->vm_flags & VM_WRITE))
+		mapp->range.default_flags |= HMM_PFN_REQ_WRITE;
+}
+
 static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 				   const struct mmu_notifier_range *range,
 				   unsigned long cur_seq)
@@ -270,6 +284,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	down_write(&xdna->notifier_lock);
 	abo->mem.map_invalid = true;
 	mapp->invalid = true;
+	amdxdna_umap_set_fault_flags(mapp, NULL);
 	mmu_interval_set_seq(&mapp->notifier, cur_seq);
 	up_write(&xdna->notifier_lock);
 
@@ -418,7 +433,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	mapp->range.notifier = &mapp->notifier;
 	mapp->range.start = vma->vm_start;
 	mapp->range.end = vma->vm_end;
-	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
+	amdxdna_umap_set_fault_flags(mapp, vma);
 	mapp->abo = abo;
 	kref_init(&mapp->refcnt);
 
-- 
2.34.1

