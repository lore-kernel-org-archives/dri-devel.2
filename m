Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778ECA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5345E10EF8D;
	Tue,  6 Oct 2026 04:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsguPSlE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A274210EF7B
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNjJr8D07u0q7ZnMW4mEtzjCgCqnayOaHAdouubq+4aA1cGN//a2sEuBNYOymlSt52wPy/0tYLzZWOFVN+n5yBzeH3/U8zbBkG3pK+ofjG6MesK9XBtZipl+jNomDz5ZMJyr2MMYKEoSIs+9FfrZN88gI243mSVPXg4p8Ev+RQA44F+z/6lXL6vve3E3gMtAdo0w9xAW0r+w8a/VHpE9vi66Q6WMcBbYKsmiObNLBhFG0BfuNiGKJbqi9RvRkaWnNOKIx1sPO7G+2rMySiaMjb835IruSC6NjAU4tDpwQGVUuU0zmCvpxOgaXpVORnr/+CGm1I64yI+LHQE97wukQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w20RjS560B9YC3hMbO43Q+NqtWgj/M9oypwSWtcgi0=;
 b=HQU09DaJyLfOnvYG1n8JnRQR/+KptELDdiTdN22vDjIH2Zd2actSO7Z2NeG+2agKKmpq2ybR2CvdSp0JzCqD05EJmYQsbr+8Fu1kkGhXcbTiFGautBq1d+SEwuA97hLQ6tOl3OZCfBGduoLCya1hCGtqbw8noDOWiqfnF/6QL/YU2sUepHH8H+E3N7ZuXNflhGWBqh4IDZzmnpntqOuS2FOTX9qnhMQPUBmTY0I3q2MeZWX1jK94Hi71TpWA9PHq3LrhvQwfxMNzFwp4qpHDxKVwjnYyLz1KuxWxR6ChObTL+ZM8QhKtXSDCVh8zy35eh4TiAfPgu04MzfB9Sdm8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w20RjS560B9YC3hMbO43Q+NqtWgj/M9oypwSWtcgi0=;
 b=jsguPSlEWmZk3MPGEawXWiPcpWqgWKt0ozgifMiyJV7MQ9DTns/uUQ1OyuGXiGsZnB0VHuuF4bAUw2XU2QzoGGNqIdYw1JoSsxQiiQwrleg6a+MiDPZG0pkDgcP6Djk1WJSzfRv+eJOt9pO51zT9SDuvLmJt1AeDBCqzTm/LkJg=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 04:23:00 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::c) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:23:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:23:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:59 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:57 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <Hayden.Laccabue@amd.com>
Subject: [PATCH V2 15/20] accel/amdxdna: Make hmm_invalidate common for AIE2
 and AIE4
Date: Mon, 5 Oct 2026 21:22:25 -0700
Message-ID: <20261006042230.547807-16-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a338690-3a99-40ce-e7db-08df2361818a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 80XsnHR20VeFtK0wUqKhbrPoOZmgbmeEWKbFShDViLIMQd6PyYsNOMzK2chaRQYqUE5AeLShYOqXB0Iq25FP6W2gayAqBlaGznxlSY1QPRqvLVlWaHuCd0AGZV704n6uqyqE0WvpS3zdtI28qsHKArg0+keDtf1ZS370T4zeFCnBtdU7RrJiuSB/hwkCvE6w3fcQLhi18u6hYlfmdLcwlGvx5yv7Z2GMFz+c+hmzU/wy8A7cr1IcflrHopaSilMvBsvqHSE7nBmoyKTo3wU4UpyKWA83fbBiqrQ0PXbJUs5RAbVZQ1AWdowfWFQdiWYcwnwUlyzbY6OUFAbbkUv0EYCy3yx5apisSpiQZjVGvFT3rkV1hRDdUkyWX6f5juyetxtwCJjHN9cXvpqr/jmcmK1ODa/10ZOGxvpD9LocsClx6Gynv/rgOolrN8s/cukP8m2u0XTlO1g+4DeKrtMvP9h2tTcFpybxO5Selrd3id8TdBLN2ANnv3nWoex0sQe/vhZvbozSOTq2Lf2rB3IaKQYzfx4TKh7DzICbzK9sufWkKsxrcqohSZwi6bbQZqIC5TL68Bgeh6t+G2G3/nss0x/soGCDsJsQTTfhH0MamWK4rwPCLBan+MzndjyKSVH+IHiiHqjQAKwjwlLcppGkvCcVpWfyFZWCFzldMepeeC2RnjrFnyRnt6cMLwJLMbti91exZodg7fnNAsMaEaDTeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lyDmsKthRgPP4jIluzR+6NPoIfobbt79vTEfOXXqyke4hfvVOWoqAe3Edrwaud1svMDAJeohLPOyx0juSjnGXerTXye586nrAqBpw0q+O1WXZF7ZgKDVvFx4TD9s0Nh+EbSZYV29BgIuR6Rt1tBCQ6wAYdCPcpIEfupF9wim7JRPKJSYv2+ZxqZtVERWsEL2G3aQH8cZeavUwJJKvJ0mwBdiBebcDNIWXuvDvjZo+Wy+8xjlBJyO+s9yf0mnB1d0UH5vpl06hHuTQ6Smq8PDyBL+TiN9mckfG55X/rj/K79OCnsRNgIVzMApsJshEmI/Ix/A8Y3KggfGEkWZqukZle4LA3dHdTZT5HnbNJXJkHQ8E/E0LvM8UUceiiQzNVHgSJH72fZj0FR98soAqRx2ipxhCtoVBMvRalCRUNHvaQR26wfUbkhwgYwbPzuGQqsb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:23:00.1648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a338690-3a99-40ce-e7db-08df2361818a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

