Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2131BC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D70D10E3CB;
	Sat,  5 Sep 2026 13:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XON6P58c";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD78710E3CB;
 Sat,  5 Sep 2026 13:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFS/S1iaYscRkPsXwbLeh1oQUBpAKiNv0TYlce6lvysw40yQb6qeDrVbv/rowxeWq6eCgXn5N+aBxmzIbXisEFh7uxpr6FDkWyFIRBX6SzXEjEzTw8iIQODVSgT6lIXkiRKBlavWYu0DzeBLmuxr0Ux3k5q/nTxNFjcjibMfwlaDKJbtp1GAlY/dUQBIeLDLnMDL/PZHgd+UhNsII7A2fP+gWkpSXro3VHnnFIzgVnLwTxh+ndn5M/sQTCyFhse/PU2qPgNOMYlepAaoJ7uWeQqr71c3d95GOU104jis/9lS+9BK4/dmUHS13B6p9P9zRrVSMeniEfyO0DOl3Q4AUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJYGM+Wdir2GcRs+hVKoVs/cUOzsy4+C0i9c+iLhrU=;
 b=kYqZJpE3EZoYMvzKgXI83aSx0eJbkCCRAStc+nF0vUQsr1qGwL5UvvnGMBoLaGZ74jjgxpPTXDMkQudHEFY2uYRboVf0SkCGFeHl1fVzlmAhT/8CJi6HguoXYjtBrJ+rvki8ZtQjf4sOtQahQ50B6piigCfn3+Q0QOFyN0G++Lu81aaT4Db17zswJqs/5g/Wkgj4PsAHNgipVy0P8C3UtL/CSIdfunjRc/UjmBqmRbDAWg+kP8vBWrfjB5OLVF5k5GN6YZyOg+uyCEK/LHlUZl4jwFMmOKD32JwguYFgXQ6iadtn5EYh/qwk58nl2ZbyyjPoZ8JhjG8AjmsALM+ivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VJYGM+Wdir2GcRs+hVKoVs/cUOzsy4+C0i9c+iLhrU=;
 b=XON6P58ciH40DbBn+MhcVnIqwpxb5TDrBXRcEa3MHXsjm6MLfCMe3hbXdo1YAbeIRCU2eewtFKvyqXLB5EWaFHwfFO3vu+7AMtzmFAfroi4yMkYHmgE/mL7AUbyUbbnSMqgOR5tcsDroEqJfLudgBJYJ4KdAHBipHIo2jxMQmHo=
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sat, 5 Sep
 2026 13:32:15 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::a5) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 13:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 13:32:15 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 08:32:11 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 4/6] drm/gpusvm: make the DMA mapping step in get_pages()
 optional
Date: Sat, 5 Sep 2026 21:31:40 +0800
Message-ID: <20260905133142.3628027-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905133142.3628027-1-honghuan@amd.com>
References: <20260905133142.3628027-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4aeb23-ff7a-47f9-eb8e-08df0b521986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6LpWXvZmK7jExErJemX+yAid12qBu1YEspnm0YxAxaQeIRe36z8g1R2B2LqEvvwcsN1DrQgRQKOagfa3fXqZNml+M947nyfWtXU1i/Sa/8Kqy2IVbEbyZP3sijhvIyBDexrWtpk4XtCXYjNQ7ycF6lGWVsAarEPK3fQ3irPQ+06EzOxphMOTSRkRRl/8QyRwPFbrnYgxfIzusm7IONN8sR7XVa3C3zbt10Z9wzuM7L+4Vei1Mu2Jndi/bdJDVsDE4CJhGnzA39dw3FEelPvbvArsP9nvmmaNuDcnSVItjlJClvPZkMYqVYw/clQ5vWGKBM9Erf+QFWS9CiPCpvCSawSQJp+sRsjsnvBdjGkYlHQ1EMTGh6ZGa7GekF7s2/3sFzi40D6C996f8tJwyduQnARlEtSADNsYms6tazIAR+AAJ/ZM3278VLzH/ZlqXhOhLNcAhrXfUv3cd+73eWq6ppGN7FjzQy6VZ/Qmq6zqYt3eg9nwb57hWAo37bQlsqU7+Ea3PSPlydn0iWRzqxx7Gb2HfGC1dJbMI3NKUmBYuQsVzf617les/HUenmaGoQNod3KWZnyn6TpxCt0hoE9wXZTT8+X8RjkomOSYlLbsL3C8/TVvz0bKyu0gacuAc5NEUvb47MnE7lNqWbUwRyxVT5W6d6EoyrS+HX/XoFfOC9BYvdAOHvFGE58bpBzu8dlifIGQxkRJMDxuJVUYgF0fcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aLZOdfduRuSgET3/qfoqGnCIiVoFHfAwDQeEX8gMWxY5fo5X5YE6EhCRddNTVkvlCi4vGx3+Kds9JXoWuWcDhfWu0OYDHqPZrm+BsHXRM2dl+eBtL0E47lPha1GLHjC8fOOByf3PmuMRUZ/MGpgwEVnepBRGX9Paqyzp8/opc/1m/TTBJ6jIRw1rxI8BSNHZy2vvttnMM4/iex235//SonwLxcJ0LZzvyzhVw7xt+ovHWFK+pPvMErA9cG8DhOUZTOZd/ncReqeCGF33bqudo8lG8gnG6QanIzZnvjMjaAxrYPPnjf4URP8yCmqGIyoVc8/Bcj6firbkp0HlfecUAxPsrTALlLq4Rmcj5lS4jgMkH/A8tsaET1VW18rnb4Lw94rD+nms8nSuBXOIuU8EA2URXfe+sE9YcvamIrL02W+STpZzWZfWnI45Bjx61KiY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:32:15.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4aeb23-ff7a-47f9-eb8e-08df0b521986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

