Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6603FF44845
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A4610E949;
	Fri, 10 Apr 2026 11:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLYes+y/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E588D10E94A;
 Fri, 10 Apr 2026 11:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icpldmKgqCS5yYftqfkyZfn/G3dpTteG4pMLlffeFyyxY96jCuN3iizOcDzdTQ8GMYJdaQD1g3uK1L5CU463pS3sMs2sejBo1jRHI2ovG7HvOMc2gPQ0BJt1E4NuDZiA+pOOdmmKGaO+fZhX+eeYMHP2r0UHSvjcxniv9yRXZKXRKpl0LqYwLxxQT5cZILsJWaqmH1hLmqIuGgjVLmHUL3DwueFmnNFKX4+hVeldVABarQnT6/PH5CKa1Le10/ZqsA4KsWyrcmfTqpNQjsoH91aH5y9POW0wMi/LWbWtd+czFL8p1f620nGfbAzD0OkaCVZKZVSG/TRRuktEWKsO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbQQU3jXCUCOzxA1QsnZasxDGNl6X2FEwaB/NquDmEs=;
 b=NcHY7DIRqN5LDq5Jgzt5sOUDizyg+NmN0Lz/25uTN9h4/Gd6Ps5+gE7tvyy6xjJpiEb73UIODpjCtaIPA/odibzjJC6icQKFBnZ+Yc4o6igdEO6LNe3g7PVHnwPf8HXk7E0/3dGgHgGnyVOtVOxA12edE/ufHa/Ybtfi9HEKqIk+ufdks1gRt9uhGjZISrlPKEnBcDAwwVS+xnW6i8sBRP2R2SvavT3lYl48xth+8bRsQcrLnt4L6AnFFsz3jPEyn8lGSna7Y5bRzG2eLbaBr6RDMqyZk0dvQWgnZHPSb6kQW8Q98fJebPp8u3o4y6szwo53fh0QBv6inbCjsYq2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbQQU3jXCUCOzxA1QsnZasxDGNl6X2FEwaB/NquDmEs=;
 b=XLYes+y/YeQyJeIsmjYO9X+1fHJlxAB7UayJ+9ljmdoBTf3REb0dsHxuwceXau0XzcK/E1Aao8Ofyuttpk8deggyRY7G8dXyikIKWeAWFKSbQChpBGmCd/CwfTdUCeq5rd3dTO/7YcTCai+VZswozzGEcyz9sXakX7jUefd6t6A=
Received: from PH7P221CA0079.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::14)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 11:32:34 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::52) by PH7P221CA0079.outlook.office365.com
 (2603:10b6:510:328::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 11:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:32:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 06:32:11 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Apr 2026 06:32:08 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH RFC 6/6] drm/amdgpu: integrate VRAM migration into SVM range
 map path
