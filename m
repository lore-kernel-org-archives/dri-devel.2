Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F303C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0166D10F3B2;
	Fri, 31 Jul 2026 19:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Qiu5xlR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5503F10F3B1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 19:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwplVRk+yaR8kuH4d57Go4UynlVoPDtLO9HiWhTZIouG9ADH75YNWd1e7lNRXtmgX9STVYthSiJtM+u4sF3+jIz4AufrpcBQbGriu0xA4w8DVj4ifl6lrb43k4M/d6odo/T0+2Y0f051UnbK7KpOvz5ZJLrfHNTgE/3oR/ED/FU5mZUSX8NxzsPRnp8M+QoQEJzk6YWWGC3uC4XS5FdsoxmW1fx8QnGHX/m+cP6GbGh6Ja+5dNZUsS9kpcpd8fdcvdwvLyFYFyD8FtrFgy+2SCpZE0uAwUMRyCh2VoIgnvRj9s21kDiVR1cJ4L2NcKdlf8VwstmWDegv9g49UxlR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0FOW/WNJ1G25JZPuEuZPW2tmCY266qKJPGeefpTxDQ=;
 b=UTCWHJOXTjsfReci6SvtOOBySxk8Nmh4uD8AIukRZxk0nPRaOwsEqFuaXBoOYAOi4MwusKiUCAbhxvkBaYakobS60AiiwkVZVAy4F66k2O4WgA6Den8JWTyolgzRDxq5w2aaNBw0vqn0UAxnPpUTVff83dyUR7K7gPgCurG0+hClnwcuLMY4ddwkPq2IrqesaPrs/1ASa3M9b8y2lim3xCC1T6jRrRD4bLvUeNLkQdYbP4ZoYEwhxAO90BOnElXxLwV918TYZbfb7czlYrHrrvgNoQJfGKAjXw87BIzbSTG+4eog2ClcJ5ifv3wMOhoY1Xz3+ItW0fzN5y8UjLsrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0FOW/WNJ1G25JZPuEuZPW2tmCY266qKJPGeefpTxDQ=;
 b=5Qiu5xlRlpX5wYwu5Q+Zpi3aCJjaccz7wNG0nn996Khw0Q+WelCTvUG+/jsk0UnT7xoAljvNCr2EujGKLc5/2TxtysqgVYDBDobopz1Sg6mF3SjS3ZjdxQ77xC89PPECpwBkYWnaPO5b2Z83oVOjWTz/nze9VVPSyzkavY+70jE=
