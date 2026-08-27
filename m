Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE9C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3638910EEB4;
	Thu, 27 Aug 2026 07:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAALKIgn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E552C10EEA4;
 Thu, 27 Aug 2026 07:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDyaOobOURpAfp+tjbqttd5b5GMkE7ulhTX9F8m39PxJcOl6FAOrgu9z+OSwTLTaPm6CQXT4uYmL9bJd8eugRgnTGhMmE8gMB/vfX5c10GvnPmcjpjA61mZu7MYCSFY/ihIyWI6OE0CeCnp6UnqgabsdUbyo6idSIqeaBE3LwDj6qpf9XP+jvybImpMowZxaA71/LD84drNEvEGJckNQ1KP2bL8QdTT55jvan71RD+tWWURDSBGUnWVTAygd8pjiHpzTyBaW/f4vxWAE4EKwYHXyWHeeSesl9RXDvQvooV8AH8RUtcnWH5mPYNRU1V2Bnbee/rnIVCGXqH4c4sRVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7siTEW2CKiZshvU8V5uDSNGrVsPJi1BQF/HyVxzdbM=;
 b=WDbCPsUHm4rjlSfPkmt5J9VCo8RgKm/eivVkSulUKFEDo1RT5/zMPaYpc0My83fhfU/+clSwAhTzNiJ+G5o4k4vREUntk1QijOO9Ncsssuon/e3x9MAoHTswPGKdlJdv5E2xk+D6za+wIdXe48QJROb5NCis1T8oJloK75p9H3OcWnD0xxlkgCJsco5d0LI3ullPN9/k2QWKsdNNswkOKw1FL8cGoiwTiXgoReFul665zg/eZXO0VqhiFfF4ZLL0IgUIBljfzTQutvvRa3upWxz3b+CCBghRjEttdSigkXOzw0YAFqF5qEXBufRn4LYUlREB9f/pYvkbt70yJK5ZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7siTEW2CKiZshvU8V5uDSNGrVsPJi1BQF/HyVxzdbM=;
 b=DAALKIgnihB1vt7bseI/nE8BViXGCwA6e4bijYJ2lzSFE+XO0OVOhg0y9d3DVOr3hXMtBk7jpFzn2gnGKh7AekRQ3ab0U49WkDO8Yig1ouVGC7qzHotowPbC/OYqMa4WxcD2dGcRHxbgdF18MwCxKvti1zkYCjKIHT3Ps9xBZhk=
Received: from BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:15:25 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::35) by BL1PR13CA0011.outlook.office365.com
 (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Thu, 27
 Aug 2026 07:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:15:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:15:21 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC PATCH v1 5/5] drm/gpusvm: make the DMA mapping step in
 get_pages() optional
Date: Thu, 27 Aug 2026 15:14:49 +0800
Message-ID: <20260827071449.520398-6-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827071449.520398-1-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d6acc4-5a68-4a78-b43d-08df040af770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dHlGJZIL9DRUzhaE/lO27YspqdWPzngwppzBXTPe/o52woDJ2uSZjUiAwN8S8o7Q9ZInVCn882/LdABMIWvLT7ilI4PUfbufwT+onLqY89jPSaW9jun0bbnrvzKd3kv/E40ktPwnszkg9+GLDCP3+dHwtNvuJtifuQ1LJ/Dz99No266IgDBNwcNrO7cgnubB+S/Jr5F+/gKTTpZxAq8wL6inFTCKyEWJWsb8wrEKyugAaaW0TYFDFOw6DCB1wTX7Sc72FHKSWco+Ej+2qs1YHylvti8YrhafAqm1gcMJ2mQ2ottnEKVMFdyexjRDqgZUK7oMGUE408tUaM34rkUtJccjT5LHPUYlm8vdTt3gjyNm0g9B9ek9U9DoEjVekyL8fxoRhyL9NmuiXa82pDD+kkNHeljL3MKamoSNX/iRGMLPoYPYywcWcURjfCf1pybBj4SmSN8adYj7dD6uqkF/WFdXMdB1d9R1MgWtwWUlZIm7kpBfe+n6p2vziPUhUM00MBgKm5O2tzOQFctxF+0uKB0RTKDkF0fg/5fiyhDgSDTZDbdeAvsXGTm0jxK9mTv4sOL49dPUIb/yvhB//YYZaQn59JPA34eFG2odJBOJ8CGaPLUa90ZUQdL8mOjU3Wjrt7EOLqNGgEbgQewAHgUE9aMp+OtB5SIohyQqArRo7RZCE3VwBnPsYnLzpaTYrPobppUIWwQTqfUEct8e05fpaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gSBSkUBExh3wdVIoJU47D99YZewvaOk+NNMF4UTFMCXjUmKtAlPZIsirOexweDg8vgFz9nBUGdVLUyvnmmdjwN5lxveqHOouiFUl9B1PzQHgUDcLufZ2bzliXLskRoYQBTZbuQOiaGeDPDSjx9IwLAQ8Hu7qpmjBUzi0k+EHnWxMLqTpHVoO+PSvJkXLMX/kDydJn9Fu9eAbnqsRHdIZJ9SAMhG5QGHgA1KStMBwT+X3bGTf93EPRsVrZNrFjRYMWFHzh/eMiw01jbReCbdwyvQE9BtU1sWe14q+OMuGv9jDWn8EHLQAXOXBFx87TTNypU4cln+7p96/lhjXokSasYfLSjPiskiHhFPndl4mqa2BfUz8aqldsZ6OuKOgW+Dof+S82I5y/ESHetF6i0jPQbZq5dTq8/rL1iDWvLPxHegQJRzxAxXSVWhsBaAheToN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:15:25.6990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d6acc4-5a68-4a78-b43d-08df040af770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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
 drivers/gpu/drm/drm_gpusvm.c | 64 ++++++++++++++++++++++++++----------
 include/drm/drm_gpusvm.h     |  5 +++
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 42e606b94681..c89ff4a9d081 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1703,11 +1703,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	const bool map_dma = !ctx->no_dma_map;
 	unsigned int p;