Date: Fri, 10 Apr 2026 19:31:46 +0800
Message-ID: <20260410113146.146212-7-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410113146.146212-1-Junhua.Shen@amd.com>
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d42b29-4a64-4187-88a2-08de96f4dbf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4hGNYLwc37+Iug9ClQV20s2EWYn3nHNMaeE45ucuHkzTx20Bqx+KbH6mlZS7yV06M6Q97jQq4VoJ4FNidAF0ct6jJyOp45kvoKDOU12/pmmnlUUvZmhWJfU/w9mrGUkXQ3SJB9Gz4OMSv8OMTkUE+nTKWqa7AwOC9fTA2WqKhcDphahoUG6EvXsPHMhA4WObchTETONS2UC++PVaaX66ThRwx4A6W+g9LnXvsYC3IUrjbgr6QQ+1DZ61YNx8a22ahhynudySdzFBxQr3Am/AOZg6dZ1X5lLrfebQk0A/8+BLwKXOl8P4xiG5nYtRxd78d3rzF0zTCSJZasb5jTR2eR6yhO/tbJcUeaTtVyewDezwJuQQr3iQ1HIXzR02uRw9E959BsiRQpu3DxMebXzuQFge1YrAda5lgd04NCQ6fS5jQX3JAWhkw3ceJl7NkcUmFLcWi5UtinndsRNYLS1YcGJjxSTHQjSQTImVhfRBLlUWg0rQ8HxIyXAgiLrWSSoxjAxdmzkETPB/yTGR+Iq+cPJ4KCehwRFzcuR2iNg7EeNq/4qsJiM7tJiXzPNOuqJCN0/MLCOsSonJyhT0gFtSi+7Fh+wKtZOP4q9TqYxszWUDW8PO+8BR3N30GcZZXN5Y7jJOtcy9YqCKQTGAnmbNXw4qYxKUCrQGURleDqi486gAJzuzEBt4GQSWbhVIx/jgUIufCzzSzLlxf2/qYps4xYr0Ta1w5WEu1tsKwbGESicSrncSaiptAaPrzU22qu9kc651H5tDlbSerUMReq8SBVTNPWe3wre90R0e6EYVY1JrBEextu0C0h918D4WaQ4D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b0CSjwcA9CMk33JzcMyfbjTExoszuQDT7J8dPeOyzaiFP7DNfK9fxidz1WNF48aFmp3CFEfgu0+IQW/u8Sg2EpIe+EKYhPfgx2Yq/DG8TQwbM0kS0HrX0f/hSxdMu6vyZw2m11qKv3cllBwyhlhUcSZPYFfeDrCr+rdjkHSFbvjhZwN3vYP1h9VnmXFqqdIm56uV8EK+TMj4rOQWX5Crk10QavD9C3Dn+/ZqAKZ46H0BlPh85fYP5d4wRLo1shmZK6GiRuO7JKs7+kG3hLKTZH7SmuuljyQ7yYRHEsChx3Vzh5SljnupRuw7FYjMHPEtDWfo6RR5fdWarSAJAfVN4E3f+fkpXzRhTQQ2ozybv0WhMpE6IB5UFz437VJDSeowqO8TESvYJd25yVLOCzLhPMLZUJLRdV5xeZgGa7ZuYGH+Qeim6pVLZQ+kI4B2BrDu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:32:33.8854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d42b29-4a64-4187-88a2-08de96f4dbf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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

Embed VRAM migration directly into the per-range map loop.

Introduce enum amdgpu_svm_migrate_mode to carry migration intent
through the entire map_attr_ranges → map_interval → map call chain:

  MIGRATE_POLICY  – follow preferred_loc (normal ioctl / first map)
  MIGRATE_TO_VRAM – one-shot prefetch, force VRAM migration
  MIGRATE_NONE    – suppress migration (restore worker / evict remap)

MIGRATE_NONE is critical for the restore worker: after TTM evicts
VRAM back to RAM, the worker must only rebuild GPU mappings without
re-migrating to VRAM, otherwise preferred_loc=VRAM causes a livelock
(CPU fault → migrate_to_ram → notifier → restore → migrate back →
CPU fault …).

Key changes:

GPU mapping for VRAM pages:
  - Handle AMDGPU_INTERCONNECT_VRAM protocol in update_gpu_range,
    clear SYSTEM/SNOOPED PTE bits for local VRAM addresses

Prefetch (attr_change LOCATION_CHANGE trigger):
  - prefetch_loc → VRAM: map with MIGRATE_TO_VRAM
  - prefetch_loc → SYSMEM: evict existing VRAM ranges first, then
    remap with MIGRATE_NONE

mmu_notifier filtering:
  - Skip MMU_NOTIFY_MIGRATE when in_populate is set (self-initiated
    RAM→VRAM); process when clear (CPU-fault migrate_to_ram)

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 486 ++++++++++++++++--
 1 file changed, 453 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 472a641fb836..994c4767183a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -27,6 +27,7 @@
 #include "amdgpu_svm_range.h"
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_migrate.h"
 #include "amdgpu_vm.h"
 
 #include <drm/drm_exec.h>
@@ -40,6 +41,19 @@ enum amdgpu_svm_range_queue_op {
 	AMDGPU_SVM_RANGE_OP_UNMAP = 1,
 };
 
