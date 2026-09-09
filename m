Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA15C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E3CC10F1F1;
	Wed,  9 Sep 2026 16:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vUwo+Ff3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4E510F1F1
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7PmC1K/vvJb9tn7Fm1of8XdTcPgjNRejxzQP18d0TLTDxYZnncZEue1aupGe9FxcxOle9voE7bpsJDeOnc76BphPqyPu7s6KatTF4btqPdv+5pLBqhwY2aJUMczDdDe2oNQ3PdDl8H9R4PbnP3UWf7nb35Qs8pd+8URq9BNHbmSr2VyB4rULkMNMpuXvMh6Ns6R+h0yZ2SUBSC30MpCnEL+M/M5FcmoJSpkJ71gACQtuUbvSo3xAlioam9RK0dCynKyYP+JKtvuHgbuvrZAAvLNv5Hx2AFTguGvcQAMZ1FUu3/WZYvTo4acjcaGU/k39MuNO0SjSl1womuo09Vo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olPYyDUk7ClEwuOPKR75lNKZHDovqAMuGIF/AjWATf4=;
 b=AwAWuVly2RXU2MiE4651etdAiOxRTCg6BVolgckh09nI6l7u7PAm6d12tKqIpnax+yy6zgltbM+Kv2vSIvQXnfpegm5IrpZqPGDrGuwE41nyQ2TgqT1RLFpYsNVSUo2HHyRzt2bF9cftPoxIpq9J8Ja5AcS5ZOKI/WNoR2aEdzTYNaKtry1W2MhWkmb1KlWV7t9U7xnSE7MQH/pIHALp0bJ5prGnL/6A2P48aKsl0St06yvr0B3jwyApfQcVECx+AC+lb0Yy+x/DQ98xOCxfVYWCuQFhcyaokHIqGU5Te6pjRttlFw3YrqTkXXAbHEomzWri1BCABbtvTagAwaqmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olPYyDUk7ClEwuOPKR75lNKZHDovqAMuGIF/AjWATf4=;
 b=vUwo+Ff30uu22nJGA64wGVU6CCaaR4/xca44YS6rlI/cGbY70tFACKX/VPM8q04mryBGQUBw5zob4L0CTXRH0YUcep2boc8xg/6BktOvGfqn9IkOTH2SsLp150hpM04nvsRyc6+sXyPdXLjj3GaDxdpeYlH7rxIiSadF9MmNzW8=
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 16:32:15 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::35) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 16:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 16:32:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 11:32:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 11:32:13 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 11:32:12 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1 1/1] accel/amdxdna: Fix unsafe use of handle_mm_fault()
Date: Wed, 9 Sep 2026 09:32:10 -0700
Message-ID: <20260909163211.950709-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: f33b6254-bd89-4c47-ffaf-08df0e8fe883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: nbJNALv7YOTnin+CXx5a49csm7WmvR9SypR6cf7C+FdEOZOAM0HQNQf39qBLj2R2+jJUoSKiLpwCZVlGm4GmFSeOYIM8g7mO0D9xAcDCiKk9kQfbR8/jmiCMDP+yKRrmaEw9R6qwaDj3X921Ykxx5wFm4ZvIk9Wr08hZ01DDaDWRnYaNBzG7OEu/CatA2Q2zfAiakVoIMEssNqoDIEYz7ELNpQ8nEF7hZD4YZGmgjPlZrdXmXQ7GEEaO1E9I45rsjPfouVP5q/LsF4Co+oMMWdXoOXj22EAUGx29WHEWL0VWPg4ZMJvbxuJIMER/FZFqjgkioSwxhDIbyaWEm1+XwyErQcN8ipz2gJV1ThIiiH6pPlXIcjNlGuuPwdPk+OlihGAk5WScfETHPb9IqiC+PIMihG/jlgkmPm47TJUi+Yz8LZtAanZNPnGnxRWdGZ9xaoXLG2CloI+q16xzS/z2LMjHLYuZCKJq9GvWPFV2KnEsfOc4t9CkS4VFemhlg4f3/Npz+eNyOamVlVZfr4WmgxRWoIPpMKMLYLI5jvMN9265bhCnIVJia2DM1OGDIIbBJMJ76skJGZnwMiL/ANll78W251nljbEknqe/pNqUTpcc9jjbKNoGwUTchTfx8CQW0SAtFXwx5JZAfDSLPOfYBc+hJT2tXYxVmeeAq8IXUYl7FJc1NEAhqBhY9/rS321B1lONGGl7EeMWcbqWZh1g3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EJCHiisowTuy8Kb+fP+5whEuBljUr6er21Iutr8MnYhNAgRL2zrR+5jXJbtXefvwtv7geQzWjrk8FXqRqKoW1N5cF+7o14brBHKMb7y5SOyu7dNHXuwkoyWmRSZq7es2OjKMbFLjDYyqfELHmLQzGeqPRVpt/7aNz2GrBFUuHwluBx/c/SYFuGlTojlHUMOsEU4AeC1npUmqkYf12PXSajuCXoCR0wz6prSgIgNAOBYrZKij2Em5KgrXLIyrf46Au19VM06zQcQrjDm5rx+UpyfM57mYN2dvGlCqQpP4XzdVZSgHKAa7cvXxPEfUjWR50dPRuC/ZkGQhkC/PlTE60fD8lE2eq9Dhfy1tx1qA3rO6e7xhb+A8MgF0iyqdZLLSHLlhBztidgTLt34+xfcXjltObi5d7+g0TgWH7SOAxg60hzDJyha7C3AgGC/qqqoQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:32:15.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33b6254-bd89-4c47-ffaf-08df0e8fe883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
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

