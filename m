Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C0CC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BF810E4B7;
	Thu, 17 Sep 2026 15:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2j3hIqa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E17A10E4B7
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 15:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTOaJUHMrzh4+td5dc9B9kJpiiLzm1WX/3Fk27buCzb8BnS22R5YwOD3MDVb3GGhsY3jTFUgClpGx5MswtCSVHkyHYzdWY7UjCu2qTli/jYSFjM3DfE0QWKF+S8azOXVGCaRbi2VbUnGutHflf9SOFWFnFzfVEKb0T6+R1FdQk3sAeHl3p94r3/sgrfyl03cR1tm5vbqMBGP7ieAyLAulQ15ruad8yJkcxXhnIr5O4ZK/9dCeRTe/MZuKAOXW7yNUXoArM+8cPWhVFzc0pl1n4SveWrOnpTG/KYCepH3mkgbNFydnC8ky8yWRFFol9S87IjcZqUte1SUF5taf8a89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgo8ebSzQuNyMtzLHnjfq1PVnJ6HLhISBsQfNQfVmoU=;
 b=hfuwPPjA8yfovKTZupkdoWO6S+0EL7m5m2MmVfiQ9rttGMTdoDb1qQqEEvDYYKtZaVjQHDFNXUujS3DHzCRahRKxZhirQOExvvcEpNrxt2DE2YIZvFGtwiHobYD7iTvAGHxEFYC/M9CxE2+GZ1sAw7qMjm2pFYPk1Bj3i7v8jrciW3vcaVgIZgl1rEYUx4Dpsby5f2x34aHvfFN4qSIL3FACPpGf260hhhNZEMFdc34fWXKGe70ubKDWPTa8K90kcQGktnPfCzFVzvLD3oTSQe6hQ17oXOzkFrHLwVQ0cNYC62RPDm5uBBcAu7tZOcxmbsCdtlG1RlFVSv1JaFs/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgo8ebSzQuNyMtzLHnjfq1PVnJ6HLhISBsQfNQfVmoU=;
 b=d2j3hIqaPcWCiAvnVb41gfGsY4lWxcdm+pmDCWb9XLBgJ1xZGMurXmi4ANsiBQMBWBzHKdezbCVVjzS+VAw9V9wJbbBz5f+zFQS7ui53wepKZccp/UUheEJz5xtE93VWSePI1YTFAlqJ021DL/4nIna+E5yJ/RQihRXWSl7ZSos=
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 15:49:28 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:510:34b:cafe::70) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 15:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 15:49:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:49:27 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 10:49:27 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults
Date: Thu, 17 Sep 2026 08:49:20 -0700
Message-ID: <20260917154920.1872289-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b67185-9e6d-4276-8b42-08df14d34193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: rPJjhOlOymE4cIugAmtSdmYCJej1/t+c/xke/ZeNRFh46llLlRCBbEXGN2WdEyoYXJVGPNNq89hI4dXMHyZgdDwtVsrxqrOsyhwwzSEf+wpqwu5Y2DoNP1PImSTl8j+OjotIafNP9fmzLTt221Y7CNf69kp79emvdraLq1fHmhiOqhJQi6w4NGeVY4rtfsu/jvZZKAIbe4oIALh2oId55OO9lMrVbWAI+wDM+zNuKO5w2IGZwfXNW8WuEjVnhLZGzIQc2lJ0yba3f8CbSdO3end29XIMfLpM2zHAoCXFXiBLCDC02NWVqQW7/gdN26n64otl4d9VClnYyLc72Zv+gohQLlGte+MwpJNkwnB+4mQA5vZH+1vBW8yjMlw2TnM9HuMjPqDQWhXORQzh4FzrRrJANUlQwmbLWncI7vI4S0jbaf53XMPEu6x5Y9Jr32LOys6+HXs9zeLXDexoDdUi2+03C/PPFE59xK3nW3QQtYKd0Cg0nouLfx/JtHbhmLorgultkGk+ePPNS4A8jUXnGlmMRh/IMEZEEvNrQ0hqknT6+RPY/NEhtPnXK0DaNtSz/3gGK7Ld+LxTwOwnP/iaIuHja0vjRfIilbGGxHnOpEe0T4GARdQnuxTEYRJd4pjQZmMuX+JSNXaA78L3BDCevGLZGJwVVBlDHQ+HHpjJPNTxjHPBy84mnzB2gRvagfyQ9S+ihPQ26lKufHsQA1cYoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: woo0QTVjB4RKSXhmnE3ba3MeUvn8ifQYl7FSvjJ5lVhZKKRMkcEPg5qut8KYnKVR8RZkmznevjiwCHTXctPlLR1cGgRdAxglpEDYQaLQoWFv0XdlW7bLg4PH3hNhFIllRHGTEvjl/Fr30JIDbYN4MraBTii5l+ONnsfqkddb/1O1SiJdivr5EjRQmq6DjR/mqJ3nN/PHTgjV6S51bdVyeHZl96YVpVsHvjNvLaRASnsgB6N/rQoZaqqc5wA+fPxg1kNWjomHInUtzhAdGgLfi95ecwn6JFSSRenZm+JL/tkb22UaKHAf2sJRpceHwnDTmHhsTkN3iRJbsP4fm0iPEKxsDKkBC7Tr803BAw0mI0FEUWcMgmG3rXcqlE5WHv82zQ9dEfmvRciP+poScw0gDqmv22ugvk1yiE2ZZGeR2Vwy3EgwB0mGeqqw0g88GiMM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:49:28.0446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b67185-9e6d-4276-8b42-08df14d34193
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
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
 drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 398d0a58b53a..fc3c2c6665aa 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -381,6 +381,8 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	mapp->range.start = vma->vm_start;
 	mapp->range.end = vma->vm_end;
 	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
+	if (vma->vm_flags & VM_WRITE)
+		mapp->range.default_flags |= HMM_PFN_REQ_WRITE;
 	mapp->abo = abo;
 	kref_init(&mapp->refcnt);
 
-- 
2.34.1