+/**
+ * enum amdgpu_svm_migrate_mode - Migration intent for map paths
+ * @AMDGPU_SVM_MIGRATE_POLICY: Follow preferred_loc policy (normal/restore path)
+ * @AMDGPU_SVM_MIGRATE_TO_VRAM: Force VRAM migration (prefetch-to-VRAM, one-shot)
+ * @AMDGPU_SVM_MIGRATE_NONE: Suppress all migration (post-evict remap —
+ *			      just map existing SYSMEM pages to GPU)
+ */
+enum amdgpu_svm_migrate_mode {
+	AMDGPU_SVM_MIGRATE_POLICY,
+	AMDGPU_SVM_MIGRATE_TO_VRAM,
+	AMDGPU_SVM_MIGRATE_NONE,
+};
+
 enum amdgpu_svm_range_pending_op {
 	AMDGPU_SVM_RANGE_PENDING_OP_NONE    = 0,
 	AMDGPU_SVM_RANGE_PENDING_OP_UNMAP   = BIT(0),
@@ -114,6 +128,199 @@ range_pages_valid(struct amdgpu_svm *svm,
 	return drm_gpusvm_range_pages_valid(&svm->gpusvm, range);
 }
 
+/**
+ * amdgpu_svm_range_in_vram - Advisory check if range pages are in VRAM
+ * @range: Pointer to the GPU SVM range
+ *
+ * Uses READ_ONCE to do a lock-free advisory check on whether the range's
+ * pages are currently backed by device memory (VRAM). This pairs with
+ * WRITE_ONCE in drm_gpusvm.c that updates the flags after DMA mapping.
+ *
+ * Return: true if the range has device memory pages, false otherwise
+ */
+static bool amdgpu_svm_range_in_vram(struct drm_gpusvm_range *range)
+{
+	struct drm_gpusvm_pages_flags flags = {
+		/* Pairs with WRITE_ONCE in drm_gpusvm_get_pages() */
+		.__flags = READ_ONCE(range->pages.flags.__flags),
+	};
+
+	return flags.has_devmem_pages;
+}
+
+/**
+ * amdgpu_svm_get_dpagemap - Get the drm_pagemap for this device's VRAM
+ * @svm: Pointer to the AMDGPU SVM structure
+ *
+ * Return: Pointer to drm_pagemap on success, NULL if not available
+ */
+static struct drm_pagemap *
+amdgpu_svm_get_dpagemap(struct amdgpu_svm *svm)
+{
+	struct amdgpu_pagemap *apagemap = &svm->adev->kfd.apagemap;
+
+	if (!apagemap->initialized)
+		return NULL;
+
+	return &apagemap->dpagemap;
+}
+
+/**
+ * amdgpu_pagemap_capable - Check if hardware supports device memory
+ * @svm: Pointer to the AMDGPU SVM structure
+ *
+ * Pure hardware capability check. Returns true if the device is a discrete
+ * GPU with a drm_pagemap available for VRAM migration. This does NOT check
+ * any user policy (preferred_loc, prefetch_loc) — those decisions are made
+ * in amdgpu_svm_range_needs_migrate_to_vram().
+ *
+ * Used to set drm_gpusvm_ctx.devmem_possible so that all ranges on dGPU
+ * are created with migrate_devmem=true (hardware capability).
+ *
+ * Return: true if device memory migration is supported by hardware
+ */
+static bool
+amdgpu_pagemap_capable(struct amdgpu_svm *svm)
+{
+	if (svm->adev->gmc.is_app_apu)
+		return false;
+
+	if (!amdgpu_svm_get_dpagemap(svm))
+		return false;
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_preferred_loc_is_vram - Check if preferred_loc requests VRAM
+ * @attrs: Pointer to the SVM attributes
+ *
+ * Policy check: returns true if the user has set preferred_loc to a GPU
+ * VRAM location (not SYSMEM and not UNDEFINED).
+ *
+ * Return: true if preferred_loc targets VRAM
+ */
+static inline bool
+amdgpu_svm_preferred_loc_is_vram(const struct amdgpu_svm_attrs *attrs)
+{
+	return attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM &&
+	       attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED;
+}
+
+/**
+ * amdgpu_svm_range_needs_migrate_to_vram - Per-range VRAM migration check
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: Pointer to the GPU SVM range
+ * @attrs: Current SVM attributes for this address range
+ *
+ * Three-level decision:
+ *   1. Capability:  range->migrate_devmem (hardware, set at creation, stable)
+ *   2. Command:     mode==TO_VRAM (one-shot prefetch_loc override)
+ *   3. Policy:      preferred_loc (persistent user intent, when mode==POLICY)
+ *
+ * Return: true if range should be migrated to VRAM
+ */
+static bool
+amdgpu_svm_range_needs_migrate_to_vram(struct amdgpu_svm *svm,
+					struct drm_gpusvm_range *range,
+					const struct amdgpu_svm_attrs *attrs,
+					enum amdgpu_svm_migrate_mode mode)
+{
+	/* Capability: hardware must support VRAM for this range */
+	if (!range->pages.flags.migrate_devmem)
+		return false;
+
+	/* Suppress: post-evict remap — just map existing SYSMEM pages */
+	if (mode == AMDGPU_SVM_MIGRATE_NONE)
+		return false;
+
+	/* Already backed by VRAM — no migration needed */
+	if (amdgpu_svm_range_in_vram(range))
+		return false;
+
+	/* Command: prefetch overrides policy — migrate unconditionally */
+	if (mode == AMDGPU_SVM_MIGRATE_TO_VRAM)
+		return true;
+
+	/* Policy: only migrate if preferred_loc targets VRAM */
+	return amdgpu_svm_preferred_loc_is_vram(attrs);
+}
+
+/**
+ * amdgpu_svm_range_alloc_vram - Migrate a single range's pages to VRAM
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: Pointer to the GPU SVM range to migrate
+ *
+ * Per-range migration helper that calls drm_pagemap_populate_mm() bounded
+ * by the range's [start, end).
+ *
+ * The in_populate flag is set around populate_mm to tell the mmu_notifier
+ * handler to skip the self-migration event. After successful migration,
+ * the range's cached DMA addresses and gpu_mapped state are explicitly
+ * invalidated so that the subsequent get_pages() call will re-fault with
+ * fresh VRAM DMA addresses.
+ *
+ * Handles one retry-able error case:
+ *  - -EBUSY: the range already has device-private pages from a different
+ *            allocation.  Evict those pages to RAM first and retry.
+ *
+ * VRAM overcommit is handled at the TTM layer via DISCARDABLE BOs with
+ * eviction fences — TTM evicts SVM BOs when VRAM is full, and the
+ * eviction fence worker migrates ZONE_DEVICE pages back to RAM before
+ * the BO is discarded.
+ *
+ * Return: 0 on success, negative errno on failure (non-fatal to caller)
+ */
+static int
+amdgpu_svm_range_alloc_vram(struct amdgpu_svm *svm,
+			    struct drm_gpusvm_range *range)
+{
+	struct drm_pagemap *dpagemap = amdgpu_svm_get_dpagemap(svm);
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	unsigned long start = drm_gpusvm_range_start(range);
+	unsigned long end = drm_gpusvm_range_end(range);
+	int ret, retries = 3;
+
+	if (!dpagemap)
+		return -ENODEV;
+
+	do {
+		atomic_set(&svm->in_populate, 1);
+		ret = drm_pagemap_populate_mm(dpagemap,
+					  start, end, svm->gpusvm.mm, 0);
+		atomic_set(&svm->in_populate, 0);
+
+		if (ret == -EBUSY && retries) {
+			/*
+			 * Range has existing device-private pages that conflict.
+			 * Evict them to RAM, then retry the migration.
+			 */
+			AMDGPU_SVM_TRACE("alloc_vram -EBUSY, evicting [0x%lx-0x%lx]\n",
+				 start, end);
+			drm_gpusvm_range_evict(&svm->gpusvm, range);
+		} else if (ret) {
+			break;
+		}
+	} while (ret && retries--);
+
+	if (ret) {
+		AMDGPU_SVM_TRACE("range alloc_vram failed: ret=%d [0x%lx-0x%lx]\n",
+				 ret, drm_gpusvm_range_start(range),
+				 drm_gpusvm_range_end(range));
+		return ret;
+	}
+
+	/*
+	 * Migration succeeded.  Because in_populate caused the mmu_notifier
+	 * to skip this event, the range's cached DMA addresses and
+	 * gpu_mapped flag are now stale.  Explicitly invalidate them so
+	 * the caller's get_pages() will re-fault fresh VRAM addresses.
+	 */
+	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	range_invalidate_gpu_mapping(range);
+
+	return 0;
+}
 
 static int
 amdgpu_svm_range_gpu_unmap_in_notifier(struct amdgpu_svm *svm,
@@ -376,9 +583,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 						npages - mapped_pages);
 		dma_addr_t seg_addr = entry->addr;
 		unsigned long start_page, last_page;
+		uint64_t seg_pte_flags;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		while (mapped_pages + seg_pages < npages) {
@@ -399,9 +608,26 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		last_page = start_page + seg_pages - 1;
 		is_last_seg = mapped_pages + seg_pages == npages;
 
+		/*
+		 * For VRAM pages, device_map() already returned the MC
+		 * address in seg_addr.  Clear the SYSTEM and SNOOPED bits
+		 * since this is local VRAM, not DMA-mapped system memory.
+		 */
+		if (entry->proto == AMDGPU_INTERCONNECT_VRAM)
+			seg_pte_flags = pte_flags & ~(AMDGPU_PTE_SYSTEM |
+						      AMDGPU_PTE_SNOOPED);
+		else
+			seg_pte_flags = pte_flags;
+
+		AMDGPU_SVM_TRACE("update_gpu_pte: VA [0x%lx-0x%lx] proto=%u addr=0x%llx flags=0x%llx pte_val=0x%llx flush=%d\n",
+				 start_page, last_page, entry->proto,
+				 (u64)seg_addr, seg_pte_flags,
+				 (u64)seg_addr | seg_pte_flags,
+				 flush_tlb && is_last_seg ? 1 : 0);
+
 		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
 					     flush_tlb && is_last_seg, true, NULL,
-					     start_page, last_page, pte_flags,
+					     start_page, last_page, seg_pte_flags,
 					     0, seg_addr, NULL, NULL,
 					     wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
@@ -419,7 +645,8 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 		       unsigned long end,
 		       const struct amdgpu_svm_attrs *attrs,
 		       const struct drm_gpusvm_ctx *gpusvm_ctx,
-		       uint64_t pte_flags)
+		       uint64_t pte_flags,
+		       enum amdgpu_svm_migrate_mode migrate_mode)
 {
 	unsigned long addr = start;
 	int ret;
@@ -462,6 +689,25 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 		if (next_addr <= addr)
 			return -EINVAL;
 
+		/* Per-range VRAM migration*/
+		if (map_ctx.devmem_possible &&
+		    amdgpu_svm_range_needs_migrate_to_vram(svm, range, attrs,
+							   migrate_mode)) {
+			int mret;
+
+			AMDGPU_SVM_TRACE("alloc_vram: mode=%d [0x%lx-0x%lx]\n",
+					 migrate_mode,
+					 drm_gpusvm_range_start(range),
+					 drm_gpusvm_range_end(range));
+
+			mret = amdgpu_svm_range_alloc_vram(svm, range);
+			if (mret)
+				AMDGPU_SVM_TRACE("per-range alloc_vram non-fatal: ret=%d [0x%lx-0x%lx]\n",
+						 mret,
+						 drm_gpusvm_range_start(range),
+						 drm_gpusvm_range_end(range));
+		}
+
 		range_pte_flags = map_ctx.read_only ?
 			(pte_flags & ~AMDGPU_PTE_WRITEABLE) : pte_flags;
 
@@ -509,6 +755,7 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 
 		if (!ret)
 			ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+
 		if (!ret) {
 			svm->flush_tlb(svm);
 			WRITE_ONCE(to_amdgpu_svm_range(range)->pte_flags, range_pte_flags);
@@ -527,12 +774,18 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 }
 
 static int
-amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
+amdgpu_svm_range_map_interval_ex(struct amdgpu_svm *svm, unsigned long start_page,
 				unsigned long last_page,
-				const struct amdgpu_svm_attrs *attrs)
+				const struct amdgpu_svm_attrs *attrs,
+				enum amdgpu_svm_migrate_mode migrate_mode)
 {
+	bool hw_devmem = amdgpu_pagemap_capable(svm);
+
 	struct drm_gpusvm_ctx gpusvm_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
+		.devmem_possible = hw_devmem,
+		.device_private_page_owner = hw_devmem ?
+			AMDGPU_SVM_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	unsigned long start = start_page << PAGE_SHIFT;
 	unsigned long end = (last_page + 1) << PAGE_SHIFT;
@@ -542,7 +795,7 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 	pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs);
 
 	ret = amdgpu_svm_range_map(svm, start, end, attrs, &gpusvm_ctx,
-				   pte_flags);
+				   pte_flags, migrate_mode);
 	if (ret)
 		AMDGPU_SVM_TRACE("map_interval failed: ret=%d [0x%lx-0x%lx)-0x%lx\n",
 				 ret, start, end, end - start);
