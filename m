Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2628606AEFB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jemFO3cb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B730810EFC2;
	Mon, 19 Oct 2026 16:48:43 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8A310ECC4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDSyDVn+fWuQ6+uCiwtbES1oUx+twhytV2EhtwmUQpqKI9YJwaWMYY4YHLR3mZW2rKrh7VqpK8HNOWn2iV0ERGeCwuhRNd7wuK9HOIxg+cAgZnP4WBCdTNjVM48O3ouFjI4/mFOQapjEd8rhKe47FXSpVgCxlFn/HE9J/v31aMWHgBMy+141+qjlYDEUQmxJMrn6PQEq1+hOC8mhYjsBb7BAUuhnuPbmQPGLatv37GZYLSnlwCiedhR4bvTuVPSeRDC+QSOB8HK1zVKXL1lEdthdHkZkvXNpOiGTz9cXYAxx0KckIesSS4WazCdfPdVD0wzfQznLc+Q6RMDPJ31QYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HNk6GCUzLUCPaFcOfJ8t8Zj7EuwIZpJu7adDznM1II=;
 b=KBleuPGuYfIjmYG9GvBj9OSoaKGJe9JwXD4un5Fn+tXc/9nIlmuDxt54OeHQAB131vJ7x6DtR/nZC+trxGlRgciFPYsRwEwMmOZy3d+E4A4YDnbJDAYwFtDC45xzxBWwoHmxxw7MZauA/NRn38qxE1vl39kwhhmtPoAI1eCkOw0gOr93Uno8UibDkj/yUEPycf2FD37xvn6aVHilK4BvJIBS5Dz7nnMJlXorkCCzZf1suqffKRgZFIaRiWJuZvK0mYtm0NKOU7QKHADsODg2qQkfXJRyfXnQD6wVk3fYeuSWuh5CfCpBiZwG+nE6BwGaxPDzGK8ff3S4dt+vBcl6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HNk6GCUzLUCPaFcOfJ8t8Zj7EuwIZpJu7adDznM1II=;
 b=jemFO3cbf9PREEOyiTdJrkKPHYzig3MoSTOM7GjYbv+SE3n5nLyMfsAn3fwRFjS06RNWyQsHXExQt1yZ68cDBqeQGgqVjqO29p/A7ay3cqql2neALs0aZTbZeL8i0HN+UQDCOTSKfAfu83lqyFtZmkJnE2pbytUosDsudVWmUmk=