The HMM range invalidation callback (.hmm_invalidate) has identical
logic across NPU generations: waiting on the GEM object's reservation
fences using dma_resv_wait_timeout() with DMA_RESV_USAGE_BOOKKEEP.

Consolidate this callback by moving it from aie2_ctx.c into aie.c as
aie_hmm_invalidate(), and declare it in aie.h. Wire .hmm_invalidate to
aie_hmm_invalidate in aie2_ops, aie4_vf_ops, and aie4_classic_ops.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie.c      | 18 ++++++++++++++++++
 drivers/accel/amdxdna/aie.h      |  2 ++
 drivers/accel/amdxdna/aie2_ctx.c | 15 ---------------
 drivers/accel/amdxdna/aie2_pci.c |  2 +-
 drivers/accel/amdxdna/aie2_pci.h |  1 -
 drivers/accel/amdxdna/aie4_pci.c |  2 ++
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index 01a439c0ccf4..010d94715ff4 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -3,9 +3,12 @@
  * Copyright (C) 2026, Advanced Micro Devices, Inc.
  */
 
+#include <linux/dma-resv.h>
 #include <linux/errno.h>
+#include <linux/sched.h>
 
 #include "aie.h"
+#include "amdxdna_gem.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_mailbox.h"
 #include "amdxdna_pci_drv.h"
@@ -202,3 +205,18 @@ void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
 
 	dma_free_noncoherent(xdna->ddev.dev, size, cpu_addr, dma_addr, DMA_FROM_DEVICE);
 }
+
+void aie_hmm_invalidate(struct amdxdna_gem_obj *abo,
+			unsigned long cur_seq)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
+	struct drm_gem_object *gobj = to_gobj(abo);
+	long ret;
+
+	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (!ret)
+		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
+	else if (ret == -ERESTARTSYS)
+		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
+}
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 6268b708d17b..5cb9ebf45379 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -14,6 +14,7 @@
 
 struct psp_device;
 struct smu_device;
+struct amdxdna_gem_obj;
 
 struct aie_device {
 	struct amdxdna_dev *xdna;
@@ -141,6 +142,7 @@ void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
 			       dma_addr_t *dma_addr);
 void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
 			     void *cpu_addr, dma_addr_t dma_addr);
+void aie_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
 int amdxdna_get_aie_version(struct amdxdna_client *client,
 			    struct amdxdna_drm_get_info *args,
 			    struct amdxdna_drm_query_aie_version *version);
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index d927c8c9d557..8c1b29964f8f 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1277,21 +1277,6 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	return ret;
 }
 
-void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
-			 unsigned long cur_seq)
-{
-	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
-	struct drm_gem_object *gobj = to_gobj(abo);
-	long ret;
-
-	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
-				    true, MAX_SCHEDULE_TIMEOUT);
-	if (!ret)
-		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
-	else if (ret == -ERESTARTSYS)
-		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
-}
-
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
 			   struct amdxdna_gem_obj *heap)
 {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index b70af1923643..c4e916e832cb 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1216,7 +1216,7 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.hwctx_config = aie2_hwctx_config,
 	.hwctx_sync_debug_bo = aie2_hwctx_sync_debug_bo,
 	.cmd_submit = aie2_cmd_submit,
-	.hmm_invalidate = aie2_hmm_invalidate,
+	.hmm_invalidate = aie_hmm_invalidate,
 	.get_array = aie2_get_array,
 	.get_dev_revision = aie2_get_dev_rev,
 	.hwctx_heap_expand = aie2_hwctx_heap_expand,
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 0c8dd6510292..ba17df97223a 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -272,7 +272,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 void aie2_hwctx_suspend(struct amdxdna_client *client);
 int aie2_hwctx_resume(struct amdxdna_client *client);
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
-void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
 
 #endif /* _AIE2_PCI_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index c7b12bde50c0..3b930197d5ee 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1082,6 +1082,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
+	.hmm_invalidate		= aie_hmm_invalidate,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
 };
@@ -1095,6 +1096,7 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
+	.hmm_invalidate		= aie_hmm_invalidate,
 	.get_aie_info		= aie4_get_info,
 	.set_aie_state		= aie4_set_state,
 };
-- 
2.34.1