@@ -550,10 +803,20 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 	return ret;
 }
 
-int
-amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
-				 unsigned long start_page,
-				 unsigned long last_page)
+static int
+amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
+				unsigned long last_page,
+				const struct amdgpu_svm_attrs *attrs)
+{
+	return amdgpu_svm_range_map_interval_ex(svm, start_page, last_page,
+						attrs, AMDGPU_SVM_MIGRATE_POLICY);
+}
+
+static int
+amdgpu_svm_range_map_attr_ranges_ex(struct amdgpu_svm *svm,
+				     unsigned long start_page,
+				     unsigned long last_page,
+				     enum amdgpu_svm_migrate_mode migrate_mode)
 {
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -573,9 +836,10 @@ amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 
 		seg_last = min(seg_last, last_page);
 		if (range_has_access(attrs.access)) {
-			/* map may fail here cause no vma or access deny */
-			ret = amdgpu_svm_range_map_interval(svm, cursor, seg_last,
-							    &attrs);
+			ret = amdgpu_svm_range_map_interval_ex(svm, cursor,
+							       seg_last,
+							       &attrs,
+							       migrate_mode);
 			if (ret)
 				return ret;
 		}
@@ -592,6 +856,15 @@ amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 	return 0;
 }
 
+int
+amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
+				 unsigned long start_page,
+				 unsigned long last_page)
+{
+	return amdgpu_svm_range_map_attr_ranges_ex(svm, start_page, last_page,
+						   AMDGPU_SVM_MIGRATE_POLICY);
+}
+
 static void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
 						   struct drm_gpusvm_range *range,
 						   struct drm_gpusvm_ctx *ctx)