handle_mm_fault() must not be called from the mmap callback because
the VMA has not yet been linked. The handle_mm_fault() API contract
assumes that the VMA is already linked.

Remove the handle_mm_fault() call from the mmap callback. For shmem
BOs, use remap_pfn_range() instead. For imported BOs, mark the
mapping as invalid and rely on the first command submission to fault
in the pages.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 43 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 0d165b66c1fc..3092e327c500 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -13,6 +13,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-direct.h>
 #include <linux/iosys-map.h>
+#include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 
@@ -490,16 +491,10 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	unsigned long num_pages = vma_pages(vma);
-	unsigned long offset = 0;
+	unsigned long i;
 	int ret;
 
-	if (!is_import_bo(abo)) {
-		ret = drm_gem_shmem_mmap(&abo->base, vma);
-		if (ret) {
-			XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
-			return ret;
-		}
-	} else {
+	if (is_import_bo(abo)) {
 		vma->vm_private_data = NULL;
 		vma->vm_ops = NULL;
 		ret = dma_buf_mmap(abo->dma_buf, vma, 0);
@@ -508,23 +503,33 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 			return ret;
 		}
 
+		amdxdna_mark_mapp_invalid(abo, vma);
+
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
 		drm_gem_object_put(to_gobj(abo));
+		return 0;
+	}
+
+	ret = drm_gem_shmem_mmap(&abo->base, vma);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
+		return ret;
 	}
 
-	do {
-		vm_fault_t fault_ret;
+	for (i = 0; i < num_pages; i++) {
 
-		fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
-					    FAULT_FLAG_WRITE, NULL);
-		if (fault_ret & VM_FAULT_ERROR) {
-			XDNA_ERR(xdna, "Fault in page failed");
-			amdxdna_mark_mapp_invalid(abo, vma);
-			break;
+		ret = remap_pfn_range(vma, vma->vm_start + (i << PAGE_SHIFT),
+				      page_to_pfn(abo->base.pages[vma->vm_pgoff + i]),
+				      PAGE_SIZE, vma->vm_page_prot);
+		if (ret) {
+			if (i > 0)
+				zap_special_vma_range(vma, vma->vm_start, i << PAGE_SHIFT);
+			dma_resv_lock(to_gobj(abo)->resv, NULL);
+			drm_gem_shmem_put_pages_locked(&abo->base);
+			dma_resv_unlock(to_gobj(abo)->resv);
+			return ret;
 		}
-
-		offset += PAGE_SIZE;
-	} while (--num_pages);
+	}
 
 	return 0;
 }
-- 
2.34.1

