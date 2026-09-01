Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF827C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1BB10EC2A;
	Tue,  1 Sep 2026 09:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kgDg5O3c";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E0110EC17;
 Tue,  1 Sep 2026 09:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uazu7j/uZbHCbhfwVKRYOSN+FnxyLG8VCnPlQSdSQ7IXnBoyRyF3Yp9vMRgq49/kysOOt+Xe1lcHPvCtddj0MJ+JmtugOtvEk4lS4c0jT4SKCCE74JGhcIsAn9PCpZtff9hqZKsXlMInxploCf0HYSMjCciuGYUhIJ7v7rXj6up/IPmABMrSNwztIgRZIJd6OOf/CFCkFmEnON3M9dJSuJcHvuFquqv1swcKcEVjNx0LWEkqLNkLC9GiL6UNSqATXZqwQwhglp5ygKp8iDsd6RbDGAcan1U2/0hTGrDA0IWCpxj8URhaKxgHp124EHUp0cfwXs7BEAANa14UYPfDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVmaBCzW4XGsjpDzm6Fi9vJqQX+hOF99q39zMdDXZpE=;
 b=XS1n5vIoW98zhwndNcqh4tBWy9zp3db6VKjHP3PF4MgsbplUmfE24RLGK0d6LS9ygkZhwHhq1cZNMBCoTXagOpQVuPxXihJPX4OQAwRmd+VGJGTulohZWQb7UbBTs2Ylr5wwDrvhGYMcsus8OhYzOiVL9cxHeKQtCBZTsNqIFP67Lw3uTQ2gXxz9SGqOqTMWB4pBnNcK9pNSeBnvvRui+BwvxFSppiVWqPh6pbsdN9YeyN83thqwyGKEVDFrcPrloZveNvQ2uXMkfKcUdoWukTemjVGTxOZl1TWHMhG1263tfY4P2vAE/vSjBgusJh3UgET4j5dgTNWHcNuuBVA2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVmaBCzW4XGsjpDzm6Fi9vJqQX+hOF99q39zMdDXZpE=;
 b=kgDg5O3cyNFSXqYBHetbPCv7U4UeYGZwpDCy5vQO5Cfa7SuEbe68d6hONExo+ft9RPZwxb755cWGsnzrmvWd8Pu0OPwuhjDmvOms6jUgx6mvN3dlPxvgJQA96vaizpeZwwusvYji24I5Wyq9jD2D0gVwiv1NoH6xTaV4vhVb8IY=
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:01:32 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::37) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:01:32 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:01:28 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 4/4] drm/gpusvm: make the DMA mapping step in get_pages()
 optional
Date: Tue, 1 Sep 2026 17:01:00 +0800
Message-ID: <20260901090100.2024933-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901090100.2024933-1-honghuan@amd.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea24281-a78e-4cc7-9d35-08df08079e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: AAYKuecdqQ5sjqCj35EUO1S83ISdfyC9i/xYD/7GlYknN/mwAM3hnniEjFuAIMdBp02NHEV2ClatEQSTky62Do6eQzdQ69J+53tsvt1+xhq0ZKlz+6kfBlOu66qFBHRdemNYF3e2bTWjs+GcMBcOzOLrjfRRNXspu57B/orm+MkpJtjfvMcobteHvaVG01QUvexeQsVwh3f9jfw2oXor6K05YCx/X1uxLdP+AYNTbYsHtheoNegW1KeoEqe6X0Fv/K18J7GyX/gLBCDvs50h61chOWFLjP6G71ruyA0oo/H42Gh9rIk/0lgy1PCWaJVmjzyOzHoSLc9fabIGRsBuQSJjhaHc5YdNZGiWlt40kkd4oqO+wjDLLHg3T6UbCwgGiTgizZ58x7LCpDMCqBkF9fs4kwsX9kdN1lqYSkW262Gp1IsnNeUNAuan136ytG6kDVqh29hY4cP66fZ96d1O1N4alO5CVx20IHfNakTAV0BciC8JmmS3fVjEIq46wRc61Rdu41w1C8igCLFxD9/0xKSKKSW68Z4tXLgCllI4u0u/uD6OyIMxOc4FKN+OiGKDnjm9XiRJjlT2NQfqOrbF0ark4Hlwf9pv6iGPHQsH4zdzNKkAFidhHGEJiMOkojHbPM5NPNpglKPhACTV0ioEl3itnrO4h7BUMnstJFzxW3bL66Wf8//C2ZbwLO0/f81dR4M112FlR57IESnXMqcA9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: By3JBRLn8h1o1jWer1RYXInAij2UaAF3GPKcSC8kdaxpleQCVphu8CDLzoHtQl/bLr83PJsvTvSofIw4Zj7oAdgaeh9eEXjeL9tSu5d8iKxMfZqtehEUOgTx6tTe+gT+S3nE3Ka8ziiu5ldt7hScenHVgayKM9GQpCgHA/Sr7UXTVkfBG8+D9s5B3G7Dpzdzphm7+AO5s7HykvXjLengyYR6NtUNsIcvVXLwiftSvvqu/QWSmW3Yibp1VVPYDRvC8gDP9Rz08TFPquZc4/hHwNzhbA6SMoiHFKtIi2mkbPEomO4RPzSooUkWXMmlso17N2YLCTqeXV8RRY5qxQApIOs9jYWRkTtpdXt50hbos6V3T/qY4VA6S6428uOQQzn0di2neK7hEY7MQjW7p0NzSwW+KXjrH9KpnvYOuoh26cPgV7F73POIpjx1lbvXXXRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:01:32.1754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea24281-a78e-4cc7-9d35-08df08079e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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