@@ -657,7 +930,6 @@ static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
 	unsigned long rebuild_start = start_page;
 	unsigned long rebuild_last = last_page;
 	bool removed;
-	int ret;
 
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -675,12 +947,7 @@ static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
 		return amdgpu_svm_range_map_attr_ranges(svm, rebuild_start,
 							rebuild_last);
 
-	ret = amdgpu_svm_range_update_gpu(svm, rebuild_start, rebuild_last,
-					  0, NULL, true, true, true);
-	if (!ret)
-		svm->flush_tlb(svm);
-
-	return ret;
+	return 0;
 }
 
 static void
@@ -706,10 +973,23 @@ amdgpu_svm_range_process_notifier_ranges(struct amdgpu_svm *svm,
 		if (clear_pte) {
 			amdgpu_svm_range_gpu_unmap_in_notifier(svm, range,
 									   mmu_range);
-			range_invalidate_gpu_mapping(range);
 		}
 
 		drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+
+		/*
+		 * Always invalidate gpu_mapped after tearing down DMA
+		 * mappings.  Without this, a non-UNMAP notifier (e.g.
+		 * MMU_NOTIFY_MIGRATE during VRAM→RAM migration) clears
+		 * has_dma_mapping via unmap_pages but leaves gpu_mapped
+		 * true.  The restore worker then sees skip_map=true
+		 * (attrs still match), enters the fast path, finds pages
+		 * invalid and returns -EAGAIN — wasting a full retry
+		 * cycle before the second attempt takes the get_pages
+		 * slow path and succeeds.
+		 */
+		range_invalidate_gpu_mapping(range);
+
 		if (is_unmap)
 			drm_gpusvm_range_set_unmapped(range, mmu_range);
 
@@ -749,12 +1029,79 @@ amdgpu_svm_range_interval_has_range(struct amdgpu_svm *svm,
 	return false;
 }
 
+/**
+ * amdgpu_svm_range_evict - Evict VRAM pages back to system memory
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @start_page: Start page of the interval
+ * @last_page: Last page of the interval (inclusive)
+ *
+ * Walk all existing svm_ranges in the [start_page, last_page] interval and
+ * evict any that currently reside in VRAM back to system memory. This is
+ * used by the prefetch-to-SYSMEM path.
+ *
+ * Eviction failure for individual ranges is not fatal — we continue
+ * processing remaining ranges and return the first error encountered.
+ */
+static int
+amdgpu_svm_range_evict(struct amdgpu_svm *svm,
+				unsigned long start_page,
+				unsigned long last_page)
+{
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_notifier *notifier;
+	int ret = 0;
+
+	lockdep_assert_held(&svm->svm_lock);
+
+	drm_gpusvm_for_each_notifier(notifier, &svm->gpusvm, start, end) {
+		struct drm_gpusvm_range *range = NULL;
+
+		drm_gpusvm_for_each_range(range, notifier, start, end) {
+			if (!amdgpu_svm_range_in_vram(range))
+				continue;
+
+			AMDGPU_SVM_TRACE("evict_interval: evict [0x%lx-0x%lx]\n",
+					 drm_gpusvm_range_start(range),
+					 drm_gpusvm_range_end(range));
+
+			ret = drm_gpusvm_range_evict(&svm->gpusvm, range);
+			if (ret) {
+				AMDGPU_SVM_TRACE("evict_interval: evict failed ret=%d [0x%lx-0x%lx]\n",
+						 ret,
+						 drm_gpusvm_range_start(range),
+						 drm_gpusvm_range_end(range));
+				/*
+				 * Eviction failure is not fatal for prefetch.
+				 * Continue with remaining ranges.
+				 */
+				ret = 0;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * prefetch_loc_is_vram - Check if prefetch location targets VRAM
+ * @attrs: Pointer to the SVM attributes
+ *
+ * Return: true if prefetch_loc specifies a GPU VRAM location
+ */
+static inline bool
+prefetch_loc_is_vram(const struct amdgpu_svm_attrs *attrs)
+{
+	return attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM &&
+	       attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED;
+}
+
 int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
-				       unsigned long start,
-				       unsigned long last,
-				       uint32_t trigger,
-				       const struct amdgpu_svm_attrs *prev_attrs,
-				       const struct amdgpu_svm_attrs *new_attrs)
+		   unsigned long start,
+		   unsigned long last,
+		   uint32_t trigger,
+		   const struct amdgpu_svm_attrs *prev_attrs,
+		   const struct amdgpu_svm_attrs *new_attrs)
 {
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -789,14 +1136,36 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 		update_mapping = true;
 
 	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE) {
-		/* TODO: add migration */
+		/*
+		 * Prefetch is a one-shot migration hint (KFD semantics):
+		 * move pages NOW to the specified location, then remap.
+		 *
+		 * Unlike preferred_loc (long-term policy that controls
+		 * migrate_devmem on future range creation), prefetch_loc
+		 * triggers an immediate migration without changing the
+		 * range's migrate_devmem flag.
+		 */
+		if (new_access) {
+			if (prefetch_loc_is_vram(new_attrs)) {
+				return amdgpu_svm_range_map_interval_ex(
+						svm, start, last, new_attrs,
+						AMDGPU_SVM_MIGRATE_TO_VRAM);
+			} else if (new_attrs->prefetch_loc ==
+				       AMDGPU_SVM_LOCATION_SYSMEM) {
+				amdgpu_svm_range_evict(svm, start, last);
+				return amdgpu_svm_range_map_interval_ex(
+						svm, start, last, new_attrs,
+						AMDGPU_SVM_MIGRATE_NONE);
+			} else {
+				AMDGPU_SVM_TRACE("preferred_loc only change, no migration [0x%lx-0x%lx]\n",
+						 start, last);
+			}
+		}
 	}
 
 	if (!update_mapping)
 		return 0;
 
-	AMDGPU_SVM_TRACE("mapping update: remap interval [0x%lx-0x%lx]-0x%lx\n",
-			 start, last, last - start + 1);
 	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs);
 }
 
@@ -1003,13 +1372,30 @@ static void amdgpu_svm_range_restore_worker(struct work_struct *w)
 		spin_unlock(&svm->gc_lock);
 
 		down_write(&svm->svm_lock);
-		ret = amdgpu_svm_range_map_attr_ranges(svm, op_ctx.start,
-						       op_ctx.last);
+		/*
+		 * Use MIGRATE_NONE: the restore worker's job is only to
+		 * rebuild GPU mappings for pages that are now in system
+		 * memory (after migrate_to_ram).  It must NOT migrate
+		 * pages back to VRAM, even if preferred_loc says VRAM.
+		 *
+		 * Without this, preferred_loc=VRAM causes a livelock:
+		 *   CPU fault → migrate_to_ram → notifier → restore →
+		 *   migrate back to VRAM → CPU fault again → …
+		 *
+		 * This matches KFD SVM behavior where the restore worker
+		 * (svm_range_restore_work) only calls validate_and_map
+		 * without triggering any migration.
+		 */
+		AMDGPU_SVM_TRACE("restore_worker: MIGRATE_NONE [0x%lx-0x%lx]\n",
+				 op_ctx.start, op_ctx.last);
+		ret = amdgpu_svm_range_map_attr_ranges_ex(svm, op_ctx.start,
+							   op_ctx.last,
+							   AMDGPU_SVM_MIGRATE_NONE);
 		up_write(&svm->svm_lock);
 
 		if (ret) {
 			AMDGPU_SVM_TRACE("restore work retry ret=%d start=0x%lx last=0x%lx ret=%d\n",
-					 ret, op_ctx.start, op_ctx.last, ret);
+					ret, op_ctx.start, op_ctx.last, ret);
 			spin_lock(&svm->gc_lock);
 			range_requeue_restore_locked(svm, op_ctx.range,
 								op_ctx.start, op_ctx.last);
@@ -1094,14 +1480,48 @@ void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
 	uint32_t op;
 	enum amdgpu_svm_range_queue_op queue_op;
 
+	AMDGPU_SVM_TRACE("invalidate: event=%d [0x%lx-0x%lx] owner=%px our=%px\n",
+			 mmu_range->event, mmu_range->start, mmu_range->end,
+			 mmu_range->owner, AMDGPU_SVM_PGMAP_OWNER(svm->adev));
+
 	if (mmu_range->event == MMU_NOTIFY_RELEASE)
 		return;
 	if (atomic_read(&svm->exiting))
 		return;
 
+	/*
+	 * Skip migration events that we initiated ourselves via
+	 * drm_pagemap_populate_mm() (RAM→VRAM prefetch).
+	 *
+	 * Both populate_mm (RAM→VRAM) and the CPU-fault-triggered
+	 * migrate_to_ram (VRAM→RAM) fire MMU_NOTIFY_MIGRATE with
+	 * owner == our pgmap owner.  We use the in_populate flag to
+	 * distinguish them:
+	 *
+	 *  - in_populate set: we are inside populate_mm, the caller
+	 *    will rebuild GPU mappings after migration → skip.
+	 *  - in_populate clear: a CPU page fault triggered migrate_to_ram,
+	 *    nobody else will update GPU mappings → must process so that
+	 *    queues are quiesced and the restore worker rebuilds mappings.
+	 */
+	if (mmu_range->event == MMU_NOTIFY_MIGRATE &&
+	    mmu_range->owner == AMDGPU_SVM_PGMAP_OWNER(svm->adev) &&
+	    atomic_read(&svm->in_populate)) {
+		AMDGPU_SVM_TRACE("invalidate: SKIP self-populate [0x%lx-0x%lx]\n",
+				 mmu_range->start, mmu_range->end);
+		return;
+	}
+
 	if (!drm_gpusvm_range_find(notifier, mmu_range->start,
-				    mmu_range->end))
+				    mmu_range->end)) {
+		AMDGPU_SVM_TRACE("invalidate: no range found [0x%lx-0x%lx]\n",
+				 mmu_range->start, mmu_range->end);
 		return;
+	}
+
+	AMDGPU_SVM_TRACE("invalidate: PROCESSING event=%d is_unmap=%d need_rebuild=%d [0x%lx-0x%lx]\n",
+			 mmu_range->event, is_unmap, NEED_REBUILD(svm) ? 1 : 0,
+			 mmu_range->start, mmu_range->end);
 
 	if (is_unmap) {
 		op = AMDGPU_SVM_RANGE_NOTIFIER_CLEAR_PTE |
-- 
2.34.1

