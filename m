Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D7BC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D1110E582;
	Fri,  4 Sep 2026 16:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXq9ByP3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C8910E582;
 Fri,  4 Sep 2026 16:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhWOobAy5dnzTORnSV1ggsOAp8NKYigBWWVaVSA1eXZ29rsxSqt90imiO32uz37/GFtfbfsnPuqJulipShx8wvvC7vWzzULrTHg1aQVv+dqNthEoBOqjkd0SlS0vsnu492U4bWaxdhtjcoxx1X4u4YKezchiuUEPRa6qbITW/dQHQ496zGPjsTnwVe/Ser0tK5wL9oWaSTNSNYU/ot04E71lm9IY4+IJbsjZCaygsg6OEnYXYDQ7iGb/ZkpbZxWBGM/XAAPMPcNKPPRP2pqIvSg5OWMyMnmbQizugXa8rsi8ZT8KfGOTxGYx53rvnCMsfdCplMLx8n/s4BomzN2TjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJYGM+Wdir2GcRs+hVKoVs/cUOzsy4+C0i9c+iLhrU=;
 b=YqmbzF8lLFwHUnEwzji8fr8lfULp479LEwDpaSEyjQoy/mm3BETyODcTMVDWSThU5cEGUFNcK8vIZ7NtDpIWPjejGhqf2DS7VO6R3sQqDsPxwj0Iry251IanjW4oSG2dawGjsR7ZRK2o179ovXIgij6igV0F6vn/sa35lROR0zctgcsdjy3Mm5z7MtSlCqHhQfWO6n/YWV6D3AxvpXzDufm/Kl2Hn19FJigoug1/mRG41j8VOTQlbobqjFVnlxOgWe0garFu282oVS52tc3HjmUNTYibjoWf2/+rKO7eUXa1Bs85jcCoSolGDB8j7xKMr0X5yienn86Jf9IRyYFg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VJYGM+Wdir2GcRs+hVKoVs/cUOzsy4+C0i9c+iLhrU=;
 b=zXq9ByP3YN2WrofDp93oPvAxpAMo5PW/YPPnLCVG7fvfJGKllQRFfBfpvELV6sb3/7TJwjKRAbVDycqOQg8Gvs6QyJxtiKt2flWT1wAGw6QLuOd6pWqKOTozPQEOTvohZy6BCeU4eGsiDprUR+sGzEdGVhle3JBqVAiI0sqNZxA=
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:40:31 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::27) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 16:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 16:40:28 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:40:23 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 4/6] drm/gpusvm: make the DMA mapping step in get_pages()
 optional
Date: Sat, 5 Sep 2026 00:39:54 +0800
Message-ID: <20260904163956.3433293-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904163956.3433293-1-honghuan@amd.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: f29fd9f5-da0d-4368-7536-08df0aa33a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +pptHWtrjADTdmVFr6toBP33y9DpwOFsSkW7je1QQ1y9U7/EtFIRUlu7Wv1SXTE/atKA4Znz0PMKPWyittR1uCEVyUKlrpBM8+POQvZGtE5l9TqS3n3ior0T9IHX+mDDd7Uv+/TMc0PJE6n2isedHqvV5VUSF2sEaM5FdroyyFvaNTWOf4SbBM5S86NOs/dLbLq2xiE4UHXdcr9r1SnOA9PqakeiR1VfDtMW+zDzgLlThMeyK/xwipkl086nHLeAoRh9tLAuuGW/K/WOjPVhsaj4QNWyYGPsWkIRhuiPx/dmf1zyHJT5IM1J0/gvIogio/ye6v3p2ZYmkUgppMfKXaSA1JpvElnKKSp19o24iTOQ8d2O4GIAZYDqBoV88HWCyonxQqr6sHtIhsyyFrQIjpKKrZ/V+0qa1xfIJhFQAs1HPic7mvzMCssbJ4+0NS/10nUojhcxwPeSx5W1vnIXFTJHuaUGkWxsmfSL8iby+Ka6PkRGF4eaY0idbBCoTvyMTHSJHZFN2ne/5LxAPrh3cU9vPo2y0ulAsoQFUWPwPC2ZtxQfAfGneundBPC5qSkwGTmmMqL8aeZkJoWyczwRRBTlPxHFxqvL8EiVhAnHT6P7vzc37BC5yKnufAXg4mIBvHwI1jMeLz2Sbfa9dVFNK+mAuSVlStoI8Gbj1/dixY3o9VPcvgRDzyGpusQ9vrCfYytfWIrf63D+SMuoBq49Fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JI+U16DbSvoevfPL5y1VxFhx/ZPOpWaLrIhnLW5mqIt3LKrI9PW0lUETKGTaqKrpgmUh1KeMxIRBer96TR+jdITV5ktURaC1hGZHb58XVMeRZMQqAzDyQXAwIk3KS/zuqzi7rYmgbRP2AakHDzq0M2myfpQ0kt9LZLdyY4R9BJhZGojkPdy6t8L9E6ucE4tvEE6EmQUGya0MeIcuK80iN9/e6/v/9X7xW8TknK/1SoYDz5Pm9E+nuaYX3UrfQ4V01guUpkL8WxL32+VEN9fxDK5LQ8AMV61rbjI+Zb92d6h3fBd6Qwu1jscR/YWRfTcY5wFwsAM/5GzL3eNiHZX35wrMqqtlpmzCyqe7oiFIt4m6lxVKZ5uDtRuNgJTnvRxiB35RFjEKCxiz7yTfNQzSy0ccqsE/rkZGoVK18CLn2uy9YNbbSSmBxRfOB7NVkwbS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:40:28.2581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f29fd9f5-da0d-4368-7536-08df0aa33a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 44 ++++++++++++++++++++++++++----------
 include/drm/drm_gpusvm.h     |  9 ++++++++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index d8ee0e5f2ae..7efc35507f1 100644
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
@@ -1689,14 +1695,21 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	const bool map_dma = !ctx->no_dma_map;
 	unsigned int p;
 
 	if (!num_pages)
 		return -EINVAL;
 
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
@@ -1706,7 +1719,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
 
-	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
+	if (map_dma &&
+	    drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
 		goto set_seqno;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
@@ -1724,14 +1738,16 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
 
@@ -1758,6 +1774,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
+	if (!map_dma)
+		goto done_mapping;
+
 	for (p = 0; p < num_pages; ++p) {
 		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
 			continue;
@@ -1776,6 +1795,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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