Some drivers (e.g. AMDXDNA) only need the CPU pages faulted in and tracked
by the notifier, no need DMA mapping.

Add a drm_gpusvm_ctx::no_dma_map flag. When set, get_pages() does the
shared HMM fault and records notifier_seq, but skips svm_pages->drm
validation, the dma_addr allocation and drm_gpusvm_dma_map_pages().
With no mapping state to check, the fault is redone on every call. The
default (no_dma_map == 0) is unchanged.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 44 ++++++++++++++++++++++++++----------
 include/drm/drm_gpusvm.h     |  9 ++++++++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 810f801a9f7..0156ee82d7c 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1663,6 +1663,12 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
  * On error the instances mapped before the failing one stay mapped, so the
  * caller must unmap and free every instance regardless of the return value.
  *
+ * With &drm_gpusvm_ctx.no_dma_map no mapping state is recorded, so
+ * drm_gpusvm_pages_valid() never returns true and success is only a snapshot:
+ * the caller must recheck mmu_interval_read_retry() against the recorded
+ * &drm_gpusvm_pages.notifier_seq under the notifier lock, and hold it until
+ * its work is visible to invalidation.
+ *
  * Return: 0 on success, negative error code on failure.
  */
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
@@ -1689,11 +1695,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	const bool map_dma = !ctx->no_dma_map;
 	unsigned int p;
 
-	for (p = 0; p < num_pages; ++p)
-		if (!svm_pages[p].drm)
-			return -EINVAL;
+	if (ctx->no_dma_map && ctx->devmem_only)
+		return -EINVAL;
+
+	if (map_dma) {
+		for (p = 0; p < num_pages; ++p) {
+			if (!svm_pages[p].drm)
+				return -EINVAL;
+		}
+	}
 
 retry:
 	remaining = timeout - jiffies;
@@ -1703,7 +1716,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
 
-	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
+	if (map_dma &&
+	    drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
 		goto set_seqno;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
@@ -1721,14 +1735,16 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
-	for (p = 0; p < num_pages; ++p) {
-		if (svm_pages[p].dma_addr)
-			continue;
-		svm_pages[p].dma_addr =
-			kvzalloc_objs(*svm_pages[p].dma_addr, npages);
-		if (!svm_pages[p].dma_addr) {
-			err = -ENOMEM;
-			goto err_free;
+	if (map_dma) {
+		for (p = 0; p < num_pages; ++p) {
+			if (svm_pages[p].dma_addr)
+				continue;
+			svm_pages[p].dma_addr =
+				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
+			if (!svm_pages[p].dma_addr) {
+				err = -ENOMEM;
+				goto err_free;
+			}
 		}
 	}
 
@@ -1753,6 +1769,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
+	if (!map_dma)
+		goto done_mapping;
+
 	for (p = 0; p < num_pages; ++p) {
 		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
 			continue;
@@ -1771,6 +1790,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		}
 	}
 
+done_mapping:
 	drm_gpusvm_notifier_unlock(gpusvm);
 	kvfree(pfns);
 set_seqno:
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index d2b6f3d2b84..ec7b81957b1 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -254,6 +254,14 @@ struct drm_gpusvm {
  * @allow_mixed: Allow mixed mappings in get pages. Mixing between system and
  *               single dpagemap is supported, mixing between multiple dpagemap
  *               is unsupported.
+ * @no_dma_map: Only fault the CPU pages for the range; skip the device DMA
+ *              mapping step. Used by drivers that consume the faulted pages
+ *              without needing a DMA mapping. In this mode @drm on the
+ *              drm_gpusvm_pages is not required, no mapping state is recorded
+ *              and drm_gpusvm_pages_valid() therefore never reports these
+ *              pages as valid; the caller revalidates the snapshot itself, see
+ *              drm_gpusvm_get_pages(). @devmem_only is rejected and no page
+ *              type check is performed, so @allow_mixed has no effect.
  *
  * Context that is DRM GPUSVM is operating in (i.e. user arguments).
  */
@@ -266,6 +274,7 @@ struct drm_gpusvm_ctx {
 	unsigned int devmem_possible :1;
 	unsigned int devmem_only :1;
 	unsigned int allow_mixed :1;
+	unsigned int no_dma_map :1;
 };
 
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-- 
2.34.1