Received: from DS7P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::15) by
 EAYPR12MB999155.namprd12.prod.outlook.com (2603:10b6:303:2be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:48:02 +0000
Received: from DS4PEPF000001BE.namprd21.prod.outlook.com
 (2603:10b6:8:25b:cafe::2c) by DS7P221CA0009.outlook.office365.com
 (2603:10b6:8:25b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:48:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001BE.mail.protection.outlook.com (10.167.23.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 16:48:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:54 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:53 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <Hayden.Laccabue@amd.com>
Subject: [PATCH V5 14/19] accel/amdxdna: Move HMM invalidate wait into common
 GEM code
Date: Mon, 19 Oct 2026 09:47:41 -0700
Message-ID: <20261019164746.827277-15-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BE:EE_|EAYPR12MB999155:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e488e6c-dfbb-49b6-219c-08df2e00bd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ImExBB1S3eDNhbQZJZmKWNx/bekDoLrNgFl96hjln1KO5dT29cfNmJI5BJ0YH2/GV881ucdIqwVAyeqNW/o4GJGKlzgaui/mG16gIDWnlPR+aHgzJobD86qg70xFPN1ZQkIHgNj9I71WTmXDehYFwXjSAT3YScK0IbTP1zEKsgLOW/eAIH1fRzhCIg4slOxDnUJzh7yTeyDWlN4D+5N6IPsm14KrAOMP9zc/bVHQK4AsP5Cf4+wrnJZtjvLJ2FjXz0rhShpeqY18Dy1m792hq0WUJ5L80xgILdONu7/XXzM0ZSHPcR2ySSKqmyPE5wNBYS+nZTKVzYye6Y8o8RxbUlS7Wt0yaANMQRC7oZCbnuA6FvKPZLhfPHKQMYnM+ZqVyZC/T2gSsH0otCQpPHlkY93jFGQTw5BUQ7hVQfhV2gtWEAfN/Er/C8KHHlwC+YsiwTV/seBo6tz/RAM5jKYw2jokE7/+sHxty90UKKFEvfXHEwhATGi8nQS/ymt1cd5xhM55i/fWSRDk5GABCztag2edcbV/47t+uJz2Nbhr4fXrbVR/z5yIATxfwcPn/alyuv2TSBWLGYQTFlgRXPz8IqEfkyzzH+8fdGp1jfipdks3HtKYUWhQUFR5+Ybj3UHS3HAt+D9rYWwcNRXaZ5GTIaJf3CxTV97qwyd4UzkQyYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sqBZEjvSBQKISAQTkeWvk/gYobygRqir0fsrbSmo+20ePnQZaTWb9C7PderuCoDA30Ij1+zLr6FcdJb73P/PRvYz3TdmGRKMjpUdfXgs/q+oc/Sb/3OkEtqy0kJBx2zUjxrwDEppABLzndaRQIN9pk0bA8ff4RRkkLiVhkM2QElfOatvpzgQd+mghxAMsLfjJnBg3gFq1Rw7EmZNoji9s9plee+UOg9o3u7yE+F5NJv3GQ85bXS3fl8VZtqci5XAtZYElx3gBvo1dhR67xbRO5CzS48XXAcQwWlFHjslgvnAtlogzREgUUxfU7+rWR4sOgw4JJJNDcCRICyaHGn43G1y/wyVSHKIqyy7XsvSEXSlU8Caa3ApzFJT2auRs/hfYB5MKn9LT+I4/tObzWZ9ANxzc9X8qI4vtAKpaMdmdtNLmKwuyUmhx6GwpBWZjOfP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:02.4938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e488e6c-dfbb-49b6-219c-08df2e00bd94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001BE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999155
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a user mapping of a BO is invalidated, the driver must wait for
the BO's reservation fences before the pages are released. AIE2 does
this in aie2_hmm_invalidate() through the .hmm_invalidate callback,
and AIE4 needs the same wait.

Do the wait directly in amdxdna_hmm_invalidate() in amdxdna_gem.c and
remove the .hmm_invalidate callback and aie2_hmm_invalidate(). Devices
that do not attach fences to user BOs return from the wait at once.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c        | 11 -----------
 drivers/accel/amdxdna/aie2_pci.c        |  1 -
 drivers/accel/amdxdna/aie2_pci.h        |  1 -
 drivers/accel/amdxdna/amdxdna_gem.c     |  9 +++++++--
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 6f63a8f94215..1c3cc32f119b 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1288,17 +1288,6 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	return ret;
 }
 
-void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
-			 unsigned long cur_seq)
-{
-	/*
-	 * The pages must not be released while the device may still access
-	 * them, so this wait must be neither interruptible nor time limited.
-	 */
-	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
-			      false, MAX_SCHEDULE_TIMEOUT);
-}
-
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
 			   struct amdxdna_gem_obj *heap)
 {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 1b029d33a24b..690ad035463c 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1228,7 +1228,6 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.hwctx_config = aie2_hwctx_config,
 	.hwctx_sync_debug_bo = aie2_hwctx_sync_debug_bo,
 	.cmd_submit = aie2_cmd_submit,
-	.hmm_invalidate = aie2_hmm_invalidate,
 	.get_array = aie2_get_array,
 	.get_dev_revision = aie2_get_dev_rev,
 	.hwctx_heap_expand = aie2_hwctx_heap_expand,
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 709e7545c65f..13391275df31 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -272,7 +272,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 void aie2_hwctx_suspend(struct amdxdna_client *client);
 int aie2_hwctx_resume(struct amdxdna_client *client);
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
-void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
 
 #endif /* _AIE2_PCI_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 37bfa5058095..0af1506f6363 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -12,6 +12,7 @@
 #include <drm/gpu_scheduler.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-resv.h>
 #include <linux/iosys-map.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
@@ -249,8 +250,12 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
 	mmu_interval_set_seq(&mapp->notifier, cur_seq);
 	up_write(&xdna->notifier_lock);
 
-	if (xdna->dev_info->ops->hmm_invalidate)
-		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
+	/*
+	 * The pages must not be released while the device may still access
+	 * them, so this wait must be neither interruptible nor time limited.
+	 */
+	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
+			      false, MAX_SCHEDULE_TIMEOUT);
 
 	if (range->event == MMU_NOTIFY_UNMAP) {
 		down_write(&xdna->notifier_lock);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index b27492e2bf8a..274e5b609882 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -63,7 +63,6 @@ struct amdxdna_dev_ops {
 	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
 	int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 	int (*hwctx_heap_expand)(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
-	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
 	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
 	int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
 	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
-- 
2.34.1