Received: from BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::7)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:59:58 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::3a) by BY1P220CA0039.outlook.office365.com
 (2603:10b6:a03:59e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 18:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:59:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:59:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:59:57 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:59:56 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix locally exploitable BUG_ON in
 amdxdna_insert_pages()
Date: Fri, 31 Jul 2026 11:59:55 -0700
Message-ID: <20260731185955.3449311-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: ce799e6f-4176-4e52-6f55-08deef35eace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: X7htCTB/uKCSp1X0rHC5Hf/YKh310FMcaLH5OwfvSnUSoFua2q7bf2RKl0NEL38+hq0IzAq5DrNlDervz8GEcfcKTfvuA/A6OMK5g42JFI536yRgfyFMi8OuAVcmMPbH800S/FLVyl6hhCwuFKJh0+bVpaBnpeZOA/YbA6gk1N3tz9DPdaOiS2Vgh2e7O8ywSQBPWw1IFhwP26GOQmx1D9pJSZdXL/jL3uGeIIe/MTNQ3btKfuFzPOzkddO80uucykc6qTpakaYdDfCXdOg+8eOhfvYOEVemdRHhAvqG52PyTn8USpYjnEUXYWtQ48ARYH25WkGUVfNOnabslxRLLY8Mjww8+SISSolFIHwVxZXoNfLfE7hdJzrc3oTPXpHI3W5FuIeH5wse0lLDEtaXPbo77z482Q9T37JqabQ/386CgdUZ1w2ZUpt2p/YLAszfZY6oD/H2JUOS24++5VJDC+C0MBQVg3mLtGiyHu/xJ9FXituzvdms2Iiopbnc9VMYUhm55Gv4RfxsUKJb98E8HMZn63hG36wvMMkBrh8KG0c5TX8W9Xe2opYjd+vNkn/d48eakn8LrXGfo9gOSvOc6FoUfZymzpJN4wjWyCOMYroX5EwUr8NS1xLONzPwvbdbsnWsP2odWoeymM8tAZXRP0eBWw1rLzBwbgMWHLYgl3m9uigZ/SQUnzhKLqi2GkeFXydEpdwlshKQ4cIGbraQ/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(3023799007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i4MorI4hO05iyHn6auCa2EesyN0a3o1wCrnFvcECexTAOQhGAZQLnpKvIGBFlst2rc93JQDVB7h8JnNpOo5DOv+W+ztaHi/F1INMumhk7Ru8KJoW835A0eIxrPUZogwzxmBBnXTefe7AIP+4XsQHrRFigMXf0fcFVssGy65ZLhwIKLv6UFDXNSQ/leGGz28Le+ctW8TN35/w2C5+qirtL9Vpht4nLl3x+IYDV+XqmVsJWrDIawk/5vENvdM+rla9E0lwHEh2ZpJ3Y08V+t6zzXKiwRf5bxe7+Q+Lavxck7dPcx5khqB+S3PW6wAGp/d2by7dt+XruRH49Jpm7xEpdO4HTTGyjmlJH2oKuQial911kSwEmuQyagIzRJ7OFHqh7mBPwSxVjccFukIzn/Wz+1PICqY91NThb5dVX/LIXbA5TR/6LUUqqVdr0FLhsE4i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:59:58.3556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce799e6f-4176-4e52-6f55-08deef35eace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
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

In amdxdna_insert_pages(), vm_flags_mod() sets VM_MIXEDMAP and clears
VM_PFNMAP. If an unprivileged userspace process mmaps a non-imported GEM
object and then calls madvise(MADV_DONTNEED), the PTEs will be
successfully cleared because VM_MIXEDMAP allows this (unlike VM_PFNMAP).

When userspace subsequently accesses the memory, drm_gem_shmem_fault()
handles the page fault and attempts to map the backing shmem page via
vmf_insert_pfn() which calls vmf_insert_pfn_prot(). Because the backing
shmem page is normal system memory (pfn_valid(pfn) is true) and the VMA
now has VM_MIXEDMAP set, won't this predictably trigger the explicit
assertion BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))

Fix by removing the vm_flags_mod() call and replacing the vm_insert_pages()
pre-population with the handle_mm_fault() loop that was already used for
the import (dma-buf) path.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index aec69d5f463e..1c63eff0a4a8 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -467,25 +467,17 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 			XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
 			return ret;
 		}
-
-		/* The buffer is based on memory pages. Fix the flag. */
-		vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
-		ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages,
-				      &num_pages);
+	} else {
+		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+		ret = dma_buf_mmap(abo->dma_buf, vma, 0);
 		if (ret) {
-			XDNA_ERR(xdna, "Failed insert pages %d", ret);
-			amdxdna_mark_mapp_invalid(abo, vma);
+			XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
+			return ret;
 		}
 
-		return 0;
-	}
-
-	vma->vm_private_data = NULL;
-	vma->vm_ops = NULL;
-	ret = dma_buf_mmap(abo->dma_buf, vma, 0);
-	if (ret) {
-		XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
-		return ret;
+		/* Drop the reference drm_gem_mmap_obj() acquired.*/
+		drm_gem_object_put(to_gobj(abo));
 	}
 
 	do {
@@ -502,9 +494,6 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 		offset += PAGE_SIZE;
 	} while (--num_pages);
 
-	/* Drop the reference drm_gem_mmap_obj() acquired.*/
-	drm_gem_object_put(to_gobj(abo));
-
 	return 0;
 }
 
-- 
2.34.1