-	bool all_valid;
 
 	for (p = 0; p < num_pages; ++p)
-		if (!svm_pages[p].drm)
+		if (map_dma && !svm_pages[p].drm)
 			return -EINVAL;
 
 retry:
@@ -1716,12 +1716,24 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
 
-	all_valid = true;
-	for (p = 0; p < num_pages; ++p)
-		if (!drm_gpusvm_pages_valid_unlocked(gpusvm, &svm_pages[p]))
-			all_valid = false;
-	if (all_valid)
-		goto set_seqno;
+	/*
+	 * The HMM fault is shared by all the drm_gpusvm_pages instances (they
+	 * all mirror the same CPU range); only the DMA mapping below is
+	 * per-instance. In no_dma_map mode there is no DMA mapping state to
+	 * validate, so the fault is always redone. Otherwise skip the fault
+	 * entirely if every instance is already valid.
+	 * drm_gpusvm_pages_valid_unlocked() also drops the stale dma_addr array
+	 * of any instance that is no longer valid.
+	 */
+	if (map_dma) {
+		bool all_valid = true;
+
+		for (p = 0; p < num_pages; ++p)
+			if (!drm_gpusvm_pages_valid_unlocked(gpusvm, &svm_pages[p]))
+				all_valid = false;
+		if (all_valid)
+			goto set_seqno;
+	}
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
@@ -1731,17 +1743,24 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
-	for (p = 0; p < num_pages; ++p) {
-		if (svm_pages[p].dma_addr)
-			continue;
-		svm_pages[p].dma_addr =
-			kvmalloc_objs(*svm_pages[p].dma_addr, npages);
-		if (!svm_pages[p].dma_addr) {
-			err = -ENOMEM;
-			goto err_free;
+	/*
+	 * Allocate the dma_addr array of each instance outside the notifier
+	 * lock. A still-valid instance keeps its existing dma_addr array and
+	 * is not reallocated. Skipped entirely in no_dma_map mode.
+	 */
+	if (map_dma) {
+		for (p = 0; p < num_pages; ++p) {
+			if (svm_pages[p].dma_addr)
+				continue;
+			svm_pages[p].dma_addr =
+				kvmalloc_objs(*svm_pages[p].dma_addr, npages);
+			if (!svm_pages[p].dma_addr) {
+				err = -ENOMEM;
+				goto err_free;
+			}
+			svm_pages[p].state = (struct dma_iova_state){};
+			svm_pages[p].state_offset = 0;
 		}
-		svm_pages[p].state = (struct dma_iova_state){};
-		svm_pages[p].state_offset = 0;
 	}
 
 	/*
@@ -1765,6 +1784,14 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
+	/*
+	 * no_dma_map: the caller only needs the HMM fault, not a device DMA
+	 * mapping. The fault has been validated under the notifier lock
+	 * above; skip the per-instance DMA mapping entirely.
+	 */
+	if (!map_dma)
+		goto done_mapping;
+
 	for (p = 0; p < num_pages; ++p) {
 		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
 			continue;
@@ -1784,6 +1811,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		}
 	}
 
+done_mapping:
 	drm_gpusvm_notifier_unlock(gpusvm);
 	kvfree(pfns);
 set_seqno:
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index d2b6f3d2b842..84db209cf148 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -254,6 +254,10 @@ struct drm_gpusvm {
  * @allow_mixed: Allow mixed mappings in get pages. Mixing between system and
  *               single dpagemap is supported, mixing between multiple dpagemap
  *               is unsupported.
+ * @no_dma_map: Only fault the CPU pages for the range; skip the device DMA
+ *              mapping step. Used by drivers (e.g. AMDXDNA userptr) that
+ *              consume the faulted pages without needing a DMA mapping. In
+ *              this mode @drm on the drm_gpusvm_pages is not required.
  *
  * Context that is DRM GPUSVM is operating in (i.e. user arguments).
  */
@@ -266,6 +270,7 @@ struct drm_gpusvm_ctx {
 	unsigned int devmem_possible :1;
 	unsigned int devmem_only :1;
 	unsigned int allow_mixed :1;
+	unsigned int no_dma_map :1;
 };
 
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-- 
2.34.1

